From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 9 Jan 2014 10:27:27 +0200
Subject: [PATCH 1/2] ARM: omapfb: add coherent dma memory support
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EDB141E@DBDE04.ent.ti.com>
References: <1388409550-10720-1-git-send-email-tomi.valkeinen@ti.com>
 <1388409550-10720-2-git-send-email-tomi.valkeinen@ti.com>
 <20140107235951.GH5074@atomide.com> <52CD5D13.9090806@ti.com>
 <79CD15C6BA57404B839C016229A409A83EDB11F5@DBDE04.ent.ti.com>
 <52CE5123.9050702@gmail.com>
 <79CD15C6BA57404B839C016229A409A83EDB141E@DBDE04.ent.ti.com>
Message-ID: <52CE5D6F.3050700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-01-09 10:08, Hiremath, Vaibhav wrote:

> No, that's what is causing issue to me. Can you try predefined address flow?
> Just to highlight, I get UNDERFLOW during boot itself, immediately when it gets mapped to userspace.
> 
> Boot LOG:
> 

> [    4.822549] Freeing unused kernel memory: 440K (c0919000 - c0987000)
> [    5.276615] OMAPFB: pan_display(0)
> [    5.276625] OMAPFB: setcmap
> [    5.276635] OMAPFB: setcmap
> [    5.293518] OMAPFB: user mmap region start a0000000, len 1536000, off 0
> [    5.300171] omapdss APPLY error: FIFO UNDERFLOW on gfx, disabling the overlay

Hmm that's interesting... So you have some tool that's ran early, which
draws something on the screen? Or maybe that's X starting?

Ah... I think I understand now. As I mentioned, AM4x has issues already.
I think the CPU/others can block DSS when accessing memory. So, if we
have bad caching for the mapped framebuffer, the CPU will use more
bandwidth when reading/writing to it, and that will cause DSS to underflow.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140109/94e5177e/attachment-0001.sig>
