From: JBeulich@suse.com (Jan Beulich)
Date: Tue, 24 Nov 2015 00:20:21 -0700
Subject: [PATCH v3 05/62] acpi: Don't do traditional BIOS table
 scan for ARM64
In-Reply-To: <5653DC00.6010607@huawei.com>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-6-git-send-email-shannon.zhao@linaro.org>
 <alpine.DEB.2.02.1511231120320.1107@kaball.uk.xensource.com>
 <5653082602000078000B7C28@prv-mh.provo.novell.com>
 <5653DC00.6010607@huawei.com>
Message-ID: <56541DC502000078000B82F2@prv-mh.provo.novell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> On 24.11.15 at 04:39, <zhaoshenglong@huawei.com> wrote:
> On 2015/11/23 19:35, Jan Beulich wrote:
>>>>> On 23.11.15 at 12:24, <stefano.stabellini@eu.citrix.com> wrote:
>>> On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
>>>> --- a/xen/drivers/acpi/osl.c
>>>> +++ b/xen/drivers/acpi/osl.c
>>>> @@ -78,7 +78,9 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
>>>>  	} else {
>>>>  		acpi_physical_address pa = 0;
>>>>  
>>>> +		#ifdef CONFIG_X86
>>>>  		acpi_find_root_pointer(&pa);
>>>> +		#endif
>>>>  		return pa;
>>>>  	}
>>>
>>> I think it might be best to error out earlier if acpi and !efi_enabled
>>> on arm and arm64.  If we do that we'll never enter this "else".
>>>
>>> If acpi_find_root_pointer doesn't build on arm, we should move it to an
>>> x86 specific location, such as xen/arch/x86/efi.
>> 
>> No, definitely not (or if anything, then xen/arch/x86/acpi/). Instead
>> the function itself should be stubbed out to do nothing on ARM. (And
>> of course also the #ifdef placement is rather odd).
>> 
> How about adding a new CONFIG_ACPI_LEGACY_TABLES_LOOKUP like Linux
> kernel for x86?

Unless you know of an architecture other than x86 potentially
needing this, I think this would go too far. Plus the suggested name
would imply "old style" lookup only, whereas per-arch customization
also allows for other "modern" (or simply "alternative") mechanisms
to be used.

Jan
