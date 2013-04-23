From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Apr 2013 20:40:07 +0100
Subject: [PATCH v4 12/15] ARM: CCI: ensure powerdown-time data is
 flushed from cache
In-Reply-To: <1360041732-17936-13-git-send-email-nicolas.pitre@linaro.org>
References: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
 <1360041732-17936-13-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20130423194007.GD5316@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 12:22:09AM -0500, Nicolas Pitre wrote:
> +	/*
> +	 * Multi-cluster systems may need this data when non-coherent, during
> +	 * cluster power-up/power-down. Make sure it reaches main memory:
> +	 */
> +	__cpuc_flush_dcache_area(info, sizeof *info);
> +	__cpuc_flush_dcache_area(&info, sizeof info);
> +	outer_clean_range(virt_to_phys(info), virt_to_phys(info + 1));
> +	outer_clean_range(virt_to_phys(&info), virt_to_phys(&info + 1));

This seems to be a recurring theme throughout these patches.  What it's
saying is that we need a proper way to do this, rather than keep on
open coding this same thing time and time again.  So, it's do something
about that rather than having to go back and rework all this stuff later,
creating "pointless churn" that Linus really hates.
