From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Feb 2010 20:30:52 +0000
Subject: [PATCH] Clean up ARM compressed loader
In-Reply-To: <alpine.LFD.2.00.1002251428410.1946@xanadu.home>
References: <20100224234215.GA21985@n2100.arm.linux.org.uk>
	<4B85BCE0.7000903@marcansoft.com>
	<20100225000114.GB21985@n2100.arm.linux.org.uk>
	<4B85C4A4.4060005@marcansoft.com>
	<alpine.LFD.2.00.1002242309030.1946@xanadu.home>
	<20100225093859.GA19870@n2100.arm.linux.org.uk>
	<4B864B4C.9020805@marcansoft.com>
	<alpine.LFD.2.00.1002251332190.1946@xanadu.home>
	<4B86CDC8.4080107@marcansoft.com>
	<alpine.LFD.2.00.1002251428410.1946@xanadu.home>
Message-ID: <20100225203052.GE3101@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2010 at 02:40:43PM -0500, Nicolas Pitre wrote:
> On Thu, 25 Feb 2010, Hector Martin wrote:
> > And I'm still not convinced that compiler behavior is defined such 
> > that this cannot break in the future.
> 
> Seems to me that we're relying on compiler conventions that have been 
> around for decades already.  What do you expect to break?

Sigh.  It's well defined behaviour - it's part of the ELF ABI.  There's
nothing undefined or spurious about it, and it's not going away any time
soon.

For example, my C library has this:

00ca5d60 B __environ

as part of it's BSS segment.  If I do:

#include <stdio.h>
char **__environ;
int main() {
        printf("&__environ = %p\n", &__environ);
        printf("__environ = %p\n", __environ);
        printf("__environ[0] = %s\n", __environ[0]);
        return 0;
}

I get:

080496a0 B __environ

as part of the program.  So, as soon as I run this program, there exists
two '__environ' variables - one in the program and one in the C library.

Let's see what happens when I run the program:

&__environ = 0x80496a0
__environ = 0xbfa01c1c
__environ[0] = HOSTNAME=rmk-PC

That's definitely the one in the application program.  How can the program,
which clearly has this variable as part of its BSS segment independent of
the C library, and which never initializes this BSS variable, end up with
data in there?

It's well defined behaviour brought about by global data and the GOT,
where the shared library is pointed to the version in the user program
rather than its own BSS - independent of the rest of the shared library's
text, data, and bss segments.  When the shared library reads or writes
'__environ', it does it via the GOT which is redirected _at run time_ to
point at the application binary copy by the dynamic linker.

And now try changing that 'char **__environ' to be extern, and see what
effect that has:

080496e0 B __environ@@GLIBC_2.0

Yes, still part of the application binary (this time versioned with the
C library version), and the C library still finds that instead of its
own copy.

But, build an application binary which doesn't reference __environ, and
the version in the C library's BSS segment will be used instead.

This is not undefined compiler behaviour.  This is well defined behaviour,
and it's precisely this behaviour that we're using.  We're directing the
*global* data references to some other part of memory independent of the
rest of the decompressor image.

So, rather than wasting my time with this crap, can we please move on?

I guess I could've pulled several people's trees during the time it's
taken to write this email which shouldn't have been necessary.
