From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 21 Aug 2011 19:26:04 +0100
Subject: [PATCH 1/3] ARM: debug: use kconfig choice for selecting
	DEBUG_LL UART
In-Reply-To: <alpine.LFD.2.00.1108211258490.20358@xanadu.home>
References: <1313530873-24961-1-git-send-email-will.deacon@arm.com>
	<20110818161105.GA12527@S2100-06.ap.freescale.net>
	<20110818160712.GA26691@e102144-lin.cambridge.arm.com>
	<20110819045956.GB12527@S2100-06.ap.freescale.net>
	<20110819110822.GB8918@e102144-lin.cambridge.arm.com>
	<20110819113740.GF12527@S2100-06.ap.freescale.net>
	<20110819123238.GD8918@e102144-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1108191101560.20358@xanadu.home>
	<20110821091452.GH12028@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1108211258490.20358@xanadu.home>
Message-ID: <20110821182604.GI28546@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 21, 2011 at 01:35:33PM -0400, Nicolas Pitre wrote:
> On Sun, 21 Aug 2011, Russell King - ARM Linux wrote:
> > Plus you need the virtual address too, because the LL debug stuff is
> > there to debug around places like the initial assembly, before C code
> > is setup.
> 
> The kernel should determine or set up the virtual address by itself.  
> This is obviously not something we want the bootloader to provide.  For 
> the same reason, I've discarded the idea that the bootloader could 
> simply have provided via a DT node a small segment of code (it's only a 
> few assembly instructions after all) to drive the serial port because it 
> would require a stable mapping to match that code's idea of the register 
> locations.

Yes, and the virtual and physical base addresses are set via the
existing macros.

To take the virtual address out of that means that we then have to find
some way of storing that data - which can't be inside the normal kernel
bss or data sections.  BSS has not been zeroed at the point where we want
working DEBUG_LL stuff.

Defining a offset-fixed memory location from the kernel is fragile, and
will end up wasting the entire page - which would have to be permanently
reserved.

This is just getting _idiotic_.  There are times when "no" is the word
which has to be used, and this is one of them.

> I'm not trying to cover the full story.  This is mainly for 98% of those 
> cases where a plain serial port is used for both the DEBUG_LL _and_ the 
> early output from the decompressor.

So yet again we end up with another half baked "solution", which will
result in "end-users" being confused because it'll work on some stuff
but not on other stuff.

That is *no* solution what so ever.

> Those people with a JTAG debugger and the knowledge to use it really 
> don't need any generic infrastructure to get some early debugging 
> information out.  They can reconfigure their kernel and even hack the 
> source to suit their needs.  But the people who are going to be the main 
> consumers of a multi-SOC single-binary kernel won't be the ones 
> recompiling their kernel just to provide us with debugging info.

That is a stupid argument.  The people who need the early console are
those bringing up a new board.  By the act of being involved in bringing
up a new board, they are a developer.  They are not a user.  They will
be having to rebuild the kernel.

There is no technical problem here.  It's just entirely conceptual,
and one of trying to use stuff inappropriately.
