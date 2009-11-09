From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Nov 2009 19:14:20 +0000
Subject: [PATCH] Use definition for cmpxchg swi
In-Reply-To: <20091109190852.GD3808@shareable.org>
References: <20091108200459.GA32760@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0911082033580.16711@xanadu.home>
	<20091109085137.GA14453@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0911090953010.16711@xanadu.home>
	<20091109173040.GA24358@n2100.arm.linux.org.uk>
	<20091109190852.GD3808@shareable.org>
Message-ID: <20091109191420.GA24833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 09, 2009 at 07:08:52PM +0000, Jamie Lokier wrote:
> Russell King - ARM Linux wrote:
> > I'll add a comment then.
> > 
> > Note, however, that the original code was buggy - it resulted in
> > the '0xfff0' syscall being called instead of '0xffff0' - note the
> > extra 4 bits there.
> 
> Meaning that nobody has ever actually used the original code? :-)

Correct, because SMP on ARM architectures prior to V6 is rather rare.
My only implementation of that is a pile of FPGAs implementing a 4-way
ARM926 SMP system.

> I notice that it loads the syscall number register for EABI
> compatibility, but that instruction could be trivially omitted with
> OABI-compatible kernels, couldn't it?

It could.

> By the way, did you change it to LDR to make it faster?  (I.e. does
> that make it faster?)

Well, we could use one mov and two orr instructions to load the minimum
20 bits of syscall number (which equates to a minimum of 3 cycles) or
one ldr, which can be 1 cycle if the cache is warm.  Since the result
is not used in the following two instructions, there is no impact from
result delays.
