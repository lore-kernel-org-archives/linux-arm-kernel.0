From: keescook@chromium.org (Kees Cook)
Date: Mon, 7 Aug 2017 16:34:31 -0700
Subject: [PATCH] lkdtm: Test VMAP_STACK allocates leading/trailing guard
 pages
In-Reply-To: <0e9a80c2-3e5e-db98-dff6-b45e9e4817fd@redhat.com>
References: <20170807203948.GA22298@beast> <20170807220056.GA29059@remoulade>
 <0e9a80c2-3e5e-db98-dff6-b45e9e4817fd@redhat.com>
Message-ID: <CAGXu5jJuf4QqYn-K5-EFim8oa4S0V7A19cqonZpSbitzL5hjWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 7, 2017 at 3:55 PM, Laura Abbott <labbott@redhat.com> wrote:
> On 08/07/2017 03:00 PM, Mark Rutland wrote:
>> Hi,
>>
>> On Mon, Aug 07, 2017 at 01:39:48PM -0700, Kees Cook wrote:
>>> Two new tests STACK_GUARD_PAGE_LEADING and STACK_GUARD_PAGE_TRAILING
>>> attempt to read the byte before and after, respectively, of the current
>>> stack frame, which should fault under VMAP_STACK.
>>>
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>> ---
>>> Do these tests both trip with the new arm64 VMAP_STACK code?
>>
>>> +/* Test that VMAP_STACK is actually allocating with a leading guard page */
>>> +void lkdtm_STACK_GUARD_PAGE_LEADING(void)
>>> +{
>>> +    const unsigned char *stack = task_stack_page(current);
>>> +    const unsigned char *ptr = stack - 1;
>>> +    volatile unsigned char byte;
>>> +
>>> +    pr_info("attempting bad read from page below current stack\n");
>>> +
>>> +    byte = *ptr;
>>> +
>>> +    pr_err("FAIL: accessed page before stack!\n");
>>> +}
>>> +
>>> +/* Test that VMAP_STACK is actually allocating with a trailing guard page */
>>> +void lkdtm_STACK_GUARD_PAGE_TRAILING(void)
>>> +{
>>> +    const unsigned char *stack = task_stack_page(current);
>>> +    const unsigned char *ptr = stack + THREAD_SIZE;
>>> +    volatile unsigned char byte;
>>> +
>>> +    pr_info("attempting bad read from page above current stack\n");
>>> +
>>> +    byte = *ptr;
>>> +
>>> +    pr_err("FAIL: accessed page after stack!\n");
>>> +}
>>
>> I can give these a go tomorrow.
>>
>> These *should* fault, and IIUC should trigger the usual "Unable to handle
>> kernel %s at virtual address %08lx\n" splat from arm64's __do_kernel_fault(),
>> which should end up with an Oops().
>>
>> Since these don't mess with the SP, they shouldn't trigger the overflow
>> detection, which detects whether we have sufficient stack space to store the
>> exception context to the stack. That caught the LKDTM overflow test reliably.
>>
>> Thanks,
>> Mark.
>>
>
> I gave these a quick test in QEMU and they seem to do the correct thing:
>
> # echo STACK_GUARD_PAGE_LEADING > /sys/kernel/debug/provoke-crash/DIRECT
> [   24.593306] lkdtm: Performing direct entry STACK_GUARD_PAGE_LEADING
> [   24.593780] lkdtm: attempting bad read from page below current stack
> [   24.594289] Unable to handle kernel paging request at virtual address ffff000009b77fff
> [...]
>
> # echo STACK_GUARD_PAGE_TRAILING > /sys/kernel/debug/provoke-crash/DIRECT
> [  103.144313] lkdtm: Performing direct entry STACK_GUARD_PAGE_TRAILING
> [  103.144749] lkdtm: attempting bad read from page above current stack
> [  103.145100] Unable to handle kernel paging request at virtual address ffff000009c2c000
> [...]
>
> I also confirmed they failed as expected with CONFIG_VMAP_STACK=n

Awesome!

-Kees

-- 
Kees Cook
Pixel Security
