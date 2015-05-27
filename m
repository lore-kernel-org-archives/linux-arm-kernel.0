From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 27 May 2015 11:36:44 +0100
Subject: some question about arm64 smp_spin_table.c
In-Reply-To: <CADUS3o=4b9zfKtyiZ2CKgC2AA9ntkFLo91pJug17t1Xz2jM34w@mail.gmail.com>
References: <CADUS3o=4b9zfKtyiZ2CKgC2AA9ntkFLo91pJug17t1Xz2jM34w@mail.gmail.com>
Message-ID: <20150527103644.GE8439@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 27, 2015 at 10:47:09AM +0100, yoma sophian wrote:
> hi all:

Hi,

> in arm64/kernel/smp_spin_table.c
>     --> smp_spin_table_prepare_cpu,
> we suppose the cpu_release_addr[cpu] is located in kernel logical memory.
> 
> in Arm plarform, this part is implement by each platform driver, since
> they register its own smp_operations.
> 
> And in Arm64, once other platform use different area, such as register
> or device memory, to put cpu_release_addr[cpu], shall we use ioremap
> to get the va like below patch?

Platforms need to place the release address in memory which can be
mapped with cacheable attributes. That is required by the semantics of
memreserve (which implies a cacheable mapping is fine).

Since commit 113954c6463d1d80 ("arm64: spin-table: handle unmapped
cpu-release-addrs") we allowed for cpu-release-addrs which did not fall
in the linear mapping, by using ioremap_cache. This still requires that
the memory can be mapped cacheable.

As Arnd says, if the cpu-release-addr is not in memory which can be
mapped as cacheable, then you're arguably not implementing spin-table.
There are a whole slew of coherency issues that the current
implementation avoids by being very simple, and I'm not keen about
prospect of changing that.

Is there any particular reason that you do not wish to place your
cpu-release-addrs in memory?

Thanks,
Mark.

> 
> Appreciate your kind in advance,
> 
> diff --git a/arch/arm64/kernel/smp_spin_table.c
> b/arch/arm64/kernel/smp_spin_table.c
> index 7c35fa6..9d945bd 100644
> --- a/arch/arm64/kernel/smp_spin_table.c
> +++ b/arch/arm64/kernel/smp_spin_table.c
> @@ -21,6 +21,7 @@
>  #include <linux/smp.h>
> 
>  #include <asm/cacheflush.h>
> +#include <linux/io.h>
> 
>  static phys_addr_t cpu_release_addr[NR_CPUS];
> 
> @@ -47,10 +48,9 @@ static int __init smp_spin_table_prepare_cpu(int cpu)
>         if (!cpu_release_addr[cpu])
>                 return -ENODEV;
> 
> -       release_addr = __va(cpu_release_addr[cpu]);
> +       release_addr = ioremap(cpu_release_addr[cpu], SZ_4K);
>         release_addr[0] = (void *)__pa(secondary_holding_pen);
> -       __flush_dcache_area(release_addr, sizeof(release_addr[0]));
> -
> +       iounmap(release_addr);
>         /*
>          * Send an event to wake up the secondary CPU.
>          */
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
