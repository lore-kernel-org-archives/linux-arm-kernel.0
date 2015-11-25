From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 25 Nov 2015 07:50:18 +0000
Subject: [PATCH v9] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
In-Reply-To: <8520D5D51A55D047800579B0941471982586607F@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1447911323-12567-1-git-send-email-bharatku@xilinx.com>
 <20151124173556.18aff6b5@arm.com>
 <8520D5D51A55D047800579B0941471982586607F@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <20151125075018.68e97010@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Nov 2015 05:40:49 +0000
Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com> wrote:

> > On Thu, 19 Nov 2015 11:05:23 +0530
> > Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com> wrote:
> > 
> > > Adding PCIe Root Port driver for Xilinx PCIe NWL bridge IP.
> > >
> > > Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> > > Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
> > > Acked-by: Rob Herring <robh@kernel.org>
> > > ---
> > > +
> > > +#define MSI_ADDRESS				0xDEED0000
> > 
> > How did you pick this value? What if it intersect with some actual RAM?
> > What if a device actually does DMA to that location?
> > 
> > Wouldn't it make sense to actually pick a real *device* address (hint:
> > your MSI controller itself) for this purpose, as the device will never DMA
> > there?
> >
> > 
> We have already mentioned in previous patch discussion, we don't have
> any device address on our SOC for MSI, that's the reason we are
> allocating a page for MSI in RAM. Since our memory write is consumed
> by bridge and doesn't write to memory, you suggested to use some
> random address,  so using some random address.

This is becoming painful.

- "write is consumed by bridge and doesn't write to memory": So why are
  you using something that has a chance of actually being memory??? Are
  you in the business of corrupting unsuspecting data?

- "we don't have any device address on our SOC for MSI": You have
  plenty, and that's the whole of your device space. *All of it*. So
  just take the base address of your PCIe controller, and be done with
  it. Or your UART. Anything that cannot be DMA'ed to from a PCIe
  device, and that is downstream of your PCIe bridge.

	M.
-- 
Jazz is not dead. It just smells funny.
