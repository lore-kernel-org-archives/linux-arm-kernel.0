From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 14 Feb 2010 19:45:01 +0000
Subject: [PATCH 05/14] ARM: LPC32XX: System suspend support
In-Reply-To: <20100214165122.GA1365@ucw.cz>
References: <1265674295-23996-1-git-send-email-wellsk40@gmail.com>
	<1265674295-23996-6-git-send-email-wellsk40@gmail.com>
	<20100214165122.GA1365@ucw.cz>
Message-ID: <20100214194501.GB11315@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 14, 2010 at 05:51:22PM +0100, Pavel Machek wrote:
> > +	/* Backup a small area of IRAM used for the suspend code */
> > +	memcpy(iram_swap_area, (void *) TEMP_IRAM_AREA,
> > +		lpc32xx_sys_suspend_sz);
> > +	flush_cache_all();
> > +
> > +	/*
> > +	 * Copy code to suspend system into IRAM. The suspend code
> > +	 * needs to run from IRAM as DRAM may no longer be available
> > +	 * when the PLL is stopped.
> > +	 */
> > +	memcpy((void *) TEMP_IRAM_AREA, &lpc32xx_sys_suspend,
> > +		lpc32xx_sys_suspend_sz);
> 
> icache flush needed here? or does the above flush suffice? ... I
> believe you do need the flush.

It is not sufficient, and I'm not sure what that 'flush_cache_all'
above is doing there.

flush_icache_range() is always required after copying instructions
into a new kernel area prior to executing them to ensure that the
newly placed instructions are visible to instruction fetches.
