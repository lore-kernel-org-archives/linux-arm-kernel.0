From: alex.shi@linaro.org (Alex Shi)
Date: Tue, 28 Nov 2017 21:17:07 +0800
Subject: [PATCH 0/2] Fix ftracetest issues
In-Reply-To: <CA+G9fYuMVZpJAfw09_nnx36oKgtpHmS+jY2=3d30inAko0YgHA@mail.gmail.com>
References: <20171125113302.GY31757@n2100.armlinux.org.uk>
 <101d41c7-2096-295e-b978-05224e16073e@linaro.org>
 <CA+G9fYuMVZpJAfw09_nnx36oKgtpHmS+jY2=3d30inAko0YgHA@mail.gmail.com>
Message-ID: <a4c802f6-a231-b640-b60a-643232eedfd6@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Case 1: Build PASS on linux-4.14.y
> -----------
> Tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> Branch: linux-4.14.y
> Commit id: f9f0b03dedc1 (HEAD -> linux-4.14.y, tag: v4.14.2,
> origin/linux-4.14.y) Linux 4.14.2
> 
> Patches 1 and 2 applies smooth and build PASS with defconfig.
> Ftrace test did not hang on beagleboard x15.
> 

Thanks  Naresh, could you like to give a 'tested-by:' for theses patches?


> 
> 
> Case 2: Build failed on linux-4.9.y and linux-4.4.y
> -----------
> Tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> Branch: linux-4.9.y
> Commit id: 133e6ccf46f1 (HEAD -> linux-4.9.y, tag: v4.9.65,
> origin/linux-4.9.y) Linux 4.9.65
> 
> Tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> Branch: linux-4.4.y
> Commit id: 29ffb9c1fb4a (HEAD, tag: v4.4.102, origin/linux-4.4.y) Linux 4.4.102
> 
> Patch-1 : Patch applied smooth.
> Patch-2: Patch failed to apply. Manually changed this file
> "arch/arm/include/asm/traps.h"
> 
> Build failed on linux-4.9.y and linux-4.4.y with defconfig.
> 
> Build Error
> ---------------
> arch/arm/kernel/traps.c: In function ?dump_backtrace_entry?:
> arch/arm/kernel/traps.c:73:2: error: implicit declaration of function
> ?in_entry_text? [-Werror=implicit-function-declaration]
> cc1: some warnings being treated as errors
> make[1]: *** [arch/arm/kernel/traps.o] Error 1
> make: *** [arch/arm/kernel] Error 2
> 
> - Naresh
> 
>> On 11/25/2017 07:33 PM, Russell King - ARM Linux wrote:
>>> ftracetest provokes the kernel to try and return to userspace addresses
>>> in kernel mode.  These two patches prevent that.
>>>
>>> The first patch, which I intend merging with Linus tonight, ensures that
>>> we catch the condition before we hit userspace, meaning that there is no
>>> possibility of executing user code while in kernel mode.
>>>
>>> The second patch fixes the ftracetest issue itself by ensuring that it
>>> is not possible to set a kprobe on any of the "special" assembler code.
>>> Such code includes:
>>> - the kernel primary/secondary CPU startup code
>>> - exception entry code
>>> - idmap code
>>>
>>> This is because the conditions under which this code is executed does
>>> not meet the kprobes requirements, which is basically that the
>>> "function" is C-like - it does something and then returns to the parent,
>>> and has a stack.  This is just not universally true of the above code.
>>>
>>> This patch is larger than one may desire as we re-organise the sections
>>> that some code ends up in, the way the unwinder works, and how we print
>>> stack frames.
>>>
>>>  arch/arm/include/asm/assembler.h | 18 ++++++++++++++++++
>>>  arch/arm/include/asm/exception.h |  3 +--
>>>  arch/arm/include/asm/sections.h  | 21 +++++++++++++++++++++
>>>  arch/arm/include/asm/traps.h     | 12 ------------
>>>  arch/arm/kernel/entry-armv.S     |  6 +-----
>>>  arch/arm/kernel/entry-common.S   |  1 +
>>>  arch/arm/kernel/entry-header.S   |  6 ++++++
>>>  arch/arm/kernel/stacktrace.c     | 14 ++------------
>>>  arch/arm/kernel/traps.c          |  4 ++--
>>>  arch/arm/kernel/vmlinux.lds.S    |  6 +++---
>>>  arch/arm/mm/fault.c              |  5 ++---
>>>  arch/arm/probes/kprobes/core.c   | 14 +++++++++++---
>>>  12 files changed, 68 insertions(+), 42 deletions(-)
>>>
