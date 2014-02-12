From: monstr@monstr.eu (Michal Simek)
Date: Wed, 12 Feb 2014 11:51:11 +0100
Subject: [RFC PATCH 2/3] mfd: syscon: Support early initialization
In-Reply-To: <20140212095424.GV15081@lee--X1>
References: <cover.1392045742.git.michal.simek@xilinx.com>
 <1785585d090175da81b561b17eeef95d991ff0de.1392045742.git.michal.simek@xilinx.com>
 <20140212095424.GV15081@lee--X1>
Message-ID: <52FB521F.5040006@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/2014 10:54 AM, Lee Jones wrote:
> On Mon, 10 Feb 2014, Michal Simek wrote:
> 
>> Some platforms need to get system controller
>> ready as soon as possible.
>> The patch provides early_syscon_initialization
>> which create early mapping for all syscon compatible
>> devices in early_syscon_probe.
>> Regmap is get via syscon_early_regmap_lookup_by_phandle()
>>
>> Regular device probes attach device to regmap
>> via regmap_attach_dev().
>>
>> For early syscon initialization is necessary to extend
>> struct syscon and provide remove function
>> which unmap all early init structures.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>>  drivers/mfd/syscon.c       | 126 +++++++++++++++++++++++++++++++++++++++------
>>  include/linux/mfd/syscon.h |  11 ++++
>>  2 files changed, 120 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> 
> <snip>
> 
>>  struct regmap *syscon_regmap_lookup_by_phandle(struct device_node *np,
>>  					const char *property)
>>  {
>> @@ -128,40 +149,110 @@ static int syscon_probe(struct platform_device *pdev)
>>  	struct device *dev = &pdev->dev;
>>  	struct syscon *syscon;
>>  	struct resource *res;
>> -	void __iomem *base;
>>
>> -	syscon = devm_kzalloc(dev, sizeof(*syscon), GFP_KERNEL);
>> +	/* Early syscon init */
>> +	if (pdev->dev.of_node && pdev->dev.of_node->data) {
>> +		syscon = pdev->dev.of_node->data;
>> +		res = &syscon->res;
>> +		regmap_attach_dev(dev, syscon->regmap, &syscon_regmap_config);
> 
> Instead of duplicating all of the init code with early and late
> versions of each, is there any reason why we can't always do the early
> stuff early and then connect it to the dev infrastructure when it
> becomes available?

I am waiting for Arnd and Mark opinions regarding this.
That's why it was just RFC.
There the next question is if this should still stay
in mfd or moved to base.

I wanted to keep this to be driver compatible
that's why I have done it in this way.

We will see.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140212/3f71a6b5/attachment.sig>
