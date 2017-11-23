From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 23 Nov 2017 15:31:34 +0000
Subject: [PATCH 01/11] Initialize the mapping of KASan shadow memory
In-Reply-To: <B8AC3E80E903784988AB3003E3E97330C0069032@dggemm510-mbx.china.huawei.com>
References: <87po8ir1kg.fsf@on-the-bus.cambridge.arm.com>
 <B8AC3E80E903784988AB3003E3E97330C006371B@dggemm510-mbs.china.huawei.com>
 <87375eqobb.fsf@on-the-bus.cambridge.arm.com>
 <B8AC3E80E903784988AB3003E3E97330C0063816@dggemm510-mbs.china.huawei.com>
 <20171117073556.GB28855@cbox>
 <B8AC3E80E903784988AB3003E3E97330C00638D4@dggemm510-mbs.china.huawei.com>
 <20171118134841.3f6c9183@why.wild-wind.fr.eu.org>
 <B8AC3E80E903784988AB3003E3E97330C0068F12@dggemm510-mbx.china.huawei.com>
 <20171121122938.sydii3i36jbzi7x4@lakrids.cambridge.arm.com>
 <B8AC3E80E903784988AB3003E3E97330C0069032@dggemm510-mbx.china.huawei.com>
Message-ID: <20171123153133.mwyuxthy2ysktx7c@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 22, 2017 at 12:56:44PM +0000, Liuwenliang (Abbott Liu) wrote:
> +static inline u64 get_ttbr0(void)
> +{
> + if (IS_ENABLED(CONFIG_ARM_LPAE))
> +         return read_sysreg(TTBR0_64);
> + else
> +         return (u64)read_sysreg(TTBR0_32);
> +}

> +static inline u64 get_ttbr1(void)
> +{
> + if (IS_ENABLED(CONFIG_ARM_LPAE))
> +         return read_sysreg(TTBR1_64);
> + else
> +         return (u64)read_sysreg(TTBR1_32);
> +}

In addition to the whitespace damage that need to be fixed, there's no
need for the u64 casts here. The compiler will implicitly cast to the
return type, and as u32 and u64 are both arithmetic types, we don't need
an explicit cast here.

Thanks,
Mark.
