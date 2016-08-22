From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 22 Aug 2016 22:30:08 +0530
Subject: [PATCH] dmaengine: qcom_hidma: release the descriptor before the
 callback
In-Reply-To: <6151fe21-3c48-e691-1c99-bafd3cc699e6@codeaurora.org>
References: <20160819024853.GR9681@localhost>
 <8c096fee-9749-a7df-7e04-25d21c0ea9ac@codeaurora.org>
 <20160819034249.GS9681@localhost>
 <3592cfe2-a563-7c26-9a9e-925051cc1934@codeaurora.org>
 <20160819055252.GT9681@localhost>
 <37b059dcb67d1c83c2193acecef0ab96@codeaurora.org>
 <20160819170208.GC9343@localhost>
 <f11a2775-63b8-6933-ab15-20e3927f0db7@codeaurora.org>
 <20160822060803.GH2890@localhost>
 <6151fe21-3c48-e691-1c99-bafd3cc699e6@codeaurora.org>
Message-ID: <20160822170008.GR2890@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2016 at 09:27:04AM -0400, Sinan Kaya wrote:
> >>>>> You didn't answer my question!
> >>>>>
> >>>>> On error you said you flush, so who does that?
> >>>>
> >>>> This is done by the driver in interrupt context when an error
> >>>> interrupt is received. All transactions are posted and hw is reset.
> >>>
> >>> Hmmm, waht about the txn which are pending? DO you clear them..?
> >>>
> >>
> >> Yes, I clear both pending and active transactions. 
> > 
> > Okay, in that case your can consider below:
> > 
> > 1. dmaengine asserts error interrupt
> > 2. Driver receives and mark's the txn as error
> > 3. Driver completes the txn and intimates the client. No further
> >    submissions. Drop the locks before calling callback, as subsequent
> >    processing by client maybe in callback thread.
> > 4. Client invokes status and you can return error
> > 5. On error, client calls terminate_all. You can reset channel, free all
> >    descriptors in the active, pending and completed lists
> > 6. Client prepares new txn and so on..
> 
> 
> Just to be clear, you are telling me not to accept any new transactions until
> terminate_all is called, right?

You may return error for those cases, but my guess is that since you are
interrupt driven, the error propagation in callback and query will be
faster.

-- 
~Vinod
