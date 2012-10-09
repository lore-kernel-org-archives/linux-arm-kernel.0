From: jonathan.austin@arm.com (Jonathan Austin)
Date: Tue, 09 Oct 2012 16:40:54 +0100
Subject: [PATCH 4/9] ARM: export default read_current_timer
In-Reply-To: <1349796183-30648-5-git-send-email-arnd@arndb.de>
References: <1349796183-30648-1-git-send-email-arnd@arndb.de>
 <1349796183-30648-5-git-send-email-arnd@arndb.de>
Message-ID: <50744586.6010806@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 09/10/12 16:22, Arnd Bergmann wrote:

> read_current_timer is used by get_cycles since "ARM: 7538/1: delay:
> add registration mechanism for delay timer sources", and get_cycles
> can be used by device drivers in loadable modules, so it has to
> be exported.
> 
> Without this patch, building imote2_defconfig fails with
> 
> ERROR: "read_current_timer" [crypto/tcrypt.ko] undefined!
[...]

>  arch/arm/lib/delay.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
> index 9d0a300..0dc5385 100644
> --- a/arch/arm/lib/delay.c
> +++ b/arch/arm/lib/delay.c
> @@ -45,6 +45,7 @@ int read_current_timer(unsigned long *timer_val)
>  	*timer_val = delay_timer->read_current_timer();
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(read_current_timer);


Perhaps this fits better in armksyms.c? That way it lives with
arm_delay_ops and friends.

I've got a patch doing it like that, which I can put in Russell's
patch-system, unless you prefer doing it in delay.c for any reason?

Jonny

(Here's the original patch sent to the kernel-janitors list and Will Deacon)
-------8<---------
On ARM, get_cycles() is implemented in terms of read_current_timer(), but
the latter is not exported to modules, resulting in failure to link:

  ERROR: "read_current_timer" [fs/ext4/ext4.ko] undefined!

This patch exports the symbol as required.

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
---
 arch/arm/kernel/armksyms.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/armksyms.c b/arch/arm/kernel/armksyms.c
index 60d3b73..6a37f8d 100644
--- a/arch/arm/kernel/armksyms.c
+++ b/arch/arm/kernel/armksyms.c
@@ -50,6 +50,7 @@ extern void fpundefinstr(void);
 
        /* platform dependent support */
 EXPORT_SYMBOL(arm_delay_ops);
+EXPORT_SYMBOL(read_current_timer);
 
        /* networking */
 EXPORT_SYMBOL(csum_partial);
-- 
1.7.1
