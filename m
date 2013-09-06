From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 6 Sep 2013 17:40:59 +0100
Subject: [RFC 0/4] Create infrastructure for running C code from SRAM.
In-Reply-To: <20130906111408.GI25647@n2100.arm.linux.org.uk>
References: <1378226665-27090-1-git-send-email-Russ.Dill@ti.com>
 <52278F84.2080509@elopez.com.ar>
 <CA+Bv8XaHonrpeNZ6tRCyqpMK1bzgpDTqvLyrsLWEyMY_ky6apQ@mail.gmail.com>
 <20130906111408.GI25647@n2100.arm.linux.org.uk>
Message-ID: <20130906164059.GC3558@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 06, 2013 at 12:14:08PM +0100, Russell King - ARM Linux wrote:
> On Wed, Sep 04, 2013 at 02:47:51PM -0700, Russ Dill wrote:
> > I think this is already taken care of by the way sram.c is using
> > genalloc. The allocation returned should be aligned to 32 bytes. The
> > thumb bit shouldn't be an issue as code is copied based on the start
> > and end makers made by the linker. I may need to add .align statements
> > in the linker so that the start and end markers for the copied code
> > are aligned to at least 8 bytes.
> 
> I think you need to read up on what fncpy does... there's more to it
> than just merely copying code at an appropriate alignment.

The technique of putting each loadable blob in a specific vmlinux
section, and then adjusting entry-point symbols by adding/subtracting
the appropriate offset, probably does work.

This relies on the functions' code alignment requirement being
honoured by both the vmlinux link map, and the allocator used to find
SRAM space to copy the functions to.

Searching the entire list of known blobs every time we want to convert
a symbol seems unnecessary though.  Surely the caller could know the
blob<->symbol mapping anyway?


One thing fncpy() doesn't provide is a way to copy groups of functions
that call each other, if vmlinux needs to know about any symbol other
than the one at the start.  We might need a better mechanism if that is
needed.


I actually wonder whether fncpy() contains a buglet, whereby
flush_icache_range() is used instead of coherent_kern_range().
The SRAM is probably not mapped cached, but at least a DSB would be
needed before flushing the relevant lines from the I-cache.

However, flush_icache_range() seems to be implemented by a call to
coherent_kern_range() anyway, so perhaps that's not a problem.

Cheers
---Dave
