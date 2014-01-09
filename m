From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 9 Jan 2014 10:21:46 +0200
Subject: [PATCH 1/2] ARM: omapfb: add coherent dma memory support
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EDB11F5@DBDE04.ent.ti.com>
References: <1388409550-10720-1-git-send-email-tomi.valkeinen@ti.com>
 <1388409550-10720-2-git-send-email-tomi.valkeinen@ti.com>
 <20140107235951.GH5074@atomide.com> <52CD5D13.9090806@ti.com>
 <79CD15C6BA57404B839C016229A409A83EDB11F5@DBDE04.ent.ti.com>
Message-ID: <52CE5C1A.3070603@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-01-09 07:06, Hiremath, Vaibhav wrote:

> I am seeing underflow issue on AM43x device if I use omapfb_vram argument.
> Did you see this on OMAP?
> 
> I am using "omapfb_vram=10M at 0xA0000000", and I believe it is correct way of usage.

Hmm ok... The AM4x seems to have issues anyway, as we're seeing
underflows easily in other situations also.

Well, there's a small difference in the allocation. The normal dma alloc
uses dma_alloc_attrs() and passes DMA_ATTR_WRITE_COMBINE as a flag,
whereas allocating from the absolute address just uses the piece of
memory. I couldn't find how to set write-combine for the abs memory area.

Then again, that's for CPU caching, so I don't see why it would affect
DSS as such (but that's still something we should measure, cpu
read/write perf for normal and abs allocation).

The only thought I have is that somehow the reserved memory area is
missing some configuration that is done for the rest of the memory. But
that's purely a guess, this is totally out of my area of expertise...

Vaibhav, just to be sure, can you run both with normal dma_alloc and
with the reserve, and verify that the dispc register dumps are the same?
I don't see how they could be different, but just to be sure.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140109/72c0c420/attachment.sig>
