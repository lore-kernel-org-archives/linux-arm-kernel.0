From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 14 Apr 2015 16:59:41 +0100
Subject: [RFC PATCH 4/5] arm64: smp: move the pen to a header file
In-Reply-To: <1428601031-5366-5-git-send-email-galak@codeaurora.org>
References: <1428601031-5366-1-git-send-email-galak@codeaurora.org>
 <1428601031-5366-5-git-send-email-galak@codeaurora.org>
Message-ID: <20150414155941.GK28709@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 09, 2015 at 06:37:10PM +0100, Kumar Gala wrote:
> From: Abhimanyu Kapur <abhimany@codeaurora.org>
> 
> Move the secondary_pen_release variable and the secondary_holding_pen
> entry function to asm/smp_plat.h so that the other cpu ops implementations
> can share them.

If anything, this should all be moved into smp_spin_table.c, and made
static.

We made a mistake with the pen (and allowing multiple CPUs to enter the
kernel at once). That mistake shouldn't be spread further.

Mark.

> 
> Signed-off-by: Abhimanyu Kapur <abhimany@codeaurora.org>
> Signed-off-by: Kumar Gala <galak@codeaurora.org>
> ---
>  arch/arm64/include/asm/smp_plat.h  | 2 ++
>  arch/arm64/kernel/smp.c            | 1 +
>  arch/arm64/kernel/smp_spin_table.c | 3 ---
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/smp_plat.h b/arch/arm64/include/asm/smp_plat.h
> index 59e2823..235ff04 100644
> --- a/arch/arm64/include/asm/smp_plat.h
> +++ b/arch/arm64/include/asm/smp_plat.h
> @@ -34,10 +34,12 @@ static inline u32 mpidr_hash_size(void)
>  	return 1 << mpidr_hash.bits;
>  }
>  
> +extern void secondary_holding_pen(void);
>  /*
>   * Logical CPU mapping.
>   */
>  extern u64 __cpu_logical_map[NR_CPUS];
>  #define cpu_logical_map(cpu)    __cpu_logical_map[cpu]
> +extern volatile unsigned long secondary_holding_pen_release;
>  
>  #endif /* __ASM_SMP_PLAT_H */
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 328b8ce..4ce1f23 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -61,6 +61,7 @@
>   * where to place its SVC stack
>   */
>  struct secondary_data secondary_data;
> +volatile unsigned long secondary_holding_pen_release = INVALID_HWID;
>  
>  enum ipi_msg_type {
>  	IPI_RESCHEDULE,
> diff --git a/arch/arm64/kernel/smp_spin_table.c b/arch/arm64/kernel/smp_spin_table.c
> index b41a8b4..be833b9 100644
> --- a/arch/arm64/kernel/smp_spin_table.c
> +++ b/arch/arm64/kernel/smp_spin_table.c
> @@ -28,9 +28,6 @@
>  #include <asm/io.h>
>  #include <asm/smp_plat.h>
>  
> -extern void secondary_holding_pen(void);
> -volatile unsigned long secondary_holding_pen_release = INVALID_HWID;
> -
>  static phys_addr_t cpu_release_addr[NR_CPUS];
>  
>  /*
> -- 
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
