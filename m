From: jonathan.austin@arm.com (Jonathan Austin)
Date: Fri, 11 Jan 2013 15:34:39 +0000
Subject: [PATCH] ARM: let CPUs not being able to run in ARM mode enter
 in THUMB mode
In-Reply-To: <1357904397-8476-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1357904397-8476-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <50F0310F.3070502@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,
On 11/01/13 11:39, Uwe Kleine-K?nig wrote:
> Some ARM cores are not capable to run in ARM mode (e.g. Cortex-M3). So
> obviously these cannot enter the kernel in ARM mode. Make an exception
> for them and let them enter in THUMB mode.

Clearly something like this is necessary, but it isn't something I'd 
like for people to start using *unless* they have a THUMB only CPU (for 
example, to work around dodgy boot-loaders, etc)

Seeing as there are no THUMB-only CPUs with an MMU, I think we could 
safely constrain this change to:
a) depend on !MMU
b) only touch head-nommu.S

Does that cause any issue for what you're doing.

[...]

> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 3fd629d..bc3150c 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -1,5 +1,11 @@
>   comment "Processor Type"
>
> +# Select this if your CPU doesn't support the 32 bit ARM instructions.
> +config THUMBONLY_CPU
> +	bool
> +	select THUMB2_KERNEL
> +	select ARM_THUMB
> +
>   # Select CPU types depending on the architecture selected.  This selects
>   # which CPUs we support in the kernel image, and the compiler instruction
>   # optimiser behaviour.

Also, a couple of minor questions about this:
- What's the rationale for the placement within the file - it looks a 
bit curious up the top there.
- Given the fact that we don't want people using this except in very 
specific circumstances, should we write a little bit of help for the option?


Jonny
