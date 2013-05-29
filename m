From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 28 May 2013 21:54:04 -0400 (EDT)
Subject: Single zImage and A15/LPAE
In-Reply-To: <180001ce5c03$60cbcf70$22636e50$%kim@samsung.com>
References: <50735B75.8070109@wwwdotorg.org>
 <alpine.LFD.2.02.1210082201470.16518@xanadu.home>
 <2043931.InXdkgrjkp@wuerfel> <20121009141736.GB2122@linaro.org>
 <180001ce5c03$60cbcf70$22636e50$%kim@samsung.com>
Message-ID: <alpine.LFD.2.03.1305282148560.1918@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 29 May 2013, Kukjin Kim wrote:

> Dave Martin wrote:
> > On Tue, Oct 09, 2012 at 07:51:02AM +0000, Arnd Bergmann wrote:
> > > On Monday 08 October 2012 22:18:24 Nicolas Pitre wrote:
> > > > On Mon, 8 Oct 2012, Stephen Warren wrote:
> > > >
> > > > > I'm curious what the single-zImage story is for Cortex A15 CPUs with
> > > > > LPAE extensions; IIRC, LPAE entails a different page table format
> > and so
> > > > > isn't going to co-exist in the same zImage as non-LPAE
> > > >
> > > > LPAE vs non LPAE is an even more invasive change than ARMv6+ vs pre
> > > > ARMv6 support.  So no, I don't think we'll ever support LPAE and non
> > > > LPAE configs in the same kernel binary.
> > > >
> > > > > (although doesn't x86 support that now; I though separate
> > > > > LPAE/non-LPAE kernels went away there?)
> > > >
> > > > I don't think so.  At least Ubuntu apparently still carries a PAE and
> > > > non PAE kernel packages.  Fedora doesn't, probably because they
> > decided
> > > > not to support non PAE capable machines anymore.  We certainly cannot
> > > > make this choice on ARM yet.
> > >
> > > Fedora 18 still has both PAE and non-PAE kernels. I would really hope
> > > they could give up the PAE version in favor of a 64 bit kernel in
> > > the 32 bit distro, but it seems none of the big distros trust the
> > > compat code enough yet. On x86, the number of 32 bit machines still
> > > running with more than 3GB of RAM installed should be very marginal
> > > now, most people running the PAE kernel actually have 64 bit capable
> > > CPUs and have some legacy 32 bit applications that are easier to
> > > run with a 32 bit user space.
> > >
> > > Maybe we get to the same point on ARM in some 10 years, but for
> > > the forseeable future, Cortex-a15 machines with lots of RAM will
> > > be very real and we need to have separate kernels for those.
> > 
> > In the medium term we could work around this with a fat kernel in
> > principle (i.e., bundle a non-LPAE single kernel together with an LPAE
> > one and choose the right one at boot time).  This can be solved outside
> > the kernel if necessary.
> > 
> > This is not great, but the general feeling seems to be that combining
> > LPAE and non-LPAE in the same kernel is just not going to be worth the
> > pain (either in code or runtime impacts).
> > 
> > For AArch64, we obviously have a different kernel binary anyway.
> > 
> (+ Olof, Russell)
> 
> Just note, I found this in my old mail-box...
> 
> So I think, as a result, we need to support separate kernel binary for LPAE
> and non-LPAE and you guys don't hold a different view about it.

LPAE and non-LPAE configurations will most likely never be supported 
together in the same kernel binary.  The runtime cost would simply be 
too high to be worth it.

> Current SSDK5440 and SD5v1 boards which are reference boards for EXYNOS5440
> has over 4GB memory as a default and that's why I'm writing this e-mail. It
> means I should keep separated kernel to support exynos5440 and other exynos
> SoCs.

They could all be supported together but with less than 4GB of memory.


Nicolas
