From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 Oct 2014 16:01:02 +0100
Subject: [PATCH v2 5/5] ARM: use early console instead of early debug in
 allmodconfig kernels
In-Reply-To: <20141028143536.GI27405@n2100.arm.linux.org.uk>
References: <1414503095-25986-1-git-send-email-kaixu.xia@linaro.org>
 <3063784.TXO37ZkrnY@wuerfel> <20141028143536.GI27405@n2100.arm.linux.org.uk>
Message-ID: <1974731.Nqyg6BoJOO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 October 2014 14:35:36 Russell King - ARM Linux wrote:
> On Tue, Oct 28, 2014 at 03:29:01PM +0100, Arnd Bergmann wrote:
> > On Tuesday 28 October 2014 14:05:36 Russell King - ARM Linux wrote:
> > > On Tue, Oct 28, 2014 at 09:31:35PM +0800, Xia Kaixu wrote:
> > > > The early debug could break something when booting 'allmodconfig'
> > > > kernels. So we use early console instead of early debug.
> > > > 
> > > > The early console didn't work yet on OMAP4460 because of missing
> > > > earlycon support and I am working on that.
> > > 
> > > No. bloody. way.
> > > 
> > > > @@ -78,7 +78,7 @@ config DEBUG_USER
> > > >  # These options are only for real kernel hackers who want to get their hands dirty.
> > > >  config DEBUG_LL
> > > >       bool "Kernel low-level debugging functions (read help!)"
> > > > -     depends on DEBUG_KERNEL
> > > > +     depends on DEBUG_KERNEL && !ARCH_MULTIPLATFORM_STRICT
> > > 
> > > Firstly, this is well advertised that it can only be applied to a single
> > > configuration.  So I don't think we need this dependency here.  Even if
> > > you want to build a strict multiplatform kernel, it should still be
> > > possible to enable this for a specific platform.
> > 
> > I've asked Kaixu to do this patch. This is one of the most fundamental
> > uses of ARCH_MULTIPLATFORM_STRICT: as soon as you turn on DEBUG_LL, the
> > kernel no longer runs on any other platform, so it can still be built
> > as a multiplatform kernel, but not a "strict" one that is known to
> > work on all hardware that is enabled.
> 
> No, that is not correct.  You can turn on DEBUG_LL, and a multiplatform
> kernel will still run.
> 
> The point at which it won't run is if you call the DEBUG_LL function on
> a platform it wasn't configured for.  That happens if you start using
> the printascii() et.al. functions, or (against my better judgement) the
> early console support is enabled.
>
> So, as the early console support went against my wishes there, I see
> this problem as more of an early console problem than a DEBUG_LL problem.

Good point, yes.

What about DEBUG_UNCOMPRESS then? It is currently defined as

config DEBUG_UNCOMPRESS
        bool
        depends on ARCH_MULTIPLATFORM || ARCH_MSM || PLAT_SAMSUNG
        default y if DEBUG_LL && !DEBUG_OMAP2PLUS_UART && \
                     (!DEBUG_TEGRA_UART || !ZBOOT_ROM)

so it will be turned on implicitly when DEBUG_LL is set on a
multiplatform kernel. Doesn't that cause an external abort or similar
as soon as you start writing to some random physical address from the
decompressor when running on the wrong platform?

	Arnd
