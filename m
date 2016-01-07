From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 7 Jan 2016 08:21:33 -0800
Subject: [Qemu-devel] arm64 qemu tests failing in linux-next since 'arm64:
 kernel: enforce pmuserenr_el0 initialization and restore'
In-Reply-To: <20160107155310.GA4064@red-moon>
References: <567B41E3.5060800@roeck-us.net>
 <CAFEAcA_c9DicGF+is6ST3NJv+c5Bi4dHYo2t8Q2n9AS9G4q0+Q@mail.gmail.com>
 <20160107155310.GA4064@red-moon>
Message-ID: <568E908D.4070007@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/07/2016 07:53 AM, Lorenzo Pieralisi wrote:
> On Thu, Jan 07, 2016 at 01:25:35PM +0000, Peter Maydell wrote:
>> On 24 December 2015 at 00:52, Guenter Roeck <linux@roeck-us.net> wrote:
>>> Hi all,
>>>
>>> since commit 60792ad349f3 ("arm64: kernel: enforce pmuserenr_el0
>>> initialization
>>> and restore"), my arm64 qemu tests of linux-next are failing. After this
>>> commit,
>>> qemu does not display any output.
>>>
>>> Qemu version is 2.5.0. Linux kernel configuration is arm64:defconfig.
>>>
>>> qemu command line is as follows:
>>>
>>>          qemu-system-aarch64 -machine virt -cpu cortex-a57 -machine type=virt
>>> -nographic -smp 1 \
>>>                  -m 512 -kernel arch/arm64/boot/Image -initrd
>>> rootfs.arm64.cpio -no-reboot \
>>>                  -append "console=ttyAMA0"
>>>
>>> Any idea what might cause this problem and how to fix it (presumably in
>>> qemu) ?
>>
>> This turns out to be because QEMU doesn't currently implement
>> PMUSERENR_EL0 for AArch64 (we do have an AArch32 implementation),
>> so you get an immediate UNDEF when the kernel touches it, followed
>> by an infinite loop of UNDEF exceptions because the instruction
>> at the UNDEF vector entrypoint is unallocated at this point in
>> execution.
>>
>> We had previously been relying on the kernel not attempting to
>> touch the PMU if the ID_AA64DFR0_EL1 PMUVer bits read 0000
>> ("Performance Monitors extension System registers not implemented").
>
> Ok, thanks for looking into this. I wonder why reading pmcr_el0 does
> not suffer from the same problem though.
>
>> Since the v8 ARM ARM states that the Performance Monitors Extension is
>> an optional feature of an implementation, this seems like a kernel
>> bug to me. (QEMU should probably get round to implementing the PMU
>> at some point for feature parity with v7, but this has not been
>> a priority for us since they're not actually very useful in a
>> fully emulated setup.)
>
> Fixup patch coming, thanks.
>

The following code around the register accesses fixes the problem for me.
+       mrs     x0, ID_AA64DFR0_EL1
+       tst     x0, #0xf00
+       b.eq    1f
         msr     pmuserenr_el0, xzr              // Disable PMU access from EL0
+1:

I don't have a real system, so I can not verify if the register is correctly
set there. Plus, of course, I don't really know aarch64 assembler, so the above
code may be plain wrong ;-).

Guenter
