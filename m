From: masami.hiramatsu.pt@hitachi.com (=?gb2312?B?xr3LydHFy8ggLyBISVJBTUFUVaOsTUFTQU1J?=)
Date: Thu, 17 Mar 2016 12:58:20 +0000
Subject: [PATCH v11 8/9] arm64: Add kernel return probes support
 (kretprobes)
In-Reply-To: <50399556C9727B4D88A595C8584AAB37B4E50431@GSjpTKYDCembx32.service.hitachi.net>
References: <1457501543-24197-1-git-send-email-dave.long@linaro.org>
 <1457501543-24197-9-git-send-email-dave.long@linaro.org>
 <50399556C9727B4D88A595C8584AAB37B4E50431@GSjpTKYDCembx32.service.hitachi.net>
Message-ID: <50399556C9727B4D88A595C8584AAB37B4E504AA@GSjpTKYDCembx32.service.hitachi.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From: ???? / HIRAMATU?MASAMI [mailto:masami.hiramatsu.pt at hitachi.com]
>
>Hi,
>
>>From: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
>>
>>The pre-handler of this special 'trampoline' kprobe executes the return
>>probe handler functions and restores original return address in ELR_EL1.
>>This way the saved pt_regs still hold the original register context to be
>>carried back to the probed kernel function.
>
>This patch seems not well separated.
>
>>diff --git a/arch/arm64/kernel/kprobes.c b/arch/arm64/kernel/kprobes.c
>>index bd3f233..13d3333 100644
>>--- a/arch/arm64/kernel/kprobes.c
>>+++ b/arch/arm64/kernel/kprobes.c
>
>[snip]
>
>>+void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
>>+				      struct pt_regs *regs)
>>+{
>>+	ri->ret_addr = (kprobe_opcode_t *)regs->regs[30];
>>+
>>+	/* replace return addr (x30) with trampoline */
>>+	regs->regs[30] = (long)&kretprobe_trampoline;
>
>So, where is the kretprobe_trampoline? It seems that function is
>defined in other patch.
>
>>+}
>>+
>>+int __kprobes arch_trampoline_kprobe(struct kprobe *p)
>>+{
>>+	return 0;
>> }
>
>And what this function is for??

Ah, sorry, this was my fault. Yes, this function is required.
But this implementation also means there is an asm-based trampoline
function which should be included in this patch.

David, could you tell me the repository which I can get the latest
version of this series? I'd like to see the whole code of kprobes/arm64.

Thank you,
