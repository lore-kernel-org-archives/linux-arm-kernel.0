From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Jun 2014 09:27:18 +0200
Subject: [PATCH v7 0/9] ARM: VDSO
In-Reply-To: <20140628144904.GF32514@n2100.arm.linux.org.uk>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
 <20140628095504.GD32514@n2100.arm.linux.org.uk>
 <20140628144904.GF32514@n2100.arm.linux.org.uk>
Message-ID: <6335724.sfrxa4DtUh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 28 June 2014 15:49:04 Russell King - ARM Linux wrote:
> On Sat, Jun 28, 2014 at 10:55:04AM +0100, Russell King - ARM Linux wrote:
> > On Sat, Jun 28, 2014 at 10:42:19AM +0100, Russell King - ARM Linux wrote:
> > > On Fri, Jun 27, 2014 at 12:01:12PM -0500, Nathan Lynch wrote:
> > > > Since removing -lgcc from the link (one of the changes from v6 to v7), I
> > > > believe the VDSO is not asking more of the toolchain or build
> > > > environment than the rest of the kernel does.  I have definitely built
> > > > it without a target libc.  Apart from the host program's use of
> > > > too-recent ELF constants (now fixed), I would appreciate help
> > > > identifying any remaining sources of fragility.
> > > 
> > > There's still something wrong:
> > > 
> > > fs/binfmt_elf.c: In function 'create_elf_tables':
> > > fs/binfmt_elf.c:231:35: error: 'AT_SYSINFO_EHDR' undeclared (first use in this function)
> > > fs/binfmt_elf.c:231:35: note: each undeclared identifier is reported only once for each function it appears in
> > > 
> > > The problem is the fscking generated includes.  This is going to be a
> > > right pain - Arnd, is there anything which can be done about this?
> > 
> > And yes, I see that you've mentioned this in the cover - but I think we
> > /really/ need this solved before we can merge this series, otherwise
> > we're likely to get lots of people asking about it.
> 
> Thinking about this some more - if this can't be resolved by kbuild,
> then I think we should add to arch/arm/Kconfig to detect the generated
> include file, print a helpful message telling the user how to fix their
> build tree, and error out.

I think there is a way to flag files to be deleted on every build in the
Makefile, I'd have to read up on that. I've run into similar problems
before, also with generated files sometimes not getting removed during
'make clean'.

	Arnd
