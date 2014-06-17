From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 17 Jun 2014 10:09:21 +0300
Subject: [RESEND PATCH 1/2] ARM: AM43xx: hwmod: add DSS hwmod data
In-Reply-To: <20140616092219.GZ17845@atomide.com>
References: <1402676147-3711-1-git-send-email-balbi@ti.com>
 <1402676147-3711-2-git-send-email-balbi@ti.com>
 <20140616092219.GZ17845@atomide.com>
Message-ID: <539FE9A1.7040409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/06/14 12:22, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [140613 09:17]:
>> From: Sathya Prakash M R <sathyap@ti.com>
>>
>> Add DSS hwmod data for AM43xx.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Acked-by: Rajendra Nayak <rnayak@ti.com>
>> Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>> ---
>>
>> Note that this patch was originally send on May 9th [1], changes were requested
>> and a new version was sent on May 19th [2], then on May 27th [3] Tomi pinged
>> maintainer again and go no response.
>>
>> Without this patch, we cannot get display working on any AM437x devices.
>>
>> [1] http://marc.info/?l=linux-arm-kernel&m=139963677925227&w=2
>> [2] http://marc.info/?l=linux-arm-kernel&m=140049799425512&w=2
>> [3] http://marc.info/?l=linux-arm-kernel&m=140117232826754&w=2
>>
>>  arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 98 ++++++++++++++++++++++++++++++
>>  arch/arm/mach-omap2/prcm43xx.h             |  1 +
>>  2 files changed, 99 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
>> index 5c2cc80..d2a7b6d 100644
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
>> @@ -415,6 +417,70 @@ static struct omap_hwmod am43xx_qspi_hwmod = {
>>  	},
>>  };
>>  
>> +/* Display sub system - DSS */
>> +
>> +struct omap_dss_dispc_dev_attr am43xx_dss_dispc_dev_attr = {
>> +	.manager_count		= 1,
>> +	.has_framedonetv_irq	= 0
>> +};
>> +
>> +
>> +static struct omap_hwmod_class_sysconfig am43xx_dispc_sysc = {
>> +	.rev_offs	= 0x0000,
>> +	.sysc_offs	= 0x0010,
>> +	.syss_offs	= 0x0014,
>> +	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE),
>> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
>> +	.sysc_fields	= &omap_hwmod_sysc_type1,
>> +};
> 
> Looking at the TRM, "Table 13-43. DISPC_SYSCFG Register Field
> Descriptions" seems to list the folowing bits available:
> 
> 13-12	MIDLEMODE 
> 9-8	CLOCK_ACTIVITY 
> 4-3	SIDLEMODE 
> 2	ENWAKEUP 
> 1	SOFTRESET 
> 0	AUTOIDLE 
> 
> Have I missed something or how come we don't define them all
> as available?

Yes, you're right. I don't see why they shouldn't be there.

> The .idlemodes available values and .sysc_fields seems to match
> the TRM.

Shouldn't idlemodes also have:

	MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART

I changed the dispc flags to:

	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_SOFTRESET |
		SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
		SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_MIDLEMODE),
	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
		MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),

and DSS seems to work fine for me. Then again, I don't think there's any
proper PM going on (or at least things like debugfs/pm_debug/count shows
no sensible values), so it could well be that those flags are not even
used at the moment.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140617/363fb9c3/attachment.sig>
