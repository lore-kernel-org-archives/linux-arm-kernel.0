From: scott.wood@nxp.com (Scott Wood)
Date: Wed, 18 Jan 2017 23:36:18 +0000
Subject: [PATCH 06/10] soc/qbman: Add ARM equivalent for
 flush_dcache_range()
References: <1484779180-1344-1-git-send-email-roy.pledge@nxp.com>
 <1484779180-1344-7-git-send-email-roy.pledge@nxp.com>
 <20170118231206.GT27312@n2100.armlinux.org.uk>
Message-ID: <VI1PR0401MB2430DA6BD2F857C30EC86A50917F0@VI1PR0401MB2430.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18/2017 05:12 PM, Russell King - ARM Linux wrote:
> On Wed, Jan 18, 2017 at 05:39:36PM -0500, Roy Pledge wrote:
>> From: Claudiu Manoil <claudiu.manoil@nxp.com>
>>
>> Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
>> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
>> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
>> ---
>>  drivers/soc/fsl/qbman/qman_ccsr.c |    6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
>> index 43feaa9..67ae073 100644
>> --- a/drivers/soc/fsl/qbman/qman_ccsr.c
>> +++ b/drivers/soc/fsl/qbman/qman_ccsr.c
>> @@ -446,8 +446,14 @@ static int zero_priv_mem(struct device *dev, struct device_node *node,
>>  		return -ENOMEM;
>>  
>>  	memset(tmpp, 0, sz);
>> +#ifdef CONFIG_PPC
>>  	flush_dcache_range((unsigned long)tmpp,
>>  			   (unsigned long)tmpp + sz);
>> +#elif defined(CONFIG_ARM)
>> +	__cpuc_flush_dcache_area(tmpp, sz);
> 
> Please do not fiddle about under the covers, there be dragons there.
> 
> It looks to me like you're trying to use __cpuc_flush_dcache_area()
> on an area that's been ioremap()'d, which is a waste of CPU cycles.
> ioremap()'d areas are mapped as "device" memory type, which means
> the region isn't even cached.  So I don't think this is necessary.

It is mapped cachable, via memremap() (see patch 1/10).  This is RAM
that the device uses, non-coherently, for its own purposes (but requires
software to clear it first).

Is there a non-"under the covers" way to say "flush this region" without
the arch second-guessing whether it really needs to be flushed?

-Scott
