From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 4 Apr 2012 14:07:34 -0500
Subject: [PATCH] ARM: vic: re-read status register before dispatching
 each IRQ handler
In-Reply-To: <1333533912-30813-1-git-send-email-will.deacon@arm.com>
References: <1333533912-30813-1-git-send-email-will.deacon@arm.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F002069840A167@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, April 04, 2012 3:05 AM, Will Deacon wrote:
>
> handle_IRQ may briefly cause interrupts to be re-enabled during soft IRQ
> processing on the exit path, leading to nested handling of VIC interrupts.
>
> Since the current code does not re-read the VIC_IRQ_STATUS register, this
> can lead to multiple invocations of the same interrupt handler and
> spurious interrupts to be reported.
>
> This patch changes the VIC interrupt dispatching code to re-read the
> status register each time, avoiding duplicate invocations of the same
> handler.
>
> Acked-and-tested-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Reviewed-by: Jamie Iles <jamie@jamieiles.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>
> Taken against v3.4-rc1 and tested on Versatile AB 926 (+ PL011 NULL
> pointer fix). I'll put this in the patch system tomorrow if there aren't
> any objections.
>
>  arch/arm/common/vic.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
> index 7a66311..6b1de5d 100644
> --- a/arch/arm/common/vic.c
> +++ b/arch/arm/common/vic.c
> @@ -435,11 +435,9 @@ static int handle_one_vic(struct vic_device *vic, struct pt_regs *regs)
>  	u32 stat, irq;
>  	int handled = 0;
>  
> -	stat = readl_relaxed(vic->base + VIC_IRQ_STATUS);
> -	while (stat) {
> +	while ((stat = readl_relaxed(vic->base + VIC_IRQ_STATUS))) {
>  		irq = ffs(stat) - 1;
>  		handle_IRQ(irq_find_mapping(vic->domain, irq), regs);
> -		stat &= ~(1 << irq);
>  		handled = 1;
>  	}

You probably should fix the comment above the function:

/*
 * Handle each interrupt in a single VIC.  Returns non-zero if we've
 * handled at least one interrupt.  This does a single read of the
 * status register and handles all interrupts in order from LSB first.
 */

You are no longer doing a single read. You might mention the problem
caused by the single read so that no one tries to "optimize" the loop
and reintroduce the problem.

Regards,
Hartley
