From: lersek@redhat.com (Laszlo Ersek)
Date: Fri, 7 Jul 2017 11:43:20 +0200
Subject: [Qemu-devel] [PATCH v3 1/4] ACPI: Add APEI GHES Table Generation
 support
In-Reply-To: <dbbab7f6-18c4-9b6c-799e-8267797a31bd@huawei.com>
References: <1493530506-26833-1-git-send-email-gengdongjiu@huawei.com>
 <4dde45bb-a730-82b1-dc49-ad00a6b73d85@redhat.com>
 <accf8880-f4b0-85f1-9f33-4103c8c26d7a@redhat.com>
 <e90c5fb8-e68b-a620-9023-f4fcfdd68e97@redhat.com>
 <dbbab7f6-18c4-9b6c-799e-8267797a31bd@huawei.com>
Message-ID: <d3443cbe-8752-0943-95b8-185d436de2fd@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/17 10:32, gengdongjiu wrote:
> Hi Laszlo,
>    sorry for my late response.
> 
> On 2017/6/3 20:01, Laszlo Ersek wrote:
>> On 05/22/17 16:23, Laszlo Ersek wrote:
>>> Keeping some context:
>>>
>>> On 05/12/17 23:00, Laszlo Ersek wrote:
>>>> On 04/30/17 07:35, Dongjiu Geng wrote:
>>
>>> (68) In the code below, you are not taking an "OVMF header probe
>>> suppressor" into account.
>>>
>>> But, we have already planned to replace that quirk with a separate,
>>> dedicated allocation hint or command, so I'm not going to describe what
>>> an "OVMF header probe suppressor" is; instead, I'll describe the
>>> replacement for it.
>>>
>>> [...]
>>
>> So, the NOACPI allocation hint is a no-go at the moment, based on the
>> discussion in the following threads:
>>
>> http://mid.mail-archive.com/20170601112241.2580-1-ard.biesheuvel at linaro.org
>>
>> http://mid.mail-archive.com/c76b36de-ebf9-c662-d454-0a95b43901e8 at redhat.com
>>
>> Therefore the header probe suppression remains necessary.
>>
>> In this case, it is not hard to do, you just have to reorder the
>> following two ADD_POINTER additions a bit:
>  Ok, it is no problem.
> 
>>
>>>>> +
>>>>> +        bios_linker_loader_add_pointer(linker, GHES_ERRORS_FW_CFG_FILE,
>>>>> +                                sizeof(uint64_t) * i, sizeof(uint64_t),
>>>>> +                                GHES_ERRORS_FW_CFG_FILE,
>>>>> +                                MAX_ERROR_SOURCE_COUNT_V6 * sizeof(uint64_t) +
>>>>> +                                i * MAX_RAW_DATA_LENGTH);
>>
>> This one should be moved out to a separate loop, after the current loop.
>>
>>>>> +        bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
>>>>> +                    address_registers_offset
>>>>> +                    + i * sizeof(AcpiGenericHardwareErrorSource),
>>>>> +                    sizeof(uint32_t), GHES_ERRORS_FW_CFG_FILE,
>>>>> +                    i * sizeof(uint64_t));
>>
>> This one should be kept in the first (i.e., current) loop.
>>
>> The idea is, when you first point the HEST/GHES_n entries in
>> ACPI_BUILD_TABLE_FILE to the "address registers" in
>> GHES_ERRORS_FW_CFG_FILE, all those address registers will still be
>> zero-filled. This will fail the ACPI table header probe in
>> OvmfPkg/AcpiPlatformDxe, which is what we want.
>>
>> After this is done, the address registers in GHES_ERRORS_FW_CFG_FILE
>> should be pointed to the error status data blocks in the same fw_cfg
>> blob, in a separate loop. (Those error status data blocks will again be
>> zero-filled, so no ACPI table headers will be mistakenly recognized in
>> them.)
> I understand your idear. but I have a question:
> how about we exchange the two function's place, such as shown below:
> then it still meets ours needs, the change is easy.
> For every loop:
> (1)when patch address in ACPI_BUILD_TABLE_FILE to the "address registers", the address register is zero-filed.
> (2)when patch address in GHES_ERRORS_FW_CFG_FILE to the error status data blocks, the error status data block is still zero-filed.
> 
>     for (i = 0; i < GHES_ACPI_HEST_NOTIFY_RESERVED; i++) {
>         .....................................
>         bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
>                     address_registers_offset
>                     + i * sizeof(AcpiGenericHardwareErrorSource),
>                     sizeof(uint32_t), GHES_ERRORS_FW_CFG_FILE,
>                     i * sizeof(uint64_t));
> 
> 
>         bios_linker_loader_add_pointer(linker, GHES_ERRORS_FW_CFG_FILE,
>                                 sizeof(uint64_t) * i, sizeof(uint64_t),
>                                 GHES_ERRORS_FW_CFG_FILE,
>                                 MAX_ERROR_SOURCE_COUNT_V6 * sizeof(uint64_t) +
>                                 i * MAX_RAW_DATA_LENGTH);
> 	.........................................
> 
>      }

Your suggestion seems to do the same, but there is a subtle difference.

When the firmware scans the targets of the ADD_POINTER commands for byte
sequences that "look like" an ACPI table header, in order to suppress
that probe, we should keep 36 bytes (i.e., the size of the ACPI table
header structure) zeroed at the target location.

* In the patch, as posted, this was not the case, because it first
filled in the address register inside the GHES_ERRORS_FW_CFG_FILE blob,
and then pointed a GHES pointer field in the HEST table to the *now*
nonzero address register.

* My suggestion was to first fill in all the GHES pointers (when still
all the pointed-to address registers are zero), and then the address
registers themselves should be patched.

Under this scheme, it is irrelevant whether both loops are incrementing
or decrementing loops.

* Your suggestion would preserve the safe patching order between any
given GHES field and its corresponding (pointed-to) address register. So
that's great.

However, consider the following case:

- Assume that the loop is decrementing, and not incrementing.

- First, the last GHES pointer field, GHES[9].<whatever> is patched. It
is pointed to the last address register in "etc/hardware_errors", which
is still zero-filled. Also, the last address register in
"etc/hardware_errors" is immediately followed by the first Error Status
Data Block, which is also filled with zero. This means that when the
header probe will look at the *target* of GHES[9].<whatever>, it will
definitely fail (which is what we want), because all consecutive 36
bytes that start at the last address register in "etc/hardware_errors"
are zero.

- Second, the last address register, address[9], is patched. It is
pointed to the last Error Status Data Block, which is zero filled, so
the header probe in the firmware fails -- great.

- Third, GHES[8].<whatever> is patched. It is set to &address[8].
However, at this point, the 36 consecutive bytes starting at &address[8]
are *not* all zero, because at relative offset 8, we have the already
patched address[9] register, which is nonzero. I'm not saying that this
would necessarily cause a problem, but we'd better be safe than sorry.


In other words, your suggestion is OK, because the loop we have is
incrementing, not decrementing. But, if you decide to go with your idea,
please add a comment before the "for" instruction, "this loop must
remain an incrementing loop, to safely suppress the ACPI SDT header
probe in the firmware".

Thanks
Laszlo
