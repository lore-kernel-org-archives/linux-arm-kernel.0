From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 13:49:52 +0100
Subject: [PATCH 1/3] clocksource: defbool CLKSRC_QCOM=y on ARCH_QCOM and
 make it visible
In-Reply-To: <5655ABA1.6030206@linaro.org>
References: <1448413710-8101-1-git-send-email-sboyd@codeaurora.org>
 <3550727.W9y7mWx54D@wuerfel> <5655ABA1.6030206@linaro.org>
Message-ID: <2558718.Gz71lz6d4y@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 November 2015 13:37:53 Daniel Lezcano wrote:
> On 11/25/2015 11:17 AM, Arnd Bergmann wrote:
> > On Wednesday 25 November 2015 11:10:49 Daniel Lezcano wrote:
> >> On 11/25/2015 02:08 AM, Stephen Boyd wrote:
> >>> We want to remove the ARCH_MSM* configs in mach-qcom/Kconfig
> >>> because they are mostly proxy configs for selecting the right
> >>> clocksource driver. Therefore, make CLKSRC_QCOM default to the
> >>> value of ARCH_QCOM, but also make it visible if ARCH_QCOM=y so
> >>> that we can turn it off when we don't want it.
> >>
> >> I have been removing the ARCH dependencies in the Kconfig file.
> >>
> >> Why do you have to turn it off manually ?
> >
> > The background is that this is used only on some of the older
> > MSM SoCs, while the newer ones use the arch timer.
> >
> > We decided to remove the SoC-specific top-level options from
> > mach-msm as they are becoming rather meaningless these days
> > and just a burden to maintain at the rate that new variants
> > get released, so being able to turn off this driver helps make
> > the kernel slightly smaller if you are building a kernel for
> > only the more recent models.
> 
> Ok, thanks for the clarification.
> 
> I don't really like this approach even if it is correct because it 
> breaks the current approach I am trying to make consistent across the 
> drivers.
> 
> I would like to have the COMPILE_TEST option available for all the 
> drivers and move this option under the menu config. This patch will 
> prevent to do this code factoring.

How about moving the option to arch/arm/mach-qcom/Kconfig then?

We could have a user-selectable "allow use of qcom clocksource"
option there, which would then select the driver.

> On the other side, this option is supposed to have a slightly smaller 
> kernel when it is not used. But when does it happen ? When 
> ARCH_MSM8X60=n and ARCH_MSM8960=n. With this patchset, I don't see the 
> ability to turn these SoCs off as the options are removed. So the 
> associated code is not removed, right ?
> 
> So why allow to turn off the timer but disallow that for the entire SoC ?

The timer is the only code that is controlled by those two options at
the moment, all the other differences between SoCs are already handled
by enabling the respective device drivers.

	Arnd
