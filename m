From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Feb 2016 10:54:49 +0100
Subject: [PATCH] iommu: exynos: pointers are nto physical addresses
In-Reply-To: <56D41087.60506@samsung.com>
References: <1456735568-3886545-1-git-send-email-arnd@arndb.de>
 <56D41087.60506@samsung.com>
Message-ID: <26472865.zD5Ep58Exn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 February 2016 10:33:59 Marek Szyprowski wrote:
> > ---
> > I also see that some incorrect __raw_writel() calls have crept in
> > around the same time, which breaks running big-endian kernels when
> > this driver is loaded.
> >
> > Please fix and that that as well.
> 
> Okay, so in the driver code all __raw_writel should be replaced by
> writel(), right?

Yes, writel() is always the safe choice if you don't know what to
use. __raw_writel() should be considered an implementation detail
and not used in drivers at all. There is also writel_relaxed(),
which is faster than writel() because it leaves out all the
barriers (as __raw_writel does too), and you can sometimes use that
in the fast path if you can prove that no barriers are needed.

	Arnd
