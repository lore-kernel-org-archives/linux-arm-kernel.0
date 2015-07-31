From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 31 Jul 2015 12:48:00 +0100
Subject: [PATCH] iommu/arm-smmu-v2: ThunderX(errata-23399) mis-extends
 64bit registers
In-Reply-To: <91236962-23EF-4306-B0FA-0F7DAE4F06CD@caviumnetworks.com>
References: <1438278906-29627-1-git-send-email-tchalamarla@caviumnetworks.com>
 <20150730184523.GC16663@arm.com>
 <96AD8EF9-D416-43AB-BA6F-2C25098BB8BB@caviumnetworks.com>
 <91236962-23EF-4306-B0FA-0F7DAE4F06CD@caviumnetworks.com>
Message-ID: <20150731114800.GA28948@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 30, 2015 at 08:54:04PM +0000, Chalamarla, Tirumalesh wrote:
> is some thing like this looks good
> 
> +#ifdef CONFIG_64BIT
> +#define smmu_writeq(reg64, addr)       writeq_relaxed((reg64), (addr))
> +#else
> +#define smmu_writeq(reg64, addr)                       \
> +               writel_relaxed(((reg64) >> 32), ((addr) + 4));  \
> +               writel_relaxed((reg64), (addr))

It's missing a #endif.

This also suffers from multiple argument evaluation, and it hides that
there's two expressions here - which makes future maintanence harder.

#define smmu_writeq(reg64, addr)					\
	do {								\
		u64 __val = (reg64);					\
		volatile void __iomem *__addr = (addr);			\
		writel_relaxed(__val >> 32, __addr + 4);		\
		writel_relaxed(__val, __addr);				\
	} while (0)

is longer but is much preferred as it won't suffer side effects from
stuff like:

	if (...)
		smmu_writeq(val++, addr);

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
