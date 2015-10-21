From: caesar.upstream@gmail.com (Caesar Wang)
Date: Wed, 21 Oct 2015 09:41:09 +0800
Subject: [PATCH 2/4] thermal: rockchip: ensure the otp state before
 resetting the controller
In-Reply-To: <CAD=FV=WHvwNGdRZ4Yjwk0zB00o2gFHXLfbAYHai1kM_oBAR4_g@mail.gmail.com>
References: <1445332264-6054-1-git-send-email-wxt@rock-chips.com>
 <1445332264-6054-3-git-send-email-wxt@rock-chips.com>
 <CAD=FV=WHvwNGdRZ4Yjwk0zB00o2gFHXLfbAYHai1kM_oBAR4_g@mail.gmail.com>
Message-ID: <5626ED35.3010403@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Doug,

? 2015?10?20? 23:52, Doug Anderson ??:
> Caesar,
>
> On Tue, Oct 20, 2015 at 2:11 AM, Caesar Wang <wxt@rock-chips.com> wrote:
>> We need the OTP pin is gpio state before resetting the TSADC controller,
>> since the tshut polarity will generate a high signal.
>>
>> Says:
>> The TSHUT temperature is setting more than 80 degree, the default tshut
>> polarity is high.
>>
>> If T > 80C, the OTP output the High Signal.
>> If T < 80C, the OTP output the Low Signal.
>>
>> On the moment, the TSADC controller is reset, the tshut polarity will be
>> low in a short period of time.
>> So:
>>
>> If T < 80C, the OTP output the High Signal.
>> If T > 80C, the OTP output the Low Signal.
>>
>> In some cases, the OTP pin is connected to the PMIC, maybe the PMIC can
>> accept the reset response time to avoid this issue.
>> In other words, the system will be always reboot if we make the OTP pin
>> is connected the others IC to control the power.
>>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>> ---
>>
>>   drivers/thermal/rockchip_thermal.c | 32 ++++++++++++++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
> I think you could do this with no code changes to the thermal driver
> if we simply convince Linus W. to apply a change that I posted up just
> about a year ago.  See:
>
> https://patchwork.kernel.org/patch/5055741/
>
> In v1 of that patch at <https://patchwork.kernel.org/patch/5049041/>
> Linus said he liked it "A lot" and was willing to merge it with Greg
> KH's Ack and with a small comment fix.  I obtained the Ack and fixed
> the comment, but then the patch didn't end up being needed for me and
> so I never bumped it and it got lost...
>
> Maybe you could re-test that patch?  It looks like it has a merge
> conflict with current linuxnext but it looks trivial to resolve.  You
> could re-post my patch or I could repost it and you could add your
> Tested-by.
>
> You'd still want to have a bindings change to describe "init", but at
> least you shouldn't need any code changes.

Okay, https://patchwork.kernel.org/patch/5055741/ that's working for me.
Fell free add my  test tag if you resend the patch. (Tested-by: Caesar 
Wang <wxt@rock-chips.com>)


1634ed8 FROMLIST: drivers/pinctrl: Add the concept of an "init" state
15158f8 FROMLIST: ARM: dts: rockchip: Add the OTP gpio pinctrl
e7d3b88 FROMLIST: thermal: rockchip: change the TSHUT default state
184b154 FROMLIST: thermal: rockchip: ensure the otp state before 
resetting the controller
9edbe15 FROMLIST: dt-bindings: Sync the dts to this document

Meanwhile, I change the dts as follows.

-               pinctrl-names = "default", "otp_out";
+               pinctrl-names = "init", "default";
                 pinctrl-0 = <&otp_gpio>;
                 pinctrl-1 = <&otp_out>;

>
> -Doug
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


-- 
Thanks,
Caesar
