From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 30 Jul 2013 13:59:54 +0530
Subject: [PATCH 7/9] ARM: edma: Don't clear EMR of channel in edma_stop
In-Reply-To: <1375104595-16018-8-git-send-email-joelf@ti.com>
References: <1375104595-16018-1-git-send-email-joelf@ti.com>
 <1375104595-16018-8-git-send-email-joelf@ti.com>
Message-ID: <51F77982.7030601@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 July 2013 06:59 PM, Joel Fernandes wrote:
> We certainly don't want error conditions to be cleared anywhere

'anywhere' is a really loaded term.

> as this will make us 'forget' about missed events. We depend on
> knowing which events were missed in order to be able to reissue them.

> This fixes a race condition where the EMR was being cleared
> by the transfer completion interrupt handler.
> 
> Basically, what was happening was:
> 
>             Missed event
>              |
>              |
>              V
> SG1-SG2-SG3-Null
>          \
>           \__TC Interrupt (Almost same time as ARM is executing
> TC interrupt handler, an event got missed and also forgotten
> by clearing the EMR).

Sorry, but I dont see how edma_stop() is coming into picture in the race
you describe?

> The EMR is ultimately being cleared by the Error interrupt
> handler once it is handled so we don't have to do it in edma_stop.

This, I agree with. edma_clean_channel() also there to re-initialize the
channel so doing it in edma_stop() certainly seems superfluous.

Thanks,
Sekhar

> 
> Signed-off-by: Joel Fernandes <joelf@ti.com>
> ---
>  arch/arm/common/edma.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> index 10995b2..dec772e 100644
> --- a/arch/arm/common/edma.c
> +++ b/arch/arm/common/edma.c
> @@ -1328,7 +1328,6 @@ void edma_stop(unsigned channel)
>  		edma_shadow0_write_array(ctlr, SH_EECR, j, mask);
>  		edma_shadow0_write_array(ctlr, SH_ECR, j, mask);
>  		edma_shadow0_write_array(ctlr, SH_SECR, j, mask);
> -		edma_write_array(ctlr, EDMA_EMCR, j, mask);
>  
>  		pr_debug("EDMA: EER%d %08x\n", j,
>  				edma_shadow0_read_array(ctlr, SH_EER, j));
> 
