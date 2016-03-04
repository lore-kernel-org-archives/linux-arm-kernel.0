From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 4 Mar 2016 00:20:14 -0500
Subject: [PATCH V14 8/9] vfio, platform: add support for ACPI while
 detecting the reset driver
In-Reply-To: <56D8C539.9000203@linaro.org>
References: <1454646882-24369-1-git-send-email-okaya@codeaurora.org>
 <1454646882-24369-9-git-send-email-okaya@codeaurora.org>
 <56D08843.5020306@linaro.org> <56D7323B.4040100@codeaurora.org>
 <56D8C539.9000203@linaro.org>
Message-ID: <56D91B0E.1080203@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/3/2016 6:14 PM, Eric Auger wrote:
> Hi Sinan,
> On 03/02/2016 07:34 PM, Sinan Kaya wrote:
>> On 2/26/2016 12:15 PM, Eric Auger wrote:
>>>> -module_init(reset ## _module_init);				\
>>>>> +#define module_vfio_reset_handler(compat, acpihid, reset)		\
>>>>> +MODULE_ALIAS("vfio-reset:" compat);					\
>>> Here you need to handle alias for hid case I think
>>
>> I'm wondering what happens when Compat or ACPI string is NULL.
>>
>> MODULE_ALIAS("vfio-reset:" NULL)
>>
>> Would the kernel like it? 
> 
>>
>> I'd rather create an alias only when the string is not NULL. Given
>> this is a macro, I believe it won't work. 
> 
> Indeed I think we should create an alias only for the supported case or
> 2 aliases if both are supported.
>>
>> Can you think of any other way in the code to create the alias?
>>
> To be honest I did not find any elegant solution either. Personally I
> would move the MODULE_ALIAS for compat/acpihid outside of
> module_vfio_reset_handler macro, directly in the reset module. But maybe
> someone will propose a better solution?
> 

I briefly looked at this. 

#define MODULE_ALIAS(_alias) MODULE_INFO(alias, _alias)
#define MODULE_INFO(tag, info) __MODULE_INFO(tag, tag, info)

and it eventually becomes this

#define __MODULE_INFO(tag, name, info)                                    \
static const char __UNIQUE_ID(name)[]                                     \
   __used __attribute__((section(".modinfo"), unused, aligned(1)))         \
   = __stringify(tag) "=" info

Since the info is on the right side of the equation, I'm allowed to add some 
conditionals.

#define module_vfio_reset_handler(compat, acpihid, reset)		\
MODULE_ALIAS("vfio-reset:" acpihid? acpihid: compat);			\

This way, we'll create an alias with one of the provided strings.  



-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
