From: j@jannau.net (Janne Grunau)
Date: Mon, 7 Jul 2014 19:52:11 +0200
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <20140707145208.GC32578@arm.com>
References: <20140701234800.GA23577@sirena.org.uk> <4473002.jGohFvPsvi@wuerfel>
 <7B049AD4-78F8-4494-A2CB-57DD346107DA@arm.com>
 <201407061739.22152.arnd@arndb.de>
 <loom.20140707T153253-384@post.gmane.org>
 <20140707145208.GC32578@arm.com>
Message-ID: <20140707175211.GE16282@jannau.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-07-07 15:52:08 +0100, Catalin Marinas wrote:
> On Mon, Jul 07, 2014 at 01:59:54PM +0000, Janne Grunau wrote:
> > Arnd Bergmann <arnd <at> arndb.de> writes:
> > > but I don't see how we could emulate IT without anything
> > > short of a full interpretation of user instructions from the kernel.
> > 
> > Avoiding deprecated forms of IT would be harder. It's used more often in
> > libav (~50 times)
> 
> Is this explicitly written IT instructions or in generated code (gas,
> gcc)?

Those 50 times are explicitly written IT instructions with more than one 
conditional instruction in assembly. At least on linux none of the 
functions should be used without runtime cpu/feature detection.

gcc 4.8.3 itself generates tons of IT with more than one conditional 
instruction (~1500 for a 90k SLOC C library).

> > so it should be only disabled if it's emulated or not
> > available using an explicit HWCAP. Not using Thumb for those functions would
> > be another option for libav. Again this doesn't fix existing binaries and it
> > doesn't fix compiled code.
> 
> As I said, I don't see this going away (easily). I've heard the
> toolchain guys adding warnings but they don't help unless you rebuild
> your code. Given the amount of IT instructions, I don't even propose
> adding emulation/warnings to the kernel for the time being (that would
> be step 1 in my "instruction deprecation" proposal, we have to think
> about it; some trapping would be handy to to assess the impact but
> still defaulting to native).

I guess that would just detect thumb2 binaries not compiled with 
'-mrestrict-it' i.e. all legacy thumb2 binaries.

Janne
