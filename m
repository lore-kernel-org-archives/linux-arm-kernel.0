From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 20 Jan 2014 19:03:34 +0100
Subject: [PATCH v2 0/5] arm64: advertise availability of CRC and crypto
 instructions
In-Reply-To: <alpine.LFD.2.11.1401201242480.1652@knanqh.ubzr>
References: <1387807592-26375-1-git-send-email-ard.biesheuvel@linaro.org>
 <20140120173838.GD29971@arm.com>
 <alpine.LFD.2.11.1401201242480.1652@knanqh.ubzr>
Message-ID: <CAKv+Gu8jqctGFsyccg6_VGkZ6ogf8BD_kq1rsRQrc+cw7pk+qA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 January 2014 18:44, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Mon, 20 Jan 2014, Catalin Marinas wrote:
>
>> On Mon, Dec 23, 2013 at 02:06:27PM +0000, Ard Biesheuvel wrote:
>> > This series is a followup to the patch that was recently merged by Catalin that
>> > allocates hwcaps bits for CRC and Crypto Extensions instructions so userland can
>> > discover whether the current CPU has any of those capabilities.
>> >
>> > Patch #1 enables ARM support for the ELF_HWCAP2/AT_HWCAP2 ELF auxv entry that
>> > was recently added to the kernel and glibc (2.18). It extends the feature bit
>> > space to 64 bits (on 32-bit architectures)
>> >
>> > Patch #2 adds generic support for ELF_HWCAP2/AT_HWCAP2 to the 32-bit ELF compat
>> > mode for 64-bit architectures.
>> >
>> > Patch #3 adds support for ELF_HWCAP2/AT_HWCAP2 to arm64's 32-bit ELF compat mode
>> >
>> > Patch #4 allocates the HWCAP2 bits in the arch/arm tree. This is necessary
>> > because 32-bit ARM binaries can execute both under ARM and under arm64 kernels,
>> > so there should be agreement about the meaning of feature bits, even if the ARM
>> > kernel has no support yet for ARMv8 32-bit only hardware (such as ARMv8-R).
>>
>> It looks a bit strange to start filling HWCAP2 before HWCAP is full but
>> I guess we want to preserve some future extensions in HWCAP for older
>> glibc.
>
> How could older glibc possibly care about future extensions?
>

Calling getauxval(AT_HWCAP) on an outdated libc.so will give you the
whole value, not just the bits whose meaning was known to glibc at the
time.
So if desired, a program can interpret AT_HWCAP itself.

AT_HWCAP2 is completely new, so you won't be able to retrieve it using
getauxval() on an older libc.

-- 
Ard.
