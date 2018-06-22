From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 21 Jun 2018 23:26:37 -0500
Subject: [PATCH 2/2] hwrng: msm: add ACPI support
In-Reply-To: <20180622042322.GF27187@vkoul-mobl>
References: <1529594276-12210-1-git-send-email-timur@codeaurora.org>
 <1529594276-12210-2-git-send-email-timur@codeaurora.org>
 <20180622042322.GF27187@vkoul-mobl>
Message-ID: <869e9828-5e34-49db-4387-629dcc4b09b0@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/21/18 11:23 PM, Vinod wrote:
> On 21-06-18, 10:17, Timur Tabi wrote:
>> Add support for probing on ACPI systems, with ACPI HID QCOM8160.
>>
>> On ACPI systems, clocks are always enabled, the PRNG should
>> already be enabled, and the register region is read-only.
>> The driver only verifies that the hardware is already
>> enabled never tries to disable or configure it.
> 
> so if you are using v2 hardware, are you pointing to High Level OS EE or
> some other..?

I'm not sure what you mean.

>>  +	/*
>> +	 * ACPI systems have v2 hardware. The clocks are always enabled,
>> +	 * the PRNG register space is read-only, and the PRNG should
>> +	 * already be enabled.
>> +	 */
>> +	if (has_acpi_companion(&pdev->dev)) {
>> +		u32 val;
>> +
>> +		val = readl(rng->base + PRNG_CONFIG);
> 
> v2 EEs dont seem to have CONFIG register, so not sure about this one

I can post the register set, but this works on my silicon.  The first 
device has all the registers.  Then there are about 12-13 other devices 
with their own 64K register regions, and those don't have a config 
register.

I don't know why you would choose to support a one of the secondary 
register sets when you can use the primary.


-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
