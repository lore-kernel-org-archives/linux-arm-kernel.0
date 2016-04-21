From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 21 Apr 2016 09:52:03 +0200
Subject: SoCFPGA with CONFIG_THUMB2_KERNEL boot error
In-Reply-To: <CAKv+Gu8_hZvY1TK=D3bhwy6F2UW1kSeSGyRciU5wVQPHy0m7LA@mail.gmail.com>
References: <20160419140220.GA9503@pengutronix.de>
 <20160420092516.GA21732@e103592.cambridge.arm.com>
 <CAKv+Gu8_hZvY1TK=D3bhwy6F2UW1kSeSGyRciU5wVQPHy0m7LA@mail.gmail.com>
Message-ID: <CAKv+Gu_mpj_qodDmtY+FiawD7r=q4ouxacqQ3Ezh9aJbqObKgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 April 2016 at 11:39, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> (+ Arnd)
>
> On 20 April 2016 at 11:25, Dave Martin <Dave.Martin@arm.com> wrote:
>> On Tue, Apr 19, 2016 at 04:02:20PM +0200, Steffen Trumtrar wrote:
>>> Hi!
>>>
>>> According to kernelci.org (and validating on my own hardware), the current
>>> socfpga mainline kernel has an issue with CONFIG_THUMB2_KERNEL enabled.
>>>
>>> https://storage.kernelci.org/mainline/v4.6-rc4-11-g12566cc35d0e/arm-multi_v7_defconfig/lab-khilman/boot-socfpga_cyclone5_de0_sockit.html
>>>
>>> vs
>>>
>>> https://storage.kernelci.org/mainline/v4.6-rc4-11-g12566cc35d0e/arm-multi_v7_defconfig+CONFIG_THUMB2_KERNEL=y/lab-khilman/boot-socfpga_cyclone5_de0_sockit.html
>>>
>>> Both boot successfully, but notice that the board fails to bring up CPU1 if
>>> thumb2 support is enabled.
>>>
>>> Any ideas why this might be happening?
>>
>> Looks like there is at least a module loading problem:
>>
>> dwc2: section 2 reloc 234 sym '_raw_spin_lock': relocation 10 out of range (0xbf801086 -> 0xc08c2d75)
>>
>> This happens because of the smaller branch range on Thumb2 versus ARM,
>> if the combined size of the kernel and modules area gets too large.
>>
>> So, use CONFIG_THUMB2_KERNEL=n, shrink your kernel or load fewer
>> modules :P
>>
>
> Indeed. 0xc08c2d74 - 0xbf801086 == 0x10c1f0 which exceeds the +/- 16
> MB range of the branch instruction of the Thumb2 ISA
>
>> You could try enabling CONFIG_ARM_MODULE_PLTS -- I've never tried that,
>> but it looks like it is designed to solve this problem by allocating
>> space for trampolines to help resolve long branches.  If you are
>> _already_ enabling this option, there may be a bug in its
>> implementation though...
>>
>
> This is disabled by default, so the kernelci.org builds would not have
> that enabled.
>
> I will propose a patch to kernelci to enable the PLT option for these
> kernels, as multi_v7_defconfig obviously requires it due to the size
> of the core image

FYI this is now fixed. The multi_v7_defconfig+CONFIG_THUMB2_KERNEL=y
configuration was updated to
multi_v7_defconfig+CONFIG_THUMB2_KERNEL=y+CONFIG_ARM_MODULE_PLTS=y and
the relocation out of range error is no longer emitted.

https://storage.kernelci.org/mainline/v4.6-rc4-17-g55f058e7574c/arm-multi_v7_defconfig+CONFIG_THUMB2_KERNEL=y+CONFIG_ARM_MODULE_PLTS=y/lab-khilman/boot-socfpga_cyclone5_de0_sockit.html
