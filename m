From: broonie@kernel.org (Mark Brown)
Date: Wed, 9 Dec 2015 22:10:36 +0000
Subject: regmap-mmio and paged registers
In-Reply-To: <20151209214150.GH3515@piout.net>
References: <20151209214150.GH3515@piout.net>
Message-ID: <20151209221036.GK5727@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 09, 2015 at 10:41:50PM +0100, Alexandre Belloni wrote:

> 	/* It is possible to have selector register inside data window.
> 	   In that case, selector register is located on every page and
> 	   it needs no page switching, when accessed alone. */
> 	if (val_num > 1 ||
> 	    range->window_start + win_offset != range->selector_reg) {

> So it ends up never writing the page number in the register.

> One possible solution would be to implement our own .read and .write to
> handle that paging but maybe you can think of something else.

So to be explicit about the actual issue the problem here is that you
have data bits in the same register as your selector and indeed the
register map you're trying to page is a single register.  That's pretty
pathological.

Honestly looking at the register I'm not even convinced it is a paged
regmap, it looks more like a mailbox for communication with a
coprocessor than anything else (the fact that the selector is named PID,
the fact that the bitfields include CMD...).  Are you sure that it's a
good idea to represent this as a regmap at all?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151209/7d65c2bd/attachment.sig>
