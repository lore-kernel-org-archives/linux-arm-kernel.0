From: grant.likely@linaro.org (Grant Likely)
Date: Wed, 12 Nov 2014 11:45:10 +0000
Subject: [PATCH v2 1/2] of/fdt: export fdt blob as /sys/firmware/fdt
In-Reply-To: <CAKv+Gu-UOPMaGQ+eRu8TX4DX_AN93JHt9dFHSaWs9+UB3UhdAg@mail.gmail.com>
References: <1415645222-14909-1-git-send-email-ard.biesheuvel@linaro.org>
 <1415645222-14909-2-git-send-email-ard.biesheuvel@linaro.org>
 <20141111144221.5FCDAC416AF@trevor.secretlab.ca>
 <CAL_JsqKeG1dWrMZydCN119V3++WKXqsjMm1bG7Fodhf3O8owpw@mail.gmail.com>
 <CACxGe6tsLr52ZLww2JfwHFHajHW+f6nbYJPyWXmZJg3coKmMCA@mail.gmail.com>
 <CAKv+Gu-UOPMaGQ+eRu8TX4DX_AN93JHt9dFHSaWs9+UB3UhdAg@mail.gmail.com>
Message-ID: <CACxGe6sN6dObiOnbhYM4Ltdn0BU_KTESuefvxh3odm1BbcUVbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 11, 2014 at 8:34 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 11 November 2014 21:08, Grant Likely <grant.likely@linaro.org> wrote:
>> On Tue, Nov 11, 2014 at 4:25 PM, Rob Herring <robherring2@gmail.com> wrote:
>>> On Tue, Nov 11, 2014 at 8:42 AM, Grant Likely <grant.likely@linaro.org> wrote:
>>>> On Mon, 10 Nov 2014 19:47:01 +0100
>>>> , Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>>>  wrote:
>>>>> Create a new /sys entry '/sys/firmware/fdt' to export the FDT blob
>>>>> that was passed to the kernel by the bootloader. This allows userland
>>>>> applications such as kexec to access the raw binary. The blob needs to
>>>>> be preserved as early as possible by calling preserve_fdt().
>>>>>
>>>>> The fact that this node does not reside under /sys/firmware/device-tree
>>>>> is deliberate: FDT is also used on arm64 UEFI/ACPI systems to
>>>>> communicate just the UEFI and ACPI entry points, but the FDT is never
>>>>> unflattened and used to configure the system.
>>>>>
>>>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>>>
>>>> On further thought, nak. I want tree modifications to be treated as
>>>> bugs. Do a checksum CRC32 or check. It's simpler and it can be extended
>>>> to us an in-blob CRC when the file format gets upreved to include one.
>>>
>>> Why? MIPS Octeon is full of them BTW. So the rule is any modifications
>>> or fixups have to be on the unflattened tree?
>>
>> That, or we require the fixups to explicitly clean up the CRC after
>> themselves. That will force them to be visible. Anything using the
>> fdt_*() write functions could potentially take care of it
>> automatically. That would make it immediately discoverable where
>> changes are being made in the tree.
>>
>
> Doesn't that defeat the purpose of capturing the FDT as it was passed
> by the bootloader? Those fixups will be reapplied by the kexec'ed
> kernel anyway.

We're always going to be in a grey area here. There are some things
that should not be passed over. For example, a framebuffer that is
passed in from firmware will no longer be valid on kexec. Right now on
arch/arm, the exynos platform fixes up the DT because the memory node
is outright /corrupt/. In the MIPS case, they do a bunch of stuff in
the kernel to figure out the hardware as configured by firmware. I
don't agree with that approach, but I would be very surprised if the
full original DT has any validity after the early boot fixups.

Early boot fixups to the .dtb are always going to be oddball cases.

g.
