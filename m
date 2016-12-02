From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 2 Dec 2016 09:09:37 +0000
Subject: [PATCH 2/2] arm64: xen: Split architecture-specific headers from
 32bit ARM
In-Reply-To: <alpine.DEB.2.10.1612011412120.2781@sstabellini-ThinkPad-X260>
References: <1480589074-809-1-git-send-email-marc.zyngier@arm.com>
 <1480589074-809-3-git-send-email-marc.zyngier@arm.com>
 <alpine.DEB.2.10.1612011412120.2781@sstabellini-ThinkPad-X260>
Message-ID: <252e1445-8549-fa44-5f34-7f3603989f9f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/16 22:17, Stefano Stabellini wrote:
> On Thu, 1 Dec 2016, Marc Zyngier wrote:
>> ARM and arm64 Xen ports share a number of headers, leading to
>> packaging issues when these headers needs to be exported, as it
>> breaks the reasonable requirement that an architecture port
>> is standalone.
>>
>> Solve the issue by copying the 5 header files over the arch
>> barrier.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> I might be unhappy about making life more difficult for people building
> out of tree modules (not really, but I can pretend), but copying the
> headers over is not a solution. I really don't want two copies of them.
> 
> What does "standalone" mean in this context? What is the failure exactly?

Standalone means exactly that. You don't need any include file from
another architecture, and arch/arm64/include/* together with include/*
should be enough to build any odd piece of out of tree code, like on any
other architecture. For example, here's an extract from Wookey's
(internal) report trying to build the *cough* mali driver *cough*:

$ sudo make -C /usr/src/linux-headers-4.8.0-1-arm64
M=/usr/src/midgard-0.r2p0/ EXTRA_CFLAGS="-I
/usr/src/linux-headers-4.8.0-1-common/include/ -Wall -Werror
-DCONFIG_MALI_MIDGARD=m -DCONFIG_MALI_BACKEND=gpu" CONFIG_MALI_MIDGARD=m
CONFIG_MALI_BACKEND=gpu modules
make: Entering directory '/usr/src/linux-headers-4.8.0-1-arm64'
   CC [M]  /usr/src/midgard-0.r2p0//mali_kbase_device.o
In file included from
/usr/src/linux-headers-4.8.0-1-common/arch/arm64/include/asm/sysreg.h:25:0,
                  from
/usr/src/linux-headers-4.8.0-1-common/arch/arm64/include/asm/cputype.h:94,
                  from
/usr/src/linux-headers-4.8.0-1-common/arch/arm64/include/asm/cachetype.h:19,
                  from
/usr/src/linux-headers-4.8.0-1-common/arch/arm64/include/asm/cache.h:19,
                  from
/usr/src/linux-headers-4.8.0-1-common/include/linux/cache.h:5,
                  from
/usr/src/linux-headers-4.8.0-1-common/include/linux/printk.h:8,
                  from
/usr/src/linux-headers-4.8.0-1-common/include/linux/kernel.h:13,
                  from
/usr/src/linux-headers-4.8.0-1-common/include/linux/list.h:8,
                  from
/usr/src/linux-headers-4.8.0-1-common/include/linux/wait.h:6,
                  from
/usr/src/linux-headers-4.8.0-1-common/include/linux/fs.h:5,
                  from
/usr/src/linux-headers-4.8.0-1-common/include/linux/debugfs.h:18,
                  from
/usr/src/midgard-0.r2p0//mali_kbase_device.c:24:/usr/src/linux-headers-4.8.0-1-common/arch/arm64/include/asm/opcodes.h:5:43:

fatal error: ../../arm/include/asm/opcodes.h: No such file or directory
compilation terminated.

As I said in the cover letter, I don't care much for out of tree code
either. However, there is strictly no need for arm64 to break the
reasonable expectation that header files can be packaged using the
method that "just works" on all other architectures. Distributions do
depend on this, and breaking these expectations is not something that I
find acceptable. YMMV.

> If moving the headers out of arch/arm is necessary, then please move
> them to another shared directory, maybe include/xen/arm.

Works for me, I'll respin this patch.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
