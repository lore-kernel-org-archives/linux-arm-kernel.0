From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 22 Aug 2016 11:38:03 +0530
Subject: [PATCH] dmaengine: qcom_hidma: release the descriptor before the
 callback
In-Reply-To: <f11a2775-63b8-6933-ab15-20e3927f0db7@codeaurora.org>
References: <20160810172805.GH9681@localhost>
 <d09ebb5f-99ea-a4e9-da9c-693be89c7cd4@codeaurora.org>
 <20160819024853.GR9681@localhost>
 <8c096fee-9749-a7df-7e04-25d21c0ea9ac@codeaurora.org>
 <20160819034249.GS9681@localhost>
 <3592cfe2-a563-7c26-9a9e-925051cc1934@codeaurora.org>
 <20160819055252.GT9681@localhost>
 <37b059dcb67d1c83c2193acecef0ab96@codeaurora.org>
 <20160819170208.GC9343@localhost>
 <f11a2775-63b8-6933-ab15-20e3927f0db7@codeaurora.org>
Message-ID: <20160822060803.GH2890@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2016 at 01:21:34PM -0400, Sinan Kaya wrote:
> On 8/19/2016 1:02 PM, Vinod Koul wrote:
> > On Fri, Aug 19, 2016 at 07:13:43AM -0400, okaya at codeaurora.org wrote:
> >> On 2016-08-19 01:52, Vinod Koul wrote:
> >>> On Thu, Aug 18, 2016 at 11:48:52PM -0400, Sinan Kaya wrote:
> >>>> On 8/18/2016 11:42 PM, Vinod Koul wrote:
> >>>>> On Thu, Aug 18, 2016 at 11:26:28PM -0400, Sinan Kaya wrote:
> >>>>>> On 8/18/2016 10:48 PM, Vinod Koul wrote:
> >>>>>>>> Keep a size limited list with error cookies and flush them in terminate all?
> >>>>>>> I think so, terminate_all anyway cleans up the channel. Btw what is the
> >>>>>>> behaviour on error? Do you terminate or somthing else?
> >>>>>>>
> >>>>>>
> >>>>>> On error, I flush all outstanding transactions with an error code and I reset
> >>>>>> the channel. After the reset, the DMA channel is functional again. The client
> >>>>>> doesn't need to shutdown anything.
> >>>>>
> >>>>> You mean from the client context or driver?
> >>>>>
> >>>>
> >>>> The client doesn't need to call device_free_chan_resources and
> >>>> device_terminate_all
> >>>> to be specific. Client can certainly call these if it needs to
> >>>> but it is not
> >>>> required to recover the channel.
> >>>
> >>> You didn't answer my question!
> >>>
> >>> On error you said you flush, so who does that?
> >>
> >> This is done by the driver in interrupt context when an error
> >> interrupt is received. All transactions are posted and hw is reset.
> > 
> > Hmmm, waht about the txn which are pending? DO you clear them..?
> > 
> 
> Yes, I clear both pending and active transactions. 

Okay, in that case your can consider below:

1. dmaengine asserts error interrupt
2. Driver receives and mark's the txn as error
3. Driver completes the txn and intimates the client. No further
   submissions. Drop the locks before calling callback, as subsequent
   processing by client maybe in callback thread.
4. Client invokes status and you can return error
5. On error, client calls terminate_all. You can reset channel, free all
   descriptors in the active, pending and completed lists
6. Client prepares new txn and so on..

Thanks
-- 
~Vinod
