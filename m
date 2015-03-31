From: sbranden@broadcom.com (Scott Branden)
Date: Mon, 30 Mar 2015 20:40:43 -0700
Subject: [PATCH] dmaengine: pl330: fix the race condition in pl330 driver.
In-Reply-To: <20150330172546.GI7192@intel.com>
References: <1427414105-3480-1-git-send-email-sbranden@broadcom.com>
 <CABb+yY3s8ZXWe3YAsEeKZ6Vx2av2yvdjWiBGiy7_uGCcai=Rpw@mail.gmail.com>
 <20150330172546.GI7192@intel.com>
Message-ID: <551A173B.4010704@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod, Jassi,

Some details on the problem encountered.

On 15-03-30 10:25 AM, Vinod Koul wrote:
> On Mon, Mar 30, 2015 at 10:17:17PM +0530, Jassi Brar wrote:
>> On Fri, Mar 27, 2015 at 5:25 AM, Scott Branden <sbranden@broadcom.com> wrote:
>>> From: ismail <ismail@broadcom.com>
>>>
>>> Update the thread running index before issuing the
>>> GO command to the DMAC.
>>>
>>> Tested-by: Mohamed Ismail Abdul Packir Mohamed <ismail@broadcom.com>
>>> Reviewed-by: Ray Jui <rjui@broadcom.com>
>>> Reviewed-by: Arun Parameswaran <aparames@broadcom.com>
>>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>>> Signed-off-by: Scott Branden <sbranden@broadcom.com>
>>> Signed-off-by: Mohamed Ismail Abdul Packir Mohamed <ismail@broadcom.com>
>>> ---
>>>   drivers/dma/pl330.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
>>> index 0e1f567..631642d 100644
>>> --- a/drivers/dma/pl330.c
>>> +++ b/drivers/dma/pl330.c
>>> @@ -1072,11 +1072,11 @@ static bool _trigger(struct pl330_thread *thrd)
>>>          /* Set to generate interrupts for SEV */
>>>          writel(readl(regs + INTEN) | (1 << thrd->ev), regs + INTEN);
>>>
>>> +       thrd->req_running = idx;
>>> +
>>>          /* Only manager can execute GO */
>>>          _execute_DBGINSN(thrd, insn, true);
>>>
>>> -       thrd->req_running = idx;
>>> -
>> It would help to know what the behavior looks like before and after
>> the patch. If anything we should look at locking rather the
>> reordering.
> Yes that ia fair request, looking at changelog it is hard to understand the
> issue seen?
>
We encountered this problem as we modified the driver to make SMC calls 
to a TZ handler.  This slowed down the driver to the point where DMA 
transactions easily failed.  I believe the same could be accomplished by 
adding a delay between the GOCMD and update of the req_running and 
running the built in dmatest.

The DMA transaction is broken if the interrupt occurs before the 
thrd->req_running is updated.

The pl330 issues a GOCMD (in _trigger function) to start a new transfer.

The issue of GOCMD generates an interrupt and the IRQ handler will call 
the pl330_update function to process the interrupt.

The pl330_update function will verify the thread running index and break 
the transaction, if the thread running index is not set.

Regards,
  Scott
