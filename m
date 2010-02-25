From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 25 Feb 2010 15:29:07 -0500 (EST)
Subject: [PATCH] Clean up ARM compressed loader
In-Reply-To: <4B86D5D8.2010905@marcansoft.com>
References: <1266978217-7023-1-git-send-email-hector@marcansoft.com>
	<20100224223418.GB25587@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1002241824520.1946@xanadu.home>
	<20100224234215.GA21985@n2100.arm.linux.org.uk>
	<4B85BCE0.7000903@marcansoft.com>
	<20100225000114.GB21985@n2100.arm.linux.org.uk>
	<4B85C4A4.4060005@marcansoft.com>
	<alpine.LFD.2.00.1002242309030.1946@xanadu.home>
	<20100225093859.GA19870@n2100.arm.linux.org.uk>
	<4B864B4C.9020805@marcansoft.com>
	<alpine.LFD.2.00.1002251332190.1946@xanadu.home>
	<4B86CDC8.4080107@marcansoft.com>
	<alpine.LFD.2.00.1002251428410.1946@xanadu.home>
	<4B86D5D8.2010905@marcansoft.com>
Message-ID: <alpine.LFD.2.00.1002251507000.1946@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Feb 2010, Hector Martin wrote:

> Compilers are getting smarter, and code relying on old assumptions that
> may no longer be true (because compilers optimize better or do things
> differently) is precisely that which is most liable to break. The only
> way you can properly guarantee things will work is by sticking to actual
> standards and doing what the compiler expects you to do. Moving around
> text/rodata without moving around bss/(maybe data) isn't something
> allowed by the compiler. Sure, you can hack around it like we're doing
> here, but you're relying on your hacks correctly preventing the compiler
> from doing something valid yet which breaks your assumptions.

Sure.  And so far we've used a naive hack with -Dstatic.  Russell's 
patch is now removing the hack and making sure the restrictions we count 
on are respected wrt .data section.  If we need to ensure no static .bss 
variable are used we might just add this in the Makefile:

	[ "$(nm compressed/vmlinux | grep " b ")" != "" ]

> Well, if you're into speed anyway, caring about the actual kernel size
> is desirable because it avoids a totally useless copy when the zImage is
> loaded into RAM somewhere near the end of where the kernel would be. The
> guesstimate in the code will think it'll overlap and move things around
> unnecessarily. Worse, if the kernel ends up being highly compressible
> for whatever reason, it could overflow the 4x guesstimate and make the
> whole compressed loader fail again if it happens to be around there.

Those are valid points, and rather orthogonal to the ROMable 
decompressor issue.  Better not to mix them together.

And I vaguely remember trying to do just that a couple years ago: 
getting hold of the decompressed kernel size and feeding that into the 
decompressor code.  I somehow didn't come up with a satisfactory 
solution and never revisited it since.

> But this discussion is rather pointless because at this stage I highly
> doubt Russell is going to change his mind.

If you produce a patch for the above, and it is clean and portable, then 
I suspect he would just merge it.  Only at that point we could 
reconsider the ROMable decompressor issue.


Nicolas
