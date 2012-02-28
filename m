From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 28 Feb 2012 18:59:44 +0000
Subject: [RFC PATCH 0/2] ARM: assembler: Add uniform assembler framework
Message-ID: <1330455586-10353-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, we have two substantially different dialects of assembly
language in arch/arm/ -- assmbler for .S files (with macros and
definitions from <asm/assembler.h>) and inline asm in .c files
(with macros and definitions from a variety of other places).

There is often a need to define macros to work around missing or
broken assembler features, abstract architectural features and
enable various magical build-time transformations.  Unfortunately,
such macros often have to be implemented twice, since macros that
work for inline asm often don't work (or are sometimes not easily
implementable) for .S files, and vice-versa.


The first patch in this series makes <asm/assembler.h> a viable
place for common declarations to be passed to the assembler, and
also paves the way for splitting out extra declarations which are
not relevant everywhere into separate headers.

The second patch demonstrated how all this might be used in
practice (and is also likely to be needed by the kvm and Xen guys,
based on previous discussion).


To achieve all this, a script arch/arm/tools/asm-header.pl is now
run by the archprepare target, to preprocess
arch/arm/include/asm/*.h.asm.  In these special headers, blocks of
native assembler declarations are transformed as shown below.

Macros defined in such blocks get transformed into something that
is includable in .c or .S files, with the desired effect:

arch/arm/include/asm/some_header.h.asm:

ASM(
stuff
for
the
assembler
)

--- becomes --->

include/generated/asm-some_header.h:

#ifdef __ASSEMBLY__
stuff
for
the
assembler
#else
asm("stuff");
asm("for");
asm("the");
asm("assembler");
#endif

Of course, there may be other, nicer ways of achieving all this...

Comments appreciated.

Cheers
---Dave

Dave Martin (2):
  ARM: assembler: Add uniform assembler framework
  ARM: virt: Add assembler helpers for the Virtualization Extensions

 arch/arm/Makefile                    |    8 +-
 arch/arm/include/asm/arch-virt.h     |    1 +
 arch/arm/include/asm/arch-virt.h.asm |  104 +++++++++++
 arch/arm/include/asm/assembler.h     |  322 +---------------------------------
 arch/arm/include/asm/assembler.h.asm |  323 ++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/opcodes.h       |   80 +--------
 arch/arm/include/asm/opcodes.h.asm   |  191 ++++++++++++++++++++
 arch/arm/tools/Makefile              |    4 +
 arch/arm/tools/asm-header.pl         |   76 ++++++++
 9 files changed, 708 insertions(+), 401 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-virt.h
 create mode 100644 arch/arm/include/asm/arch-virt.h.asm
 create mode 100644 arch/arm/include/asm/assembler.h.asm
 create mode 100644 arch/arm/include/asm/opcodes.h.asm
 create mode 100644 arch/arm/tools/asm-header.pl

--
1.7.4.1
