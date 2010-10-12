From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 12 Oct 2010 09:15:06 +0900
Subject: [PATCH v2 0/6] ARM: S5PV210: Add support S5PV210/S5PC110 CPUFREQ
In-Reply-To: <AANLkTi=pQWw2rZ0ujQ5frkJR30Vz-WDfQEYDX4y6kPa9@mail.gmail.com>
References: <1284962695-8542-1-git-send-email-sbkim73@samsung.com>
	<004001cb6605$01ff4f90$05fdeeb0$@com>
	<001501cb66ce$9dc54b40$d94fe1c0$%kim@samsung.com>
	<AANLkTikJL+94qODxkQGxzEPj0SCS3BA4=XQozJSHCpyR@mail.gmail.com>
	<003d01cb691a$eb71c8c0$c2555a40$@com>
	<AANLkTi=pQWw2rZ0ujQ5frkJR30Vz-WDfQEYDX4y6kPa9@mail.gmail.com>
Message-ID: <00f001cb69a2$8b7462b0$a25d2810$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> 
> On Mon, Oct 11, 2010 at 5:04 PM, Sangbeom Kim <sbkim73@samsung.com>
> wrote:
> > On Monday, Oct 11, 2010 9:12 AM, MyungJoo Ham
> <myungjoo.ham@samsung.com> wrote:
> >>
> >> Hello,
> >>
> >> On Fri, Oct 8, 2010 at 6:52 PM, Kukjin Kim <kgene.kim@samsung.com>
wrote:
> >> > Sangbeom Kim wrote:
> >> >>
> >> >> Hi all,
> >> >> I know that there is another S5PV210 CPUFREQ patch from Mr. Ham.
> >> >> But, That patchset seems to have unclear part.
> >> >>
> >> > http://lists.infradead.org/pipermail/linux-arm-kernel/2010-
> >> August/023626.htm
> >> >> l
> >> >> The part of 'CONFIG_PM' is unclear and still have PM support part.
> >> >> So, I think that this patch is more suitable for S5PV210/S5PC110
> >> CPUFREQ
> >> > in
> >> >> the mainline.
> >> >> because this patch implemented basic pm functionality and already
> >> tested
> >> > on
> >> >> smdkv210 board.
> >> >>
> >> > Hi,
> >> >
> >> > So...I'd like to merge this for this merge window.
> >> >
> >> > Mr. Ham, how do you think?
> >> > If any problems or opinions, please let me know.
> >>
> >>
> >> You can go ahead as long as this patch include features that the
> >> another addresses.
> >>
> >>
> >> Anyway, the part that is under "CONFIG_PM" is intended to block
> >> frequency changing while PM is doing something. For example, when the
> >> system enters a sleep, if CPUFREQ somehow enters "100MHz/0.95V" just
> >> before the sleep and wakes up, the voltage may stay at 0.95V (PMIC is
> >> not turned off during sleep) while the frequency is reset to 800MHz
> >> (by the bootloader), which requires, let's say, 1.1V. Such
> >> inconsistency may lead to system hang and we have observed such cases
> >> a few times. I intended to refuse any CPUFREQ requests at the
> >> /mach-s5pv210/cpufreq.c when PM seems to start.
> >>
> >
> > We knew already that issue,
> > So we have a plan to implement with other solution.
> > (using regulator suspend feature)
> >
> >> It may seem that such feature is not needed if the voltage is not
> >> optimized, however, CPUFREQ is useless if the voltage stays at 1.2V
> >> and if the voltage changes properly according to the frequency, such
> >> feature is required anyway.
> >
> > Currently, there is no max8698 regulator driver on mainline.
> > After submission that driver, we can add voltage scaling feature.
> >
> > Both issues have dependency on regulator driver.
> 
> Nope. it does not need to depend on any regulator drivers. We can
> simply stop changing frequency (or hold at a specific frequency) after
> suspend-to-mem is called. (probably at ".begin" stage). This depends
> on PM, but does NOT depend on REGULATOR.
> 
> The approach in the removed patch was to set a flag at the .begin PM
> ops and deflag it at .end PM ops and let target function of CPUFREQ to
> read the flag to decide whether to accept the frequency change request
> and to set at the default frequency (i.e., 800MHz) when .begin ops is
> called and restore the frequency when .end ops is called.
> 

Hi all,

Both looks reasonable to me, in my opinion, need to decide one thing.

As I said, I'd like to apply basic functionality of CPUFREQ, Jaecheol Lee's
patch in this merge window.
It would be better if could keep going update its other functionality next
time.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
