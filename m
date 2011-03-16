From: bryanh@codeaurora.org (Bryan Huntsman)
Date: Wed, 16 Mar 2011 14:12:17 -0700
Subject: [PATCH 2/3] msm: Peripheral Image Loader (PIL) driver
In-Reply-To: <1300270820.13755.14.camel@desktop>
References: <1299732274-10742-1-git-send-email-sboyd@codeaurora.org>	
	<1299732274-10742-3-git-send-email-sboyd@codeaurora.org>
	<1300270820.13755.14.camel@desktop>
Message-ID: <4D8127B1.1030306@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/16/2011 03:20 AM, Daniel Walker wrote:
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

The generic firmware request API gets a blob from userspace.  The PIL
driver uses this interface to get blobs.  The additions here are:

- ref counting, per-name
- peripheral reset sequence, per-name
- configurable loading mechanism, secure vs. non-secure
- common format for retrieving metadata to verify image integrity

Since several peripherals need this exact sequence, it made sense to
create a small driver for this functionality.

> 
>> Change-Id: I041139464bbd3b646b82370ab540f40b0ac9af6b
> 
> Can't have Change-Id's ..

Dave noted this for the first patch in the series.  For subsequent
postings, Steve will remove the Change-Ids.  Otherwise, Dave said he
would remove them prior to adding them to the MSM tree.

>> Reviewed-by: Saravana Kannan <skannan@codeaurora.org>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
>>  arch/arm/mach-msm/Kconfig                          |   13 +
>>  arch/arm/mach-msm/Makefile                         |    2 +
>>  arch/arm/mach-msm/include/mach/peripheral-loader.h |   23 +
>>  arch/arm/mach-msm/peripheral-loader.c              |  402
>> +++++++++++++++
>>  arch/arm/mach-msm/peripheral-loader.h              |   38 ++
>>  arch/arm/mach-msm/peripheral-reset.c               |  528
>> ++++++++++++++++++++
>>  6 files changed, 1006 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/arm/mach-msm/include/mach/peripheral-loader.h
>>  create mode 100644 arch/arm/mach-msm/peripheral-loader.c
>>  create mode 100644 arch/arm/mach-msm/peripheral-loader.h
>>  create mode 100644 arch/arm/mach-msm/peripheral-reset.c
>>
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
> 
> I didn't review the rest sign it might be wasted effort on my part..
> 
> Daniel

Would you elaborate on your objection here?  Should the Kconfig be
dropped and the Makefile use 'obj-$(ARCH_MSM8X60)'?  That doesn't make
sense to me since we already have a 2nd architecture, 8960, that uses
PIL.  How do you think this should be handled?  Thanks.

- Bryan

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
