From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 25 Nov 2015 14:22:21 -0800
Subject: [PATCH v2 1/3] ARM: qcom: Make an option for qcom clocksource
 platforms
In-Reply-To: <6140735.DAZiajTbh1@wuerfel>
References: <1448485478-21699-1-git-send-email-sboyd@codeaurora.org>
 <1448485478-21699-2-git-send-email-sboyd@codeaurora.org>
 <6140735.DAZiajTbh1@wuerfel>
Message-ID: <5656349D.70103@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25/15 14:08, Arnd Bergmann wrote:
> On Wednesday 25 November 2015 13:04:36 Stephen Boyd wrote:
>> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
>> index 2c2b28ee4811..999d523ac09f 100644
>> --- a/arch/arm/Makefile
>> +++ b/arch/arm/Makefile
>> @@ -148,8 +148,7 @@ textofs-$(CONFIG_PM_H1940)      := 0x00108000
>>  ifeq ($(CONFIG_ARCH_SA1100),y)
>>  textofs-$(CONFIG_SA1111) := 0x00208000
>>  endif
>> -textofs-$(CONFIG_ARCH_MSM8X60) := 0x00208000
>> -textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
>> +textofs-$(CONFIG_HAVE_CLKSRC_QCOM) := 0x00208000
>>  textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
>>  
>>  # Machine directory name.  This list is sorted alphanumerically
>> diff --git a/arch/arm/mach-qcom/Kconfig b/arch/arm/mach-qcom/Kconfig
>> index 2256cd1e25d1..35a03967d9c2 100644
>> --- a/arch/arm/mach-qcom/Kconfig
>> +++ b/arch/arm/mach-qcom/Kconfig
>> @@ -10,6 +10,14 @@ menuconfig ARCH_QCOM
>>  
>>  if ARCH_QCOM
>>  
>> +config HAVE_CLKSRC_QCOM
>> +       bool "Support platforms with qcom clocksource"
>> +       default y
>> +       select CLKSRC_QCOM
>> +       help
>> +         Select this option if you want to support platforms
>> +         with the qcom clocksource such as MSM8660 and MSM8960.
> Hmm, if we use the option for two things, I think it could use
> a different identifier and title, as it seems counterintuitive
> to make the text offset based on the clocksource driver.

Ok.

>
> Is there any common way to classify these, e.g. calling them
> 'pre-2013 models' or 'Snapdragon S4' as a way to identify them?

I was thinking I could leave it as ARCH_MSM_8X60 because that covers the
6 and the 9, but that doesn't make me feel great. I have no idea what
Snapdragon S4 is, and that didn't exist when 8660 was first released.
pre-2013 models seems alright. Or perhaps ARCH_QCOM_PRE_8974?

Internally (and sort of leaked externally now) we called MSM8960 and its
variants A-family, and the generation after B-family, so perhaps
ARCH_QCOM_A_FAMILY would be appropriate? The problem there is no end
user knows about this distinction.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
