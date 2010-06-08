From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 8 Jun 2010 20:43:13 +0800
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <20100608123102.GT15515@atomide.com>
References: <alpine.LFD.2.00.1006031829020.24526@xanadu.home>
	<4C083BCF.2060500@bluewatersys.com>
	<201006040310.15019.marek.vasut@gmail.com>
	<4C0853E1.1080005@bluewatersys.com>
	<AANLkTinEq99_8UyVNnmzNEreDoyHKEnxpuJmaAo_kpPN@mail.gmail.com>
	<20100604061034.GI6499@atomide.com>
	<AANLkTikrK-RkDntgrpptBaG6TvnesNFncOw3DW4Jt-TY@mail.gmail.com>
	<AANLkTil1IetX6koHVRrgnWs3DqhPtZVqR2euEdg9lZUa@mail.gmail.com>
	<alpine.LFD.2.00.1006041418390.22319@xanadu.home>
	<20100608115832.GB25370@n2100.arm.linux.org.uk>
	<20100608123102.GT15515@atomide.com>
Message-ID: <AANLkTilyaRYigz2LoirclkNHyj3g3CUogM6OmnpUfM4M@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 8, 2010 at 8:31 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [100608 14:53]:
>> On Fri, Jun 04, 2010 at 04:51:24PM -0400, Nicolas Pitre wrote:
>> > Linus wants something to be done about the current defconfig mess which
>> > is perfectly legitimate. ?He even suggested a possible solution. ?I
>> > don't think he'll simply drop those defconfig files if we demonstrate
>> > that we're taking action to fix the actual problem.
>>
>> However, having a set of patches which combine a load of defconfig
>> files into one is not going to solve the problem.
>>
>> If you're hypothesis that Linus is only looking at the diffstat, then
>> what are patches to combine the defconfigs going to do? ?It's going
>> to create lots of noise in arch/arm/configs/ - which is precisely what
>> Linus is complaining about. ?In fact, patch-wise it's going to create
>> an extremely large patch. ?And if we do this time and time again while
>> progressively reducing the defconfigs. ?No, this isn't the answer -
>> it's only going to make the problem worse.
>>
>> I believe the only acceptable solution is to get an alterative method
>> in place - no matter what it is - and remove the all but one of the
>> defconfig files from the mainline kernel. ?_And_, most importantly,
>> kautobuild needs to be fixed so that we still get build coverage.
>>
>> The loss of kautobuild is a major concern here, and I believe it trumps
>> everything else for the next merge window. ?Kautobuild is an extremely
>> important resource that we simply can not afford to lose.
>
> How about the following strategy for the next merge window:
>
> - Update kautobuild to temporarily host the current defconfigs
>
> - Remove all the arm defconfigs except one
>

This is actually a bit unfair and brutally. The number of defconfig is not
an ARM _only_ problem, although it's a bit significant on ARM due to
the diversity.

ycmiao at macbook-lucid:~/kernel/linux-2.6$ find arch/ -name
"*_defconfig" | grep "arch/sh" | wc -l
50
ycmiao at macbook-lucid:~/kernel/linux-2.6$ find arch/ -name
"*_defconfig" | grep "arch/powerpc" | wc -l
100
ycmiao at macbook-lucid:~/kernel/linux-2.6$ find arch/ -name
"*_defconfig" | grep "arch/mips" | wc -l
47
ycmiao at macbook-lucid:~/kernel/linux-2.6$ find arch/ -name
"*_defconfig" | grep "arch/blackfin" | wc -l
24

Removing all the _defconfig will anyway generate a super BIG patch as
well, which is also going to generate a lot noise in diffstat.

Just wondering if a migration path is possible. Does anyone seriously think
about the solution Linus proposed and maybe we can have an implementation
and have all defconfig going that way before they are completely purged?

> Then over the next few merge cycles:
>
> - Make the ARM platform specific Kconfig or similar option to work
>
> - Drop the old defconfigs from kautobuild once we have the new solution
>
> Then over yet unknown lenght of time:
>
> - Work towards building in more features (TLS/SMP/VFPvX) into the same kernel
>
> - Work towards building in multiple ARM platforms into the same kernel
>
> Regards,
>
> Tony
>
