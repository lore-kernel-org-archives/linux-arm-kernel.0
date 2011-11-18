From: haohui.mai@gmail.com (Haohui Mai)
Date: Fri, 18 Nov 2011 14:32:55 -0600
Subject: Question about unaligned memory access on ARMv7
Message-ID: <4EC6C0F7.5040203@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

My linux kernel complained about the user space binaries doing unaligned
memory access.

Here is one of the log:

[ 1056.522396] Alignment trap: rsyslogd (1400) PC=0x4004450e
Instr=0xe8541f00 Address=0x409f84f5 FSR 0x001


$ echo "0xe8 0x54 0x1f 0x00"|/opt/local/ibos/bin/llvm-mc --disassemble
-triple=thumb-apple-darwin9
     strb    r0, [r5, r3]
     movs    r7, r3

I'm using the NVIDIA Harmony board, which has a Cortex-A9MP dual core
CPU. According to the specification, this instruction is legitimate and
shouldn't fault.

I checked in arch/arm/mm/alignment.c, the function
do_alignment_t32_to_handler will ignore this because the CPU should be
able to handle it.

I also checked with the newest version of arch/arm/mm/alignment and I
noticed no changes.

Am I missing some erratas that can possibly fix this bug?

PS: I'm using a sufficiently old (2.6.32.9) kernel and I'm unable to
update it because a bug in the bootloader. :-(

Any suggestions are appreciated.

Cheers,
Haohui
