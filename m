From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 2 Jun 2015 15:52:54 +0100
Subject: [PATCH v2] arm: tcm: Don't crash when TCM banks are protected by
 TrustZone
In-Reply-To: <CACRpkdY4sZQr+VzMKzU2Rtm7sP2zMztBioCPQRJjq=VjyapAEA@mail.gmail.com>
References: <1432805760-4590-1-git-send-email-michael@smart-africa.com>
 <1432821287-31436-1-git-send-email-michael@smart-africa.com>
 <CACRpkdY4sZQr+VzMKzU2Rtm7sP2zMztBioCPQRJjq=VjyapAEA@mail.gmail.com>
Message-ID: <20150602145254.GE2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 02, 2015 at 01:16:38PM +0200, Linus Walleij wrote:
> > +static int __init tcm_handler(struct pt_regs *regs, unsigned int instr)
> > +{
> > +       regs->uregs[(instr >> 12) & 0xf] = 0;
> > +       regs->ARM_pc += 4;
> > +       return 0;
> > +}
> 
> Is the action here totally obvious to everyone except me?
> I guess it is masking off something and advancing past a
> failed instruction but whatdoIknow. Can you put in a small comment
> above the function or something?

I know what it's doing :)

It's storing '0' into the destination register of the faulted MRC
instruction, and advancing past the instruction.  So, an undef fault
on either:

	mrc	15, 0, rX, cr9, cr1, {0}
	mrc	15, 0, rX, cr9, cr1, {1}

causes them to return zero.

> > +static struct undef_hook tcm_hook __initdata = {
> > +       .instr_mask     = 0xffff0fdf,
> > +       .instr_val      = 0xee190f11,
> > +       .cpsr_mask      = MODE_MASK,
> > +       .cpsr_val       = SVC_MODE,
> > +       .fn             = tcm_handler
> > +};
> 
> Likewise here. Why not #define instruction 0xee190f11
> so it is a bit more readable? I guess this instruction will
> be trapped and handled by the hook but it'd be nice
> to know what instruction it is and how it comes to
> be issued.

We typically don't do that for instructions, otherwise we end up with
loads of problems such as how to represent the difference between these:

	ldr	rd, [rn, #4]
	ldr	rd, [rn], #4

You could use: LDR_Rd_Rn_4 but then how do you indicate the difference
between the pre-indexed and the post-indexed instruction.

In this case, it's these _two_ instructions being trapped:

	mrc	15, 0, rX, cr9, cr1, {0}
	mrc	15, 0, rX, cr9, cr1, {1}

where we don't care what register 'rX' is, and we only care about those
two, and not:

	mrc	15, 0, rX, cr9, cr1, {2}
	mrc	15, 0, rX, cr9, cr1, {3}
	...

So, if you can come up with some #define which represents just two
instructions in a class but not the others... err, nope, didn't think so.

Since the test is also:

	(actual_instruction & mask) == value

encoding the value without its mask value is pretty pointless and is
in fact ambiguous.  For example, a definition for a STR instruction
with the load bit clear in the mask matches both LDR and STR, so
while a definition for the STR instruction may seem useful, unless you
also have some way to encode the mask as well, it's pretty pointless,
and is in fact misleading if used with a mask which clears bit 20.

So it's quite reasonable to use the numeric encoding here, since
interpreting the instruction value without taking account of the mask
is pretty stupid.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
