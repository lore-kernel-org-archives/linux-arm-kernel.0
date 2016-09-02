From: xzy.xu@rock-chips.com (Ziyuan Xu)
Date: Fri, 2 Sep 2016 22:23:15 +0800
Subject: [PATCH 2/2] arm64: dts: rockchip: add eMMC's power domain support
 for rk3399
In-Reply-To: <CAPDyKFra7L5iUJegHH43mF4Dw=wYo0PmH2g_96fNL_=oRnGgug@mail.gmail.com>
References: <20160827134103.28160-1-xzy.xu@rock-chips.com>
 <20160827134103.28160-3-xzy.xu@rock-chips.com>
 <2ab8ab94-fa4d-2cd6-5805-a92ac5f9697e@rock-chips.com>
 <57C3A30B.5080707@rock-chips.com>
 <ceba6a89-6945-58c5-62e4-7d842cfa2312@rock-chips.com>
 <CAD=FV=W=LkVAm187hxp0Kbjxi5kSThwKnCMX+tr8SXQ-v_xQTQ@mail.gmail.com>
 <77f5cff1-80a2-76b3-40e9-f77caced2257@rock-chips.com>
 <12451b81-321e-b661-8f1c-25c91bffba54@rock-chips.com>
 <CAPDyKFqwqdu=9PSzD32aOYAeBVRMQ0s8oKA29JGBsMsRMsDz4w@mail.gmail.com>
 <CAD=FV=VQ7Gf33fH8=FM_Lj-r9uovoEHxusMrFQrDwf2rxeiecg@mail.gmail.com>
 <CAPDyKFra7L5iUJegHH43mF4Dw=wYo0PmH2g_96fNL_=oRnGgug@mail.gmail.com>
Message-ID: <10dfff58-88b2-a397-ef2e-9cd451253c40@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,


On 2016?09?02? 18:24, Ulf Hansson wrote:
> On 1 September 2016 at 23:50, Doug Anderson<dianders@chromium.org>  wrote:
>> >Hi,
>> >
>> >On Thu, Sep 1, 2016 at 6:45 AM, Ulf Hansson<ulf.hansson@linaro.org>  wrote:
>>> >>I was reading the discussion regarding this change and browsing the DT
>>> >>documentation around this... Can you guys explain what really goes on
>>> >>here, please.
>>> >>
>>> >>To me, it seems like you are managing one device's resources in one
>>> >>separate genpd. One genpd per device. Is that correct?
>>> >>
>>> >>Perhaps each device actually has its own PM domain and thus it makes
>>> >>sense to assign one genpd per device?
>> >
>> >I'm not as familiar with genpd as I should be, so hopefully this makes sense.
>> >
>> >...in hardware there is a "pd_emmc" that is the power domain for just
>> >eMMC.  That will be referenced hooked up via device tree, like:
>> >
>> >power-domains = <&power RK3399_PD_EMMC>;
> Yes, I noticed that and this is what puzzles me a bit.
>
>> >
>> >I believe that means that power will automatically be removed whenever
>> >the device is runtime suspended or suspended.
> Well, it depends if the genpd has a subdomain or other devices in it
> being runtime resumed.
> The genpd will not power off unless all devices within it are runtime
> enabled+suspended and that its subdomains are also powered off.
>
> So, in case you only have one device and no subdomains, then your
> statement is correct.

Yup, pd_emmc is a individual power domain which is only deployed to eMMC 
on rk3399. It has no subdomains.

>
>> >
>> >If w're not supporting "autosuspend" and nobody is tweaking anything
> I guess you mean runtime PM autosuspend? Then why don't you support this?
>
> Wouldn't that allow you to avoid wasting power in runtime when the
> device is idle?

pd_emmc manages the sdhci controller, phy and corecfg_* stuff, if we 
support autosuspend in driver, we have to re-init context. I didn't test 
the latency, if it's acceptable, we will apply it.:-)
But it's not a blocker, right?

>
>> >manually, then it's possible (I think) that runtime suspend happens at
>> >exactly the same time as suspend.  ...but my point was that it was
> I am not sure I follow you here. You must not rely on that the device
> always becomes runtime suspended during system suspend, as there are
> no guarantees for this.
>
> Instead that is something you need to take care of in the
> subsystem/driver for the device, of course.
>
>> >cleaner to actually do it any restoring in the "runtime resume" hooks
>> >to match what genpd does.  This matches what you say: use runtime PM.
> Yes!
>
> Using genpd without deploying runtime PM for the devices doesn't make
> much sense, at least to me.
>
>> >
>> >...but it also sounds like it might not be terribly important to
>> >restore these values since they're a bit silly to begin with.  If
>> >that's true then I guess we don't need to do anything special here.
>> >
>> >
>> >Did that all make sense (it's entirely possible it didn't since
>> >somehow my brain still hasn't absorbed all runtime PM and genpd
>> >concepts)
> No worries. I understand this might be a bit tricky, that's why I also
> tries to help review related changes.
>
> Kind regards
> Uffe
>
>
>
