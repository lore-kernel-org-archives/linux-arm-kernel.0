From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 28 Apr 2015 18:06:17 +0200
Subject: [PATCH 03/11] arm/mach-mvebu: remove legacy __cpuinit sections
 that crept in
In-Reply-To: <1430174880-27958-4-git-send-email-paul.gortmaker@windriver.com>
References: <1430174880-27958-1-git-send-email-paul.gortmaker@windriver.com>
 <1430174880-27958-4-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <553FAFF9.4030100@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 28/04/2015 00:47, Paul Gortmaker wrote:
> We removed __cpuinit support (leaving no-op stubs) quite some time
> ago.  However these ones crept back in as of commit 1ee89e2231a1b04dc3476
> ("ARM: mvebu: add SMP support for Armada 375 and Armada 38x")
> 
> Since we want to clobber the stubs soon, get this removed now.
> Note that there would normally be a corresponding removal of
> a ".previous" directive for each __CPUINIT in asm files, but in
> this case it appears that this single function file was never
> paired off with one.
> 

Of course you have my
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Usually the patch modifying these files should be merged through the
mvebu subsystem. However, if your last patch is merged before this one
we will lose the bisectability. As I don't expect any big changes in
these 2 files for the next merge window, I don't think there will be a
merge conflict, so you can push this patch along the last one to the
appropriate git tree.

Thanks,

Gregory




> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  arch/arm/mach-mvebu/headsmp-a9.S | 3 ---
>  arch/arm/mach-mvebu/platsmp-a9.c | 2 +-
>  2 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-mvebu/headsmp-a9.S b/arch/arm/mach-mvebu/headsmp-a9.S
> index 08d5ed46b996..f6a1b5b153af 100644
> --- a/arch/arm/mach-mvebu/headsmp-a9.S
> +++ b/arch/arm/mach-mvebu/headsmp-a9.S
> @@ -13,12 +13,9 @@
>   */
>  
>  #include <linux/linkage.h>
> -#include <linux/init.h>
>  
>  #include <asm/assembler.h>
>  
> -	__CPUINIT
> -
>  ENTRY(mvebu_cortex_a9_secondary_startup)
>  ARM_BE8(setend	be)
>  	bl      v7_invalidate_l1
> diff --git a/arch/arm/mach-mvebu/platsmp-a9.c b/arch/arm/mach-mvebu/platsmp-a9.c
> index df0a9cc5da59..3d5000481c11 100644
> --- a/arch/arm/mach-mvebu/platsmp-a9.c
> +++ b/arch/arm/mach-mvebu/platsmp-a9.c
> @@ -24,7 +24,7 @@
>  
>  extern void mvebu_cortex_a9_secondary_startup(void);
>  
> -static int __cpuinit mvebu_cortex_a9_boot_secondary(unsigned int cpu,
> +static int mvebu_cortex_a9_boot_secondary(unsigned int cpu,
>  						    struct task_struct *idle)
>  {
>  	int ret, hw_cpu;
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
