From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 13 Mar 2015 16:56:00 +0000
Subject: read_cpuid_id() in arch/arm/kernel/setup.c
In-Reply-To: <55030A68.6070002@free.fr>
References: <55030A68.6070002@free.fr>
Message-ID: <20150313165600.GB9603@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> /*
>   * The CPU ID never changes at run time, so we might as well tell the
>   * compiler that it's constant.  Use this function to read the CPU ID
>   * rather than directly reading processor_id or read_cpuid() directly.
>   */
> static inline unsigned int __attribute_const__ read_cpuid_id(void)
> {
> 	return read_cpuid(CPUID_ID);
> }
> 
> Despite the comment and attribute, my compiler(*) still reloads the
> value every time.

In the presence of big.LITTLE the comment and premise of the
optimisation here is wrong. A thread can migrate between cores of
differing microarchitectures.

So __attribute_const__ is simply broken, and we probably need to do
something like the black magic SP hazarding hack we do for the tpidr
percpu accesses (only expecting this to be called in non-preemptible
context) if it makes sense to allow the value to be cached.

> (*) gcc version 4.9.3 20141031 (prerelease) (Linaro GCC 2014.11)
> 
> e.g.
> 
> static int __get_cpu_architecture(void)
> {
> 	int cpu_arch;
> 
> 	unsigned int id = read_cpuid_id();
> 	if ((id & 0x0008f000) == 0) {
> 		cpu_arch = CPU_ARCH_UNKNOWN;
> 	} else if ((id & 0x0008f000) == 0x00007000) {
> 		cpu_arch = (id & (1 << 23)) ? CPU_ARCH_ARMv4T : CPU_ARCH_ARMv3;
> 	} else if ((id & 0x00080000) == 0x00000000) {
> 		cpu_arch = (id >> 16) & 7;
> 		if (cpu_arch)
> 			cpu_arch += CPU_ARCH_ARMv3;
> 	} else if ((id & 0x000f0000) == 0x000f0000) {

[...]

> So I thought it would be nice to give the poor compiler a break,
> and just stuff the result in a local variable:
> 
> --- setup.c	2015-03-03 18:04:59.000000000 +0100
> +++ setup.foo.c	2015-03-13 16:26:56.413380663 +0100
> @@ -237,15 +237,16 @@
>   {
>   	int cpu_arch;
>   
> -	if ((read_cpuid_id() & 0x0008f000) == 0) {
> +	unsigned int id = read_cpuid_id();
> +	if ((id & 0x0008f000) == 0) {
>   		cpu_arch = CPU_ARCH_UNKNOWN;
> -	} else if ((read_cpuid_id() & 0x0008f000) == 0x00007000) {
> -		cpu_arch = (read_cpuid_id() & (1 << 23)) ? CPU_ARCH_ARMv4T : CPU_ARCH_ARMv3;
> -	} else if ((read_cpuid_id() & 0x00080000) == 0x00000000) {
> -		cpu_arch = (read_cpuid_id() >> 16) & 7;
> +	} else if ((id & 0x0008f000) == 0x00007000) {
> +		cpu_arch = (id & (1 << 23)) ? CPU_ARCH_ARMv4T : CPU_ARCH_ARMv3;
> +	} else if ((id & 0x00080000) == 0x00000000) {
> +		cpu_arch = (id >> 16) & 7;
>   		if (cpu_arch)
>   			cpu_arch += CPU_ARCH_ARMv3;
> -	} else if ((read_cpuid_id() & 0x000f0000) == 0x000f0000) {
> +	} else if ((id & 0x000f0000) == 0x000f0000) {

[...]

> Is this nano-optimization worth considering?

This is only ever called at early boot time in setup_processor, so I'm
not sure I see the point in making changes for optimisation's sake --
this is far from a hot path.

Howevever it would be possible to make __get_cpu_architecture a little
more legible (we should be able to return early in each of the cases),
and having single read of read_cpuid_id() at the start would make the
lines a little shorter.

Mark.
