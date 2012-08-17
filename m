From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Aug 2012 10:58:37 +0100
Subject: [PATCH] BUG: clk_find() misses some clocks
In-Reply-To: <1345196843-23059-1-git-send-email-richard.genoud@gmail.com>
References: <1345196843-23059-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <20120817095837.GM18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please read the comments on the function:

 * Find the correct struct clk for the device and connection ID.
 * We do slightly fuzzy matching here:
 *  An entry with a NULL ID is assumed to be a wildcard.
 *  If an entry has a device ID, it must match
 *  If an entry has a connection ID, it must match
 * Then we take the most specific entry - with the following
 * order of precedence: dev+con > dev only > con only.

On Fri, Aug 17, 2012 at 11:47:23AM +0200, Richard Genoud wrote:
> if a clock is declared like that:
> CLKDEV_CON_DEV_ID("pioA", "fffff400.gpio", &pioAB_clk)

So you've declared it with a connection ID.  Therefore, as the comment
above says, "it must match" what the driver is asking for.

It's not a bug, this is done intentionally so that mismatches do not
occur.
