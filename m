From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 4 Jan 2011 17:19:28 +0000
Subject: [PATCHv8 00/12] Contiguous Memory Allocator
In-Reply-To: <C832F8F5D375BD43BFA11E82E0FE9FE00829C13EB2@EXDCVYMBSTM005.EQ1STM.local>
References: <cover.1292443200.git.m.nazarewicz@samsung.com>
	<AANLkTim8_=0+-zM5z4j0gBaw3PF3zgpXQNetEn-CfUGb@mail.gmail.com>
	<20101223100642.GD3636@n2100.arm.linux.org.uk>
	<C832F8F5D375BD43BFA11E82E0FE9FE00829C13EB2@EXDCVYMBSTM005.EQ1STM.local>
Message-ID: <20110104171928.GB24935@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 04, 2011 at 05:23:37PM +0100, Johan MOSSBERG wrote:
> Russell King wrote:
> > Has anyone addressed my issue with it that this is wide-open for
> > abuse by allocating large chunks of memory, and then remapping
> > them in some way with different attributes, thereby violating the
> > ARM architecture specification?
> 
> I seem to have missed the previous discussion about this issue.
> Where in the specification (preferably ARMv7) can I find
> information about this?

Here's the extracts from the architecture reference manual:

* If the same memory locations are marked as having different
  cacheability attributes, for example by the use of aliases in a
  virtual to physical address mapping, behavior is UNPREDICTABLE.

A3.5.7 Memory access restrictions

Behavior is UNPREDICTABLE if the same memory location:
* is marked as Shareable Normal and Non-shareable Normal
* is marked as having different memory types (Normal, Device, or
  Strongly-ordered)
* is marked as having different cacheability attributes
* is marked as being Shareable Device and Non-shareable Device memory.

Such memory marking contradictions can occur, for example, by the use of
aliases in a virtual to physical address mapping.

Glossary:
UNPREDICTABLE
Means the behavior cannot be relied upon. UNPREDICTABLE behavior must not
represent security holes.  UNPREDICTABLE behavior must not halt or hang
the processor, or any parts of the system. UNPREDICTABLE behavior must not
be documented or promoted as having a defined effect.

> Is the problem that it is simply
> forbidden to map an address multiple times with different cache
> setting and if this is done the hardware might start failing? Or
> is the problem that having an address mapped cached means that
> speculative pre-fetch can read it into the cache at any time,
> possibly causing problems if an un-cached mapping exists? In my
> opinion option number two can be handled and I've made an attempt
> at doing that in hwmem (posted on linux-mm a while ago), look in
> cache_handler.c. Hwmem currently does not use cma but the next
> version probably will.

Given the extract from the architecture reference manual, do you want
to run a system where you can't predict what the behaviour will be if
you have two mappings present, one which is cacheable and one which is
non-cacheable, and you're relying on the non-cacheable mapping to never
return data from the cache?

What if during your testing, it appears to work correctly, but out in
the field, someone's loaded a different application to your setup
resulting in different memory access patterns, causing cache lines to
appear in the non-cacheable mapping, and then the CPU hits them on
subsequent accesses corrupting data...

You can't say that will never happen if you're relying on this
unpredictable behaviour.
