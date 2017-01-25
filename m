From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 25 Jan 2017 12:26:10 +0800
Subject: [PATCH] arm64: kernel: do not mark reserved memory regions as
 IORESOURCE_BUSY
In-Reply-To: <CAKv+Gu9FV7pz8A+Hevq-FVYvrvkigqRBJDTRWA1c=UenTxLz8Q@mail.gmail.com>
References: <1485277900-22730-1-git-send-email-ard.biesheuvel@linaro.org>
 <20170124180109.GK1728@arm.com>
 <CAKv+Gu9FV7pz8A+Hevq-FVYvrvkigqRBJDTRWA1c=UenTxLz8Q@mail.gmail.com>
Message-ID: <711feb52-313b-965f-e404-7c9f657c8451@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/1/25 2:13, Ard Biesheuvel wrote:
> On 24 January 2017 at 18:01, Will Deacon <will.deacon@arm.com> wrote:
>> On Tue, Jan 24, 2017 at 05:11:40PM +0000, Ard Biesheuvel wrote:
>>> Memory regions marked as NOMAP should not be used for general allocation
>>> by the kernel, and should not even be covered by the linear mapping
>>> (hence the name). However, drivers or other subsystems (such as ACPI)
>>> that access the firmware directly may legally access them, which means
>>> it is also reasonable for such drivers to claim them by invoking
>>> request_resource(). Currently, this is prevented by the fact that arm64's
>>> request_standard_resources() marks reserved regions as IORESOURCE_BUSY.
>>>
>>> So drop the IORESOURCE_BUSY flag from these requests.
>>>
>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>> ---
>>>  arch/arm64/kernel/setup.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Did you find this my inspection, or has somebody reported a problem?
>>
>
> Hanjun (whom I forgot to cc) reported an issue with the ACPI EINJ
> (error injection) code, which may call request_resource() on UEFI
> reserved regions.

Yes, we were testing ACPI error ejection thought the register region,
the register region is reported by firmware in EINJ table which
the table is marked as reserved, then in the kernel will failed to
request the memory region because all the reserved memory block is
set to IORESOURCE_BUSY before this patch.

Tested this patch and error ejecting works OK.

Thanks
Hanjun
