From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 30 Jul 2014 00:45:00 -0700
Subject: [PATCH v2 03/10] mtd: spi-nor: add DDR quad read support
In-Reply-To: <20140730064413.GA15547@shldeISGChi005.sh.intel.com>
References: <1398657227-20721-1-git-send-email-b32955@freescale.com>
 <1398657227-20721-4-git-send-email-b32955@freescale.com>
 <20140730050843.GE11952@brian-ubuntu>
 <20140730064413.GA15547@shldeISGChi005.sh.intel.com>
Message-ID: <20140730074500.GF11952@brian-ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Mark

On Wed, Jul 30, 2014 at 02:44:13PM +0800, Huang Shijie wrote:
> On Tue, Jul 29, 2014 at 10:08:43PM -0700, Brian Norris wrote:
> > On Mon, Apr 28, 2014 at 11:53:40AM +0800, Huang Shijie wrote:
> > > This patch adds the DDR quad read support by the following:
> > 
> > To Mark / linux-spi:
> > 
> > Are DDR modes in the scope of drivers/spi/ at all, so that we could
> > someday wire it up through m25p80.c? Or is 'DDR' such a distortion of
> > the meaning of 'SPI' such that it will be restricted only to SPI NOR
> > dedicated controllers?
> 
> IMHO, the DDR modes can _NOT_ be handled by the driver/spi/*.

I agree to some extent, but I wanted to confirm with the SPI guys that
DDR is truly unique to SPI NOR. (I know it doesn't currently support
it.)

> The SPI can only handles the byte streams.

Sure.

> But the DDR mode may need to
> handle the cycles(such as the dummy cycles could be 7 cycles) which is not byte.

But that's the same story for some (but not all) of the dual and quad
modes now; some have dummy cycles that are not multiples of 8 bits.

Because there are some DDR modes which have 8 dummy cycles, it is
theoretically possible for the SPI subsystem to handle them.

> So the DDR mode is handled by the SPI NOR controller now.

Right.

BTW, does your quadspi controller unconditionally support DDR, or is
there any dependency on board/clock configuration? I'm just curious
whether you need a DT binding to describe DDR support, or if (as long as
the flash supports it, and we get the dummy cycles right) you can always
use DDR QUAD.

> Please correct me if I am wrong. :)
> 
> > >   [1] add SPI_NOR_DDR_QUAD read mode.
> > > 
> > >   [2] add DDR Quad read opcodes:
> > >        SPINOR_OP_READ_1_4_4_D / SPINOR_OP_READ4_1_4_4_D
> > > 
> > >   [3] add set_ddr_quad_mode() to initialize for the DDR quad read.
> > >       Currently it only works for Spansion NOR.
> > > 
> > >   [3] about the dummy cycles.
> > >       We set the dummy with 8 for DDR quad read by default.
> > 
> > Why? That seems wrong. You need to know for sure how many cycles should
> > be used, not just guess a default.
> 
> Do you mean that if people do not set the DT node for dummy, we should
> return an -EINVAL immediately?

Possibly. But I actually don't think this belongs in DT at all. See
below.

> > >       The m25p80.c can not support the DDR quad read, but the SPI NOR controller
> > >       can set the dummy value in its child DT node, and the SPI NOR framework
> > >       can parse it out.
> > 
> > Why does the dummy value belong in device tree? I think this can be
> > handled in software.

Can you answer me this question?

> > You might, however, want a few other hardware
> > description parameters in device tree to help you.
> > 
> > So I think spi-nor.c needs to know a few things:
> > 
> >  1. Does the hardware/driver support DDR clocking?
> >  2. What granularity of dummy cycles are supported? So m25p80.c needs to
> >     communicate that it only supports dummy cycles of multiples of 8,
> >     and fsl-quadspi supports single clock cycles.
> 
> I think you can send patches for these features. I does not clear about:
>   for what does the spi-nor needs to know the above things.

To properly abstract features between a driver and the spi-nor
"library." For example, we need to make sure we don't try to use a
command mode with 7 dummy cycles on m25p80.c; right now, each driver has
to (implicitly) know the details of dummy cycles when selecting a 'mode'
parameter for spi_nor_scan(). spi-nor.c should be selecting this for us,
not forcing the driver to make the selection.

> > And spi-nor.c should be able to do the following:
> > 
> >  3. Set how many dummy cycles should be used.
> where can we get the number of the cycles? 

This should be a property of the flash device, just like everything else
we detect in spi-nor.c.

> >  4. Write to the configuration register, to choose a Latency Code
> >     according to what the flash supports. I see modes that support 3, 6,
> >     7, or 8. We'd probably just go for the fastest mode, which requires
> >     8, right?
> not right.
> 
> The DDR mode can not work if we set a wrong dummy cycles for the flash.
> 
> for some chips, the fastest mode may need 6 cycles, not 8. 

OK, but can spi-nor.c detect this instead of putting this in DT? e.g.,
associate this with the device ID?

Or even better, we can support CFI detection for SPI NOR flash. I notice
the datasheet for your Spansion flash [1] has an extensive set of CFI
parameters defined, including the dummy cycle information. I think it
might be more sustainable to try to support CFI [2] and SFDP [3] for
detecting new flash, rather than adding new table entries ad-hoc.

> > So far, none of this seems to require a DT binding, unless there's
> > something I'm missing about your fsl-quadspi controller.
> > 
> > > Test this patch for Spansion s25fl128s NOR flash.
> > > 
> > > Signed-off-by: Huang Shijie <b32955@freescale.com>
> > > ---
> > > +	/* DDR Quad/Quad/Dual-read mode takes precedence over fast/normal */
> > > +	if (mode == SPI_NOR_DDR_QUAD && info->flags & SPI_NOR_DDR_QUAD_READ) {
> > 
> > Hmm, I think I should probably take another look at the design of
> > spi-nor.c... Why does spi_nor_scan() take a single 'mode' argument? The
> > driver should be communicating which (multiple) modes it supports, not
> > selecting a single mode. spi-nor.c is the only one which knows what the
> > *flash* supports, so it should be combining knowledge from the
> > controller driver with its own knowledge of the flash.
> 
> It is okay for me to add multiples modes for the spi_nor_scan().
> I added the single mode for spi_nor_scan is because that the fsl-quadspi
> does not want to support the low speed modes. (Of course, the fsl-quadspi
> controller does support the low speed modes.)

Right, fsl-quadspi only supports one mode. But m25p80.c is more
flexible, and I think we might have broken some of it in the process
(e.g., if the SPI controller supports single/dual/quad but the flash
only supports single, then we might fail to probe).

I can take a look at this problem if you don't. I'd just recommend that
we might take a step back on a few of these issues before blazing ahead
with something irrevocable, like a DT binding.

> > > +		ret = set_ddr_quad_mode(nor, info->jedec_id);
> > > +		if (ret) {
> > > +			dev_err(dev, "DDR quad mode not supported\n");
> > > +			return ret;
> > 
> > A ramification of my comment above is that we should not be returning an
> > error in a situation like this; we should be able to fall back to
> > another known-supported mode, like SDR QUAD, SDR DUAL, or just plain
> > SPI -- if they're supported by the driver -- and spi-nor.c doesn't
> > currently have enough information to do this.
> ok.
> > 
> > > +		}
> > > +		nor->flash_read = SPI_NOR_DDR_QUAD;
> > >  
> > >  /**
> > 
> > So, I'll have to take another hard look at spi-nor.c soon. I think we
> > may need to work on the abstractions here a bit more before I merge any
> > new features like this.
> 
> okay.  no problem.
> 
> > 
> > Regards,
> > Brian
> > 
> > P.S. Is there a good reason we've defined a whole read_xfer/write_xfer
> > API that is completely unused?
> These hooks are designed for other SPI NOR drivers, the fsl-quadspi does
> not use them.

Brian

[1] http://www.spansion.com/Support/Datasheets/S25FL128S_256S_00.pdf

[2] http://www.jedec.org/sites/default/files/docs/jesd68-01.pdf

    plus some of the vendor extensions which are documented in their
    datasheets

[3] http://www.macronix.com/Lists/ApplicationNote/Attachments/667/AN114v1-SFDP%20Introduction.pdf

    http://www.jedec.org/sites/default/files/docs/JESD216.pdf
    (login wall)
