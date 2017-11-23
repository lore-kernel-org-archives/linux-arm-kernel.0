From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Nov 2017 10:35:19 +0000
Subject: [PATCH] arm: ensure symbol is a thumb symbol in new binutils
In-Reply-To: <CAHmME9oMTNJFnOwfhu26QSRSP92Axbc-+v9cCPsTKxekZvGvxg@mail.gmail.com>
References: <20171121172751.29545-1-Jason@zx2c4.com>
 <20171121173857.GJ31757@n2100.armlinux.org.uk>
 <CAHmME9quDFbdOR9hKRz-Px=Mh3FvYEyhVrs4V_+JT+GjDajMrA@mail.gmail.com>
 <20171121174942.GK31757@n2100.armlinux.org.uk>
 <CAHmME9oMTNJFnOwfhu26QSRSP92Axbc-+v9cCPsTKxekZvGvxg@mail.gmail.com>
Message-ID: <20171123103518.GL31757@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 23, 2017 at 12:34:08AM +0100, Jason A. Donenfeld wrote:
> On Tue, Nov 21, 2017 at 6:49 PM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > What if we locate the "badr" instruction to the same offset - does
> > that trigger the binutils bug?  Note that the grep expression will
> > need updating...
> 
> Nope, this too does not reproduce it. I'm having a bit of trouble
> making a minimal test case to reproduce it. But I can reproduce it
> everytime by simply assembling the file in question using that
> binutils.

If it's that hard to reproduce it, it makes me wonder if it's being
caused by some memory allocation being re-used without full
initialisation, and it's reading stale data.

We can't easily build entry-common.o and check it for the problem as the
position of the "local_restart" code depends on various configuration
options.

I found this URL:

https://fossies.org/diffs/binutils/2.28_vs_2.29/gas/config/tc-arm.c-diff.html

and if you search down to around "line 8358", which is in do_adr(),
there is this new code added:

      if (inst.reloc.exp.X_op == O_symbol
          && inst.reloc.exp.X_add_symbol != NULL
          && S_IS_DEFINED (inst.reloc.exp.X_add_symbol)
          && THUMB_IS_FUNC (inst.reloc.exp.X_add_symbol))
        inst.reloc.exp.X_add_number += 1;

which would account for the issue you're seeing.

Given that this change breaks openssl, and breaks the kernel, and
this behaviour is something that we've come to rely upon in the
kernel since T2 was introduced, and there's no way around it without
adding additional instructions, I have to ask what the hell binutils
people think they are doing changing the behaviour of the assembler
in such a gratuitous way, and how they think that users of their
crapware are going to be able to write code that assembles correctly
on both pre-2.29 assemblers and post-2.29 assemblers.

Sorry, but gratuitous changes like this in the toolchain really
annoy me, and just give me more reason to stick with my old known
working versions (binutils 2.25, gcc 4.7.4!) rather than move
forward and then not know whether bugs are due to crappy toolchains
or really something wrong in the program.

binutils people need to realise that what they offer is an interface
for converting assembly code into opcodes and if they change the
translation of that in a visible way, people are going to get
annoyed - just like if we in the kernel change the kernel's user
visible API.

IMHO, binutils should have exactly the same rules - if a change causes
a regression for a user, the change is wrong and should be reverted.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
