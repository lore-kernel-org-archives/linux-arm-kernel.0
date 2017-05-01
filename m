From: roy.pledge@nxp.com (Roy Pledge)
Date: Mon, 1 May 2017 19:00:14 +0000
Subject: [PATCH v2 07/11] soc/fsl/qbman: Rework ioremap() calls for ARM/PPC
References: <1492634930-10765-1-git-send-email-roy.pledge@nxp.com>
 <1492634930-10765-8-git-send-email-roy.pledge@nxp.com>
 <1492998461.25397.16.camel@buserror.net>
Message-ID: <VI1PR04MB3216F7EC8657711225E30AAC86140@VI1PR04MB3216.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/23/2017 9:47 PM, Scott Wood wrote:
> On Wed, 2017-04-19 at 16:48 -0400, Roy Pledge wrote:
>> Rework ioremap() for PPC and ARM. The PPC devices require a
>> non-coherent mapping while ARM will work with a non-cachable/write
>> combine mapping.
>>
>> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
>> ---
>>  drivers/soc/fsl/qbman/bman_portal.c | 16 +++++++++++++---
>>  drivers/soc/fsl/qbman/qman_portal.c | 16 +++++++++++++---
>>  2 files changed, 26 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/soc/fsl/qbman/bman_portal.c
>> b/drivers/soc/fsl/qbman/bman_portal.c
>> index 8354d4d..a661f30 100644
>> --- a/drivers/soc/fsl/qbman/bman_portal.c
>> +++ b/drivers/soc/fsl/qbman/bman_portal.c
>> @@ -125,7 +125,18 @@ static int bman_portal_probe(struct platform_device
>> *pdev)
>>  	}
>>  	pcfg->irq = irq;
>>  
>> -	va = ioremap_prot(addr_phys[0]->start, resource_size(addr_phys[0]),
>> 0);
>> +#ifdef CONFIG_PPC
>> +	/* PPC requires a cacheable/non-coherent mapping of the portal */
>> +	va = ioremap_prot(addr_phys[0]->start, resource_size(addr_phys[0]),
>> +			  (pgprot_val(PAGE_KERNEL) & ~_PAGE_COHERENT));
>> +#else
>> +	/*
>> +	 * For ARM we can use write combine mapping.  A cacheable/non
>> shareable
>> +	 * mapping will perform better but equires additional platform
>> +	 * support which is not currently available
>> +	 */
> s/equires/requires/
>
> Would be nice to describe the platform support that is required.
Thanks for your feedback Scott, going to try to get a v3 of this set
ASAP. I think I will remove the
above statement for now.  We did send patches for do non-shareable
support on DPAA2 and there was significant feedback so I'm in the
process of discussing the issue with SOC architects here.  We will
follow up with ARM folks on this eventually but I'd like to get the
basic DPAA1 support in before adding the more advanced features.

Roy
>
> -Scott
>
>
