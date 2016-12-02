From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 2 Dec 2016 16:30:14 +0530
Subject: [PATCH 1/3] ARM: da850: fix infinite loop in clk_set_rate()
In-Reply-To: <1480612516-18853-2-git-send-email-bgolaszewski@baylibre.com>
References: <1480612516-18853-1-git-send-email-bgolaszewski@baylibre.com>
 <1480612516-18853-2-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <bf382533-c0d0-2ed0-dedd-9ea617775a6e@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartosz,

On Thursday 01 December 2016 10:45 PM, Bartosz Golaszewski wrote:
> The aemif clock is added twice to the lookup table in da850.c. This
> breaks the children list of pll0_sysclk3 as we're using the same list
> links in struct clk. When calling clk_set_rate(), we get stuck in
> propagate_rate().
> 
> Simply add the clock once, but specify both the con_id and dev_id in
> the lookup entry.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The issue is real, but the fix is not going to be this simple, I am
afraid. This will break NAND on all da850 boards including LCDK.

The aemif clock is accessed in two ways. One by the
drivers/memory/ti-aemif.c, using ti-aemif as the device name and NULL
connection id. Second by drivers/mtd/nand/davinci_nand.c and
arch/arm/mach-davinci/aemif.c using davinci-nand as device id and with
"aemif" as the connection id.

We will need to match both. The only way to fix this without breaking
anything is to create two clocks for the two lookups above. Both cannot
be PSC clocks for the same PSC module as that would be racy. Instead
just create a new nand clock node which is a child of the aemif node and
inherits parent's clock rate.

Thanks,
Sekhar
