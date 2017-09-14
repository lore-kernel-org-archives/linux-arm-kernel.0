From: roy.pledge@nxp.com (Roy Pledge)
Date: Thu, 14 Sep 2017 18:30:14 +0000
Subject: [v4 05/11] soc/fsl/qbman: Drop L1_CACHE_BYTES compile time check
References: <1503607075-28970-1-git-send-email-roy.pledge@nxp.com>
 <1503607075-28970-6-git-send-email-roy.pledge@nxp.com>
 <20170914134916.evw2mhjhxa6zo72x@localhost>
Message-ID: <DB6PR04MB2999FB14FAF5F663C7E02680866F0@DB6PR04MB2999.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/14/2017 9:49 AM, Catalin Marinas wrote:
> On Thu, Aug 24, 2017 at 04:37:49PM -0400, Roy Pledge wrote:
>> From: Claudiu Manoil <claudiu.manoil@nxp.com>
>>
>> Not relevant and arch dependent. Overkill for PPC.
>>
>> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
>> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
>> ---
>>   drivers/soc/fsl/qbman/dpaa_sys.h | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/soc/fsl/qbman/dpaa_sys.h b/drivers/soc/fsl/qbman/dpaa_sys.h
>> index 2ce394a..f85c319 100644
>> --- a/drivers/soc/fsl/qbman/dpaa_sys.h
>> +++ b/drivers/soc/fsl/qbman/dpaa_sys.h
>> @@ -49,10 +49,6 @@
>>   #define DPAA_PORTAL_CE 0
>>   #define DPAA_PORTAL_CI 1
>>   
>> -#if (L1_CACHE_BYTES != 32) && (L1_CACHE_BYTES != 64)
>> -#error "Unsupported Cacheline Size"
>> -#endif
> 
> Maybe this check was for a reason on PPC as it uses WB memory mappings
> for some of the qbman descriptors (which IIUC fit within a cacheline).
> You could add a check for CONFIG_PPC if you think there is any chance of
> this constant going higher.
> 

No, the reason PPC needs WB (technically any cacheable mapping) is that 
the QBMan block on those parts will raise an error IRQ if it sees any 
transaction less than cacheline size.  We know that this cannot happen 
on PPC parts with QBMan when there is a cacheable mapping because we 
also developed the interconnect for everything that has a QBMan block.

We dropped the check for L1_CACHE_BYTES due to the value being set to 
128 on ARM64 even on parts that has smaller caches. I don't think there 
is much to worry about here as cacheline size isn't something SW 
controls in any case. If we produce a part with QBMan that has a larger 
cache granularity we will need to address that in other parts of the 
code as well. The check was in the code for PPC as a sanity check but 
since the value isn't (in my opinion) meaningful on ARM we can remove it 
to avoid problems.
