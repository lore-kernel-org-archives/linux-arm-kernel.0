From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Oct 2013 17:04:20 +0100
Subject: [PATCH v2 0/7] Optimize jump label implementation on ARM64
In-Reply-To: <525C1469.4000906@gmail.com>
References: <1381675827-1610-1-git-send-email-liuj97@gmail.com>
 <20131014154044.GR25034@n2100.arm.linux.org.uk> <525C1469.4000906@gmail.com>
Message-ID: <20131014160419.GS25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 14, 2013 at 11:57:29PM +0800, Jiang Liu wrote:
> On 10/14/2013 11:40 PM, Russell King - ARM Linux wrote:
> > On Sun, Oct 13, 2013 at 10:50:20PM +0800, Jiang Liu wrote:
> >> To enable this feature, your toolchain must support "asm goto" extension
> >> and "%c" constraint extesion. Current GCC for AARCH64 doesn't support
> >> "%c", so you need a GCC patch similiar to this:
> > 
> > Oh god, not that again.  I've no idea why ARM stuff has such a problem with
> > supporting this very useful "%c" GCC constraint.  Aarch32 didn't for ages
> > consequently we now have horrid hacks around it in the kernel source
> > because our compilers suck.  Seems Aarch64 is doomed to repeat the same
> > stupid mistakes. :(
> > 
> We need to do the same trick for ARM64 too:)

Just been locating it - it's part of the gcc internals documentation:

|  In the simplest case, a `%' followed by a digit N says to output
| operand N at that point in the string.
| 
|  `%' followed by a letter and a digit says to output an operand in an
| alternate fashion.  Four letters have standard, built-in meanings
| described below.  The machine description macro `PRINT_OPERAND' can
| define additional letters with nonstandard meanings.
| 
|  `%cDIGIT' can be used to substitute an operand that is a constant
| value without the syntax that normally indicates an immediate operand.
| ...
|  `%lDIGIT' is used to substitute a `label_ref' into a jump instruction.

%lDIGIT is used (but not commented upon) in the gcc extended asm
documentation where it talks about asm gotos, so there's probably a doc
bug here too about whether these options should be described in the
main doc as well.

Nevertheness, this section is documenting the _internals_ of gcc, and
it seems perverse for a gcc backend to ignore something that is
documented as being a standard part of gcc.
