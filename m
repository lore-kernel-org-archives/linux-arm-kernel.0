From: s-anna@ti.com (Suman Anna)
Date: Thu, 7 Jan 2016 15:26:18 -0600
Subject: dra7xx pci driver broken on dra7xx-evm
In-Reply-To: <568DF4FE.5010704@ti.com>
References: <20160106214518.GA6106@localhost.localdomain>
 <568DF4FE.5010704@ti.com>
Message-ID: <568ED7FA.4000508@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/2016 11:17 PM, Kishon Vijay Abraham I wrote:
> Hi,

+ Tero, Tony and linux-omap

> 
> On Thursday 07 January 2016 03:15 AM, Richard Cochran wrote:
>>
>> The dra7xx-evm box freezes hard at the very first PCI bus access, the
>> call to in dra7xx_pcie_readl() in dra7xx_pcie_probe().
>>
>> The out-of-tree 3.14.53 TI driver performs a reset via platform data,
>> calling omap_device_assert_hardreset() by hook and crook.

Yeah, this is the only feasible way and not break multi-arch atm until a
reset framework is in place. We have couple of drivers (omap_iommu and
wkup_m3_rproc) following this approach.

>>
>> Adding the reset into the mainline driver cures the freeze.


>>
>> Question: How on earth is this driver supposed to work?
> 
> It doesn't work out of the box in mainline. (Every time I post a PCI patch, I
> add the pdata-quirks mechanism to test it). The pdata-quirks mechanism used in
> TI tree is not an upstream-able solution. Something like this [1] was done for
> performing reset. Not sure the latest state of that. Dan? Suman?

Yeah, [1] is very old, and it doesn't deal with the hwmod integration
for pm_runtime API usage. Tero has posted another revamped series [2]
with hwmod integration, and it needs to be refreshed with few additional
patches and fixes. It will probably take couple of releases before it
hits mainline. So, I guess it is then a question of picking up the pdata
quirks solution for interim to get the driver functional until the reset
framework hits mainline, or mark the driver as broken.

regards
Suman

> 
> [1] -> https://patches.linaro.org/33797/

[2] http://marc.info/?l=linux-omap&m=144310496514782&w=2
