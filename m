From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 25 Oct 2018 10:53:12 -0700
Subject: [PATCH 2/2] perf tests: Add a test for the ARM 32-bit [vectors]
 page
In-Reply-To: <20181025173242.GC30658@n2100.armlinux.org.uk>
References: <20181025000905.6095-1-f.fainelli@gmail.com>
 <20181025000905.6095-3-f.fainelli@gmail.com> <20181025021013.GA30116@lunn.ch>
 <175fd725-a97a-c282-5aa1-952014ff9023@gmail.com>
 <20181025173242.GC30658@n2100.armlinux.org.uk>
Message-ID: <a6f5b6e7-4d3e-dd8f-4028-0ee370b11722@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/18 10:32 AM, Russell King - ARM Linux wrote:
> On Thu, Oct 25, 2018 at 10:19:54AM -0700, Florian Fainelli wrote:
>> On 10/24/18 7:10 PM, Andrew Lunn wrote:
>>> On Wed, Oct 24, 2018 at 05:09:05PM -0700, Florian Fainelli wrote:
>>>> perf on ARM requires CONFIG_KUSER_HELPERS to be turned on to allow some
>>>> independance with respect to the ARM CPU being used. Add a test which
>>>> tries to locate the [vectors] page, created when CONFIG_KUSER_HELPERS is
>>>> turned on to help asses the system's health.
>>>
>>> Hi Florian
>>>
>>> I've suffered the pain from missing CONFIG_KUSER_HELPERS. The
>>> segfaults give little clue as to what is going wrong,and gdb is not
>>> much use either.
>>
>> If you have a working backtrace, you can typically see the virtual
>> address being in 0xffff_xxxx which gives a bit of a clue, but yes, this
>> is not particularly helpful.
>>
>>>
>>> What i don't see here is any clue to CONFIG_KUSER_HELPERS. If the test
>>> fails, could you print a message suggesting CONFIG_KUSER_HELPERS on
>>> ARM?
>>
>> Sure, sounds reasonable, thanks for taking a look.
> 
> An alternative would be rather than adding this to user programs, to
> have the kernel detect it and print a warning itself.

Something like this below? It does not have to be an alternative
solution, I would find it useful for perf to make sure the vectors page
is present in the virtual address space by having an explicit test. perf
maintains, what do you think?

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index f4ea4c62c613..b045b48d368d 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -173,6 +173,11 @@ __do_user_fault(struct task_struct *tsk, unsigned
long addr,
                show_regs(regs);
        }
 #endif
+#ifndef CONFIG_KUSER_HELPERS
+       if (((addr & PAGE_MASK) == 0xffff0000) && (sig == SIGSEGV))
+               printk(KERN_DEBUG "%s: CONFIG_KUSER_HELPERS disabled at
0x%08lx\n",
+                      tsk->comm, addr);
+#endif

        tsk->thread.address = addr;
        tsk->thread.error_code = fsr;


> 
> BTW, I note that the help text for CONFIG_KUSER_HELPERS needs to be
> updated.
> 


-- 
Florian
