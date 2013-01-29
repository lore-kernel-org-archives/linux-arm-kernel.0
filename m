From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 29 Jan 2013 12:44:27 +0000
Subject: [PATCH] ARM: let CPUs not being able to run in ARM mode enter in
 THUMB mode
In-Reply-To: <1357904397-8476-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1357904397-8476-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20130129124427.GB1974@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 12:39:57PM +0100, Uwe Kleine-K?nig wrote:
> Some ARM cores are not capable to run in ARM mode (e.g. Cortex-M3). So
> obviously these cannot enter the kernel in ARM mode. Make an exception
> for them and let them enter in THUMB mode.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/kernel/head-nommu.S |    8 +++++++-
>  arch/arm/kernel/head.S       |    8 +++++++-
>  arch/arm/mm/Kconfig          |    6 ++++++
>  3 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
> index 3782320..ae7ed46 100644
> --- a/arch/arm/kernel/head-nommu.S
> +++ b/arch/arm/kernel/head-nommu.S
> @@ -32,15 +32,21 @@
>   * numbers for r1.
>   *
>   */
> -	.arm
>  
>  	__HEAD
> +
> +#ifdef CONFIG_THUMBONLY_CPU
> +	.thumb
> +ENTRY(stext)
> +#else
> +	.arm
>  ENTRY(stext)
>  
>   THUMB(	adr	r9, BSYM(1f)	)	@ Kernel is always entered in ARM.
>   THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
>   THUMB(	.thumb			)	@ switch to Thumb now.
>   THUMB(1:			)
> +#endif

The behaviour is that we start the file is kernel entry state, then
we switch to kernel run state.

The switch is only needed for kernels which run on CPUs supporting
both states, where the run state is not ARM.

So, it would be neater for these entry sequences to look something
like:

HAS_ARM(.arm)	@ because -mthumb is default for Thumb kernels anyway

ENTRY(stext)
HAS_ARM(THUMB(	@ code to switch to Thumb ))

	@ real code starts here, in run state.



Where

#ifdef CONFIG_THUMBONLY_CPU
#define HAS_ARM(x...)
#else
#define HAS_ARM(x...) x
#endif

(I haven't read the whole thread yet, so decisions about what
config variables and macro names should be used may be overridden
by other people...)


Thoughts?

Cheers
---Dave
