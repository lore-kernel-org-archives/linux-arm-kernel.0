From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Dec 2013 21:12:52 +0100
Subject: [PATCH 2/3] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
In-Reply-To: <52A8868A.3000105@linaro.org>
References: <1386770541-15056-1-git-send-email-zhangfei.gao@linaro.org>
 <201312111549.14017.arnd@arndb.de> <52A8868A.3000105@linaro.org>
Message-ID: <201312112112.52746.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 December 2013, zhangfei wrote:
> >
> > I have not seen "clk-table" and "clk-table-num" before. Are these standard
> > properties? What are the units that are used here, what does the index mean?
> >
> 
> "clk-table" and "clk-table-num" are private properties.
> Instead simply on/off, the ip need different ciu clock for each timing mode.

But aren't the times fixed for each mode? Why do you need to specify them in
the DT? I would expect that the clock rates for each mode are set in the
MMC and SD specifications. When you call clk_set_rate(), it should normally
be enough to ask for the clock you actually want and let the clk subsystem
figure out how to set up the parents and multipliers on the way.

> Take emmc as example,
> clk-table-num = <8>;
> clk-table =
> <13000000 50000000 0 0 13000000 50000000 0 100000000>;
> MMC_TIMING_LEGACY mode, 25M should be set with parent clock 180M,
> MMC_TIMING_MMC_HS mode, 50M is required with parent clock 360M
> 
> "clk-table" list all clocks to be set in all supported timing one by one.
> "clk-table-num" is the table number, since not find function getting 
> table number.
> For example, next version will support MMC_TIMING_MMC_HS200 mode, the 
> clk-table-num = <9> with 9 clocks in the "clk-table"

If you have a property with an array, you can use of_find_property()
to get to the 'struct property' and then read the 'length' member
of that struct, or you can use of_property_for_each_u32() to iterate
through each value.

While I still hope that you don't even need this array as per the reasoning
above, if you actually need it, you should specify exactly what each
value means, such as

1. CIU clock rate in HZ for 20MHz SPI mode operation 
2. CIU clock rate in HZ for 25MHz SD card operation
3. CIU clock rate in HZ for 26MHz MMC card operation
4. CIU clock rate in HZ for 50MHz SD card operation
...

	Arnd
