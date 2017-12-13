From: dianders@chromium.org (Doug Anderson)
Date: Wed, 13 Dec 2017 11:14:53 -0800
Subject: [PATCH] phy: rockchip-typec: Try to turn the PHY on several times
In-Reply-To: <CAFqH_52coxz73waki18JicDsndG9bzEw6Zbq6TCOST0J3N+NXQ@mail.gmail.com>
References: <20171211214553.118337-1-dianders@chromium.org>
 <CAFqH_52coxz73waki18JicDsndG9bzEw6Zbq6TCOST0J3N+NXQ@mail.gmail.com>
Message-ID: <CAD=FV=Vw3_foX0_VfFG8h0xVrEEfOCWmVfF6xDVg++AqBbDRCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 13, 2017 at 4:41 AM, Enric Balletbo Serra
<eballetbo@gmail.com> wrote:
> Hi Doug,
>
> 2017-12-11 22:45 GMT+01:00 Douglas Anderson <dianders@chromium.org>:
>> Bind / unbind stress testing of the USB controller on rk3399 found
>> that we'd often end up with lots of failures that looked like this:
>>
>>   phy phy-ff800000.phy.9: phy poweron failed --> -110
>>   dwc3 fe900000.dwc3: failed to initialize core
>>   dwc3: probe of fe900000.dwc3 failed with error -110
>>
>> Those errors were sometimes seen at bootup too, in which case USB
>> peripherals wouldn't work until unplugged and re-plugged in.
>>
>> I spent some time trying to figure out why the PHY was failing to
>> power on but I wasn't able to.  Possibly this has to do with the fact
>> that the PHY docs say that the USB controller "needs to be held in
>> reset to hold pipe power state in P2 before initializing the Type C
>> PHY" but that doesn't appear to be easy to do with the dwc3 driver
>> today.  Messing around with the ordering of the reset vs. the PHY
>> initialization in the dwc3 driver didn't seem to fix things.
>>
>> I did, however, find that if I simply retry the power on it seems to
>> have a good chance of working.  So let's add some retries.  I ran a
>> pretty tight bind/unbind loop overnight.  When I did so, I found that
>> I need to retry between 1% and 2% of the time.  Overnight I found only
>> a small handful of times where I needed 2 retries.  I never found a
>> case where I needed 3 retries.
>>
>> I'm completely aware of the fact that this is quite an ugly hack and I
>> wish I didn't have to resort to it, but I have no other real idea how
>> to make this hardware reliable.  If Rockchip in the future can come up
>> with a solution we can always revert this hack.  Until then, let's at
>> least have something that works.
>>
>> This patch is tested atop Enric's latest dwc3 patch series ending at:
>>   https://patchwork.kernel.org/patch/10095527/
>> ...but it could be applied independently of that series without any
>> bad effects.
>>
>> For some more details on this bug, you can refer to:
>>   https://bugs.chromium.org/p/chromium/issues/detail?id=783464
>>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> ---
>>
>>  drivers/phy/rockchip/phy-rockchip-typec.c | 24 ++++++++++++++++++++++--
>>  1 file changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
>> index ee85fa0ca4b0..5c2157156ce1 100644
>> --- a/drivers/phy/rockchip/phy-rockchip-typec.c
>> +++ b/drivers/phy/rockchip/phy-rockchip-typec.c
>> @@ -349,6 +349,8 @@
>>  #define MODE_DFP_USB                   BIT(1)
>>  #define MODE_DFP_DP                    BIT(2)
>>
>> +#define POWER_ON_TRIES                 5
>> +
>
> I did the test of increase the number of tries to 100 because
> unfortunately, even with this patch applied, I can see the problem on
> my kevin with current mainline.
>
> [  244.309094] rockchip-typec-phy ff800000.phy: Turn on failed after 100 loops
>
> That's an extra debug print ^
>
> [  244.317019] phy phy-ff800000.phy.8: phy poweron failed --> -110
> [  244.323824] dwc3 fe900000.dwc3: failed to initialize core
> [  244.330057] dwc3: probe of fe900000.dwc3 failed with error -110
>
> So I'm wondering if there is something else that I need to apply to
> really fix this as you didn't reproduce the issue doing lots of tests
> and I can reproduce the issue very easily.

Ah!  I added that message to the top of my upstream series and,
indeed, I sometimes see the PHY fail to turn on.  Doh.

OK, so here's what I've done:

* The place where I ran the overnight loops was actually the Chrome OS
4.4 kernel.  In that kernel I had a message very similar to yours and
I didn't hit it.  I just re-ran this for 20 minutes now and I can
re-confirm.  In the Chrome OS kernel I never see it needing more than
a 1 (or 2) loops and it doesn't ever get into the "totally failed"
case.

* Previously I ran ~10 minutes with the upstream kernel, but at the
time I didn't have your printout.  After 10 minutes I checked my logs
and I definitely saw the "Needed 1 loops to turn on", so I knew my
patch was doing something useful.  It didn't occur to me to re-confirm
that I didn't get the "totally failed" upstream, though now that I say
it out loud it's stupid that I didn't think to do this.

* Previously when playing with patches on the upstream kernel I saw
lots of problems powering on the PHY and I thought my patch was
helping, but that was all very non-scientific.


So to say it shortly:

* For me, my patch makes things a slightly better even on the upstream
kernel (I do sometimes see the "turned on after 1 tries")

* I can confirm that my patch doesn't fix everything upstream, so
there's something different about the Chrome OS tree still.

---

I also picked all the local patches from the Chrome OS kernel to the
PHY driver and now my PHY driver in the upstream and downstream trees
match.  I can still reproduce problems.  So the issue is somewhere at
a higher level...


So basically something outside the PHY driver is causing it to fail
unexpectedly upstream.  I guess the hacky retry won't work well enough
there after all.  :(

One question: if you get the "failed after 100 loops" and then you do
another unbind / bind, does it work after that?  The original reason I
got the idea to retry was because if I simply tried an unbind / bind
again then things worked OK...


-Doug
