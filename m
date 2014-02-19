From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 18 Feb 2014 22:40:33 -0500 (EST)
Subject: [PATCH RFC 03/31] mmc: sdio_irq: rework sdio irq handling
In-Reply-To: <E1WFmIP-0006li-SO@rmk-PC.arm.linux.org.uk>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
 <E1WFmIP-0006li-SO@rmk-PC.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.11.1402182233590.17677@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Feb 2014, Russell King wrote:

> Rather than the SDIO support spawning it's own thread for handling card
> interrupts, use the generic IRQ infrastructure for this, triggering it
> from the host interface's interrupt handling directly.
> 
> This avoids a race between the parent thread waiting to receive an
> interrupt response from the card, and the slow startup from the sdio
> irq thread, which can occur as a result of high system load (eg, while
> udev is running.)
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> =-DO NOT APPLY-=
>  drivers/mmc/core/sdio_irq.c | 41 +++++++++++++++++++++++++++++++----------
>  include/linux/mmc/host.h    |  3 +++
>  2 files changed, 34 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> index aaa90460ed23..f23d73993dc6 100644
> =-DO NOT APPLY-= a/drivers/mmc/core/sdio_irq.c
> =+DO NOT APPLY+= b/drivers/mmc/core/sdio_irq.c
> @@ -90,6 +90,15 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
>  	return ret;
>  }
>  
> =+DO NOT APPLY+=void sdio_run_irqs(struct mmc_host *host)
> =+DO NOT APPLY+={
> =+DO NOT APPLY+=	mmc_claim_host(host);
> =+DO NOT APPLY+=	host->sdio_irq_pending = true;
> =+DO NOT APPLY+=	process_sdio_pending_irqs(host);
> =+DO NOT APPLY+=	mmc_release_host(host);
> =+DO NOT APPLY+=}
> =+DO NOT APPLY+=EXPORT_SYMBOL_GPL(sdio_run_irqs);
> =+DO NOT APPLY+=

Could you please dispense with those obnoxious "DO NOT APPLY" strings 
all over the place?  That makes patch review very annoying.


Nicolas
