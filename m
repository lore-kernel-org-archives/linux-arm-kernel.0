From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 28 Jun 2014 10:42:19 +0100
Subject: [PATCH v7 0/9] ARM: VDSO
In-Reply-To: <53ADA358.7000305@mentor.com>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
 <20140627085125.GA7088@hal> <20140627085705.GC32514@n2100.arm.linux.org.uk>
 <CAKv+Gu9NfGT8r8FSYzsuP70r1BRD_pdJw7AZHkc4qLt2_SwanA@mail.gmail.com>
 <20140627094648.GE32514@n2100.arm.linux.org.uk> <53ADA358.7000305@mentor.com>
Message-ID: <20140628094219.GB32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 12:01:12PM -0500, Nathan Lynch wrote:
> Since removing -lgcc from the link (one of the changes from v6 to v7), I
> believe the VDSO is not asking more of the toolchain or build
> environment than the rest of the kernel does.  I have definitely built
> it without a target libc.  Apart from the host program's use of
> too-recent ELF constants (now fixed), I would appreciate help
> identifying any remaining sources of fragility.

There's still something wrong:

fs/binfmt_elf.c: In function 'create_elf_tables':
fs/binfmt_elf.c:231:35: error: 'AT_SYSINFO_EHDR' undeclared (first use in this function)
fs/binfmt_elf.c:231:35: note: each undeclared identifier is reported only once for each function it appears in

The problem is the fscking generated includes.  This is going to be a
right pain - Arnd, is there anything which can be done about this?

What's happening is if you try and rebuild a kernel with these patches
applied, you already have an arch/arm/include/generated/asm/auxvec.h
which points at the empty asm-generic version.  This remains after
these patches are applied, so the new include of asm/auxvec.h in
asm/elf.h picks up on the empty version, not the newly introduced
version.

So, the way to get this to build with the minimum of disruption is to
first manually remove arch/arm/include/generated/asm/auxvec.h in the
build tree before running make.

This isn't a vdso problem - it's a kbuild problem, one obviously caused
by not thinking through properly the implications of generating include
files and how to deal with changes in the future like this very scenario.
I think I'd rather get rid of this generated include crap and instead
have explicit include files instead in the kernel tree - that way we
/know/ what the situation is at all times, and make has the proper idea
about the dependencies at all times.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
