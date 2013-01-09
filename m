From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 9 Jan 2013 22:14:24 +0000
Subject: [PATCH] ARM: nommu: re-enable use of vexpress without
 ARCH_MULTIPLATFORM
In-Reply-To: <alpine.LFD.2.02.1301091627010.6300@xanadu.home>
References: <1357755328-17075-1-git-send-email-jonathan.austin@arm.com>
 <201301092115.20327.arnd@arndb.de>
 <alpine.LFD.2.02.1301091627010.6300@xanadu.home>
Message-ID: <201301092214.24639.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 January 2013, Nicolas Pitre wrote:
> On Wed, 9 Jan 2013, Arnd Bergmann wrote:
> 
> > On Wednesday 09 January 2013, Nicolas Pitre wrote:
> > > > If we decide that building an allnoconfig without any platform
> > > > is actually ok, we could just as well rip out that error statement.
> > > 
> > > Is it expected for allnoconfig kernels to still boot on other 
> > > architectures? If so I think we should try to still provide a valid 
> > > config even in the allnoconfig case.
> > 
> > The practical use of a kernel without any device drivers or file
> > systems is pretty low, I would not expect such a kernel to be
> > any useful.
> 
> I didn't say "useful".  But at least "booting" e.g. to print out a 
> kernel oops because no root filesystem is available or the like should 
> be a minimum.  Having the wrong platform configured in might prevent 
> even that from working, but at least we shouldn't allow for a kernel 
> config that we know in advance has no chance of ever executing anywhere.

x86 allows you disable support for all the CPU types at the same time,
although the default is to not give you the option and enable them
all together, which means that allnoconfig may still boot, but
randconfig may not. That is probably a reasonable compromise.

Maybe we could have the virtual platform as the default but make it
invisible if CONFIG_EXPERT is disable. That would also make allnoconfig
be reasonable. Thinking a bit more about the CPU setting for the
virtual platform, I guess it actually makes sense to let the user
build this for any CPU: It makes a very nice minimal kernel for
running in qemu and easily allows you to test a rootfs that was
built for an arbitrary CPU without having to support a specific
SoC in qemu.

	Arnd
