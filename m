From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Jun 2013 14:43:36 +0200
Subject: About LPAE supporting on EXYNOS5440
In-Reply-To: <10b001ce668b$2fdddec0$8f999c40$%kim@samsung.com>
References: <109e01ce667e$5becc880$13c65980$%kim@samsung.com>
 <6690814.Wx0lSuVAQ5@wuerfel>
 <10b001ce668b$2fdddec0$8f999c40$%kim@samsung.com>
Message-ID: <15605927.1Yi6Xe5hWs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 June 2013 19:05:22 Kukjin Kim wrote:
> Arnd Bergmann wrote:
> > 
> > On Tuesday 11 June 2013 17:33:33 Kukjin Kim wrote:
> > > Hi all,
> > >
> > > The exynos5440 can support LPAE and referece boards, SSDK5440 and SD5v1
> > have
> > > over 8GiB memory.
> > >
> > > Current exynos_defconfig selects every EXYNOS SoCs including exynos5440
> > it
> > > means supporting LPAE will be selected for other EXYNOS SoCs.
> > >
> > > I'm wondering if seleting LPAE causes some problem for multiplatform.
> > Can we
> > > support LPAE enabled and disabled platform together with single zImage?
> > 
> > No, that isn't possible.
> 
> Yeah, I know that.
> 
> > I think we should enable all exynos support in
> > the
> > regular multi_v7_defconfig and leave LPAE turned off for that,
> 
> But if so, problem will happen in the memory parsing without LPAE
> enabling...so I'm wondering I should deselect exynos5440 in the defconfig
> for other exynos SoCs...

I think there is a bug in the memory parsing code and already two people
have submitted independent fixes for that. It really should just work
even if you have more memory that ends up getting ignored.

> > but create
> > another multi_lpae_defconfig that has all LPAE capable machines turned on.
> > This is also what I expect the distros to do.
> > 
> Yeah, it could be a solution for multiplatform at this moment. And if so,
> probably I should deselect exynos5440 in the exynos_defconfig and need to
> add another defconfig for exynos lpae stuff.

I would definitely leave on exynos5440 support in defconfig. It's not a
lot of extra code, and if you have a system with less than 4GB memory,
you really don't want to enable LPAE because of the overhead.
 
> BTW, do you know what SoCs can support LPAE now?

Upstream I think we support exynos, vexpress (using A15, A7 and A12
core tiles), omap5 (partially), mvebu (Armada XP), highbank (Midway)
and some of the shmobile parts we added in 3.10.

In mach-sunxi, there will soon be support for Allwinner-A20 and -A31,
which are both Cortex-A7 based. MSM also has support for Cortex-A7
but not upstream. A couple of new platforms are under discussion
already that will also have LPAE, mostly server parts.

	Arnd
