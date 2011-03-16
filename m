From: davidb@codeaurora.org (David Brown)
Date: Wed, 16 Mar 2011 11:40:27 -0700
Subject: [PATCH 2/3] msm: Peripheral Image Loader (PIL) driver
In-Reply-To: <1300270820.13755.14.camel@desktop> (Daniel Walker's message of
	"Wed, 16 Mar 2011 03:20:19 -0700")
References: <1299732274-10742-1-git-send-email-sboyd@codeaurora.org>
	<1299732274-10742-3-git-send-email-sboyd@codeaurora.org>
	<1300270820.13755.14.camel@desktop>
Message-ID: <8ya62riucx0.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16 2011, Daniel Walker wrote:

> On Wed, 2011-03-09 at 20:44 -0800, Stephen Boyd wrote:
>> On 8660, the modem, dsp, and sensors peripherals require their
>> firmware to be loaded into memory before they can be properly
>> taken out of reset.
>> 
>> Drivers are expected to call pil_get() when they wish to load a
>> peripheral. This will initiate multiple firmware_request()s for
>> the metadata and image blobs for a peripheral. Once the image has
>> been loaded into memory, it is validated and brought out of reset
>> via the peripheral reset driver.
>
> Why can't this be part of the generic firmware request API ?

Can you clarify what you mean by this?  The firmware request API is used
to get the firmware itself, which this code uses.  This code is what
manages making those calls for the various MSM peripherals that require
firmware.

>> diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
>> index 997c5bd..25b73b0 100644
>> --- a/arch/arm/mach-msm/Kconfig
>> +++ b/arch/arm/mach-msm/Kconfig
>> @@ -210,4 +210,17 @@ config IOMMU_API
>>  
>>  config MSM_SCM
>>         bool
>> +
>> +config MSM_PIL
>> +       bool "Peripheral image loading (PIL)"
>> +       select FW_LOADER
>> +       select MSM_SCM
>> +       depends on ARCH_MSM8X60
>> +       help
>> +         Some peripherals need to be loaded into memory before they
>> can be
>> +         brought out of reset.
>> +
>> +         Say yes to support these devices.
>> +
>> +
>
> You shouldn't be adding anything like this to the Kconfig. To me if you
> add stuff like this it's a big red flag.

Can you clarify what you mean "stuff like this".

It seems to me that this option should be selected by the drivers that
need it, since it doesn't make sense to have this if there are no
drivers that need it, and it is required when those drivers are
included.

I do think there are valid hardware configurations that don't have any
peripherals needing firmware, and would think that those should be able
to avoid requiring the code to manage that.  Saravana/Stephen can
clarify that, though.

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
