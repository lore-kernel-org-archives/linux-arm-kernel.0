From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 02 Sep 2016 12:43:39 +0200
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <CADRPPNTQURmuwyuXCjHZcCq6jmQDFiyEUqfcqO-us15nosGCDA@mail.gmail.com>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <87vb31kdvh.fsf@intel.com>
 <CADRPPNTQURmuwyuXCjHZcCq6jmQDFiyEUqfcqO-us15nosGCDA@mail.gmail.com>
Message-ID: <6414695.LEIYfGPUEg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 1, 2016 5:14:28 PM CEST Leo Li wrote:
> 
> Hi Felipe and Arnd,
> 
> It has been a while since the last response to this discussion, but we
> haven't reached an agreement yet!  Can we get to a conclusion on if it
> is valid to create child platform device for abstraction purpose?  If
> yes, can this child device do DMA by itself?

I'd say it's no problem for a driver to create child devices in order
to represent different aspects of a device, but you should not rely on
those devices working when used with the dma-mapping interfaces.

This used to be simpler back when we could configure the kernel for
only one SoC platform at a time, and the platforms could provide their
own overrides for the dma-mapping interfaces. These days, we rely on
firmware or bootloader to describe various aspects of how DMA is done,
so you can't assume that passing a device without an of_node pointer
or ACPI data into those functions will do the right thing.

	Arnd
