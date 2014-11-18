From: broonie@kernel.org (Mark Brown)
Date: Tue, 18 Nov 2014 14:06:58 +0000
Subject: [PATCH v2 1/4] spi: Add 'last' flag to spi_transfer structure
In-Reply-To: <1416264471-774-2-git-send-email-b.galvani@gmail.com>
References: <1416264471-774-1-git-send-email-b.galvani@gmail.com>
 <1416264471-774-2-git-send-email-b.galvani@gmail.com>
Message-ID: <20141118140658.GI22111@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 11:47:48PM +0100, Beniamino Galvani wrote:

> +	list_for_each_entry(xfer, &master->cur_msg->transfers, transfer_list) {
> +		xfer->last = list_is_last(&xfer->transfer_list,
> +					  &master->cur_msg->transfers);
> +	}

It's incredibly sad to iterate through the entire list in order to find
the last entry, especially given that it's a doubly linked list and this
is a bit of a hot path.  We should look at the previous entry for the
list head instead, or perhaps better yet by doing this as part of
spi_validate() which already itereates over the entire list and is where
we do other similar fixups.

Though looking at this I'm not sure that a flag is the best approach at
all - why not just have the driver call list_is_last() in the transfer
function or ideally provide an inline function that does that so that we
can change the implementation later?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141118/e87d57a0/attachment.sig>
