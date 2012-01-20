From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 19:27:50 +0000
Subject: inconvenience when hand editing DEBUG_LL in .config
In-Reply-To: <20120120164036.GO4066@pengutronix.de>
References: <20120120164036.GO4066@pengutronix.de>
Message-ID: <20120120192750.GE11845@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2012 at 05:40:36PM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> usually when I want to change a single kernel option I just open .config
> in my editor, remove the line for the config item I want to change and
> run oldconfig. For DEBUG_LL (defined in arch/arm/Kconfig.debug) this
> doesn't work as usual though.
> 
> On 3.3-rc1 the following happens:
> 
> 	make ARCH=arm at91rm9200_defconfig
> 	sed -i /CONFIG_DEBUG_LL/d .config

Note that this deletes two entries.  Use /CONFIG_DEBUG_LL\\\>/d to delete
just one (or get rid of two of those \ and use ' to quote it.)

> 	make ARCH=arm oldconfig
> 
> The last command then asks me for DEBUG_LL, after specifying 'y', the
> output looks as follows:
> 
> 	Verbose user fault messages (DEBUG_USER) [N/y/?] n
> 	Kernel low-level debugging functions (read help!) (DEBUG_LL) [N/y/?] (NEW) y
> 	  Kernel low-level debugging port
> 	  > 1. No low-level debugging UART (DEBUG_LL_UART_NONE) (NEW)
> 	    2. Kernel low-level debugging via EmbeddedICE DCC channel (DEBUG_ICEDCC) (NEW)
> 	    3. Kernel low-level debugging on rm9200, 9260/9g20, 9261/9g10 and 9rl (AT91_DEBUG_LL_DBGU0) (NEW)
> 	  choice[1-3]: 1
> 	  Early printk (EARLY_PRINTK) [N/y/?] (NEW) 
> 
> Note that I didn't specify the '1' for the choice even though all items
> are marked as new and oldconfig only starts at EARLY_PRINTK to ask
> again.
> 
> I would have expected to be able to select AT91_DEBUG_LL_DBGU0.

Confirmed here.

> This is not intended, is it?

Nope - and if you delete all the DEBUG choice entries from your .config,
it still defaults to the first and doesn't offer it for you to choose.
Ditto if you delete none.
