From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 05 Jul 2010 20:21:56 +0900
Subject: About cachetype on ARMv7
Message-ID: <004c01cb1c34$49773f60$dc65be20$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I have a query about cachetype on ARMv7.

Following is from arch/arm/kernel/setup.c

static void __init cacheid_init(void)
{
	unsigned int cachetype = read_cpuid_cachetype();
	unsigned int arch = cpu_architecture();

	if (arch >= CPU_ARCH_ARMv6) {
		if ((cachetype & (7 << 29)) == 4 << 29) {
			/* ARMv7 register format */
			cacheid = CACHEID_VIPT_NONALIASING;

(snip)

	printk("CPU: %s data cache, %s instruction cache\n",
		cache_is_vivt() ? "VIVT" :
		cache_is_vipt_aliasing() ? "VIPT aliasing" :
		cache_is_vipt_nonaliasing() ? "VIPT nonaliasing" :
"unknown",
		cache_is_vivt() ? "VIVT" :
		icache_is_vivt_asid_tagged() ? "VIVT ASID tagged" :
		cache_is_vipt_aliasing() ? "VIPT aliasing" :
		cache_is_vipt_nonaliasing() ? "VIPT nonaliasing" :
"unknown");
}

The cachetype access cp15 CTR register through read_cpuid_cachetype(). And
if ARMv7, then its [31:29] value is 100(b).

[31:29] = 100(b) on ARMv7
[31:29] = 000(b) on ARMv6

So, if ARMv7, then cacheid is mapped VIPT cache and non-aliasing,
CACHEID_VIPT_NONALIASING.

But actually, didn't check L1Ip which has policy of instruction cache, and
policy of data cache from other register at that time. Nevertheless, if
ARMv7, printed like following and used.
'CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache'

If every ARMv7 SoCs have VIPT non-aliasing d-cache and i-cache, then no
problem. But actually, Samsung S5PV310(cortex-A9) has PIPT d-cache and VIPT
non-aliasing i-cache. I think PIPT does not mean VIPT non-aliasing even
though their functionality is similar.
Isn't there any functionality difference?
And..in this case, isn't there any problems?
...

How do you think about this?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
