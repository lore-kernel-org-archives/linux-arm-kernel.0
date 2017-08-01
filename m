From: panand@redhat.com (Pratyush Anand)
Date: Tue, 1 Aug 2017 14:02:02 +0530
Subject: [PATCH v3 0/5] ARM64: disable irq between breakpoint and step
 exception
In-Reply-To: <20170801081420.GB7745@linaro.org>
References: <cover.1501496603.git.panand@redhat.com>
 <20170801081420.GB7745@linaro.org>
Message-ID: <0309fb7e-4906-0f92-5b7a-87b0f487d0dc@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Takahiro,

On Tuesday 01 August 2017 01:44 PM, AKASHI Takahiro wrote:
> Hi Pratyush,
> 
> On Mon, Jul 31, 2017 at 04:10:28PM +0530, Pratyush Anand wrote:
>> v2 -> v3
>> - Moved step_needed from uapi structure to kernel only structure
>> - Re-enable interrupt if stepped instruction faults
>> - Modified register_wide_hw_breakpoint() to accept step_needed arg
>> v2 was here: http://marc.info/?l=linux-arm-kernel&m=149942910730496&w=2
>>
>> v1 -> v2:
>> - patch 1 of v1 has been modified to patch 1-3 of v2.
>> - Introduced a new event attribute step_needed and implemented
>>    hw_breakpoint_needs_single_step() (patch 1)
>> - Replaced usage of is_default_overflow_handler() with
>>    hw_breakpoint_needs_single_step(). (patch 2)
>> - Modified sample test to set set step_needed bit field (patch 3)
>> v1 was here: http://marc.info/?l=linux-arm-kernel&m=149910958418708&w=2
>>
>> samples/hw_breakpoint/data_breakpoint.c passes with x86_64 but fails with
>> ARM64. Even though it has been NAKed previously on upstream [1, 2], I have
>> tried to come up with patches which can resolve it for ARM64 as well.
>>
>> I noticed that even perf step exception can go into an infinite loop if CPU
>> receives an interrupt while executing breakpoint/watchpoint handler. So,
>> event though we are not concerned about above test, we will have to find a
>> solution for the perf issue.
>>
>> This patchset attempts to resolve both the issue. Please review.
>> Since, it also takes care of SW breakpoint, so I hope kgdb should also be
>> fine. However, I have not tested that.
>> @Takahiro: Will it be possible to test these patches for kgdb.
> 
> I have not yet understood the details of your patch, but
> I gave it a try and didn't see any difference around the behavior
> of kgdb's single stepping.
> 
> I also gave a try to James' patch, but again nothing different
> as long as kgdb is concerned.
> (I'm tackling some issue in single stepping at irq's kernel_exit,
> in particular, 'eret'.)

You mean that you were expecting an step exception after eret (and this eret 
was being called from kgdb breakpoint exception handler), but you got irq 
exception? This is what I understood from your previous patch [0].

If that was the case, then I was expecting that this patch series should help.
See, patch 4/5:
- kgdb breakpoint handler kgdb_brk_fn() will be called from 
arch/arm64/kernel/debug-monitors.c: brk_handler().
- If we are expecting a step exception after servicing this breakpoint 
handler, then kgdb code would have called kernel_enable_single_step(). So, we 
should see kernel_active_single_step() true in brk_handler().
- If above happens then do_debug_exception() will make sure that PSR I bit is 
set before eret is called and we should not see an IRQ exception after eret.

Can you please help me with your reproducer test case?

[0]  http://lists.infradead.org/pipermail/linux-arm-kernel/2017-May/508066.html

-- 
Regards
Pratyush
