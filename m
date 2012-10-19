From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 19 Oct 2012 10:40:29 -0600
Subject: [PATCH V2 3/3] ARM: tegra: move debug-macro.S to include/debug
In-Reply-To: <5080088C.9090607@gmail.com>
References: <1350328024-30485-1-git-send-email-swarren@wwwdotorg.org>
 <1350328024-30485-3-git-send-email-swarren@wwwdotorg.org>
 <507EC303.1080000@gmail.com> <507EDB37.1060102@wwwdotorg.org>
 <507F1F31.2060503@wwwdotorg.org> <5080088C.9090607@gmail.com>
Message-ID: <5081827D.9060906@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/18/2012 07:47 AM, Rob Herring wrote:
...
> Here is what I mentioned previously. This removes the static mapping from 
> the platforms. This is untested and probably breaks on different DEBUG_LL 
> options. For now, platforms call debug_ll_io_init, but once all platforms 
> are converted, this can be called from devicemaps_init.

> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c

> +void __init debug_ll_io_init(void)
> +{
> +	struct map_desc map;
> +
> +	if (!IS_ENABLED(CONFIG_DEBUG_LL))
> +		return;
> +
> +	debug_ll_addr(&map.pfn, &map.virtual);
> +	map.pfn = __phys_to_pfn(map.pfn);
> +	map.length = PAGE_SIZE;
> +	map.type = MT_DEVICE;
> +	create_mapping(&map);
> +}

OK, so I just call this new function from Tegra's tegra_map_common_io().
That looks pretty neat. I'll give it a try.
