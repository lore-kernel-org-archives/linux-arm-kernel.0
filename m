From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 2 Sep 2016 11:47:07 +0100
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <6414695.LEIYfGPUEg@wuerfel>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <87vb31kdvh.fsf@intel.com>
 <CADRPPNTQURmuwyuXCjHZcCq6jmQDFiyEUqfcqO-us15nosGCDA@mail.gmail.com>
 <6414695.LEIYfGPUEg@wuerfel>
Message-ID: <20160902104707.GC1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 02, 2016 at 12:43:39PM +0200, Arnd Bergmann wrote:
> On Thursday, September 1, 2016 5:14:28 PM CEST Leo Li wrote:
> > 
> > Hi Felipe and Arnd,
> > 
> > It has been a while since the last response to this discussion, but we
> > haven't reached an agreement yet!  Can we get to a conclusion on if it
> > is valid to create child platform device for abstraction purpose?  If
> > yes, can this child device do DMA by itself?
> 
> I'd say it's no problem for a driver to create child devices in order
> to represent different aspects of a device, but you should not rely on
> those devices working when used with the dma-mapping interfaces.

That's absolutely right.  Consider the USB model - only the USB host
controller can perform DMA, not the USB devices themselves.  All DMA
mappings need to be mapped using the USB host controller device struct
not the USB device struct.

The same _should_ be true everywhere else: the struct device representing
the device performing DMA must be the one used to map the transfer.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
