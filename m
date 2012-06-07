From: balbi@ti.com (Felipe Balbi)
Date: Thu, 7 Jun 2012 10:33:24 +0300
Subject: [PATCH 04/11] ARM: OMAP2+: usb_host_fs: add custom reset for
 usb_host_fs (fsusb)
In-Reply-To: <20120607073112.GX12766@atomide.com>
References: <20120607060901.25532.68354.stgit@dusk>
 <20120607061308.25532.19767.stgit@dusk>
 <20120607073112.GX12766@atomide.com>
Message-ID: <20120607073323.GD16342@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jun 07, 2012 at 12:31:13AM -0700, Tony Lindgren wrote:
> * Paul Walmsley <paul@pwsan.com> [120606 23:26]:
> > From: Tero Kristo <t-kristo@ti.com>
> > 
> > Add a custom reset function for the usb_host_fs/fsusb IP block, and
> > connect it to the OMAP4 FSUSB block.
> > 
> > This is the first of two fixes required to get rid of the boot
> > warning:
> > 
> > omap_hwmod: usb_host_fs: _wait_target_disable failed
> > 
> > and to allow the module to idle.
> > 
> > It may be necessary to use this reset method for OMAP2xxx SoCs as
> > well; this is left for a future patch.
> 
> Here too I think driver like features like this should live in the
> driver init for omap OHCI driver. In the likely case that FS OHCI is
> not in use on the board, the OHCI glue can just reset it.

this I don't agree. It means we will have to add some OHCI code even
when OHCI is disabled.

> > +/* HCCOMMANDSTATUS: the register offset of the HCCOMMANDSTATUS register */
> > +#define HCCOMMANDSTATUS			0x0008
> > +
> > +/* HCCOMMANDSTATUS_HCR: the bitmask of the host controller reset flag */
> > +#define HCCOMMANDSTATUS_HCR_MASK	(1 << 0)
> 
> I don't think the bus layer code should need to know anything about driver
> specific registers.
> 
> > +	omap_hwmod_write(HCCOMMANDSTATUS_HCR_MASK, oh, HCCOMMANDSTATUS);
> > +
> > +	omap_test_timeout(!(omap_hwmod_read(oh, HCCOMMANDSTATUS)
> > +			    & HCCOMMANDSTATUS_HCR_MASK),
> > +			  MAX_MODULE_SOFTRESET_WAIT, c);
> > +
> 
> These should be accessed by the driver in a standard way after ioremapping
> the device.

agree.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120607/f6e637b0/attachment.sig>
