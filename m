From: ohaugan@codeaurora.org (Olav Haugan)
Date: Wed, 06 Aug 2014 16:34:09 -0700
Subject: [PATCH v2 2/2] iommu/arm-smmu: Do not access non-existing SMR
 registers
In-Reply-To: <20140806173518.GG25953@arm.com>
References: <1407175263-10699-1-git-send-email-ohaugan@codeaurora.org>
 <1407175263-10699-3-git-send-email-ohaugan@codeaurora.org>
 <20140806101948.GD23882@arm.com> <53E25B76.6090208@codeaurora.org>
 <20140806173518.GG25953@arm.com>
Message-ID: <53E2BB71.9000201@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/6/2014 10:35 AM, Will Deacon wrote:
> Hi Olav,
> 
> On Wed, Aug 06, 2014 at 05:44:38PM +0100, Olav Haugan wrote:
>> On 8/6/2014 3:19 AM, Will Deacon wrote:
>>> On Mon, Aug 04, 2014 at 07:01:03PM +0100, Olav Haugan wrote:
>>>> The SMR registers do not exist when stream matching is not
>>>> supported by the hardware. Avoid writing to this register if not needed.
>>>>
>>>> Signed-off-by: Olav Haugan <ohaugan@codeaurora.org>
>>>> ---
>>>>  drivers/iommu/arm-smmu.c | 5 ++++-
>>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>>> index c16431f..1f3a5b3 100644
>>>> --- a/drivers/iommu/arm-smmu.c
>>>> +++ b/drivers/iommu/arm-smmu.c
>>>> @@ -1731,7 +1731,10 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
>>>>  
>>>>  	/* Mark all SMRn as invalid and all S2CRn as bypass */
>>>>  	for (i = 0; i < smmu->num_mapping_groups; ++i) {
>>>> -		writel_relaxed(~SMR_VALID, gr0_base + ARM_SMMU_GR0_SMR(i));
>>>> +		if (smmu->features & ARM_SMMU_FEAT_STREAM_MATCH) {
>>>> +			writel_relaxed(~SMR_VALID,
>>>> +					gr0_base + ARM_SMMU_GR0_SMR(i));
>>>> +		}
>>>>  		writel_relaxed(S2CR_TYPE_BYPASS,
>>>>  			gr0_base + ARM_SMMU_GR0_S2CR(i));
>>>
>>> smmu->num_mapping_groups should be zero for an SMMU that doesn't include
>>> the SMR registers, so I don't think this change is needed. Are you seeing
>>> problems with real hardware?
>>
>> Yes, you are correct. However, since that is the case we wouldn't be
>> setting the S2CR registers to bypass then? Seems like
>> num_mappings_groups should be initialized regardless whether stream
>> matching or stream indexing is used. SMMU_IDR0.NUMSMRG specifies the
>> number of stream mapping register groups (Section 2.5.2 of the ARM
>> SMMUv1-v2 spec). So with stream indexing support this register should
>> still tell us how many S2CR registers exist?
> 
> Hmm, I'm checking this with the architects because the TRMs aren't exactly
> clear. The NUMSMRG works for stream-indexing (i.e. reports the number of
> S2CRs), then all we have to do is change the above ~SMR_VALID to 0x0, since
> those registers will be SBZP.

You don't agree that we should avoid doing register writes if not
necessarily? In general I like to avoid trying to write registers that
is not needed so that we don't do more work than needed.

> 
>> As far as I can tell there are no other register telling us how many S2CR
>> registers exist. That also brings up another point that there is no check
>> in the code to ensure we are not trying to program more than the available
>> S2CR registers when we use stream indexing.
> 
> On an SMMU using stream-indexing, if the StreamID goes off the end of the
> S2CRs that's a fairly serious hardware configuration issue which I don't
> think Linux is in a position to handle. I agree that a warning wouldn't
> hurt on device add/attach though.
> 

Yes, I meant to protect against programming errors where someone
specified more Stream IDs than available S2CRs.

Thanks,

Olav

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
