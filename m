From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 16 Feb 2010 14:25:55 +0530
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <201002160922.47072.oliver@neukum.org>
References: <20100208065519.GE1290@ucw.cz>
	<1265628483.4020.63.camel@pc1117.cambridge.arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C3CF7D50@dbde02.ent.ti.com>
	<201002160922.47072.oliver@neukum.org>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF7DBB@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Oliver Neukum [mailto:oliver at neukum.org]
> Sent: Tuesday, February 16, 2010 1:53 PM
> To: Shilimkar, Santosh
> Cc: Catalin Marinas; Pavel Machek; Greg KH; Russell King - ARM Linux; Matthew Dharm; Sergei Shtylyov;
> Ming Lei; Sebastian Siewior; linux-usb at vger.kernel.org; linux-kernel; linux-arm-kernel; Mankad,
> Maulik Ojas
> Subject: Re: USB mass storage and ARM cache coherency
> 
> Am Dienstag, 16. Februar 2010 08:57:53 schrieb Shilimkar, Santosh:
> > Continuing on the USB issue w.r.t cache coherency, the usb host
> > code is violating the buffer ownership rules of streaming APIs from
> > dma and non-dma transfers point if view.
> >
> > We have a below temporary patch to get around the issue and probably it
> > needs to be fixed in the right way in the stack because some controllers
> > may not have PIO option even for control transfers. (e.g. Synopsis EHCI
> > controller)
> 
> This seems wrong to me. Buffers for control transfers may be transfered
> by DMA, so the caches must be flushed on architectures whose caches
> are not coherent with respect to DMA.
Indeed and that's what I mentioned in the comment. But we shouldn't have dma 
cache maintenance operations done for the buffers which would use pio based transfer. 
> Would you care to elaborate on the exact nature of the bug you are fixing?
On the OMAP4 (ARM cortex-a9) platform, the enumeration fails because control
transfer buffers are corrupted. On our platform, we use PIO mode for control 
transfers and DMA for bulk transfers.

The current stack performs dma cache maintenance even for the PIO transfers
which leads to the corruption issue. The control buffers are handled by CPU 
and they already coherent from CPU point of view.


Regards,
Santosh
