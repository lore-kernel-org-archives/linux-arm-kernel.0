From: tpiepho@impinj.com (Trent Piepho)
Date: Wed, 28 Nov 2018 20:00:57 +0000
Subject: [PATCH] pci: imx6: support kernels built in Thumb-2 mode
In-Reply-To: <f7096d74-9097-771d-1a4b-f6665b3689d4@arm.com>
References: <20181128132554.28139-1-stefan@agner.ch>
 <ff476784-b79e-18bf-5870-4365c8377deb@arm.com>
 <1543431377.18519.94.camel@impinj.com>
 <f7096d74-9097-771d-1a4b-f6665b3689d4@arm.com>
Message-ID: <1543435257.18519.98.camel@impinj.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-11-28 at 19:52 +0000, Robin Murphy wrote:
> On 28/11/2018 18:56, Trent Piepho wrote:
> > On Wed, 2018-11-28 at 16:16 +0000, Robin Murphy wrote:
> > > 
> > > >    
> > > > +static int imx6q_pcie_abort_handler_thumb2(unsigned long addr,
> > > > +		unsigned int fsr, struct pt_regs *regs)
> > > > +{
> > > > +	unsigned long pc = instruction_pointer(regs);
> > > > +	unsigned long instr = *(unsigned long *)pc;
> > > > +	unsigned long thumb2_instr =
> > > > __mem_to_opcode_thumb16(instr);
> > > > +	int reg = thumb2_instr & 7;
> > > > +
> > > > +	if (!__opcode_is_thumb16(instr & 0x0000ffffUL))
> > > > +		return 1;
> > > 
> > > There are plenty of 32-bit Thumb encodings of various LDR/STR
> > > variants,
> > > and I doubt we can guarantee that the offset, target register,
> > > and/or
> > > addressing mode for a config space access will *always* suit the
> > > (relatively limited) 16-bit ones.
> > 
> > It might be the case that PLD/PLI, 32-bit thumb2 instructions,
> > could
> > trigger an abort too.
> 
> Preload instructions shouldn't cause a *synchronous* abort, which is 
> what we're trapping here, and they could only result in an asynchronous 
> abort coming back later if the address is mapped as Normal memory, which 
> it really shouldn't be in this case. Frankly either way, anyone even 
> thinking about trying to pull PCI config space into data caches, let 
> alone instruction caches, probably deserves everything they get ;)

It would be easy to do from userspace.  mmap the config space attribute
in sysfs, and then call plain old glibc memcpy() on it to copy to
normal ram.  strlen(), memcpy(), etc. are coded with pld instructions.
