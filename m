From: pmladek@suse.com (Petr Mladek)
Date: Tue, 15 Dec 2015 16:43:56 +0100
Subject: [RFC PATCH 0/3] livepatch: arm64: add support for livepatch on
 arm64
In-Reply-To: <1450097378-3780-1-git-send-email-huawei.libin@huawei.com>
References: <1450097378-3780-1-git-send-email-huawei.libin@huawei.com>
Message-ID: <20151215154356.GF3729@pathway.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2015-12-14 20:49:35, Li Bin wrote:
> This patchset depends on the on-going gcc feature "-fprolog-pad=N",
> which will generate a pad of N nops at the beginning of each function.
> 
> Livepatch on arm64 can using the feature (that always placing one nop
> at the beginning of the function). And when enable/disable func patching,
> just modify the pad code to nop or branch. And that NOP and B instruction
> are both safe instructions on arm64 which called "concurrent modification
> and execution of instructions", that can be executed by one thread of
> execution as they are being modified by another thread of execution without
> requiring explicit synchronization.
> 
> And this method will improve performance significantly compared with the
> method based on ftrace, especially for the critical function being frequently
> called.

It sounds like a great feature for ftrace. If the new prologue is usable
for LivePatching, it should be usable to call the ftrace handler as
well. If you teach ftrace to use the new prologue, you will not need
all these crazy arch-specific hacks for LivePatching. Then both ftrace
and livepatch will benefit from the feature.

I suggest to read the ftrace documentation in Documentation/trace/,
especially ftrace-design.txt. I have never ported ftrace to a new
architecture. I guess that you need to teach scripts/recordmcount.c
 to find the new location. Also you might need to update
arch/arm/kernel/ftrace.c. Also please make sure that ftrace
supports DYNAMIC_FTRACE_WITH_REGS on Arm.

It is harder but the right way to go. Your current patch set
looks like a hack.

Best Regards,
Petr
