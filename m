From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 21 Nov 2012 13:29:56 -0700
Subject: [PATCH] ARM: Kirkwood: Add SPI_CHPA and SPI_CPOL support to
 spi-orion
In-Reply-To: <20121121193552.GE15800@titan.lakedaemon.net>
References: <20121121192335.GA14868@obsidianresearch.com>
 <20121121193552.GE15800@titan.lakedaemon.net>
Message-ID: <20121121202956.GA15020@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 02:35:52PM -0500, Jason Cooper wrote:

> >  	/* we support only mode 0, and no options */
> > -	master->mode_bits = 0;
> > +	master->mode_bits = SPI_CPHA | SPI_CPOL;
> 
> The comment no longer seems valid.  ;-)  Also, you are unconditionally
> enabling these modes.  Do all users of this driver support this?

Right on the comment.. Not sure about your second query?

 * @mode_bits: flags understood by this controller driver

The mode_bits need to be set so the mid layer will allow consumers to
pass them down through spi->mode when it calls into
orion_spi_setup_transfer. So that looks correct..

Now, it seems a fair question what mode the driver will run in by
default now.. Previously, the driver didn't change the CPOL and CPHA
bits, so whatever the boot firmware left them at will be the mode it
uses.

If SPI consumers are not properly requesting the proper CPOL/CPHA
operation and instead relying on the boot firmware to leave the proper
bit settings then things will break for those users (they will need to
update their board's DT file, or otherwise) - but I don't see any way
to address that and implement proper programmable support?

This could affect at least dove, dreamplug, ts219 and lsxl.

Jason
