From: alexey.klimov@linaro.org (Alexey Klimov)
Date: Tue, 8 Sep 2015 02:44:28 +0300
Subject: [question] [Cortex-A57] how to discover implementation defined system
 registers?
Message-ID: <CAP_9M69hqX6umT1L0=sh+os_vkWa6SMoQeXHo7b1Dkox64SdTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I'm implementing module for Linux kernel that needs access to
implementation defined system registers that described in section:
"D7.2.78 S3_<op1>_<Cn>_<Cm>_<op2>, IMPLEMENTATION DEFINED registers"
in ARMv8 spec. In specs for Cortex-A57 they are also described as
implementation defined. Page 4-86, table 4-15 in Cortex-A57 spec ARM
DDI0488G.

Is it correct understanding that because of implementation-defined
nature all information about are they implemented or not goes on
vendor shoulders and should be exposed to kernel through
1) Device tree or ACPI. And only if kernel finds node or entry in
DT/ACPI about this it can trigger code/driver that needs these regs.

or

2) I'm looking on undef_hook, {un,}register_undef_hook() code in
arch/arm64/traps.c. Can kernel "probe" to access to impl defined regs
using undefined instr exceptions and undef_hooks to figure out
map/impl features list/array/whatever for each cpu during startup (i'm
also checking Suzuki patches for exposing cpu features)? Maybe not all
impl defined regs can be probed this way and I suspect it might affect
KVM or guests in some way.

Registers in question are L2CTLR_EL1, CPUMERRSR_EL1, L2MERRSR_EL1.

Also, does information about CPU part, revision, variant and
implementer play some role here? For example, cpu implementations with
revision less than 1 never support this regs or only 0x41 as cpu
implementer can provide these list of impl defined regs.

Thanks,
Alexey Klimov
