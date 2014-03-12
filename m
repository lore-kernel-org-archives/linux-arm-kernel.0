From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 12 Mar 2014 13:07:37 -0600
Subject: [RFC PATCH v2 04/14] mtd: nand: define struct nand_timings
In-Reply-To: <53208F7D.8090104@gmail.com>
References: <1391006064-28890-1-git-send-email-b.brezillon.dev@gmail.com>
 <1391006064-28890-5-git-send-email-b.brezillon.dev@gmail.com>
 <531DC1A4.7010208@gmail.com>
 <20140311185554.GD31835@obsidianresearch.com>
 <53208F7D.8090104@gmail.com>
Message-ID: <20140312190737.GA27388@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 05:46:53PM +0100, Boris BREZILLON wrote:

> >>I see at least 3 of those timings that could be useful (for the moment) :
> >>- tR: this one should be used to fill the chip_delay field
> >>- tPROG and tBERS: could be used within nand_wait to choose the timeo
> >>   value appropriately.
> >IIRC these timing values are really only necessary if the controller
> >does not support the READY/BUSY input, in that case drivers typically
> >seem to use 'chip_delay' which is the maximum possible command
> >execution time (a sleep long enough to guarentee that READY/BUSY is
> >de-asserted).

> You're right about tR (or chip_delay): it's only used when there are
> no R/B pin.  I experienced it when I tried the RB_NONE case in the
> sunxi driver: the default chip_delay set by the NAND core code was
> too small to fit the NAND chip requirements.
> 
> Anyway, I really think the chip_delay field should be set according
> to NAND chip characteristics not harcoded in NAND controller driver
> code (as currently done).

Drivers these days are often taking this value from the DT node
property 'chip-delay'. I think this would be nice to have in common
code too...

> tPROG and tBERS, would be used in nand_wait function and do not
> depend on the R/B pin.  These are just used as timeouts.

tPROG/tBERS have that special mode where R/B remains asserted but you
can still issue a status read to the chip to check on the command, so
the timeout required here is just a big number to detect failed NAND
controllers, it isn't really too important to have an exact value..

> >>Or should I create a new struct for these timings ?
> >>In the latter case how should I name it ?
> >struct onfi_command_timings ?
> 
> I'm not a big fan of this name. I think timing structs should not
> contain onfi in their names, because these timings are also
> available on non ONFI chips.

Explicitly defering to the ONFI spec makes it clear what the
definition of the timing parameter actually is.

If JEDEC has a different model then drivers will need to configure
their interfaces a little differently.

So we might end up with a jedec_sdr_timings too :|

> What do you think ?

I'd focus on getting the bus timings working before tackling too much
more ...

Jason
