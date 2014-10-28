From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 Oct 2014 15:29:01 +0100
Subject: [PATCH v2 5/5] ARM: use early console instead of early debug in
 allmodconfig kernels
In-Reply-To: <20141028140536.GF27405@n2100.arm.linux.org.uk>
References: <1414503095-25986-1-git-send-email-kaixu.xia@linaro.org>
 <1414503095-25986-6-git-send-email-kaixu.xia@linaro.org>
 <20141028140536.GF27405@n2100.arm.linux.org.uk>
Message-ID: <3063784.TXO37ZkrnY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 October 2014 14:05:36 Russell King - ARM Linux wrote:
> On Tue, Oct 28, 2014 at 09:31:35PM +0800, Xia Kaixu wrote:
> > The early debug could break something when booting 'allmodconfig'
> > kernels. So we use early console instead of early debug.
> > 
> > The early console didn't work yet on OMAP4460 because of missing
> > earlycon support and I am working on that.
> 
> No. bloody. way.
> 
> > @@ -78,7 +78,7 @@ config DEBUG_USER
> >  # These options are only for real kernel hackers who want to get their hands dirty.
> >  config DEBUG_LL
> >       bool "Kernel low-level debugging functions (read help!)"
> > -     depends on DEBUG_KERNEL
> > +     depends on DEBUG_KERNEL && !ARCH_MULTIPLATFORM_STRICT
> 
> Firstly, this is well advertised that it can only be applied to a single
> configuration.  So I don't think we need this dependency here.  Even if
> you want to build a strict multiplatform kernel, it should still be
> possible to enable this for a specific platform.

I've asked Kaixu to do this patch. This is one of the most fundamental
uses of ARCH_MULTIPLATFORM_STRICT: as soon as you turn on DEBUG_LL, the
kernel no longer runs on any other platform, so it can still be built
as a multiplatform kernel, but not a "strict" one that is known to
work on all hardware that is enabled.
 
> It's a developer option, one which requires the developer to engage their
> brain before using.

Exactly, and I think it's not asking too much from a developer to turn
off ARCH_MULTIPLATFORM_STRICT if they want to turn on DEBUG_LL. Nothing
else should change if you do that.

The main use of the symbol is really to avoid turning on DEBUG_LL is
allmodconfig kernels, which will always enable ARCH_MULTIPLATFORM_STRICT.

	Arnd
