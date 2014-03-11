From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 11 Mar 2014 12:55:54 -0600
Subject: [RFC PATCH v2 04/14] mtd: nand: define struct nand_timings
In-Reply-To: <531DC1A4.7010208@gmail.com>
References: <1391006064-28890-1-git-send-email-b.brezillon.dev@gmail.com>
 <1391006064-28890-5-git-send-email-b.brezillon.dev@gmail.com>
 <531DC1A4.7010208@gmail.com>
Message-ID: <20140311185554.GD31835@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 10, 2014 at 02:44:04PM +0100, Boris BREZILLON wrote:

> Some timings are missing here (see Table 55 in the ONFI spec):

Right..

The 'mode' covers only the raw electrical parameters needed to
exchange commands, other timings cover the commands
themselves. Notably the timing mode does not alter those parameters.

To me it seems tidy to keep the 'mode' timings contained in their own
struct and find other homes for the other parameters.

> -tR
> -tBERS
> -tCCS
> -tPLEBSY
> -...
> 
> I see at least 3 of those timings that could be useful (for the moment) :
> - tR: this one should be used to fill the chip_delay field
> - tPROG and tBERS: could be used within nand_wait to choose the timeo
>   value appropriately.

IIRC these timing values are really only necessary if the controller
does not support the READY/BUSY input, in that case drivers typically
seem to use 'chip_delay' which is the maximum possible command
execution time (a sleep long enough to guarentee that READY/BUSY is
de-asserted).

> Or should I create a new struct for these timings ?
> In the latter case how should I name it ?

struct onfi_command_timings ?

Regards,
Jason
