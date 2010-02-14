From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 14 Feb 2010 17:51:22 +0100
Subject: [PATCH 05/14] ARM: LPC32XX: System suspend support
In-Reply-To: <1265674295-23996-6-git-send-email-wellsk40@gmail.com>
References: <1265674295-23996-1-git-send-email-wellsk40@gmail.com>
	<1265674295-23996-6-git-send-email-wellsk40@gmail.com>
Message-ID: <20100214165122.GA1365@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Support for system suspend and resume
> 
> Signed-off-by: Kevin Wells <wellsk40@gmail.com>
> ---


> +	/* Backup a small area of IRAM used for the suspend code */
> +	memcpy(iram_swap_area, (void *) TEMP_IRAM_AREA,
> +		lpc32xx_sys_suspend_sz);
> +	flush_cache_all();
> +
> +	/*
> +	 * Copy code to suspend system into IRAM. The suspend code
> +	 * needs to run from IRAM as DRAM may no longer be available
> +	 * when the PLL is stopped.
> +	 */
> +	memcpy((void *) TEMP_IRAM_AREA, &lpc32xx_sys_suspend,
> +		lpc32xx_sys_suspend_sz);

icache flush needed here? or does the above flush suffice? ... I
believe you do need the flush.

> +	/* Transfer to suspend code in IRAM */
> +	lpc32xx_suspend_ptr = (void *) TEMP_IRAM_AREA;
> +	(void) lpc32xx_suspend_ptr();
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
