From: sbranden@broadcom.com (Scott Branden)
Date: Tue, 31 Mar 2015 15:04:23 -0700
Subject: [PATCH] dmaengine: pl330: fix the race condition in pl330 driver.
In-Reply-To: <CABb+yY3+cNqQHVxZg62CPxhb+oKEXcU-twAvpyo6DWUK_8m4qQ@mail.gmail.com>
References: <1427414105-3480-1-git-send-email-sbranden@broadcom.com>	<CABb+yY3s8ZXWe3YAsEeKZ6Vx2av2yvdjWiBGiy7_uGCcai=Rpw@mail.gmail.com>	<20150330172546.GI7192@intel.com>	<551A173B.4010704@broadcom.com>
 <CABb+yY3+cNqQHVxZg62CPxhb+oKEXcU-twAvpyo6DWUK_8m4qQ@mail.gmail.com>
Message-ID: <551B19E7.3090608@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

Thanks for taking the time to comment on this patch and provide 
additional solution.

We have went back to reproduce the problem using the dmatest.  I am glad 
you asked for more info as we discovered the problem does not happen in 
the current code.  The problem only happens when we make additional 
modifications to the existing driver to perform some SMC calls.  Somehow 
the SMC must reenable interrupts without checking the IRQ context.  And, 
looking at the pl330 code further there are spinlock's protecting large 
chunks of code.  You have to trace up a number of functions to find 
this.  As such, this patch is not required with the current codebase.

Do you still think the new code you provided is needed to solve another 
problem?

For reference, we run in the 3.10 kernel and modify dmatest.c as follows:

--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -615,6 +615,8 @@ static int dmatest_func(void *data)
  		else if (thread->type == DMA_PQ)
  			align = dev->pq_align;

+		align = 8;
+
  		if (1 << align > params->buf_size) {
  			pr_err("%u-byte buffer too small for %d-byte alignment\n",
  			       params->buf_size, 1 << align);


And then launch dmatest:

insmod /tmp/dmatest.ko
echo 10 > /sys/kernel/debug/dmatest/iterations
echo 1 > /sys/kernel/debug/dmatest/max_channels
echo 1 > /sys/kernel/debug/dmatest/run

Next, in pl330.c add an mdelay in the _trigger function.

         /* Only manager can execute GO */
         _execute_DBGINSN(thrd, insn, true);

+       mdelay(1000);

         thrd->req_running = idx;




On 15-03-30 10:20 PM, Jassi Brar wrote:
> On Tue, Mar 31, 2015 at 9:10 AM, Scott Branden <sbranden@broadcom.com> wrote:
>> Hi Vinod, Jassi,
>>
>> Some details on the problem encountered.
>>
>>
>> On 15-03-30 10:25 AM, Vinod Koul wrote:
>>>
>>> On Mon, Mar 30, 2015 at 10:17:17PM +0530, Jassi Brar wrote:
>>>>
>>>> On Fri, Mar 27, 2015 at 5:25 AM, Scott Branden <sbranden@broadcom.com>
>>>> wrote:
>>>>>
>>>>> From: ismail <ismail@broadcom.com>
>>>>>
>>>>> Update the thread running index before issuing the
>>>>> GO command to the DMAC.
>>>>>
>>>>> Tested-by: Mohamed Ismail Abdul Packir Mohamed <ismail@broadcom.com>
>>>>> Reviewed-by: Ray Jui <rjui@broadcom.com>
>>>>> Reviewed-by: Arun Parameswaran <aparames@broadcom.com>
>>>>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>>>>> Signed-off-by: Scott Branden <sbranden@broadcom.com>
>>>>> Signed-off-by: Mohamed Ismail Abdul Packir Mohamed <ismail@broadcom.com>
>>>>> ---
>>>>>    drivers/dma/pl330.c | 4 ++--
>>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
>>>>> index 0e1f567..631642d 100644
>>>>> --- a/drivers/dma/pl330.c
>>>>> +++ b/drivers/dma/pl330.c
>>>>> @@ -1072,11 +1072,11 @@ static bool _trigger(struct pl330_thread *thrd)
>>>>>           /* Set to generate interrupts for SEV */
>>>>>           writel(readl(regs + INTEN) | (1 << thrd->ev), regs + INTEN);
>>>>>
>>>>> +       thrd->req_running = idx;
>>>>> +
>>>>>           /* Only manager can execute GO */
>>>>>           _execute_DBGINSN(thrd, insn, true);
>>>>>
>>>>> -       thrd->req_running = idx;
>>>>> -
>>>>
>>>> It would help to know what the behavior looks like before and after
>>>> the patch. If anything we should look at locking rather the
>>>> reordering.
>>>
>>> Yes that ia fair request, looking at changelog it is hard to understand
>>> the
>>> issue seen?
>>>
>> We encountered this problem as we modified the driver to make SMC calls to a
>> TZ handler.  This slowed down the driver to the point where DMA transactions
>> easily failed.  I believe the same could be accomplished by adding a delay
>> between the GOCMD and update of the req_running and running the built in
>> dmatest.
>>
>> The DMA transaction is broken if the interrupt occurs before the
>> thrd->req_running is updated.
>>
>> The pl330 issues a GOCMD (in _trigger function) to start a new transfer.
>>
>> The issue of GOCMD generates an interrupt and the IRQ handler will call the
>> pl330_update function to process the interrupt.
>>
>> The pl330_update function will verify the thread running index and break the
>> transaction, if the thread running index is not set.
>>
> As I suspected the locking seems screwed up. The following patch
> should fix the race properly. Can you please test the attached patches
> instead?
>
> Thanks.
>
