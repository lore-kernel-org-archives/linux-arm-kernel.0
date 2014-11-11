From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Tue, 11 Nov 2014 11:23:10 -0800
Subject: [RFC 2/2] regulator: qcom-rpm: Implement RPM assisted disable
In-Reply-To: <CABxcv=nGyV2F9kYALOhTzmUfO8CC6NEwv4v3SPmrum-bBi-eDw@mail.gmail.com>
References: <1415659966-16200-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1415659966-16200-3-git-send-email-bjorn.andersson@sonymobile.com>
 <CABxcv=nGyV2F9kYALOhTzmUfO8CC6NEwv4v3SPmrum-bBi-eDw@mail.gmail.com>
Message-ID: <20141111192309.GH16980@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 11 Nov 06:21 PST 2014, Javier Martinez Canillas wrote:

> Hello Bjorn,
> 

Hi Javier,

> On Mon, Nov 10, 2014 at 11:52 PM, Bjorn Andersson
> <bjorn.andersson@sonymobile.com> wrote:
> > Some regulators are used to power e.g. PLLs that clocks the core we're
> > running on, so we can't turn them off directly; but we do want them off
> > when the core is powered down. To handle this the Qualcomm SoC provides
> > a means to specify a "sleep state" for RPM resources that can be
> > triggered by the hardware when the cores are brought down.
> >
> 
> The regulator core already has support to control the state of
> regulators when the system enters into a sleep state. Now the generic
> regulator DT binding has also been extended to support defining if a
> regulator should be "regulator-{on,off}-in-suspend". Please take a
> look at the topic/suspend branch [0] in the regulator tree that has
> the latest binding.
> 

I was planning to utilize the suspend states functionality in the core and was
looking at implementing [0] myself, so glad that's coming in place.

However, as a practical example we have LDO12 on the MSM8974 SoC that is used
for powering CPU PLLs, WiFi/BT PLLs, display, camera sensor and hdmi.

In a phone it's most reasonable to expect the WiFi core keeping a vote for the
regulators to be enabled during a suspend, but if you're in airplane mode (or
WiFi is turned off) you want to save the power - so it's not possible to
configure this statically.

Further more, the CPU vote is not tied to suspend state but rather cpuidle
state. It's not unreasonable to think of a state where we're clocking out
pixels to the display in Android with the CPU turned off and hence the CPU PLL
vote lifted.

> If that is not enough for your hardware and use case, I've been
> working on adding initial and suspend mode for regulators. The latest
> series is [1] and the needed bits for the max77802 regulator driver is
> [2].
> 

Looks good.

> It's always better to use existing functionality if possible, instead
> of adding custom per driver DT bindings. So it would be great if you
> can take a look to the mentioned patches.
> 

I totally agree, but due to the dynamic nature described above I have a hard
time figuring out how to make it fit; hence this RFC.

> >  Documentation/devicetree/bindings/mfd/qcom-rpm.txt |   28 ++++++++
> >  drivers/regulator/qcom_rpm-regulator.c             |   68 +++++++++++++++-----
> 
> Against which tree this patch has been developed? afaict
> Documentation/devicetree/bindings/mfd/qcom-rpm.txt does not exist even
> in the latest for-next [3] branch of the mfd tree.
> 

v3.18-rc1 + https://lkml.org/lkml/2014/9/22/731

As I tried to explain in the cover letter, the DT bindings that I change here
are not acked and this RFC is an attempt to come to a conclusion in how to
design the sleep state part - which will change the bindings.

> >
> >         #include <dt-bindings/mfd/qcom-rpm.h>
> 
> This file doesn't exit either and the regulator driver depends on
> MFD_QCOM_RPM which also is not present in mainline.
> 
> By looking at the mail archives I see that you posted both the
> regulator and mfd driver in the same series [4] but only the regulator
> driver was picked by Mark so I guess Lee has to pick the mfd driver in
> order to allow the regulator driver to be built.
> 

Correct, I hope that after sorting the sleep state part out we can get some
acks on things.

Thanks for your review!

Regards,
Bjorn
