From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 5 Apr 2016 13:09:58 +0200
Subject: [PATCH 2/8] arm64/kernel: reuse boot_args array to get to
 __fdt_pointer
In-Reply-To: <CAKv+Gu_kV0yGRB4yi4GCjQbp-ZiiMdOOE_W+Q72Bs5Ji+vaL6w@mail.gmail.com>
References: <1459781544-14310-1-git-send-email-ard.biesheuvel@linaro.org>
 <1459781544-14310-3-git-send-email-ard.biesheuvel@linaro.org>
 <570284B6.9000006@arm.com>
 <CAKv+Gu_kV0yGRB4yi4GCjQbp-ZiiMdOOE_W+Q72Bs5Ji+vaL6w@mail.gmail.com>
Message-ID: <CAKv+Gu8POjzGSThsrz1vev7gPNrLZbgycNhYnxUP7o4a4EFR6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 April 2016 at 17:19, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 4 April 2016 at 17:13, James Morse <james.morse@arm.com> wrote:
>> Hi Ard,
>>
>> On 04/04/16 15:52, Ard Biesheuvel wrote:
>>> Since we record the boot_args [x0 .. x3] early at boot anyway, there is
>>> no need to keep the FDT address in a callee saved register with file scope
>>> in head.S. So simply refer to boot_args[0] directly in the call to
>>> setup_machine(), and drop the handling of x21 from head.S entirely.
>>
>> Won't this break Big Endian?
>> (or more accurately: bootloader-endian != kernel-endian)
>>
>> The stores in preserve_boot_args happen before the EE/E0E bits have been
>> set/cleared by el2_setup(), so they happen with boot-loader:endianness. The
>> loads after el2_setup() happen with kernel:endianness.
>>
>
> That is a very good point.

I think it would not be unreasonable to factor out the configuration
of the endianness at the current exception level, and invoke it first
before recording the boot args, since we now rely on el2_setup() to do
that. That would also fix the 'bug' where the boot_args are recorded
in the endianness of the bootloader, although I doubt anyone cares
deeply about that one.
