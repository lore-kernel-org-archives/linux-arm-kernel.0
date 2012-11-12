From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 12 Nov 2012 11:09:59 +0100
Subject: [PATCH v3 4/6] ARM: EXYNOS: Add support for Exynos secure	firmware
In-Reply-To: <20121112095114.GD28327@n2100.arm.linux.org.uk>
References: <1351178560-19188-1-git-send-email-t.figa@samsung.com>
 <1351178560-19188-5-git-send-email-t.figa@samsung.com>
 <20121112095114.GD28327@n2100.arm.linux.org.uk>
Message-ID: <1632996.MFS2BfkxD2@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russel,

On Monday 12 of November 2012 09:51:14 Russell King - ARM Linux wrote:
> > +
> > +static int exynos_cpu_boot(int cpu)
> > +{
> > +	exynos_smc(SMC_CMD_CPU1BOOT, cpu, 0, 0);
> > +	return 0;
> > +}
> 
> Same for this (though, what _exactly_ is 'cpu', is it the physical CPU
> number or the logical CPU number?)

Yes, it's the physical CPU number.

> > +
> > +static int exynos_cpu_boot_reg(int cpu, void __iomem **ptr)
> > +{
> > +	*ptr = S5P_VA_SYSRAM_NS + 0x1c + 4*cpu;
> > +	return 0;
> > +}
> 
> This is really bad.  What's it trying to do?  What is the significance
> of the 'ptr' returned?  What if a platform doesn't have a boot register?

It returns a pointer to the area where boot code (secondary startup) 
address must be stored.

This callback (just as all the firmware callbacks) is optional, if it is 
not appropriate for given platform, it will not use it.

However, now when I think of it, it may be better to just add a callback 
like set_boot_addr(cpu, addr), which would set boot address of given CPU 
without exporting address of its boot register outside firmware code. Are 
you OK with this kind of approach?


Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Linux Platform
