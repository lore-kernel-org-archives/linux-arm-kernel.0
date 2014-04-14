From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 14 Apr 2014 15:12:36 +0200
Subject: [PATCH 1/2] ARM: add cpu_is_pj4() to distinguish PJ4 core
In-Reply-To: <1395385319-25386-1-git-send-email-chao.xie@marvell.com>
References: <1395385319-25386-1-git-send-email-chao.xie@marvell.com>
Message-ID: <20140414151236.75f8816d@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Chao Xie,

On Fri, 21 Mar 2014 15:01:58 +0800, Chao Xie wrote:

> +/*
> + * Marvell's PJ4 core is based on V7 version. It has some modification
> + * for coprocessor setting. For this reason, we need a way to distinguish
> + * it.
> + */
> +#ifndef CONFIG_CPU_PJ4
> +#define cpu_is_pj4()	0
> +#else
> +static inline int cpu_is_pj4(void)
> +{
> +	unsigned int id;
> +
> +	id = read_cpuid_id();
> +	if ((id & 0xfffffff0) == 0x562f5840)
> +		return 1;

Unfortunately, this doesn't work correctly, because this cpuid check
also matches Armada XP, which uses the PJ4B-MP core, but does not have
the iWMMXt extension. Therefore, when you build mach-mvebu with Dove
support enabled, it does not boot on Armada XP: it fails with an
undefined instruction.

Also, I believe the test is not sufficient because the Dove Armada 510
uses a PJ4 core, but is not matched by the above test.

For reference, the cpuid of various platforms:

 * Armada XP, PJ4B-MP core, 0x562f5842
 * Armada 370, PJ4B core, 0x561f5811
 * Dove Armada 510, PJ4 core, 560f5815

Can you check on your platforms what was the exact cpuid, to see if we
can find a way of correcting this cpu_is_pj4() function? Can you also
check whether your CPU uses a PJ4, PJ4B or PJ4B-MP core?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
