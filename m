From: alexey.klimov@linaro.org (Alexey Klimov)
Date: Tue, 8 Sep 2015 15:27:58 +0300
Subject: [question] [Cortex-A57] how to discover implementation defined
 system registers?
In-Reply-To: <20150908091604.GC14550@e104818-lin.cambridge.arm.com>
References: <CAP_9M69hqX6umT1L0=sh+os_vkWa6SMoQeXHo7b1Dkox64SdTA@mail.gmail.com>
 <20150908091604.GC14550@e104818-lin.cambridge.arm.com>
Message-ID: <CAP_9M6-+1w0RtD33Pah=Nx=cFBJAFOKcFCDmNLa2UNPiKoFS3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 September 2015 at 12:16, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Tue, Sep 08, 2015 at 02:44:28AM +0300, Alexey Klimov wrote:
>> I'm implementing module for Linux kernel that needs access to
>> implementation defined system registers that described in section:
>> "D7.2.78 S3_<op1>_<Cn>_<Cm>_<op2>, IMPLEMENTATION DEFINED registers"
>> in ARMv8 spec.
>
> Why?
>
>> In specs for Cortex-A57 they are also described as
>> implementation defined. Page 4-86, table 4-15 in Cortex-A57 spec ARM
>> DDI0488G.
>>

[..]

> As above, why does the kernel need to access these registers?

EDAC driver. To poll correctable error and print regs to dmesg on panic.

>> Registers in question are L2CTLR_EL1, CPUMERRSR_EL1, L2MERRSR_EL1.
>
> Usually, non-secure (i.e. Linux) access to such registers is blocked by
> the (secure) firmware (at least writing to them), so they are not of
> much use to Linux.
>
>> Also, does information about CPU part, revision, variant and
>> implementer play some role here? For example, cpu implementations with
>> revision less than 1 never support this regs or only 0x41 as cpu
>> implementer can provide these list of impl defined regs.
>
> Yes, the CPU MIDR is the only reliable indication of which auxiliary
> registers you have but, as I said above, they are meant for firmware to
> access and Linux shouldn't care about them (at least arm64 Linux).

Got it. Thanks. So if EDAC driver for A-57 has to rely on regs
protected by secure world or dedicated to firmware then it might be
useless.

Best regards,
Alexey.
