From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 19 May 2014 13:12:05 +0300
Subject: [PATCH 01/11] ARM: AM43xx: hwmod: add DSS hwmod data
In-Reply-To: <5379CDD2.6080807@ti.com>
References: <1399636579-8062-1-git-send-email-tomi.valkeinen@ti.com>
 <1399636579-8062-2-git-send-email-tomi.valkeinen@ti.com>
 <5379CDD2.6080807@ti.com>
Message-ID: <5379D8F5.9030008@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/05/14 12:24, Rajendra Nayak wrote:
> On Friday 09 May 2014 05:26 PM, Tomi Valkeinen wrote:
>> From: Sathya Prakash M R <sathyap@ti.com>
>>
>> Add DSS hwmod data for AM43xx.
>>
>> Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>  arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 104 +++++++++++++++++++++++++++++
>>  arch/arm/mach-omap2/prcm43xx.h             |   1 +
>>  2 files changed, 105 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
>> index 5c2cc8083fdd..8c14db2e1e47 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
>> @@ -19,6 +19,8 @@
>>  #include "omap_hwmod.h"
>>  #include "omap_hwmod_33xx_43xx_common_data.h"
>>  #include "prcm43xx.h"
>> +#include "omap_hwmod_common_data.h"
>> +
>>  
>>  /* IP blocks */
>>  static struct omap_hwmod am43xx_l4_hs_hwmod = {
>> @@ -415,6 +417,76 @@ static struct omap_hwmod am43xx_qspi_hwmod = {
>>  	},
>>  };
>>  
>> +/* Display sub system - DSS */
>> +
>> +static struct omap_hwmod_dma_info am43xx_dss_sdma_chs[] = {
>> +	{ .name = "dispc", .dma_req = 5 },
>> +	{ .dma_req = -1 },
>> +};
> 
> the dma info needs to come in from DT. Besides these are edma
> request lines and not sdma.

Right, the sdma information is not needed anymore.

>> +
>> +struct omap_dss_dispc_dev_attr am43xx_dss_dispc_dev_attr = {
>> +	.manager_count		= 1,
>> +	.has_framedonetv_irq	= 0
>> +};
>> +
>> +
> []..
> 
>> +
>>  /* Interfaces */
>>  static struct omap_hwmod_ocp_if am43xx_l3_main__l4_hs = {
>>  	.master		= &am33xx_l3_main_hwmod,
>> @@ -654,6 +726,34 @@ static struct omap_hwmod_ocp_if am43xx_l3_s__qspi = {
>>  	.user           = OCP_USER_MPU | OCP_USER_SDMA,
>>  };
>>  
>> +static struct omap_hwmod_ocp_if am43xx_dss__l3_main = {
>> +	.master		= &am43xx_dss_core_hwmod,
>> +	.slave		= &am33xx_l3_main_hwmod,
>> +	.clk		= "disp_clk",
> 
> Isn't l3_gclk that clocks the l3 OCP master port?

Hmm, possibly... dispc_clk looks a bit odd there. It's been very
difficult to figure out things like that, with the not-so-good am43xx
documentation.

The documentation mentions "L3 Fast Interconnect" and "LCDL3OCPIFCLK"
related to DSS's OCP master, but searching for those in the TRM doesn't
reveal much.

Would the l3_gclk match the "L3 Fast Interconnect" and l3s_gclk match
the "L3 Slow Interconnect".

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140519/468c7519/attachment-0001.sig>
