From: dianders@chromium.org (Doug Anderson)
Date: Mon, 15 Sep 2014 21:37:44 -0700
Subject: [PATCH v2 5/7] clk: rockchip: add new clock-type for the cpuclk
In-Reply-To: <54178BBF.70402@rock-chips.com>
References: <1410561030-19127-1-git-send-email-heiko@sntech.de>
 <1410561030-19127-6-git-send-email-heiko@sntech.de>
 <CAD=FV=XJEL1QDRHUGL=g5BKEhLWve0uUko7ZH=dM7btWkU4+1w@mail.gmail.com>
 <54178BBF.70402@rock-chips.com>
Message-ID: <CAD=FV=VwmALrUznNtX_=89nxWK8A0koM2f2zs4L3DLbuu3Nyhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kever and Heiko

On Mon, Sep 15, 2014 at 6:00 PM, Kever Yang <kever.yang@rock-chips.com> wrote:
>>> +       /* select alternate parent */
>>> +       writel(HIWORD_UPDATE(1, 1, reg_data->mux_core_shift),
>>> +              cpuclk->reg_base + reg_data->core_reg);
>>
>> In the "alt_prate > ndata->old_rate" case there's a period of time
>> where you can be running super slow.
>>
>> If we start as 126000 and we're going to switch to 594000, we decide
>> we need a divide by 5.  We apply the divide by 5 in one statement and
>> switch to 594MHz in a second statement.  That means there's a very
>> short period of time where we're at 126000 / 5 = 25200.  That's 25MHz.
>>
>> I've found that when I stress out CPUfreq and have a lot of interrupts
>> coming in (like from USB) the my system hangs here.
>>
>> Since the "alt div" and reparenting touch the same register, I think
>> we can do them in a single operation.  That works for me.
>
> Agree, this should be work, the operation for div and parent select for
> arm clk is in the same register in rk3066, rk3188 and rk3288.
>>
>>
>> ...but something isn't adding up for me, so I'm hesitant to suggest
>> this.  Somehow I only end up with the hang here and not down in the
>> post_rate_change().  I'll keep debugging...  It strangely enough seems
>> related to the rockchip_pll_notifier_cb()???
>
> Did you test this on Gerrit 3.14? I think we have a know problem that make
> POST_RATE_CHANGE notifier is not send which has been fixed by Derek.

I accounted for that.  Thanks for the reminder though.

I think I've solved the two separate bugs.  Hopefully Heiko (and you!)
can take a look at my fixes.  The overall summary of what I think was
happening:

1. We were at 126MHz

2. We decided that we wanted to go to 216MHz

3. In prep for changing the ARM PLL, we switched to "slow mode".  AKA:
24MHz.  This happens in a callback.

4. In prep for swtiching to GPLL, we decided that the divider should be "/ 5"

5. We applied "/ 5" to the current PLL (24MHz), giving 4.8MHz


BUG: If we happen to get a USB interrupt here (we get lots and lots
and lots if we have a USB Ethernet adapter in), we're hosed.  We'll
keep getting interrupts faster than we handle them.


6. We quickly switch to GPLL, giving us 594MHz / 5 = 118.8MHz.

7. We switch the PLL to 216MHz

8. We switch out of slow mode.

9. We switch off GPLL, giving us 216MHz / 5 = 43MHz.

10. We remove the divider, giving us 216MHz.

---

With my patches we never run on 24MHz and only ever divide GPLL.  I've
put them on gerrit since I expect Heiko will just fold them in his
patches.

* https://chromium-review.googlesource.com/218432 - FIXUP: clk:
rockchip: add new clock-type for the cpuclk (slow mode fix)

* https://chromium-review.googlesource.com/218433 - FIXUP: clk:
rockchip: add new clock-type for the cpuclk (atomic change, plus ...


...I've also fixed the problem with the common clock framework caching things...


Comments are certainly welcome.  ...or if I'm doing something stupid /
wrong, please tell me.  It's late (for me) and I'm writing this after
drinking a sangria.  ;)


-Doug
