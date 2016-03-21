From: broonie@kernel.org (Mark Brown)
Date: Mon, 21 Mar 2016 13:07:34 +0000
Subject: [LINUX PATCH 1/2] mtd: Added dummy entry in the spi_transfer
 structure.
In-Reply-To: <1458562809-36114-1-git-send-email-lakshmis@xilinx.com>
References: <1458562809-36114-1-git-send-email-lakshmis@xilinx.com>
Message-ID: <20160321130734.GS2566@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 21, 2016 at 05:50:08PM +0530, P L Sai Krishna wrote:
> This patch does following things.
> 1. Added dummy entry in the spi_transfer structure.
> 2. Assigned dummy cycles to dummy member in the transfer
> structure during read operation.

Please try to follow the patch submission process covered in
SubmittingPatches, in particular please use subject lines reflecting the
style for the subsystem (which helps people identify relevant changes to
review) and...

>  drivers/mtd/devices/m25p80.c | 1 +
>  include/linux/spi/spi.h      | 2 ++
>  2 files changed, 3 insertions(+)

...split things up into individual patches, for example here you're
both adding a new feature and adding a user of that feature in a single
patch.

> + * @dummy: number of dummy cycles.

This needs to be clearer about what a dummy cycle is and where it gets
inserted.  We probably also want a better name, just "dummy" makes it
look like a padding field in the structure.  How about dummy_cycles?

> @@ -752,6 +753,7 @@ struct spi_transfer {
>  	u8		bits_per_word;
>  	u16		delay_usecs;
>  	u32		speed_hz;
> +	u32		dummy;
>  
>  	struct list_head transfer_list;
>  };

This isn't enough to add the feature - a client driver trying to make
use of this needs to be able to tell if the cycles are actually going to
be inserted.  I'd expect to see a capability flag that can be checked
and some error checking so that if we try to do a transfer with dummy
cycles and can't support it we don't silently ignore the dummy cycles,
ideally also something that'll handle multiples of 8 bits with SPI
controllers that don't otherwise support this feature.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160321/5991feb1/attachment.sig>
