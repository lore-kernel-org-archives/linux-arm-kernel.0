From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Mon, 8 Feb 2016 17:23:02 +0200
Subject: [PATCH v4] dmaengine: edma: fix residue race for cyclic
In-Reply-To: <87k2mu2e16.fsf@linutronix.de>
References: <87k2mu2e16.fsf@linutronix.de>
Message-ID: <CAHp75Vc6th4OnvN1AhVY2Y5KrS+Agza87r6b=dBY97EGQ+p8kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2016 at 12:29 PM, John Ogness <john.ogness@linutronix.de> wrote:
> When retrieving the residue value, the SRC/DST fields of the
> active PaRAM are read to determine the current position of
> the DMA engine. However, the AM335x Technical Reference Manual
> states:

> +       /*
> +        * "pos" may represent a transfer request that is still being
> +        * processed by the EDMACC or EDMATC. We will busy wait until
> +        * any one of the situations occurs:
> +        *   1. the DMA hardware is idle
> +        *   2. a new transfer request is setup
> +        *   3. we hit the loop limit
> +        */
> +       while (edma_read(echan->ecc, EDMA_CCSTAT) & EDMA_CCSTAT_ACTV) {
> +               /* check if a new transfer request is setup */
> +               if (edma_get_position(echan->ecc,
> +                                     echan->slot[0], dst) != pos) {
> +                       break;
> +               }
> +
> +               if (!--loop_count) {

More usual pattern is

while (... && --count) {
}
if (!count) {
 Timeout!
}

But since it's minor and already applied, just take into consideration
for the future.

> +                       dev_dbg_ratelimited(echan->vchan.chan.device->dev,
> +                               "%s: timeout waiting for PaRAM update\n",
> +                               __func__);
> +                       break;
> +               }
> +
> +               cpu_relax();
> +       }

-- 
With Best Regards,
Andy Shevchenko
