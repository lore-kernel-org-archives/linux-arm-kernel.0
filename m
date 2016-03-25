From: guohanjun@huawei.com (Hanjun Guo)
Date: Fri, 25 Mar 2016 15:06:35 +0800
Subject: [PATCH] arm64: opcodes.h: Add arm big-endian config options
 before including arm header
In-Reply-To: <1458838474-8625-1-git-send-email-james.morse@arm.com>
References: <1458838474-8625-1-git-send-email-james.morse@arm.com>
Message-ID: <56F4E37B.5090302@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/3/25 0:54, James Morse wrote:
> arm and arm64 use different config options to specify big endian. This
> needs taking into account when including code/headers between the two
> architectures.
>
> A case in point is PAN, which uses the __instr_arm() macro to output
> instructions. The macro comes from opcodes.h, which lives under arch/arm.
> On a big-endian build the mismatched config options mean the instruction
> isn't byte swapped correctly, resulting in undefined instruction exceptions
> during boot:
>> alternatives: patching kernel code
>> kdevtmpfs[87]: undefined instruction: pc=ffffffc0004505b4
>> kdevtmpfs[87]: undefined instruction: pc=ffffffc00076231c
>> kdevtmpfs[87]: undefined instruction: pc=ffffffc00076231c
>> kdevtmpfs[87]: undefined instruction: pc=ffffffc00076231c
>> kdevtmpfs[87]: undefined instruction: pc=ffffffc00076231c
>> kdevtmpfs[87]: undefined instruction: pc=ffffffc00076231c
>> kdevtmpfs[87]: undefined instruction: pc=ffffffc00076231c
>> kdevtmpfs[87]: undefined instruction: pc=ffffffc00076231c
>> kdevtmpfs[87]: undefined instruction: pc=ffffffc00076231c
>> kdevtmpfs[87]: undefined instruction: pc=ffffffc00076231c
>> Internal error: Oops - undefined instruction: 0 [#1] SMP
>> Modules linked in:
>> CPU: 0 PID: 87 Comm: kdevtmpfs Not tainted 4.1.16+ #5
>> Hardware name: Hisilicon PhosphorHi1382 EVB (DT)
>> task: ffffffc336591700 ti: ffffffc3365a4000 task.ti: ffffffc3365a4000
>> PC is at dump_instr+0x68/0x100
>> LR is at do_undefinstr+0x1d4/0x2a4
>> pc : [<ffffffc00076231c>] lr : [<ffffffc0000811d4>] pstate: 604001c5
>> sp : ffffffc3365a6450
> Reported-by: Hanjun Guo <guohanjun@huawei.com>

My colleague Xuefeng helped to test this patch, and the bug
reported is gone,

Tested-by: Xuefeng Wang <wxf.wang@hisilicon.com>

Thanks
Hanjun
