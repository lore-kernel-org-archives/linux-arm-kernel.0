From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 28 Nov 2015 13:27:07 +0100
Subject: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux, atags" entry
In-Reply-To: <alpine.LFD.2.20.1511271817230.22569@knanqh.ubzr>
References: <20150713131902.GH26485@atomide.com> <11537945.4HX4Y84tjV@wuerfel>
 <alpine.LFD.2.20.1511271817230.22569@knanqh.ubzr>
Message-ID: <2565382.eR6yg1spIk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 November 2015 18:28:50 Nicolas Pitre wrote:
> On Fri, 27 Nov 2015, Arnd Bergmann wrote:
> 
> > I don't mind creating the /proc/atags compatibility hack from the kernel
> > for a DT based N700 kernel, as long as we limit it as much as we can
> > to the machines that need it. Leaving a board file for the N700 in place
> > that contains the procfs code (and not much more) seems reasonable
> > here, as we are talking about a board specific hack and the whole point
> > appears to be running unmodified user space.
> > 
> > Regarding how to get the data into the kernel in the first place, my
> > preferred choice would still be to have an intermediate bootloader
> > such as pxa-impedance-matcher, but I won't complain if others are
> > happy enough about putting it into the ATAGS compat code we already
> > have, as long as it's limited to the boards we know need it.
> 
> Assuming you have a N700 board file for special procfs code, then why 
> not getting at the atags in memory where the bootloader has put them 
> directly from that same board file? This way it'll really be limited to 
> the board we know needs it and the special exception will be contained 
> to that one file.  Amongst the machine specific hooks, there is one that 
> gets invoked early during boot before those atags are overwritten.

I didn't realize this was possible, as we don't know the atags pointer
when we instead get a DTB pointer. However you are right: the board
file knows exactly that the atag_offset is 0x100, so we can grab it
from there, and that will make the implementation really easy and
contained to a single file that has access to the atags and that
can create the /proc/atags file for it.

	Arnd
