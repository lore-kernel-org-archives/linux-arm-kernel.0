From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 16 Aug 2018 16:47:30 +0100
Subject: [PATCH 08/13] coresight: Add support for CLAIM tag protocol
In-Reply-To: <20180814232053.GA5131@xps15>
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
 <1533562915-21558-9-git-send-email-suzuki.poulose@arm.com>
 <20180814232053.GA5131@xps15>
Message-ID: <4aff79b4-593e-a19b-5e3f-de2a6d5bacb7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/08/18 00:20, Mathieu Poirier wrote:
> On Mon, Aug 06, 2018 at 02:41:50PM +0100, Suzuki K Poulose wrote:
>> Add support for the CLAIM tag protocol for negotiating the
>> device ownership with other agents trying to use the coresight
>> component (internal vs. external). The Coresight architecture
>> specifies CLAIM tags (managed via CLAIMSET CLAIMCLR registers)
>> to negotiate the ownership of the device. PSCI recommends the
>> reservation of the bits in CLAIM tags for self-hosted and external
>> debug use. This patch implements the protocol for claiming
>> the devices before they are actually used.
> 
> I think the first paragraph of the cover letter (minus the reference to the
> documentation since you've included it below) would be perfect instead of the
> above.
> 
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-priv.h |  7 +++
>>   drivers/hwtracing/coresight/coresight.c      | 85 ++++++++++++++++++++++++++++
>>   include/linux/coresight.h                    | 20 +++++++
>>   3 files changed, 112 insertions(+)

>> +void coresight_disclaim_device_unlocked(void __iomem *base)
>> +{
>> +
>> +	if (coresight_is_claimed_self_hosted(base))
>> +		coresight_clear_claim_tags(base);
>> +	else
>> +		/*
>> +		 * Either we or the external agent doesn't follow
>> +		 * the protocol.
>> +		 */
>> +		WARN_ON_ONCE(1);
> 
> When writing "... or the external agent doesn't follow the protocol", I deduce
> that an external agent would have trampled our claim tag.  I think this needs
> to be said explicitly in the comment.
> 

>> +static inline int coresight_claim_device_unlocked(void __iomem *base)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline int coresight_claim_device(void __iomem *base)
>> +{
>> +	return 0;
>> +}
> 
> Returning 0 would give a caller the impression the operation has succeeded when
> in fact it didn't.  I think we should return an error code here.


Agreed on all points, will respin.

Suzuki
