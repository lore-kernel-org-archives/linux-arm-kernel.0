From: joelf@ti.com (Joel Fernandes)
Date: Wed, 4 Dec 2013 13:38:37 +0530
Subject: [PATCH] ARM: OMAP2+: omap_device: add fail hook for runtime_pm
 when bad data is detected
In-Reply-To: <1386121153-32351-1-git-send-email-nm@ti.com>
References: <1386121153-32351-1-git-send-email-nm@ti.com>
Message-ID: <529EE305.70001@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/2013 07:09 AM, Nishanth Menon wrote:
> Due to the cross dependencies between hwmod for automanaged device
> information for OMAP and dts node definitions, we can run into scenarios
> where the dts node is defined, however it's hwmod entry is yet to be
> added. In these cases:
> a) omap_device does not register a pm_domain (since it cannot find
>    hwmod entry).
> b) driver does not know about (a), does a pm_runtime_get_sync which
>    never fails
> c) It then tries to do some operation on the device (such as read the
>   revision register (as part of probe) without clock or adequate OMAP
>   generic PM operation performed for enabling the module.
> 
> This causes a crash such as that reported in:
> https://bugzilla.kernel.org/show_bug.cgi?id=66441
> 
> When 'ti,hwmod' is provided in dt node, it is expected that the device
> will not function without the OMAP's power automanagement. Hence, when
> we hit a fail condition (due to hwmod entries not present or other
> similar scenario), fail at pm_domain level due to lack of data, provide
> enough information for it to be fixed, however, it allows for the driver
> to take appropriate measures to prevent crash.
> 
> Reported-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/mach-omap2/omap_device.c |   24 ++++++++++++++++++++++++
>  arch/arm/mach-omap2/omap_device.h |    1 +
>  2 files changed, 25 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
> index 53f0735..e0a398c 100644
> --- a/arch/arm/mach-omap2/omap_device.c
> +++ b/arch/arm/mach-omap2/omap_device.c
> @@ -183,6 +183,10 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
>  odbfd_exit1:
>  	kfree(hwmods);
>  odbfd_exit:
> +	/* if data/we are at fault.. load up a fail handler */
> +	if (ret)
> +		pdev->dev.pm_domain = &omap_device_fail_pm_domain;
> +
>  	return ret;
>  }
>  

Just wondering, can't we just print the warning here instead of registering new
pm_domain callbacks?

Concerned that all this LOC may end up being dead code when the "ti,hwmods"
property becomes obsolete anyway.

-Joel
