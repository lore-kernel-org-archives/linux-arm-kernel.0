From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 20 Jul 2012 12:38:26 +0530
Subject: [RFC 1/4] ARM: OMAP3: cpuidle: Remove unused MPU OSWR support code
In-Reply-To: <1342764284-8143-2-git-send-email-rnayak@ti.com>
References: <1342764284-8143-1-git-send-email-rnayak@ti.com>
 <1342764284-8143-2-git-send-email-rnayak@ti.com>
Message-ID: <CAMQu2gzHBcYg=nhh1J2dsOGUcKBUj5MBTnJBafUPPo0uxxo7og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2012 at 11:34 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> We do not support MPU OSWR on OMAP3. Get rid of the complex/multiple
> save_state handling in omap_sram_idle() and just use 2 save_state
> definitions
>
With current mainline code, this is indeed true.

> save_state = 1, all logic and memory lost, MPU hits OFF
> save_state = 0, nothing lost, MPU hits CSWR or shallower state
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c    |   35 +++++++++--------------------------
>  arch/arm/mach-omap2/sleep34xx.S |    4 +---
>  2 files changed, 10 insertions(+), 29 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 7c7b173..8d96b1f 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -256,19 +256,16 @@ static void omap34xx_save_context(u32 *save)
>
>  static int omap34xx_do_sram_idle(unsigned long save_state)
>  {
> +       /*
> +        * save_state = 1 indicates all logic and memory/cache lost
> +        * save_state = 0 indicates nothing lost
> +        */
Keep the same comment with mention of the MPU
state like
save_state = 1, all logic and memory lost, MPU hits OFF
save_state = 0, nothing lost, MPU hits CSWR or shallower state

Rest of the code looks good.

Regards
santosh
