From: tony@atomide.com (Tony Lindgren)
Date: Tue, 22 Aug 2017 10:37:49 -0700
Subject: [PATCH 5/8] ARM: OMAP4: hwmod_data: Remove modulemode from
 IPU/DSP hwmods
In-Reply-To: <20170821234818.4755-6-s-anna@ti.com>
References: <20170821234818.4755-1-s-anna@ti.com>
 <20170821234818.4755-6-s-anna@ti.com>
Message-ID: <20170822173749.GK6008@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Suman Anna <s-anna@ti.com> [170821 16:48]:
>
> A shutdown sequence follows a reverse pattern
> with the processors put into reset first followed by the unmapping and
> disabling of the MMUs. Both the processors and the MMUs are present
> within a single clock domain and requires the domain be clocked and
> enabled until the last entity. The kernel crash can happen during the
> unmapping phase of the MMUs, as the hwmod layer disables the module
> during the omap_device_idle processing of the processor hwmod. This
> issue is fixed by not defining a modulemode for the IPU/DSP processors,
> which results in keeping the module in an activated state. The module
> is disabled properly during the omap_device_idle processing of the MMU
> hwmod while disabling the MMU.

I think a better way to fix this would be to make sure the module
is enabled during the unmapping phase of the MMUs. If there is no
driver left at that point to call pm_runtime_get() on the module,
do it via pdata-quirks.c using struct iommu_platform_data?

If you can't add the enable/disable around existing assert_reset/
deassert_reset, you can add a new one.

Regards,

Tony
