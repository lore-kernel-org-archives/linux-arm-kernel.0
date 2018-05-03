From: broonie@kernel.org (Mark Brown)
Date: Fri, 4 May 2018 08:06:02 +0900
Subject: [PATCH] spi: bcm2835aux: ensure interrupts are enabled for
 shared handler
In-Reply-To: <20180503180945.3502-1-robh@kernel.org>
References: <20180503180945.3502-1-robh@kernel.org>
Message-ID: <20180503230602.GA13402@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 03, 2018 at 01:09:44PM -0500, Rob Herring wrote:

> The root cause however is a bug in the shared handler. Shared handlers
> must check that interrupts are actually enabled before servicing the
> interrupt. Add a check that the TXEMPTY or IDLE interrupts are enabled.

The requirement is more that the handler should correctly identify if it
actually handled an interrupt - especially if the driver doesn't enable
and disable the interrupt at runtime it's not going to upset anything to
always run the interrupt handling (and of course some hardware can't
disable things anyway) but if nohing happened then the handler needs to
return IRQ_NONE.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180504/fb07c019/attachment.sig>
