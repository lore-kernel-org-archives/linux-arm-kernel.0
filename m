From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 May 2015 11:32:49 +0100
Subject: [PATCH v2] arm: improve non-section-aligned low memory mapping
In-Reply-To: <1430038028-22625-1-git-send-email-orca.chen@gmail.com>
References: <1430038028-22625-1-git-send-email-orca.chen@gmail.com>
Message-ID: <20150506103249.GG2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 26, 2015 at 04:47:08PM +0800, Min-Hua Chen wrote:
> @@ -1384,6 +1351,15 @@ static void __init map_lowmem(void)
>  				create_mapping(&map);
>  			}
>  		}
> +
> +		/*
> +		 * Find the first section-aligned memblock and set
> +		 * memblock_limit at it.
> +		 */
> +		if (!section_memblock_limit && !(end & ~SECTION_MASK)) {
> +			section_memblock_limit = end;
> +			memblock_set_current_limit(section_memblock_limit);
> +		}

I've suggested an alternative solution to this (which just means changing
the alignment of the memblock limit to 2x SECTION_SIZE).

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
