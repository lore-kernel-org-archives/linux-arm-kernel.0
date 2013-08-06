From: horms@verge.net.au (Simon Horman)
Date: Tue, 6 Aug 2013 11:07:07 +0900
Subject: [PATCH 12/13] ARM: shmobile: Use clocksource_of_init() on r8a7790
In-Reply-To: <20130806012855.GB20940@verge.net.au>
References: <20130731190110.31796.96552.sendpatchset@w520>
 <20130731190300.31796.23926.sendpatchset@w520>
 <20130806012855.GB20940@verge.net.au>
Message-ID: <20130806020705.GC20940@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 06, 2013 at 10:28:56AM +0900, Simon Horman wrote:
> On Thu, Aug 01, 2013 at 04:03:00AM +0900, Magnus Damm wrote:
> > From: Magnus Damm <damm@opensource.se>
> > 
> > Replace the call to shmobile_timer_init() with
> > clocksource_of_init(). This will allow us to
> > get rid of shmobile_timer_init().
> > 
> > Signed-off-by: Magnus Damm <damm@opensource.se>
> > ---
> > 
> >  arch/arm/mach-shmobile/setup-r8a7790.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- 0001/arch/arm/mach-shmobile/setup-r8a7790.c
> > +++ work/arch/arm/mach-shmobile/setup-r8a7790.c	2013-08-01 03:17:48.000000000 +0900
> > @@ -263,7 +263,7 @@ void __init r8a7790_timer_init(void)
> >  	iounmap(base);
> >  #endif /* CONFIG_ARM_ARCH_TIMER */
> >  
> > -	shmobile_timer_init();
> > +	clocksource_of_init();
> >  }
> >  
> >  void __init r8a7790_init_delay(void)
> 
> I seem to need the following:
> 
> diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
> index 7301255..d0f5c9f 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7790.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7790.c
> @@ -18,6 +18,7 @@
>   * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>   */
>  
> +#include <linux/clocksource.h>
>  #include <linux/irq.h>
>  #include <linux/kernel.h>
>  #include <linux/of_platform.h>
> 
> 
> To avoid:
> 
> ...
>   CC      arch/arm/mach-shmobile/setup-r8a7790.o
> arch/arm/mach-shmobile/setup-r8a7790.c: In function ?r8a7790_timer_init?:
> arch/arm/mach-shmobile/setup-r8a7790.c:266:2: error: implicit declaration of function ?clocksource_of_init? [-Werror=implicit-function-declaration]
> cc1: some warnings being treated as errors
> make[1]: *** [arch/arm/mach-shmobile/setup-r8a7790.o] Error 1

As discussed off-line, I have squashed the above change into your patch.

The result, which I plan to push shortly, is as follows:

From: Magnus Damm <damm@opensource.se>

ARM: shmobile: Use clocksource_of_init() on r8a7790

Replace the call to shmobile_timer_init() with
clocksource_of_init(). This will allow us to
get rid of shmobile_timer_init().

Signed-off-by: Magnus Damm <damm@opensource.se>
[horms+renesas at verge.net.au: include linux/clocksource.h]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7790.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 86cf507..6d4aa04 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -18,6 +18,7 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/clocksource.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
@@ -263,7 +264,7 @@ void __init r8a7790_timer_init(void)
 	iounmap(base);
 #endif /* CONFIG_ARM_ARCH_TIMER */
 
-	shmobile_timer_init();
+	clocksource_of_init();
 }
 
 void __init r8a7790_init_delay(void)
-- 
1.8.3.2
