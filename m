From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Dec 2011 22:02:47 +0000
Subject: arm and patch phys offset
In-Reply-To: <201112122255.40092.michael@walle.cc>
References: <201112112255.32534.michael@walle.cc>
 <201112122212.35506.michael@walle.cc>
 <20111212213450.GD20178@n2100.arm.linux.org.uk>
 <201112122255.40092.michael@walle.cc>
Message-ID: <20111212220247.GF20178@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 10:55:40PM +0100, Michael Walle wrote:
> Am Montag 12 Dezember 2011, 22:34:50 schrieb Russell King - ARM Linux:
> > Why do you say that, and what you do mean by "expect the addresses" ?
> > Presumably you're saying the addresses will be different.  Why do you
> > think that?
> > Are you saying that you find that the address of these 'unconverted'
> > instructions change each time you run your debug function?
> i see different output from the debug function everytime i change the source 
> code and recompile the kernel. restarting the same binary results in the same 
> unconverted instructions.
> 
> > > If it would be some memory corruption, shouldn't the table or the p2v/v2p
> > > stubs be corrupt? But the non-patched entries always points to correct
> > > v2p/p2v calls and in every case there is the unpatched add/sub
> > > instruction.
> > 
> > Have you tried dumping out the entire instruction as well as the
> > address of the unconverted instruction?
> yes, the addresses make sense as i can see the unpatched instruction at that 
> address in the disassembly and the instruction at these addresses are always:
> 
> add/sub rX, rY, #81000000
> 
> > Are you running a Thumb-2 kernel?  Which kernel are you running?
> what do you mean by which kernel?
> linus' master from yesterday, ARCH_KIRKWOOD=y
> CONFIG_THUMB2_KERNEL is not set

Yes, that's what I mean.

Right, so the problem you're describing is _impossible_ - there is no way
the fixup function can fix only some instructions and skip over others in
a properly functioning system.

The only options are that either the CPU is not executing the instructions
we're giving it (unlikely as - I assume - your hardware executes older
kernels fine), or for some reason your kernel is being called with caches
still enabled, violating the long-standing kernel's calling requirements.

So, some more questions to try to narrow this down:

1. What boot loader are you using?

2. What file are you taking from the kernel build in order to boot?

3. How are you transfering the kernel file to your target system?
