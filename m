From: b.galvani@gmail.com (Beniamino Galvani)
Date: Tue, 18 Nov 2014 23:55:46 +0100
Subject: [PATCH v2 1/4] spi: Add 'last' flag to spi_transfer structure
In-Reply-To: <20141118140658.GI22111@sirena.org.uk>
References: <1416264471-774-1-git-send-email-b.galvani@gmail.com>
 <1416264471-774-2-git-send-email-b.galvani@gmail.com>
 <20141118140658.GI22111@sirena.org.uk>
Message-ID: <20141118225546.GA27182@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 18, 2014 at 02:06:58PM +0000, Mark Brown wrote:
> It's incredibly sad to iterate through the entire list in order to find
> the last entry, especially given that it's a doubly linked list and this
> is a bit of a hot path.  We should look at the previous entry for the
> list head instead, or perhaps better yet by doing this as part of
> spi_validate() which already itereates over the entire list and is where
> we do other similar fixups.
> 
> Though looking at this I'm not sure that a flag is the best approach at
> all - why not just have the driver call list_is_last() in the transfer
> function or ideally provide an inline function that does that so that we
> can change the implementation later?

I didn't realize that the master structure passed to transfer_one()
has a reference to the current message and thus to the transfer
list. Then yes, the additional flag in the transfer structure probably
doesn't make much sense.

Would it be better to introduce something like:

static inline bool
spi_transfer_is_last(struct spi_master *master, struct spi_transfer *xfer)
{
        return list_is_last(&xfer->transfer_list, &master->cur_msg->transfers);
}

or open code it in the driver?

Beniamino
