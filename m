From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 31 Jul 2015 12:03:53 +0100
Subject: [PATCH] ARM: ux500: fix ux500 secondary CPU boot regression
In-Reply-To: <1438331874-1682-1-git-send-email-linus.walleij@linaro.org>
References: <1438331874-1682-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20150731110353.GV7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 10:37:54AM +0200, Linus Walleij wrote:
> +	scu_desc.pfn = __phys_to_pfn(res.start);
> +	scu_desc.length = resource_size(&res);
> +	iotable_init(&scu_desc, 1);
> +	/* As in devicemaps_init() */
> +	local_flush_tlb_all();
> +	flush_cache_all();

I don't like stuff moving out of the well-defined methods where it should
be done - it makes maintanence of the arch code harder to have platforms
going off and doing their own stuff in random other methods.

IOW, setting up mappings in this way should only be in the ->map_io method.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
