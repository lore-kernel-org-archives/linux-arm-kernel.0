From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 16:36:43 +0000
Subject: [PATCH] mmci: calculate remaining bytes at error correctly
In-Reply-To: <1296137666-30906-1-git-send-email-linus.walleij@stericsson.com>
References: <1296137666-30906-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110127163643.GG25968@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 27, 2011 at 03:14:26PM +0100, Linus Walleij wrote:
> The MMCIDATACNT register contain the number of byte left at error
> not the number of words, so loose the << 2 thing. Further if CRC
> fails on the first block, we may end up with a negative number
> of transferred bytes which is not good, and the formula was in
> wrong order.

Hmm.

In order to have a CRC error, you must have transferred one block through
the FIFO.  We might read the data counter before one block has been fully
transferred.

So, maybe we want:

	host->data_xfered = ((success - 1) / data->blksz) * data->blksz;

instead?
