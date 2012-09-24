From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 24 Sep 2012 16:39:11 +0200
Subject: [PATCH 4/5] ARM: EXYNOS: Add support for Exynos secure firmware
In-Reply-To: <20120916004455.GD7028@quad.lixom.net>
References: <1347524018-19301-1-git-send-email-t.figa@samsung.com>
 <1347524018-19301-5-git-send-email-t.figa@samsung.com>
 <20120916004455.GD7028@quad.lixom.net>
Message-ID: <1503070.mCpo7P41ro@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Saturday 15 of September 2012 17:44:55 Olof Johansson wrote:
> On Thu, Sep 13, 2012 at 10:13:37AM +0200, Tomasz Figa wrote:
> > +static void __iomem *exynos_cpu_boot_reg(int cpu)
> > +{
> > +	return S5P_VA_SYSRAM_NS + 0x1c + 4*cpu;
> > +}
> 
> This communication area in sysram should probably be seen as a part of
> the firmware interface. It should thus be defined as part of the binding
> instead, i.e.  through a reg property or similar there. That also would
> make it easy to convert to using ioremap() instead of iodesc tables,
> which always a nice thing.

I have tried to get around the need of statical mapping for SYSRAM, but the 
firmware has to be initialized very early, before low level L2x0 cache 
initialization (which is an early initcall, so it has to be in init_early 
machine callback) and at that time ioremap is not available yet.

I think we should just allow this additional static mapping, I don't see 
any sane way of mapping it dynamically, at least at the moment.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
