From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Aug 2015 11:54:43 +0100
Subject: [PATCH 05/20] regmap: Restructure writes in _regmap_raw_write()
In-Reply-To: <1439374365-20623-6-git-send-email-mpa@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-6-git-send-email-mpa@pengutronix.de>
Message-ID: <20150812105443.GT10748@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 12:12:30PM +0200, Markus Pargmann wrote:
> Currently we try to write the data without copying directly using
> bus->write() or bus->gather_write() if it exists. If one of the previous
> tries to write reported -ENOTSUPP or none of them were usable, we copy
> the data into a buffer and use bus->write().
> 
> However it does not make sense to try bus->write() a second time with a
> copied buffer if it didn't work the first time.
> 
> This patch restructures this if/else block to make it clear that this is
> not intended for the case where bus->write() returns -ENOTSUPP.

I'm not entirely convinced that this is an improvement.  The main effect
that I'm seeing is an increase in the indentation level and there are
potential issues with the write operation being unable to work with some
kinds of memory (like restrictions about dmaing from stack or unalinged
memory for example) which mean that copying into a newly allocated
buffer may actually help.  I don't think we detect any such restrictions
at the minute but the defensiveness is nice and I'd really hope that the
failed write case isn't any kind of fast path.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/ffeed222/attachment.sig>
