From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 26 Jun 2014 10:59:28 +1000
Subject: [PATCH v2] sched: Fix compiler warnings
In-Reply-To: <1403658329-13196-1-git-send-email-linux@roeck-us.net>
References: <1403658329-13196-1-git-send-email-linux@roeck-us.net>
Message-ID: <20140626105928.5f375f0c@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter,

[I know I'm a bit late to this, but ...]

On Tue, 24 Jun 2014 18:05:29 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
>
> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> index 9d85318..e35d880 100644
> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -275,7 +275,7 @@ void store_cpu_topology(unsigned int cpuid)
>  		cpu_topology[cpuid].socket_id, mpidr);
>  }
>  
> -static inline const int cpu_corepower_flags(void)
> +static inline int cpu_corepower_flags(void)
>  {
>  	return SD_SHARE_PKG_RESOURCES  | SD_SHARE_POWERDOMAIN;
>  }

The only reference to this function is to take its address, so "inline"
is useless, right?

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 306f4f0..0376b05 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -872,21 +872,21 @@ enum cpu_idle_type {
>  #define SD_NUMA			0x4000	/* cross-node balancing */
>  
>  #ifdef CONFIG_SCHED_SMT
> -static inline const int cpu_smt_flags(void)
> +static inline int cpu_smt_flags(void)
>  {
>  	return SD_SHARE_CPUCAPACITY | SD_SHARE_PKG_RESOURCES;
>  }
>  #endif
>  
>  #ifdef CONFIG_SCHED_MC
> -static inline const int cpu_core_flags(void)
> +static inline int cpu_core_flags(void)
>  {
>  	return SD_SHARE_PKG_RESOURCES;
>  }
>  #endif
>  
>  #ifdef CONFIG_NUMA
> -static inline const int cpu_numa_flags(void)
> +static inline int cpu_numa_flags(void)
>  {
>  	return SD_NUMA;
>  }

The same is true of those three, but then they would have to be moved
into a .c file and replaced with prototypes ...

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140626/d0b1ed89/attachment.sig>
