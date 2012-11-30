From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Nov 2012 16:03:38 +0000
Subject: [PATCH v3] ARM: Factor out cpuid implementor and part number
In-Reply-To: <1354290073-55801-1-git-send-email-c.dall@virtualopensystems.com>
References: <1354290073-55801-1-git-send-email-c.dall@virtualopensystems.com>
Message-ID: <20121130160337.GQ19440@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 30, 2012 at 10:41:13AM -0500, Christoffer Dall wrote:
> Decoding the implementor and part number of the CPU id in the CPU ID
> register is needed by KVM, so we factor it out to share the code.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
> ---
> Changes since v2:
>  - Take implementor as argument to read_cpuid_part_number

Actually, I don't think this is the correct way.  There's noting
inherently different about Xscale wrt part numbers, it's just that
someone decided to do stuff "differently" and use the CPU part
number to identify the SoC as a whole.

Here's the full list:

80200	69052000	fffffff0
PXA250	69052100	fffff7f0
PXA210	69052120	fffff3f0
8032x	69052420	fffff7e0
PXA255	69052d00	fffffff0
80219	69052e20	ffffffe0
8033x	69054010	fffffd30
IXP43x	69054040	fffffff0
PXA270	69054110	fffffff0
IXP2400	69054190	fffffff0
IXP2800	690541a0	fffffff0
IXP42x	690541c0	ffffffc0
IXP46x	69054200	ffffff00
Xscale3	69056000	ffffe000
PXA935	56056000	ffffe000

What we get from these is:
XScale1 can be identified by (id & 0xe000) == 0x2000
Xscale2 can be identified by (id & 0xe000) == 0x4000
Xscale3 can be identified by (id & 0xe000) == 0x6000

I don't think we should make a distinction in read_cpuid_part_number()
between these; if manufacturers are silly enough to abuse these fields
then its their problem. :)

What I suggest is that read_cpuid_part_number() returns the part number
field as defined by ARM.  We then also define XSCALE_ARCH_MASK to be
0xe000 and a bunch of XSCALE_ARCH_V1..V3 along those lines.  Maybe even
a xscale_cpu_version() macro which returns the XScale CPU version
pre-masked.

That would mean this becomes:

> @@ -202,47 +202,48 @@ static int __devinit probe_current_pmu(struct arm_pmu *pmu)
>  {
>  	int cpu = get_cpu();
>  	unsigned long cpuid = read_cpuid_id();
> -	unsigned long implementor = (cpuid & 0xFF000000) >> 24;
> -	unsigned long part_number = (cpuid & 0xFFF0);
> +	unsigned long implementor = read_cpuid_implementor();

Why not pass the cpuid that we read into these functions?

> +	unsigned long part_number;
	unsigned long part_number = read_cpuid_part_number(cpuid);

>  	int ret = -ENODEV;
>  
>  	pr_info("probing PMU on CPU %d\n", cpu);
>  
>  	/* ARM Ltd CPUs. */
> -	if (0x41 == implementor) {
> +	if (implementor == ARM_CPU_IMP_ARM) {
> +		part_number = read_cpuid_part_number(implementor);

This goes.

>  		switch (part_number) {
> -		case 0xB360:	/* ARM1136 */
> -		case 0xB560:	/* ARM1156 */
> -		case 0xB760:	/* ARM1176 */
> +		case ARM_CPU_PART_ARM1136:
> +		case ARM_CPU_PART_ARM1156:
> +		case ARM_CPU_PART_ARM1176:
>  			ret = armv6pmu_init(pmu);
>  			break;
> -		case 0xB020:	/* ARM11mpcore */
> +		case ARM_CPU_PART_ARM11MPCORE:
>  			ret = armv6mpcore_pmu_init(pmu);
>  			break;
> -		case 0xC080:	/* Cortex-A8 */
> +		case ARM_CPU_PART_CORTEX_A8:
>  			ret = armv7_a8_pmu_init(pmu);
>  			break;
> -		case 0xC090:	/* Cortex-A9 */
> +		case ARM_CPU_PART_CORTEX_A9:
>  			ret = armv7_a9_pmu_init(pmu);
>  			break;
> -		case 0xC050:	/* Cortex-A5 */
> +		case ARM_CPU_PART_CORTEX_A5:
>  			ret = armv7_a5_pmu_init(pmu);
>  			break;
> -		case 0xC0F0:	/* Cortex-A15 */
> +		case ARM_CPU_PART_CORTEX_A15:
>  			ret = armv7_a15_pmu_init(pmu);
>  			break;
> -		case 0xC070:	/* Cortex-A7 */
> +		case ARM_CPU_PART_CORTEX_A7:
>  			ret = armv7_a7_pmu_init(pmu);
>  			break;
>  		}
>  	/* Intel CPUs [xscale]. */
> -	} else if (0x69 == implementor) {
> -		part_number = (cpuid >> 13) & 0x7;
> +	} else if (implementor == ARM_CPU_IMP_INTEL) {
> +		part_number = read_cpuid_part_number(implementor);
>  		switch (part_number) {

		switch (xscale_cpu_version(part_number)) {

> -		case 1:
> +		case ARM_CPU_PART_XSCALE1:

		case XSCALE_ARCH_V1:

>  			ret = xscale1pmu_init(pmu);
>  			break;
> -		case 2:
> +		case ARM_CPU_PART_XSCALE2:

		case XSCALE_ARCH_V2:

and we can use read_cpuid_part_number() where getting at that field
in the CPU ID information matters.
