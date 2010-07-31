From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 31 Jul 2010 11:52:25 +0100
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors (v6)
In-Reply-To: <201007301304.54559.siarhei.siamashka@nokia.com>
References: <20100719180136.20305.7333.stgit@e200687-lin>
	<201007291313.29923.siarhei.siamashka@nokia.com>
	<20100729192855.GA4298@elf.ucw.cz>
	<201007301304.54559.siarhei.siamashka@nokia.com>
Message-ID: <20100731105225.GI23886@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 30, 2010 at 01:04:54PM +0300, Siarhei Siamashka wrote:
> On Thursday 29 July 2010 22:28:56 ext Pavel Machek wrote:
> > I believe emulation just to annoy users into submitting bugreports is
> > serious overengineering.
> 
> It's not to annoy them, but to provide the users with the information about 
> valid problems in their applications. It's up to the users to either do 
> anything with it, or ignore.

What's missing is that the SWP instruction will eventually be dropped
from the later ARM architecture revisions, so sooner or later programs
will break without either SWP emulation support or being fixed.

The SWP instruction is already deprecated from ARMv6, and in ARMv6 it
was still present (see the note in section A3.4).  In ARMv7, it defaults
to being disabled and causing an illegal instruction fault.  The next
step will be to remove it from the hardware entirely which I suspect
isn't that far away.

So this patch makes total sense.

What I do think we need to do is collect all the definitions for decoding
instructions together - we have stuff like (in kprobes-decode.c):

        int rd = (insn >> 12) & 0xf;

when we also have in arch/arm/mm/alignment.c:

#define RD_BITS(i)      ((i >> 12) & 15)        /* Rd                   */

and it seems we're going to get another version of this for the swp
emulation support.
