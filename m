From: marex@denx.de (Marek Vasut)
Date: Mon, 24 Aug 2015 19:45:33 +0200
Subject: [PATCH linux-next v4 5/5] mtd: atmel-quadspi: add driver for
 Atmel QSPI controller
In-Reply-To: <55DB4EA6.9090807@atmel.com>
References: <cover.1440410236.git.cyrille.pitchen@atmel.com>
 <201508241303.52066.marex@denx.de> <55DB4EA6.9090807@atmel.com>
Message-ID: <201508241945.33577.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 24, 2015 at 07:04:38 PM, Cyrille Pitchen wrote:
> Hi Marek,

Hi!

> Le 24/08/2015 13:03, Marek Vasut a ?crit :
> > On Monday, August 24, 2015 at 12:14:00 PM, Cyrille Pitchen wrote:
> >> This driver add support to the new Atmel QSPI controller embedded into
> >> sama5d2x SoCs. It expects a NOR memory to be connected to the QSPI
> >> controller.

[...]

> >> +	/* Compute address parameters */
> >> +	switch (cmd->enable.bits.address) {
> >> +	case 4:
> >> +		ifr |= QSPI_IFR_ADDRL;
> >> +		/*break;*/ /* fallback to the 24bit address case */
> > 
> > What's this commented out bit of code for ? :-)
> 
> I just wanted to stress out there was no missing "break;".
> I've reworded the comment to:
> /* No "break" on purpose: fallback to the 24bit address case. */

Oh, the address is in bytes . I see, yes, it makes sense to be more
explicit here about the purpose of the fallback. I think this change
in the comment will make it easier for everyone who comes back in a
few years and reads this code.

> >> +	case 3:
> >> +		iar = (cmd->enable.bits.data) ? 0 : cmd->address;
> >> +		ifr |= QSPI_IFR_ADDREN;
> >> +		break;
> >> +	case 0:
> >> +		break;
> >> +	default:
> >> +		return -EINVAL;
> >> +	}
> > 
> > [...]
> > 
> >> +no_data:
> >> +	/* Poll INSTRuction End status */
> >> +	sr = qspi_readl(aq, QSPI_SR);
> >> +	if (sr & QSPI_SR_INSTRE)
> >> +		return err;
> >> +
> >> +	/* Wait for INSTRuction End interrupt */
> >> +	init_completion(&aq->completion);
> > 
> > You should use reinit_completion() in the code. init_completion()
> > should be used only in the probe() function and nowhere else.
> 
> Alright. In the next version I'll rename the "completion" member of
> struct atmel_qspi into "cmd_completion". Also I'll add another
> dma_completion member in this very same structure to replace the local
> "struct completion completion" in atmel_qspi_run_dma_transfer().
> 
> Then I'll call init_completion() on both cmd_completion and dma_completion
> only from atmel_qspi_probe() and reinit_completion() elsewhere.
> 
> >> +	aq->pending = 0;
> >> +	qspi_writel(aq, QSPI_IER, QSPI_SR_INSTRE);
> >> +	if (!wait_for_completion_timeout(&aq->completion,
> >> +					 msecs_to_jiffies(1000)))
> >> +		err = -ETIMEDOUT;
> >> +	qspi_writel(aq, QSPI_IDR, QSPI_SR_INSTRE);
> >> +
> >> +	return err;
> >> +}
> > 
> > [...]
> > 
> > Hope this helps :)
> 
> Indeed, it does! I still work on the next version of this series to take
> all your comments into account.

Thanks :)
