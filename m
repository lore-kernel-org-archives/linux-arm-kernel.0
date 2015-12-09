From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 9 Dec 2015 22:41:50 +0100
Subject: regmap-mmio and paged registers
Message-ID: <20151209214150.GH3515@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On AT91, we have a paged register inside a register range.

This register looks like that:

AT91_PMC_PCR:
   31   30   29   28   27   26   25   24
 +----+----+----+----+----+----+----+----+
 | -- | -- | -- | EN | -- | -- | -- | -- |
 +----+----+----+----+----+----+----+----+

   23   22   21   20   19   18   17   16
 +----+----+----+----+----+----+----+----+
 | -- | -- | -- | -- | -- | -- |   DIV   |
 +----+----+----+----+----+----+----+----+

   15   14   13   12   11   10   09   08
 +----+----+----+----+----+----+----+----+
 | -- | -- | -- |CMD | -- | -- | -- | -- |
 +----+----+----+----+----+----+----+----+

   07   06   05   04   03   02   01   00
 +----+----+----+----+----+----+----+----+
 | -- | -- |             PID             |
 +----+----+----+----+----+----+----+----+

PID is our selector, the other bits are the data.

We described the regmap by creating a virtual range:

#define AT91_PMC_VIRT_PCR(id)	(0x200 + id)

static const struct regmap_range_cfg pmc_regmap_ranges[] = {
	{
		.range_min = AT91_PMC_VIRT_PCR(0),
		.range_max = AT91_PMC_VIRT_PCR(AT91_PMC_PCR_PID_MASK),
		.window_start = AT91_PMC_PCR,
		.window_len = 1,
		.selector_reg = AT91_PMC_PCR,
		.selector_mask = 0xffffffff,
	},
};

static struct regmap_config at91sam9x5_pmc_regmap_config = {
	.reg_bits = 32,
	.val_bits = 32,
	.reg_stride = 4,
	.ranges = pmc_regmap_ranges,
	.num_ranges = ARRAY_SIZE(pmc_regmap_ranges),
	.max_register = AT91_PMC_VIRT_PCR(AT91_PMC_PCR_PID_MASK),
};

The issue we have with that setup is that _regmap_select_page() does
that check before writing the page number:

	/* It is possible to have selector register inside data window.
	   In that case, selector register is located on every page and
	   it needs no page switching, when accessed alone. */
	if (val_num > 1 ||
	    range->window_start + win_offset != range->selector_reg) {

So it ends up never writing the page number in the register.

One possible solution would be to implement our own .read and .write to
handle that paging but maybe you can think of something else.


The full datasheet is here, 27.16.26 PMC Peripheral Control Register,
page 270
http://www.atmel.com/Images/Atmel-11121-32-bit-Cortex-A5-Microcontroller-SAMA5D3_Datasheet.pdf

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
