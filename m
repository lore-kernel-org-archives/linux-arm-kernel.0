From: bhuvanchandra.dv@toradex.com (BhuvanChandra.DV)
Date: Wed, 28 Jan 2015 06:58:33 +0000
Subject: [PATCH 4/7] spi: spi-fsl-dspi: avoid preparing the clock two times
In-Reply-To: <20150127130117.GU21293@sirena.org.uk>
References: <1422356244-15629-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1422356244-15629-5-git-send-email-bhuvanchandra.dv@toradex.com>
 <20150127130117.GU21293@sirena.org.uk>
Message-ID: <1422428658040.88027@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 01/27/2015 06:31 PM, Mark Brown wrote:
> On Tue, Jan 27, 2015 at 04:27:21PM +0530, Bhuvanchandra DV wrote:
>> regmap_read/regmap_write will expect the peripheral clock
>> to be enabled before accessing the registers of the peripheral.
>> Since the peripheral clock is enabled separatly, avoid redundant clock
>> prepare (with devm_regmap_init_mmio_clk) and use devm_regmap_init_mmio instead.
> What's the advantage of this?  The clock API is refcounted so there
> should be no issue with this and it seems like it's opening us up to
> bugs if there's a path where we interact with the registers without
> enabling the clocks.

My initial thought was that, since regmap_mmio_init_clk() does call
clk_prepare(), to go with regmap_mmio_init() as clk_prepare_enable()
is called at a later stage in the probe().
