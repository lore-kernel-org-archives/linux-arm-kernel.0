From: will.deacon@arm.com (Will Deacon)
Date: Sun, 28 Jul 2013 12:10:38 +0100
Subject: [PATCH] ARM: v6: avoid read_cpuid_ext() on ARM1136r0 in
 cache_ops_need_broadcast()
In-Reply-To: <alpine.DEB.2.02.1307280538460.8385@utopia.booyaka.com>
References: <alpine.DEB.2.02.1307222005370.26048@utopia.booyaka.com>
 <51EE2AA7.5060503@ti.com>
 <alpine.DEB.2.02.1307230705000.27017@utopia.booyaka.com>
 <51EE474D.5070804@ti.com>
 <20130724135617.GI11072@mudshark.cambridge.arm.com>
 <51EFE1DD.8070801@ti.com>
 <20130724142059.GJ11072@mudshark.cambridge.arm.com>
 <alpine.DEB.2.02.1307270405470.4546@utopia.booyaka.com>
 <20130727122221.GB6618@mudshark.cambridge.arm.com>
 <alpine.DEB.2.02.1307280538460.8385@utopia.booyaka.com>
Message-ID: <20130728111038.GA9374@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

Cheers for sticking with this!

On Sun, Jul 28, 2013 at 06:43:24AM +0100, Paul Walmsley wrote:
> 
> Commit 621a0147d5c921f4cc33636ccd0602ad5d7cbfbc ("ARM: 7757/1: mm:
> don't flush icache in switch_mm with hardware broadcasting") breaks
> the boot on OMAP2430SDP with omap2plus_defconfig.  Tracked to an
> undefined instruction abort from the CP15 read in
> cache_ops_need_broadcast().  It turns out that early ARM1136 variants
> don't support several CP15 registers that later ARM cores do.
> ARM1136JF-S TRM section 3.2.1 "Register allocation" has the details.

Intriguing... I wouldn't expect a cp15 read to be emitted for 1136, since
the SMP_ON_UP magic should have caused is_smp() to return false.

> diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
> index 6462a72..76214cb 100644
> --- a/arch/arm/include/asm/smp_plat.h
> +++ b/arch/arm/include/asm/smp_plat.h
> @@ -25,7 +25,6 @@ static inline bool is_smp(void)
>  #endif
>  }
>  
> -/* all SMP configurations have the extended CPUID registers */
>  #ifndef CONFIG_MMU
>  #define tlb_ops_need_broadcast()	0
>  #else
> @@ -43,6 +42,9 @@ static inline int tlb_ops_need_broadcast(void)
>  #else
>  static inline int cache_ops_need_broadcast(void)
>  {
> +	if (cpu_is_arm1136_r0())
> +		return 0;
> +
>  	if (!is_smp())
>  		return 0;

So we should have returned 0 here without exploding (this just reads a
.globl initialised in head.S). Are we somehow misidentifying your 1136
as an SMP core?

Will
