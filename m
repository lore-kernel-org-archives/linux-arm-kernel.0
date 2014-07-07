From: will.deacon@arm.com (Will Deacon)
Date: Mon, 7 Jul 2014 10:51:03 +0100
Subject: [PATCH 4/4] ARM: hwcap: disable HWCAP_SWP if the CPU advertises
 it has exclusives
In-Reply-To: <20140707094128.GY21766@n2100.arm.linux.org.uk>
References: <20140704195134.GJ21766@n2100.arm.linux.org.uk>
 <E1X39Wr-0000ly-RF@rmk-PC.arm.linux.org.uk>
 <4606711.7KmFAGVNmG@wuerfel>
 <20140704205144.GK21766@n2100.arm.linux.org.uk>
 <20140707093443.GA3676@arm.com>
 <20140707094128.GY21766@n2100.arm.linux.org.uk>
Message-ID: <20140707095103.GC3676@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 07, 2014 at 10:41:28AM +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 07, 2014 at 10:34:43AM +0100, Will Deacon wrote:
> > I don't think MPIDR exists on any 1136 (i.e. probably UNDEFs).
> 
> There has long been a requirement (back to ARMv4 I believe) that
> instructions such as:
> 
> 	mrc	p15, 0, rd, c0, c0, X
> 
> all return the MIDR unless they are implemented.  This is certainly
> carried forward to the latest ARM ARMs.  This is done to explicitly
> allow the presence of additional registers to be detected.

You're right (and I didn't know that); the ARM ARM does indeed suggest that
opc2 == {4,5,6,7} in the instruction above will alias MIDR.

> I would be very surprised if the 1136 did undef on this.
> 
> If I dig out my 1136 FPGA (which according to the docs would be r0p2)
> I can explicitly verify this... provided Integrator CP still works.

Actually, I managed to find the following in the 1136 TRM, so your plan
could actually work:

  Note

  If the processor encounters an Opcode_2 value corresponding to an
  unimplemented or reserved ID register with CRm = c0 and Opcode_1 = 0, the
  system control coprocessor returns the value of the Main ID Register.

You live and learn!

Will
