From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Mar 2015 14:49:44 +0000
Subject: [PATCH 2/5] mm: expose arch_mmap_rnd when available
In-Reply-To: <1425341988-1599-3-git-send-email-keescook@chromium.org>
References: <1425341988-1599-1-git-send-email-keescook@chromium.org>
 <1425341988-1599-3-git-send-email-keescook@chromium.org>
Message-ID: <20150309144944.GN8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 04:19:45PM -0800, Kees Cook wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 9f1f09a2bc9b..248d99cabaa8 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -3,6 +3,7 @@ config ARM
>  	default y
>  	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
>  	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
> +	select ARCH_HAS_ELF_RANDOMIZE
>  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>  	select ARCH_HAVE_CUSTOM_GPIO_H
>  	select ARCH_HAS_GCOV_PROFILE_ALL
> diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
> index 0f8bc158f2c6..3c1fedb034bb 100644
> --- a/arch/arm/mm/mmap.c
> +++ b/arch/arm/mm/mmap.c
> @@ -169,7 +169,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
>  	return addr;
>  }
>  
> -static unsigned long mmap_rnd(void)
> +unsigned long arch_mmap_rnd(void)
>  {
>  	unsigned long rnd = 0UL;
>  
> @@ -183,7 +183,7 @@ static unsigned long mmap_rnd(void)
>  
>  void arch_pick_mmap_layout(struct mm_struct *mm)
>  {
> -	unsigned long random_factor = mmap_rnd();
> +	unsigned long random_factor = arch_mmap_rnd();
>  
>  	if (mmap_is_legacy()) {
>  		mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;

For the above,

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
