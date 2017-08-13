From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Sun, 13 Aug 2017 21:28:11 +0000
Subject: [RESEND PATCH 4/4] EDAC: add support for reduced-width Armada-XP
 SDRAM
References: <20170807014641.4003-1-chris.packham@alliedtelesis.co.nz>
 <20170807014641.4003-5-chris.packham@alliedtelesis.co.nz>
 <20170811091402.GD9432@nazgul.tnic>
Message-ID: <291f8d81da814b91aee0a5e6a1133a53@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/17 21:14, Borislav Petkov wrote:
> On Mon, Aug 07, 2017 at 01:46:41PM +1200, Chris Packham wrote:
>> Some integrated Armada XP SoCs use a reduced pin count so the width of
>> the SDRAM interface is smaller than the traditional discrete SoCs. This
>> means that the definition of "full" and "half" width is further reduced.
>>
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>> ---
>>   drivers/edac/armada_xp_edac.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/edac/armada_xp_edac.c b/drivers/edac/armada_xp_edac.c
>> index 68e88b180928..d8edcaac87c0 100644
>> --- a/drivers/edac/armada_xp_edac.c
>> +++ b/drivers/edac/armada_xp_edac.c
>> @@ -350,6 +350,9 @@ static int armada_xp_mc_edac_probe(struct platform_device *pdev)
>>   	if (armada_xp_mc_edac_read_config(mci))
>>   		return -EINVAL;
>>   
>> +	if (of_property_read_bool(pdev->dev.of_node, "marvell,reduced-width"))
>> +		drvdata->width /= 2;
> 
> If the compiler doesn't already convert it to a shift on ARM, you
> probably should do
> 
> 		>>= 1;
> 
> here, just in case.

Based on discussions around the first patch in this series the final 
version will probably be something like

   if (of_device_is_compatible(pdev->dev.of_node,
                               "marvell,98dx3236-sdram-controller")
           drvdata->width >>= 1;

> 
> With that you can add my
> 
> Acked-by: Borislav Petkov <bp@suse.de>
> 
> and route it through an ARM tree.

That may depend on where Jan's series lands. This is is the only patch 
that is dependent on it. Regardless it should be inert so aside from 
triggering checkpatch warnings about dt-bindings there would be no harm 
in this patch taking the long way round.

> 
> Thx.
> 
