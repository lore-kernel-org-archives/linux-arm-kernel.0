From: panand@redhat.com (Pratyush Anand)
Date: Fri, 29 Apr 2016 19:47:43 +0530
Subject: [PATCH 01/12] ARM: kexec: fix crashkernel= handling
In-Reply-To: <E1aviEe-0000if-VZ@rmk-PC.arm.linux.org.uk>
References: <20160428092644.GX19428@n2100.arm.linux.org.uk>
 <E1aviEe-0000if-VZ@rmk-PC.arm.linux.org.uk>
Message-ID: <CAHB_GuqsoZn=i8KXtiuD5oiVAb5vj+gAr_apOtuFiEwiwPREGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Thu, Apr 28, 2016 at 2:57 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

[...]

> +   On arm, the use of "crashkernel=Y at X" is no longer necessary; the
> +   kernel will automatically locate the crash kernel image within the
> +   first 512MB of RAM if X is not given.
>
>
>  Load the Dump-capture Kernel
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 139791ed473d..77b54c461c52 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -938,6 +938,13 @@ static int __init init_machine_late(void)
>  late_initcall(init_machine_late);
>
>  #ifdef CONFIG_KEXEC
> +/*
> + * The crash region must be aligned to 128MB to avoid
> + * zImage relocating below the reserved region.
> + */
> +#define CRASH_ALIGN    (128 << 20)
> +#define CRASH_ADDR_MAX (PHYS_OFFSET + (512 << 20))
> +
>  static inline unsigned long long get_total_mem(void)
>  {
>         unsigned long total;
> @@ -965,6 +972,28 @@ static void __init reserve_crashkernel(void)
>         if (ret)
>                 return;
>
> +       if (crash_base <= 0) {
> +               unsigned long long crash_max = CRASH_ADDR_MAX;
> +               if (crash_max > (u32)~0)
> +                       crash_max = (u32)~0;
> +               crash_base = memblock_find_in_range(CRASH_ALIGN, crash_max,

Although it does not matter, memblock_find_in_range would be able to
locate correct free area even when there is no valid RAM at address
CRASH_ALIGN. However passing PHYS_OFFSET as start argument may be more
readable probably.

> +                                                   crash_size, CRASH_ALIGN);
> +               if (!crash_base) {
> +                       pr_err("crashkernel reservation failed - No suitable area found.\n");
> +                       return;
> +               }
> +       } else {
> +               unsigned long long start;
> +
> +               start = memblock_find_in_range(crash_base,
> +                                              crash_base + crash_size,
> +                                              crash_size, SECTION_SIZE);
> +               if (start != crash_base) {
> +                       pr_err("crashkernel reservation failed - memory is in use.\n");
> +                       return;
> +               }
> +       }
> +
>         ret = memblock_reserve(crash_base, crash_size);
>         if (ret < 0) {
>                 pr_warn("crashkernel reservation failed - memory is in use (0x%lx)\n",
> --

Reviewed-by: Pratyush Anand <panand@redhat.com>
