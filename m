From: dan.j.williams@intel.com (Dan Williams)
Date: Fri, 17 Nov 2017 07:57:06 -0800
Subject: [PATCH v3][for 4.15] dmaengine: dmatest: move callback wait queue
 to thread context
In-Reply-To: <7637068c-4079-1235-cd6b-777907a42e8b@codeaurora.org>
References: <1510927894-15297-1-git-send-email-awallis@codeaurora.org>
 <CAPcyv4hF=LjEdhPvD3TNWa4+XfN83NCuW2Lv7ERwo4ChFSyTbg@mail.gmail.com>
 <7637068c-4079-1235-cd6b-777907a42e8b@codeaurora.org>
Message-ID: <CAPcyv4h2O7+nbxu2fyBNtcrisCntqRtFxAzDgP-7D9iAyGJSKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 17, 2017 at 7:28 AM, Adam Wallis <awallis@codeaurora.org> wrote:
> On 11/17/2017 10:12 AM, Dan Williams wrote:
>> On Fri, Nov 17, 2017 at 6:11 AM, Adam Wallis <awallis@codeaurora.org> wrote:
>>> Commit adfa543e7314 ("dmatest: don't use set_freezable_with_signal()")
>>> introduced a bug (that is in fact documented by the patch commit text)
>>> that leaves behind a dangling pointer. Since the done_wait structure is
>>> allocated on the stack, future invocations to the DMATEST can produce
>>> undesirable results (e.g., corrupted spinlocks).
>>>
>>> Commit a9df21e34b42 ("dmaengine: dmatest: warn user when dma test times
>>> out") attempted to WARN the user that the stack was likely corrupted but
>>> did not fix the actual issue.
>>>
>>> This patch fixes the issue by pushing the wait queue and callback
>>> structs into the the thread structure. If a failure occurs due to time,
>>> dmaengine_terminate_all will force the callback to safely call
>>> wake_up_all() without possibility of using a freed pointer.
>>>
>>> Cc: stable at vger.kernel.org # 4.13.x: a9df21e: dmatest: Warn User
>>> Cc: stable at vger.kernel.org # 4.13.x
>>> Cc: stable at vger.kernel.org # 4.14.x
>>
>
> Sure - do you want me to remove them? I was just following the instructions on
> stable.

It's not broken, just a note for next time.

>
>> You don't need 3 cc stables, you don't even need the "#
>> kernel-version". Since you have the "Fixes:" line the target kernel(s)
>> for the backport can be auto-determined. I should go update
>> Documentation/process/stable-kernel-rules.rst to mention this.
>>
>>> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=197605
>>> Fixes: adfa543e7314 ("dmatest: don't use set_freezable_with_signal()")
>>> Reviewed-by: Sinan Kaya <okaya@codeaurora.org>
>>> Suggested-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
>>> Signed-off-by: Adam Wallis <awallis@codeaurora.org>
>>> ---
>>> changes from v2: Added "Fixes" tag
>>> changes from v1: Added pre-req patches for stable
>>>
>>>  drivers/dma/dmatest.c | 37 ++++++++++++++++---------------------
>>>  1 file changed, 16 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
>>> index 47edc7f..2573b6c 100644
>>> --- a/drivers/dma/dmatest.c
>>> +++ b/drivers/dma/dmatest.c
>>> @@ -155,6 +155,12 @@ struct dmatest_params {
>>>  #define PATTERN_COUNT_MASK     0x1f
>>>  #define PATTERN_MEMSET_IDX     0x01
>>>
>>> +/* poor man's completion - we want to use wait_event_freezable() on it */
>>> +struct dmatest_done {
>>> +       bool                    done;
>>> +       wait_queue_head_t       *wait;
>>> +};
>>> +
>>>  struct dmatest_thread {
>>>         struct list_head        node;
>>>         struct dmatest_info     *info;
>>> @@ -165,6 +171,8 @@ struct dmatest_thread {
>>>         u8                      **dsts;
>>>         u8                      **udsts;
>>>         enum dma_transaction_type type;
>>> +       wait_queue_head_t done_wait;
>>
>> Why are we defining a waitquehead per thread vs defining one globally
>> for the whole module with "static DECLARE_WAIT_QUEUE_HEAD(x);"?
>
> This is how the original dmatest functions. Each thread had a wait queue that it
> created so that it could go to sleep while the DMA transfer occurred. Each
> thread is dependent on its own DMA transaction for the wakeup call. Again, this
> is how the test originally worked. I just moved the wait queue from the stack
> (which was getting corrupted) to the thread context to allow for safe cleanup.
> In other words, I haven't really changed how the test works...just fixing a bug
> with the current implementation.

Ok, always takes me a bit to re-orient myself to this file since I
only look at it once a year.

This fix seems incomplete. The next test iteration after a timeout
will now reuse the per-thread 'done' notification. If the engine that
timed out still completes its dma it will collide with the next
operation that is using the same 'done' variable. So it seems to me
that the wait_queue_head should be global, and the 'done' variable
should be either allocated per-operation or we should call
dmaengine_terminate_all() after a timeout. Since not all engines
implement a terminate I think the potential memory leak of a few
'done' variables is a better option.
