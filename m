From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 14 Sep 2010 13:28:50 +0800
Subject: [PATCH 3/4] ARM: pxa: update cpuid of pxa168 & pxa910
In-Reply-To: <1283953362-2363-3-git-send-email-haojian.zhuang@marvell.com>
References: <1283953362-2363-1-git-send-email-haojian.zhuang@marvell.com>
	<1283953362-2363-2-git-send-email-haojian.zhuang@marvell.com>
	<1283953362-2363-3-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <AANLkTimfF97fYi+j0gOHTem_FdU0SZ9R4HXyPumtN49t@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

might be better now for us to move to something like:

#ifdef CONFIG_CPU_PXA168
static inline int cpu_is_pxa168(void)
{
	return ((read_cpuid_id() >> 4) & 0xff == 0x84) &&
		(mmp_chip_id & 0x0fff == 0x0333);
}
#else
#define cpu_is_pxa168()		(0)
#endif

Although these all need to be re-worked in the end once multiple SoCs can
be compiled together.

> ?#else
> -# ?define __cpu_is_pxa168(id) ?(0)
> +#define __cpu_is_pxa168(id, cid) ? ? ? (0)
> ?#endif
>
> ?#ifdef CONFIG_CPU_PXA910
> -# ?define __cpu_is_pxa910(id) ?\
> - ? ? ? ({ unsigned int _id = ((id) >> 8) & 0xff; _id == 0x80; })
> +#define __cpu_is_pxa910(id, cid) ? ? ? \
> + ? ? ? ({ unsigned int _id = ((id) >> 8) & 0xff; \
> + ? ? ? ? ?unsigned int _cid = (cid) & 0xfff; \
> + ? ? ? ? ?(_id == 0x84 || _id == 0x80) && (_cid == 0x910 || _cid == 0x920); })
> ?#else
> -# ?define __cpu_is_pxa910(id) ?(0)
> +#define __cpu_is_pxa910(id, cid) ? ? ? (0)
> ?#endif
>
> ?#ifdef CONFIG_CPU_MMP2
> -# ?define __cpu_is_mmp2(id) ? ?\
> +#define __cpu_is_mmp2(id) ? ? ?\
> ? ? ? ?({ unsigned int _id = ((id) >> 8) & 0xff; _id == 0x58; })
> ?#else
> -# ?define __cpu_is_mmp2(id) ? ?(0)
> +#define __cpu_is_mmp2(id) ? ? ?(0)
> ?#endif
>
> -#define cpu_is_pxa168() ? ? ? ? ? ? ? ?({ __cpu_is_pxa168(read_cpuid_id()); })
> -#define cpu_is_pxa910() ? ? ? ? ? ? ? ?({ __cpu_is_pxa910(read_cpuid_id()); })
> +#define cpu_is_pxa168() ? ? ? ? ? ? ? ?({ __cpu_is_pxa168(read_cpuid_id(), \
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? __raw_readl(CHIP_ID)); })
> +#define cpu_is_pxa910() ? ? ? ? ? ? ? ?({ __cpu_is_pxa910(read_cpuid_id(), \
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? __raw_readl(CHIP_ID)); })
> ?#define cpu_is_mmp2() ? ? ? ? ?({ __cpu_is_mmp2(read_cpuid_id()); })
>
> ?#endif /* __ASM_MACH_CPUTYPE_H */
> --
> 1.5.6.5
>
>
