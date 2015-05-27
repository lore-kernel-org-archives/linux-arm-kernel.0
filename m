From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 May 2015 12:06:36 +0200
Subject: some question about arm64 smp_spin_table.c
In-Reply-To: <CADUS3o=4b9zfKtyiZ2CKgC2AA9ntkFLo91pJug17t1Xz2jM34w@mail.gmail.com>
References: <CADUS3o=4b9zfKtyiZ2CKgC2AA9ntkFLo91pJug17t1Xz2jM34w@mail.gmail.com>
Message-ID: <2349133.7jIxnW0uLz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 May 2015 17:47:09 yoma sophian wrote:
> And in Arm64, once other platform use different area, such as register
> or device memory, to put cpu_release_addr[cpu], shall we use ioremap
> to get the va like below patch?
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
> 

I believe that won't work: The other CPU is spinning on its L1 cache,
and with ioremap, you would be bypassing the cache.

Basically, if the CPU uses something other than normal memory, it is
not using the spin-table protocol.

	Arnd
