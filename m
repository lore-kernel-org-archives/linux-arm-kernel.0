From: hector@marcansoft.com (Hector Martin)
Date: Thu, 25 Feb 2010 20:56:08 +0100
Subject: [PATCH] Clean up ARM compressed loader
In-Reply-To: <alpine.LFD.2.00.1002251428410.1946@xanadu.home>
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
Message-ID: <4B86D5D8.2010905@marcansoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre wrote:
> On Thu, 25 Feb 2010, Hector Martin wrote:
>> Nicolas Pitre wrote:
>>> Russell made a patch which simply ends up discarding .data section.
>> You still have the issue of the .bss section. Though I must admit this
>> would be rare, a decompressor using the .bss section would still cause
>> silent breakage.
> 
> What breakage?  We do use the .bss right now.  But .bss can be fixed to 
> some absolute address in RAM with no further handling besides clearing

static data in BSS can end up addressed with a GOT-relative offset (even
if you put it at "some absolute address" - this is still PIC code). That
 will fail once you move around the text/rodata/GOT blob when running
the ROM code from RAM, since it'll push the BSS section somewhere else
(potentially not RAM). So you still need to ensure that all BSS data is
globally visible.

> I found the following at the top of arch/arm/boot/compressed/misc.c:
> 
>  * Nicolas Pitre <nico@visuaide.com>  1999/04/14 :
>  *  For this code to run directly from Flash, all constant variables must
>  *  be marked with 'const' and all other variables initialized at run-time
>  *  only.  This way all non constant variables will end up in the bss segment,
>  *  which should point to addresses in RAM and cleared to 0 on start.
>  *  This allows for a much quicker boot time.

This is a different issue, the part where so far the code hasn't been
copying data. This is unrelated to the issue that -Dstatic= tries to
solve, which has to do with the way data can be located relative to the GOT.

>> And I'm still not convinced that compiler behavior is defined such 
>> that this cannot break in the future.
> 
> Seems to me that we're relying on compiler conventions that have been 
> around for decades already.  What do you expect to break?

Compilers are getting smarter, and code relying on old assumptions that
may no longer be true (because compilers optimize better or do things
differently) is precisely that which is most liable to break. The only
way you can properly guarantee things will work is by sticking to actual
standards and doing what the compiler expects you to do. Moving around
text/rodata without moving around bss/(maybe data) isn't something
allowed by the compiler. Sure, you can hack around it like we're doing
here, but you're relying on your hacks correctly preventing the compiler
from doing something valid yet which breaks your assumptions.

> Possible.  And granted this whole scheme was elaborated in 1999 when 
> CPUs were much slower and the kernel much smaller relative to the 
> decompressor, etc.  But again that "just works" already, without the 
> copy overhead, and the code needed to make the copy (I know it's only 4 
> asm instructions), and the complexity needed to care about the actual 
> decompressed kernel size, etc. etc.

Well, if you're into speed anyway, caring about the actual kernel size
is desirable because it avoids a totally useless copy when the zImage is
loaded into RAM somewhere near the end of where the kernel would be. The
guesstimate in the code will think it'll overlap and move things around
unnecessarily. Worse, if the kernel ends up being highly compressible
for whatever reason, it could overflow the 4x guesstimate and make the
whole compressed loader fail again if it happens to be around there.

But this discussion is rather pointless because at this stage I highly
doubt Russell is going to change his mind.

-- 
Hector Martin (hector at marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc
