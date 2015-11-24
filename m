From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Tue, 24 Nov 2015 11:39:44 +0800
Subject: [PATCH v3 05/62] acpi: Don't do traditional BIOS table scan for
 ARM64
In-Reply-To: <5653082602000078000B7C28@prv-mh.provo.novell.com>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-6-git-send-email-shannon.zhao@linaro.org>
 <alpine.DEB.2.02.1511231120320.1107@kaball.uk.xensource.com>
 <5653082602000078000B7C28@prv-mh.provo.novell.com>
Message-ID: <5653DC00.6010607@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/11/23 19:35, Jan Beulich wrote:
>>>> On 23.11.15 at 12:24, <stefano.stabellini@eu.citrix.com> wrote:
>> On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
>>> From: Shannon Zhao <shannon.zhao@linaro.org>
>>>
>>> With the addition of ARM64 that does not have a traditional BIOS to
>>> scan, add a #ifdef option for x86 to do the traditional BIOS scanning
>>> for tables.
>>>
>>> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
>>> ---
>>>  xen/drivers/acpi/osl.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/xen/drivers/acpi/osl.c b/xen/drivers/acpi/osl.c
>>> index ce15470..db74a90 100644
>>> --- a/xen/drivers/acpi/osl.c
>>> +++ b/xen/drivers/acpi/osl.c
>>> @@ -78,7 +78,9 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
>>>  	} else {
>>>  		acpi_physical_address pa = 0;
>>>  
>>> +		#ifdef CONFIG_X86
>>>  		acpi_find_root_pointer(&pa);
>>> +		#endif
>>>  		return pa;
>>>  	}
>>
>> I think it might be best to error out earlier if acpi and !efi_enabled
>> on arm and arm64.  If we do that we'll never enter this "else".
>>
>> If acpi_find_root_pointer doesn't build on arm, we should move it to an
>> x86 specific location, such as xen/arch/x86/efi.
> 
> No, definitely not (or if anything, then xen/arch/x86/acpi/). Instead
> the function itself should be stubbed out to do nothing on ARM. (And
> of course also the #ifdef placement is rather odd).
> 
How about adding a new CONFIG_ACPI_LEGACY_TABLES_LOOKUP like Linux
kernel for x86?

Thanks,
-- 
Shannon
