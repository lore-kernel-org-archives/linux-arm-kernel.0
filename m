From: gadiyar@ti.com (Gadiyar, Anand)
Date: Thu, 18 Feb 2010 12:44:21 +0530
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <201002180756.14100.oliver@neukum.org>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF84D1@dbde02.ent.ti.com>
	<Pine.LNX.4.44L0.1002171201190.1913-100000@iolanthe.rowland.org>
	<5A47E75E594F054BAF48C5E4FC4B92AB03216236D6@dbde02.ent.ti.com>
	<201002180756.14100.oliver@neukum.org>
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03215B106B@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Oliver Neukum wrote:
> Am Mittwoch, 17. Februar 2010 21:30:24 schrieb Gadiyar, Anand:
> > > Why do you skip mapping the setup packet but not the data packet?
> > > 
> > 
> > I think that's oversight. For this controller, we need to skip mapping
> > all buffers used to do transfers on EP0, which is all control transfers.
> 
> One thing more. Do you have an issue with EP 0 only or all control
> endpoints? EP 0 must be control, but devices are within spec if they
> have multiple control endpoints provided EP 0 is control.

Sorry for the confusion. The issue is not with EP 0 of devices
connected to the controller; the problem is with EP 0 on the host
controller itself.

The controller in question is the MUSB OTG controller present in
OMAPs, Davinci chips, and some Blackfins. The MUSB HCD driver is
written such that it carries out all control transfers on EP 0 of
the controller. All bulk transfers are carried out on other hardware
endpoints.

(This is the same "hardware endpoint" that is used in when the MUSB
is used in gadget mode.)


I'm not really sure why EP0 was chosen for control transfers, or
if there is a restriction that we *need* to use it. Let me study
the docs some more.

The problem is that with the driver code as written today, we use
EP 0 for all control transfers, and the DMA engine cannot do DMA
to this endpoint's FIFO.

- Anand
