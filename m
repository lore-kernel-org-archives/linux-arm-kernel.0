From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 10 Jun 2014 19:10:35 +0200
Subject: [PATCH v4 06/11] ARM: EXYNOS: Add support for mapping PMU base
 address via DT
In-Reply-To: <1399704998-13321-7-git-send-email-pankaj.dubey@samsung.com>
References: <1399704998-13321-1-git-send-email-pankaj.dubey@samsung.com>
 <1399704998-13321-7-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <53973C0B.2000903@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10.05.2014 08:56, Pankaj Dubey wrote:
> From: Young-Gun Jang <yg1004.jang@samsung.com>
> 
> Add support for mapping Samsung Power Management Unit (PMU)
> base address from device tree. This patch also adds helper
> function as "get_exynos_pmuregmap". This function can be used
> by other machine files such as "pm.c", "hotplug.c" for accessing
> PMU regmap handle.
> 

I don't think there is a need to use regmap to provide access to PMU to
such low level code such as pm.c or hotplug.c. Moreover, I believe that
it might be undesirable in some cases, e.g. very low level code running
at early resume or late suspend.

IMHO, based on what we now have for SYSRAM, you could simply map PMU
from device tree one time, before SMP init, and keep the address in some
globally accessible variable, like those for SYSRAM we have right now
(sysram_base_addr, sysram_ns_base_addr -> pmu_base_addr).

Then, registration of the normal syscon would happen through standard
platform driver mechanisms and no special early handling would be necessary.

Best regards,
Tomasz
