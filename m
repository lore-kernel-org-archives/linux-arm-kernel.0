From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 5 Sep 2015 21:38:18 +0100
Subject: [PATCH] ARM: fix alignement of __bug_table section entries
In-Reply-To: <87y4gkx04m.fsf@belgarion.home>
References: <1441175009-26730-1-git-send-email-robert.jarzmik@free.fr>
 <20150902103955.GF6281@e103592.cambridge.arm.com>
 <878u8lx9hl.fsf@belgarion.home>
 <20150905142519.GN21084@n2100.arm.linux.org.uk>
 <87y4gkx04m.fsf@belgarion.home>
Message-ID: <20150905203818.GO21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 05, 2015 at 07:10:49PM +0200, Robert Jarzmik wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> > On Sat, Sep 05, 2015 at 03:48:38PM +0200, Robert Jarzmik wrote:
> >> This time I took my JTAG to have a look at the flow, in arch/arm/mm/alignment.c,
> >> where I added the small chunk in [2], which gave in my case :
> >>     RJK: fault=4 instr=0x00000000 instrptr=0xc02b37c8 thumb_mode=0 tinstr=0x0000
> >
> > Right, so as fault is nonzero, this means that we were unable to read the
> > instruction.  That seems mad though - the instruction pointer is certainly
> > valid, and as we're using probe_kernel_address(), that switches to the
> > kernel "segment" before trying to read kernel addresses.  That should
> > mean that __copy_from_user_inatomic() is able to read the instruction.
> >
> > I think this is the root cause of the issue.
> 
> And there is more madness to come : I tried to "reread" the instruction [1] a
> second time if the first result was 4 :
> RJK: fault=4 instr=0x00000000(@c385d72c) instrptr=0xc02b39e8 thumb_mode=0 tinstr=0x0000
> RJK: reread instruction: [0xc02b39e8] = 0x10c650b2: 0
> 
> Guess what, the second probe_kernel_address() with the same parameters returns
> 0, and everything works. It's insane.
> 
> >> Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> > It seems you have SW_DOMAIN_PAN enabled.
> That's the default arch/arm/Kconfig implies.
> And ... this is what also _is_ the cause of this behavior : removing
> SW_DOMAIN_PAN makes all my pxa boards work again !!!
> 
> Moreover, this is consistent with the fact that this commit is in linux-next but
> not in v4.1 :
>     a5e090acbf54 ("ARM: software-based priviledged-no-access support")
> 
> So the issue is around this SW_DOMAIN_PAN, at least on PXA.

Is it only PXA which seems to be affected?

If so, you may need to add:

	mrc p15, 0, \rd, c2, c0, 0
	mov \rd, \rd
	sub pc, pc, #4

to the places we update the domain access register to ensure that the
Xscale pipeline stalls to allow the CP15 DACR update to hit.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
