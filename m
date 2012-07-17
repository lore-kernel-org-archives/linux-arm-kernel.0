From: cavokz@gmail.com (Domenico Andreoli)
Date: Tue, 17 Jul 2012 16:54:46 +0200
Subject: [RFC PATCH 00/12] ARM: Decompressor multiplatform support
In-Reply-To: <201207171431.16111.arnd@arndb.de>
References: <20120715024408.747946928@gmail.com>
 <201207171431.16111.arnd@arndb.de>
Message-ID: <20120717145446.GB9991@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2012 at 02:31:15PM +0000, Arnd Bergmann wrote:
> On Sunday 15 July 2012, Domenico Andreoli wrote:
> > My intent is to get rid of uncompress.h and prepare the decompressor
> > to dynamically select the various machine specific decompressor init
> > steps, included the selection of the appropriate console driver.
> > 
> > Currently the mainline kernel defines these steps statically and indeed
> > has some trouble to boot on different boards with the same binary.
> > 
> > What this patch does is allowing the four functions (arch_decomp_setup,
> > arch_error, putc and flush) currently used to define such static steps
> > to be packed in quantity and to be selected/executed by the decompressor
> > accordingly to the machid or DT passed by the boot loader.
> 
> I definitely like the implementation, it looks very nicely done with the
> driver specific code being right inside of the actual device drivers.

yep, thanks.

> I think the main question we have to answer is whether we want to go
> this far for the decompressor output. IIRC the last time this was
> debated, the argument was made (I don't remember if it was by Russell
> or someone else) that the decompressor code is designed to be as simple
> as possible and we should add too much complexity in it that would make
> it harder to debug when the only purpose of that code is to debug the
> decompressor code itself.

I also made this question [0] but probably the message was too long and
nobody bothered to read it fully :)

The question applies almost unchanged for the arch_decomp_setup()/arch_error()
calls. Those could be worthy to preserve and probably less easy to dismiss
than the console ;)

> I find it hard to judge what the benefit of your implementation is
> compared to the risk of introducing bugs.

Indeed. I can also add that without a sound extraction of console data
from DT, where arm is heading, the thing looks even less appealing.

But I needed to publish it :)

> The other part I don't understand is how it relates to the
> early_print() infrastructure that has some of the same requirements.

If there is, it's not intentional.

cheers,
Domenico

[0] http://www.spinics.net/lists/arm-kernel/msg177843.html
