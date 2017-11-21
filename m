From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 21 Nov 2017 12:29:38 +0000
Subject: =?utf-8?B?562U5aSN?= =?utf-8?Q?=3A?= [PATCH 01/11] Initialize
 the mapping of KASan shadow memory
In-Reply-To: <B8AC3E80E903784988AB3003E3E97330C0068F12@dggemm510-mbx.china.huawei.com>
References: <bbf43f92-3d0c-940d-b66b-68f92eb9b282@arm.com>
 <B8AC3E80E903784988AB3003E3E97330C00635F3@dggemm510-mbs.china.huawei.com>
 <87po8ir1kg.fsf@on-the-bus.cambridge.arm.com>
 <B8AC3E80E903784988AB3003E3E97330C006371B@dggemm510-mbs.china.huawei.com>
 <87375eqobb.fsf@on-the-bus.cambridge.arm.com>
 <B8AC3E80E903784988AB3003E3E97330C0063816@dggemm510-mbs.china.huawei.com>
 <20171117073556.GB28855@cbox>
 <B8AC3E80E903784988AB3003E3E97330C00638D4@dggemm510-mbs.china.huawei.com>
 <20171118134841.3f6c9183@why.wild-wind.fr.eu.org>
 <B8AC3E80E903784988AB3003E3E97330C0068F12@dggemm510-mbx.china.huawei.com>
Message-ID: <20171121122938.sydii3i36jbzi7x4@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 21, 2017 at 07:59:01AM +0000, Liuwenliang (Abbott Liu) wrote:
> On Nov 17, 2017  21:49  Marc Zyngier [mailto:marc.zyngier at arm.com]  wrote:
> >On Sat, 18 Nov 2017 10:40:08 +0000
> >"Liuwenliang (Abbott Liu)" <liuwenliang@huawei.com> wrote:
> >> On Nov 17, 2017  15:36 Christoffer Dall [mailto:cdall at linaro.org]  wrote:

> Please don't ask people to limit to 4GB of physical space on CPU
> supporting LPAE, please don't ask people to guaranteed to have some
> memory below 4GB on CPU supporting LPAE.

I don't think that Marc is suggesting that you'd always use the 32-bit
accessors on an LPAE system, just that all the definitions should exist
regardless of configuration.

So rather than this:

> +#ifdef CONFIG_ARM_LPAE
> +#define TTBR0           __ACCESS_CP15_64(0, c2)
> +#define TTBR1           __ACCESS_CP15_64(1, c2)
> +#define PAR             __ACCESS_CP15_64(0, c7)
> +#else
> +#define TTBR0           __ACCESS_CP15(c2, 0, c0, 0)
> +#define TTBR1           __ACCESS_CP15(c2, 0, c0, 1)
> +#define PAR             __ACCESS_CP15(c7, 0, c4, 0)
> +#endif

... you'd have the following in cp15.h:

#define TTBR0_64	__ACCESS_CP15_64(0, c2)
#define TTBR1_64	__ACCESS_CP15_64(1, c2)
#define PAR_64		__ACCESS_CP15_64(0, c7)

#define TTBR0_32	__ACCESS_CP15(c2, 0, c0, 0)
#define TTBR1_32	__ACCESS_CP15(c2, 0, c0, 1)
#define PAR_32		__ACCESS_CP15(c7, 0, c4, 0)

... and elsewhere, where it matters, we choose which to use depending on
the kernel configuration, e.g.

void set_ttbr0(u64 val)
{
	if (IS_ENABLED(CONFIG_ARM_LPAE))
		write_sysreg(val, TTBR0_64);
	else
		write_sysreg(val, TTBR0_32);
}

Thanks,
Mark.
