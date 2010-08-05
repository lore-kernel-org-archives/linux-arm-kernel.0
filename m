From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 5 Aug 2010 20:40:52 +0530
Subject: [PATCH] usb: musb: host: Issue a memory barrier before staring
	the DMA
In-Reply-To: <Pine.LNX.4.44L0.1008051102210.1944-100000@iolanthe.rowland.org>
References: <1281001990-29755-1-git-send-email-santosh.shilimkar@ti.com>
	<Pine.LNX.4.44L0.1008051102210.1944-100000@iolanthe.rowland.org>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C64A1BD6@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Alan Stern [mailto:stern at rowland.harvard.edu]
> Sent: Thursday, August 05, 2010 8:34 PM
> To: Shilimkar, Santosh
> Cc: linux-usb at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> Mankad, Maulik Ojas; Russell King; Felipe Balbi
> Subject: Re: [PATCH] usb: musb: host: Issue a memory barrier before
> staring the DMA
> 
> On Thu, 5 Aug 2010, Santosh Shilimkar wrote:
> 
> > This patch fixes the issue which was observed while transfering
> > a large file ( > 20MB) over USB (OMAP MUSB controller acts as USB host)
> > to an attached USB thumb drive.
> >
> > It was found that CDB field of CBW packet was set to 0x0. This was
> > due to missing a barrier before DMA engine starts transfer.
> > This  buffer is  allocated using dma_alloc_coherent which gives
> > non-cacheble but bufferable memory and hence needed a write
> > memory barrier to flush the write buffer.
> 
> If you see this problem when the controller uses DMA acting as a host,
> does this mean the same problem might occur when it uses DMA acting as
> a peripheral?
> 
The peripheral USB drivers seems to have using standard kernel dma-mapping
framework which internally takes care of the ordering issues.

This is one of the cases where buffer is allocated using "dma_alloc_coherent" for which except ordering issue , there is no
maintainace is necessary.

Regards,
Santosh
