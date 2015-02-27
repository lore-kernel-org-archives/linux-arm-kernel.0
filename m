From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 27 Feb 2015 15:05:47 -0600
Subject: [PATCH v9 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <CAKv+Gu-LxaX6X=qApp=zhzfmNfv=tjfscf9npFCpNW314pZvvg@mail.gmail.com>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>	<54EFE282.1090305@codeaurora.org>
 <CAKv+Gu-LxaX6X=qApp=zhzfmNfv=tjfscf9npFCpNW314pZvvg@mail.gmail.com>
Message-ID: <54F0DC2B.5010802@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/27/2015 02:50 AM, Ard Biesheuvel wrote:
> On 27 February 2015 at 03:20, Timur Tabi <timur@codeaurora.org> wrote:
>> On 02/25/2015 02:39 AM, Hanjun Guo wrote:
>>>
>>> Changes since v8:
>>
>>
>> I'm still debugging it, but v9 on the 4.0-rc1 kernel crashes after calling
>> the UEFI boot time services exit function.  That is, this line:
>>
>> status = sys_table->boottime->exit_boot_services(handle, mmap_key);
>>
>> in allocate_new_fdt_and_exit_boot() gets called, and then soon after it
>> returns, the kernel crashes.  It's really early because the UEFI exception
>> handler is called.
>>
>> I did not have this problem with v8 patchset on 3.19.
>>
>
> Are you not seeing this on v4.0-rc1 without the patchset applied?

You're right -- I get the same crash even without the patchset applied.

> Could the crash be inside the subsequent call to
> SetVirtualAddressMap() instead of inside ExitBootServices()?

It looks that way.  I'm going to have to debug that.

> If so, you have a firmware bug: Mark Rutland spotted a similar bug in
> the AMD Seattle firmware, which has been fixed in the mean time.
> It has to do with the firmware dereferencing the virtual mapping as it
> is being installed, which violates the UEFI spec.

Thanks.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
