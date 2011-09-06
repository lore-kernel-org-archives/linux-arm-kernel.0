From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Sep 2011 11:52:06 +0100
Subject: [PATCH 1/3] ARM: debug: use kconfig choice for selecting
	DEBUG_LL UART
In-Reply-To: <20110906102703.GA1895@atomide.com>
References: <alpine.LFD.2.00.1108191101560.20358@xanadu.home>
	<20110821091452.GH12028@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1108211258490.20358@xanadu.home>
	<20110821182604.GI28546@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1108211435320.20358@xanadu.home>
	<20110821191835.GA19678@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1108211522280.20358@xanadu.home>
	<20110906092816.GC3548@atomide.com>
	<20110906093738.GJ6619@n2100.arm.linux.org.uk>
	<20110906102703.GA1895@atomide.com>
Message-ID: <20110906105206.GL6619@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2011 at 03:27:03AM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [110906 02:04]:
> > On Tue, Sep 06, 2011 at 12:28:17PM +0300, Tony Lindgren wrote:
> > > Probably the best long term solution is to set up the debug uart based
> > > on DT data and initialize it in the uncompress code. Anybody debugging
> > > lower level stuff can certainly patch in the ucompress debug_ll code.
> > 
> > How do you do that before the MMU has been setup?  Are you going to
> > write a DT data parser in pure assembly to extract this information?
> 
> Don't we already have that with ATAGs to DT support in the DT append
> patches? At least it calls fdt_setprop so calling fdt_getprop should
> also work. The patch I'm talking about is:
> 
> http://permalink.gmane.org/gmane.linux.drivers.devicetree/5938 

Let me reiterate.  How are you going to do that before the MMU has been
setup.

I'll give you a hint: in the kernel (not the boot loader) you can't
call *ANY* C code until you have the MMU enabled.  One of the points
of the *LOW LEVEL* debug code is so you can debug the low level
assembly in the head*.S files before the MMU has been enabled.

That means you can't call the C function "fdt_getprop" to get the
parameters.

So, should we have a chunk of assembly code to enable the MMU so that
we can run fdt_getprop() to get the parameters for the LL debug code,
turn the MMU off, and then run through the head.S code to enable the
MMU for the kernel proper?  If you think that's silly, you're starting
to get the picture I've had for years about all this bastardization of
the LL debug code to solve problems beyond what it was originally
intended for - which, again, was to debug the head.S code.

Personally, I think this whole thing is getting impractical for the
use which people are trying to stretch it too - it's trying to be used
to solve the "how do we get console output before the console is up"
problem as well as the "how do we debug the low level assembly code".

With the advent of multi-platform kernels, the two requirements have
been well proving to be mutually exclusive.
