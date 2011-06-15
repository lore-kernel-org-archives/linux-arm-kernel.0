From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 15 Jun 2011 09:52:56 +0900
Subject: [PATCH] ARM: exynos4: fix secondary CPU boot
In-Reply-To: <BANLkTi=hEBKTpEq6daMyEdLo63aet52Gbg@mail.gmail.com>
References: <1305899190-16732-1-git-send-email-marc.zyngier@arm.com>
	<4DDD3C57.6020705@samsung.com>
	<1306346645.27474.182.camel@e102391-lin.cambridge.arm.com>
	<4DDD531A.50604@samsung.com>
	<1306422710.27474.237.camel@e102391-lin.cambridge.arm.com>
	<BANLkTi=fjq5ki8BGDhQxHVD3u-s7W-C1rw@mail.gmail.com>
	<1307003689.31098.6.camel@e102391-lin.cambridge.arm.com>
	<BANLkTi=mvCgi_6Y57aVjpwrMhL58zPcUHw@mail.gmail.com>
	<1307004853.31098.12.camel@e102391-lin.cambridge.arm.com>
	<BANLkTi=hEBKTpEq6daMyEdLo63aet52Gbg@mail.gmail.com>
Message-ID: <BANLkTinov=XKF5dH9EOpMj=oQC7oyKGKfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2011 at 7:26 AM, Angus Ainslie <angus.ainslie@linaro.org> wrote:
> On Thu, Jun 2, 2011 at 2:54 AM, Marc Zyngier <Marc.Zyngier@arm.com> wrote:
>> On Thu, 2011-06-02 at 17:39 +0900, Kyungmin Park wrote:
>>> On Thu, Jun 2, 2011 at 5:34 PM, Marc Zyngier <Marc.Zyngier@arm.com> wrote:
>>> > On Thu, 2011-06-02 at 16:01 +0900, Kyungmin Park wrote:
>>> >> On Fri, May 27, 2011 at 12:11 AM, Marc Zyngier <Marc.Zyngier@arm.com> wrote:
>>> >> > On Wed, 2011-05-25 at 12:06 -0700, Kukjin Kim wrote:
>>> >> >> On 05/25/11 11:04, Marc Zyngier wrote:
>>> >> >> > On Wed, 2011-05-25 at 10:28 -0700, Kukjin Kim wrote:
>>> >> >> >> On 05/20/11 06:46, Marc Zyngier wrote:
>>> >> >>
>>> >> >> (snip)
>>> >> >>
>>> >> >> > So that address has changed between two SoC revisions? That's
>>> >> >> > unfortunate, to say the least. I'm most probably using an early revision
>>> >> >> > of the hardware (EVT0?), as it doesn't even support MCT.
>>> >> >> >
>>> >> >> I'm afraid :( and I agree secondary CPU should work on all of
>>> >> >> Exynos4210. But I'm still think about the method...
>>> >> >>
>>> >> >> > What about the following patch?
>>> >> >> >
>>> >> >> Uhm...this is really hack but I'd like to use another normal way...?
>>> >> >
>>> >> > Oh, no question about the hack status. The trouble is, unless there is a
>>> >> > sure way to tell which SoC revision we're running on, there's little
>>> >> > else we can do than poke both locations and pray.
>>> >> >
>>> >> > Is there such a way to identify the SoC revision?
>>> >>
>>> >> It's also required for OneNAND. as you know C210 EVT0 OneNAND DMA has
>>> >> bug and need to workaround.
>>> >>
>>> >> platform codes should provide the these function. please see the OMAP
>>> >> codes. how to handle it.
>>> >
>>> > So we know there's a need beyond the wish to see the second core up and
>>> > running on my board.
>>> >
>>> > Now what is the proper method to detect the revision of the SOC?
>>> > Handling it is no problem, once we have the information. Unfortunately
>>> > the documentation I have is less than helpful on that subject.
>>>
>>> It can be distinguished by chip id. but there's no code to handle this one.
>>>
>>> 0x4320 0200 EVT0
>>> 0x4321 0210 EVT1
>>> 0x4321 0211 EVT2
>>
>> Apparently, the low 8 bits can be overloaded by the efuse. Which makes
>> telling EVT1 from EVT2 unreliable.
>>
>> But at least this is a start. I'll see if I can come up with something
>> minimal enough to be merged as a fix.
>>
>> Thanks,
>>
>> ? ? ? ?M.
>> --
>> Reality is an implementation detail.
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>>
>
> Would something like this work instead ? It seems to work on EVT0 but
> I haven't had a chance to test on EVT1.
>
>
> From a4c1b643596599df9d79776c9b94f2536661a4c9 Mon Sep 17 00:00:00 2001
> From: Angus Ainslie <angus.ainslie@linaro.org>
> Date: Tue, 14 Jun 2011 16:13:35 -0600
> Subject: [PATCH] ARM: exynos4: fix secondary CPU boot on early SoC revisions
>
> It appears that the system-wide flags register that used to be at
> 0x02025000 on the first revision of Exynos4 has moved to 0x02020000.
>
> The kernel has been updated accordingly, but this unfortunately leaves
> early boards without SMP support (the secondary CPU spins endlessly
> in BL0 waiting for an address to be written at that memory location).
>
> Use the CPU id to decide whether we are running on EVT0 and use the
> old location in that case.

