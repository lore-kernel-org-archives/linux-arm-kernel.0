From: panand@redhat.com (Pratyush Anand)
Date: Sat, 5 Nov 2016 11:01:31 +0530
Subject: [PATCH V3 0/6] ARM64: Uprobe support added
In-Reply-To: <20161104184652.rxllldll4qfe7qdn@localhost>
References: <cover.1478068479.git.panand@redhat.com>
 <20161104174951.vj4il3xkdy7a2ln7@localhost>
 <20161104184652.rxllldll4qfe7qdn@localhost>
Message-ID: <e1593d0d-b63c-cc7b-fcee-753b5bd8f0de@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Saturday 05 November 2016 12:16 AM, Catalin Marinas wrote:
> On Fri, Nov 04, 2016 at 11:49:51AM -0600, Catalin Marinas wrote:
>> On Wed, Nov 02, 2016 at 02:40:40PM +0530, Pratyush Anand wrote:
>>> Pratyush Anand (6):
>>>   arm64: kprobe: protect/rename few definitions to be reused by uprobe
>>>   arm64: kgdb_step_brk_fn: ignore other's exception
>>>   arm64: Handle TRAP_TRACE for user mode as well
>>>   arm64: Handle TRAP_BRKPT for user mode as well
>>>   arm64: introduce mm context flag to keep 32 bit task information
>>>   arm64: Add uprobe support
>>
>> I queued the patches for 4.10. I will push them into -next sometime next
>> week once I do some testing (I'm currently at the LPC).
>
> I spoke too soon. With these patches on top of 4.9-rc3, defconfig
> together with FTRACE and UPROBE_EVENT enabled I get:
>
> In file included from /work/Linux/linux-2.6-aarch64/arch/arm64/kernel/probes/decode-insn.c:20:0:
> /work/Linux/linux-2.6-aarch64/arch/arm64/include/asm/kprobes.h:52:5: error: conflicting types for 'kprobe_fault_handler'
>  int kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr);
>      ^~~~~~~~~~~~~~~~~~~~
> In file included from /work/Linux/linux-2.6-aarch64/arch/arm64/kernel/probes/decode-insn.c:17:0:
> /work/Linux/linux-2.6-aarch64/include/linux/kprobes.h:398:90: note: previous definition of 'kprobe_fault_handler' was here
>  static inline int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
>                                                                                           ^
> /work/Linux/linux-2.6-aarch64/scripts/Makefile.build:290: recipe for target 'arch/arm64/kernel/probes/decode-insn.o' failed
>

Hummmm...CONFIG_KPROBE was defined in my setup and did not notice it :( 
. We need to remove #include <asm/kprobes.h> from
/arch/arm64/kernel/probes/decode-insn.c.
<asm/kprobes.h> is already included from <linux/kprobes.h> under #ifdef 
CONFIG_KPROBE.

diff --git a/arch/arm64/kernel/probes/decode-insn.c 
b/arch/arm64/kernel/probes/decode-insn.c
index 8a29d29..6bf6657 100644
--- a/arch/arm64/kernel/probes/decode-insn.c
+++ b/arch/arm64/kernel/probes/decode-insn.c
@@ -17,7 +17,6 @@
  #include <linux/kprobes.h>
  #include <linux/module.h>
  #include <linux/kallsyms.h>
-#include <asm/kprobes.h>
  #include <asm/insn.h>
  #include <asm/sections.h>

So, do you want me to send V4 or a separate topup fixup patch. Please 
let me know, will do accordingly.

~Pratyush
