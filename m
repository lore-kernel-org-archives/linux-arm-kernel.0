From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Mar 2013 23:37:34 +0000
Subject: [GIT PULL] preparation patches for Cortex-M3
In-Reply-To: <20130307151138.GI15375@pengutronix.de>
References: <20130307151138.GI15375@pengutronix.de>
Message-ID: <20130308233733.GD4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 07, 2013 at 04:11:38PM +0100, Uwe Kleine-K?nig wrote:
> Hello Russell,
> 
> the following changes since commit 949db153b6466c6f7cad5a427ecea94985927311:
> 
>   Linux 3.8-rc5 (2013-01-25 11:57:28 -0800)
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/ukl/linux.git for-next
> 
> for you to fetch changes up to 6ebd4d038dbb626a43d87db3007e71f92f49d7b3:
> 
>   ARM: stub out read_cpuid and read_cpuid_ext for CPU_CP15=n (2013-01-31 21:44:48 +0100)
> 
> These are in next since next-20130213 without any problem reports.
> 
> I currently base my Cortex-M3 stuff on top of these. The complete series
> still has some problems though that I have to debug first. I'd be glad
> if you'd pull at least this series for 3.10.

Okay, and you of course did try doing a test-merge with something like
v3.9-rc1 before sending this pull request, so you know about these
conflicts - which I've fixed up like this.  Does this look sensible?

Note, it won't be pushed out for a while...

diff --cc arch/arm/include/asm/cputype.h
index ad41ec2,574269e..0000000
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@@ -38,6 -38,6 +38,24 @@@
  #define MPIDR_AFFINITY_LEVEL(mpidr, level) \
  	((mpidr >> (MPIDR_LEVEL_BITS * level)) & MPIDR_LEVEL_MASK)
  
++#define ARM_CPU_IMP_ARM			0x41
++#define ARM_CPU_IMP_INTEL		0x69
++
++#define ARM_CPU_PART_ARM1136		0xB360
++#define ARM_CPU_PART_ARM1156		0xB560
++#define ARM_CPU_PART_ARM1176		0xB760
++#define ARM_CPU_PART_ARM11MPCORE	0xB020
++#define ARM_CPU_PART_CORTEX_A8		0xC080
++#define ARM_CPU_PART_CORTEX_A9		0xC090
++#define ARM_CPU_PART_CORTEX_A5		0xC050
++#define ARM_CPU_PART_CORTEX_A15		0xC0F0
++#define ARM_CPU_PART_CORTEX_A7		0xC070
++
++#define ARM_CPU_XSCALE_ARCH_MASK	0xe000
++#define ARM_CPU_XSCALE_ARCH_V1		0x2000
++#define ARM_CPU_XSCALE_ARCH_V2		0x4000
++#define ARM_CPU_XSCALE_ARCH_V3		0x6000
++
  extern unsigned int processor_id;
  
  #ifdef CONFIG_CPU_CP15
@@@ -92,21 -88,15 +106,30 @@@ static inline unsigned int __attribute_
  	return read_cpuid(CPUID_ID);
  }
  
+ #else /* ifdef CONFIG_CPU_CP15 */
+ 
+ static inline unsigned int __attribute_const__ read_cpuid_id(void)
+ {
+ 	return processor_id;
+ }
+ 
+ #endif /* ifdef CONFIG_CPU_CP15 / else */
+ 
 +static inline unsigned int __attribute_const__ read_cpuid_implementor(void)
 +{
 +	return (read_cpuid_id() & 0xFF000000) >> 24;
 +}
 +
 +static inline unsigned int __attribute_const__ read_cpuid_part_number(void)
 +{
 +	return read_cpuid_id() & 0xFFF0;
 +}
 +
 +static inline unsigned int __attribute_const__ xscale_cpu_arch_version(void)
 +{
 +	return read_cpuid_part_number() & ARM_CPU_XSCALE_ARCH_MASK;
 +}
 +
  static inline unsigned int __attribute_const__ read_cpuid_cachetype(void)
  {
  	return read_cpuid(CPUID_CACHETYPE);