Hi Angus,

Now this information is also required for other device drivers such as OneNAND.
So can you make a generic function at common place such as plat-s5p?
I mean we need a generic helper function for handling the EVT version
at samsung platform.

Thank you,
Kyungmin Park
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Angus Ainslie <angus.ainslie@linaro.org>
> ---
> ?arch/arm/mach-exynos4/include/mach/map.h | ? ?1 +
> ?arch/arm/mach-exynos4/platsmp.c ? ? ? ? ?| ? 23 ++++++++++++++++++++++-
> ?2 files changed, 23 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-exynos4/include/mach/map.h
> b/arch/arm/mach-exynos4/include/mach/map.h
> index 0009e77..781e149 100644
> --- a/arch/arm/mach-exynos4/include/mach/map.h
> +++ b/arch/arm/mach-exynos4/include/mach/map.h
> @@ -24,6 +24,7 @@
> ?#include <plat/map-s5p.h>
>
> ?#define EXYNOS4_PA_SYSRAM ? ? ? ? ? ? ?0x02020000
> +#define EXYNOS4_PA_SYSRAM_EVT0 ? ? ? ? 0x02025000
>
> ?#define EXYNOS4_PA_FIMC0 ? ? ? ? ? ? ? 0x11800000
> ?#define EXYNOS4_PA_FIMC1 ? ? ? ? ? ? ? 0x11810000
> diff --git a/arch/arm/mach-exynos4/platsmp.c b/arch/arm/mach-exynos4/platsmp.c
> index c5e65a0..5f70aec 100644
> --- a/arch/arm/mach-exynos4/platsmp.c
> +++ b/arch/arm/mach-exynos4/platsmp.c
> @@ -155,6 +155,8 @@ void __init smp_init_cpus(void)
> ?void __init platform_smp_prepare_cpus(unsigned int max_cpus)
> ?{
> ? ? ? ?int i;
> + ? ? ? unsigned long idcode;
> + ? ? ? void __iomem *sysram_evt0;
>
> ? ? ? ?/*
> ? ? ? ? * Initialise the present map, which describes the set of CPUs
> @@ -165,11 +167,30 @@ void __init platform_smp_prepare_cpus(unsigned
> int max_cpus)
>
> ? ? ? ?scu_enable(scu_base_addr());
>
> + ? ? ? idcode = __raw_readl(S5P_VA_CHIPID);
> +
> ? ? ? ?/*
> ? ? ? ? * Write the address of secondary startup into the
> ? ? ? ? * system-wide flags register. The boot monitor waits
> ? ? ? ? * until it receives a soft interrupt, and then the
> ? ? ? ? * secondary CPU branches to this address.
> ? ? ? ? */
> - ? ? ? __raw_writel(BSYM(virt_to_phys(exynos4_secondary_startup)),
> S5P_VA_SYSRAM);
> + ? ? ? if ((idcode & 0xF0000) == 0) {
> + ? ? ? ? ? ? ? /*
> + ? ? ? ? ? ? ? ?* EVT0 has the system-wide flags register at a
> different address.
> + ? ? ? ? ? ? ? ?* Poke it as well, in case we're running on an old
> SoC revision.
> + ? ? ? ? ? ? ? ?*/
> + ? ? ? ? ? ? ? sysram_evt0 = ioremap(EXYNOS4_PA_SYSRAM_EVT0, SZ_4K);
> + ? ? ? ? ? ? ? if (!sysram_evt0) {
> + ? ? ? ? ? ? ? ? ? ? ? pr_err("Unable to remap EXYNOS4_PA_SYSRAM_EVT0\n");
> + ? ? ? ? ? ? ? ? ? ? ? return;
> + ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? __raw_writel(BSYM(virt_to_phys(exynos4_secondary_startup)),
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ?sysram_evt0);
> + ? ? ? ? ? ? ? iounmap(sysram_evt0);
> + ? ? ? } else {
> + ? ? ? ? ? ? ? __raw_writel(BSYM(virt_to_phys(exynos4_secondary_startup)),
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ?S5P_VA_SYSRAM);
> + ? ? ? }
> +
> ?}
> --
> 1.7.4.1
>
> --
> Angus Ainslie <angus.ainslie@linaro.org>
> Team Lead, Samsung Landing Team
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
