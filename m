From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Jan 2015 23:48:21 +0000
Subject: [PATCH v2] ARM: early fixmap support for earlycon
In-Reply-To: <1421797064-2989-1-git-send-email-stefan@agner.ch>
References: <1421797064-2989-1-git-send-email-stefan@agner.ch>
Message-ID: <20150120234821.GN26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 21, 2015 at 12:37:44AM +0100, Stefan Agner wrote:
> Add early fixmap support, initially to support permanent, fixed
> mapping support for early console. A temporary, early pte is
> created which is migrated to a permanent mapping in paging_init.
> This is also needed since the attributs may change as the memory
> types are initialized. The 3MiB range of fixmap spans two pte
> tables, but currently only one pte is created for early fixmap
> support.

I think this needs to be done more carefully - I think the entry(ies)
should be removed, the TLBs flushed, and the new entry established.
So:

> +static void __init early_fixmap_shutdown(void)
> +{
> +	int i;
> +
> +	pte_offset_fixmap = &pte_offset_late_fixmap;
> +	pmd_clear(fixmap_pmd(fix_to_virt(__end_of_permanent_fixed_addresses - 1)));

I think you should flush tlbs here.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
