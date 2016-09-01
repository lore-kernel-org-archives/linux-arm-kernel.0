From: dianders@chromium.org (Doug Anderson)
Date: Thu, 1 Sep 2016 14:50:56 -0700
Subject: [PATCH 2/2] arm64: dts: rockchip: add eMMC's power domain support
 for rk3399
In-Reply-To: <CAPDyKFqwqdu=9PSzD32aOYAeBVRMQ0s8oKA29JGBsMsRMsDz4w@mail.gmail.com>
References: <20160827134103.28160-1-xzy.xu@rock-chips.com>
 <20160827134103.28160-3-xzy.xu@rock-chips.com>
 <2ab8ab94-fa4d-2cd6-5805-a92ac5f9697e@rock-chips.com>
 <57C3A30B.5080707@rock-chips.com>
 <ceba6a89-6945-58c5-62e4-7d842cfa2312@rock-chips.com>
 <CAD=FV=W=LkVAm187hxp0Kbjxi5kSThwKnCMX+tr8SXQ-v_xQTQ@mail.gmail.com>
 <77f5cff1-80a2-76b3-40e9-f77caced2257@rock-chips.com>
 <12451b81-321e-b661-8f1c-25c91bffba54@rock-chips.com>
 <CAPDyKFqwqdu=9PSzD32aOYAeBVRMQ0s8oKA29JGBsMsRMsDz4w@mail.gmail.com>
Message-ID: <CAD=FV=VQ7Gf33fH8=FM_Lj-r9uovoEHxusMrFQrDwf2rxeiecg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 1, 2016 at 6:45 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> I was reading the discussion regarding this change and browsing the DT
> documentation around this... Can you guys explain what really goes on
> here, please.
>
> To me, it seems like you are managing one device's resources in one
> separate genpd. One genpd per device. Is that correct?
>
> Perhaps each device actually has its own PM domain and thus it makes
> sense to assign one genpd per device?

I'm not as familiar with genpd as I should be, so hopefully this makes sense.

...in hardware there is a "pd_emmc" that is the power domain for just
eMMC.  That will be referenced hooked up via device tree, like:

power-domains = <&power RK3399_PD_EMMC>;

I believe that means that power will automatically be removed whenever
the device is runtime suspended or suspended.

If w're not supporting "autosuspend" and nobody is tweaking anything
manually, then it's possible (I think) that runtime suspend happens at
exactly the same time as suspend.  ...but my point was that it was
cleaner to actually do it any restoring in the "runtime resume" hooks
to match what genpd does.  This matches what you say: use runtime PM.

...but it also sounds like it might not be terribly important to
restore these values since they're a bit silly to begin with.  If
that's true then I guess we don't need to do anything special here.


Did that all make sense (it's entirely possible it didn't since
somehow my brain still hasn't absorbed all runtime PM and genpd
concepts)

-Doug
