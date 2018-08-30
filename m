From: baicar.tyler@gmail.com (Tyler Baicar)
Date: Thu, 30 Aug 2018 12:46:10 -0400
Subject: [PATCH] EDAC, ghes: use CPER module handles to locate DIMMs
In-Reply-To: <1ac15a80-6f9a-cf9d-8e79-37d10549a4ca@arm.com>
References: <1535567632-18089-1-git-send-email-wufan@codeaurora.org>
 <c70fa799-bc9f-64c8-e151-088ca8c3ed3e@arm.com>
 <000f01d4406f$6ce8f160$46bad420$@codeaurora.org>
 <1ac15a80-6f9a-cf9d-8e79-37d10549a4ca@arm.com>
Message-ID: <CABo9ajDf09BHsq0NOs99NSD6zOV5N-CDvgvQrGi9p_wLjpJ24g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2018 at 12:32 PM, James Morse <james.morse@arm.com> wrote:
> Hi Fan,
>
> On 30/08/18 15:40, wufan wrote:
>>>> @@ -327,12 +349,20 @@ void ghes_edac_report_mem_error(int sev,
>>> struct cper_sec_mem_err *mem_err)
>>>>             p += sprintf(p, "bit_pos:%d ", mem_err->bit_pos);
>>>>     if (mem_err->validation_bits &
>>> CPER_MEM_VALID_MODULE_HANDLE) {
>>>>             const char *bank = NULL, *device = NULL;
>>>> +           int index = -1;
>>>> +
>>>>             dmi_memdev_name(mem_err->mem_dev_handle, &bank,
>>> &device);
>>>
>>>> +           p += sprintf(p, "DIMM DMI handle: 0x%.4x ",
>>>> +                        mem_err->mem_dev_handle);
>>>>             if (bank != NULL && device != NULL)
>>>>                     p += sprintf(p, "DIMM location:%s %s ", bank, device);
>>>> -           else
>>>> -                   p += sprintf(p, "DIMM DMI handle: 0x%.4x ",
>>>> -                                mem_err->mem_dev_handle);
>>>
>>> Why do we now print the handle every time? The handle is pretty
>>> meaningless, it can only be used to find the location-strings, if we get those
>>> we print them instead.
>>
>> For ghes_edac the bank/device is informational, and nothing would go wrong
>> if the bank/device numbers are the same as another entry. But the handle
>> is now critical for DIMM lookup, thus pull it out.
>
> Is printing the handle to the kernel log critical?
>

I don't see why we would need this print. The bank/device
print is enough to map what is shown in dmesg to an SMBIOS
entry if that's really needed.

Thanks,
Tyler
