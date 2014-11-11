From: grant.likely@linaro.org (Grant Likely)
Date: Tue, 11 Nov 2014 20:08:11 +0000
Subject: [PATCH v2 1/2] of/fdt: export fdt blob as /sys/firmware/fdt
In-Reply-To: <CAL_JsqKeG1dWrMZydCN119V3++WKXqsjMm1bG7Fodhf3O8owpw@mail.gmail.com>
References: <1415645222-14909-1-git-send-email-ard.biesheuvel@linaro.org>
 <1415645222-14909-2-git-send-email-ard.biesheuvel@linaro.org>
 <20141111144221.5FCDAC416AF@trevor.secretlab.ca>
 <CAL_JsqKeG1dWrMZydCN119V3++WKXqsjMm1bG7Fodhf3O8owpw@mail.gmail.com>
Message-ID: <CACxGe6tsLr52ZLww2JfwHFHajHW+f6nbYJPyWXmZJg3coKmMCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 11, 2014 at 4:25 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Tue, Nov 11, 2014 at 8:42 AM, Grant Likely <grant.likely@linaro.org> wrote:
>> On Mon, 10 Nov 2014 19:47:01 +0100
>> , Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>  wrote:
>>> Create a new /sys entry '/sys/firmware/fdt' to export the FDT blob
>>> that was passed to the kernel by the bootloader. This allows userland
>>> applications such as kexec to access the raw binary. The blob needs to
>>> be preserved as early as possible by calling preserve_fdt().
>>>
>>> The fact that this node does not reside under /sys/firmware/device-tree
>>> is deliberate: FDT is also used on arm64 UEFI/ACPI systems to
>>> communicate just the UEFI and ACPI entry points, but the FDT is never
>>> unflattened and used to configure the system.
>>>
>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>
>> On further thought, nak. I want tree modifications to be treated as
>> bugs. Do a checksum CRC32 or check. It's simpler and it can be extended
>> to us an in-blob CRC when the file format gets upreved to include one.
>
> Why? MIPS Octeon is full of them BTW. So the rule is any modifications
> or fixups have to be on the unflattened tree?

That, or we require the fixups to explicitly clean up the CRC after
themselves. That will force them to be visible. Anything using the
fdt_*() write functions could potentially take care of it
automatically. That would make it immediately discoverable where
changes are being made in the tree.

g.
