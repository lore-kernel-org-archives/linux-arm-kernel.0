From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 19 Aug 2016 08:18:53 +0530
Subject: [PATCH] dmaengine: qcom_hidma: release the descriptor before the
 callback
In-Reply-To: <d09ebb5f-99ea-a4e9-da9c-693be89c7cd4@codeaurora.org>
References: <20160724062425.GW9681@localhost>
 <971733d9-fd18-2a1b-07c0-349b47747d49@codeaurora.org>
 <20160804125525.GF9681@localhost>
 <71a15611-645f-7523-1c26-14b420aff667@codeaurora.org>
 <20160804144003.GV1041@n2100.armlinux.org.uk>
 <cff588a1-d85f-3d2c-ef61-1674d0d3ca92@codeaurora.org>
 <20160808090203.GY9681@localhost>
 <21475c6e-a5f8-5125-3998-f3995ce67c4d@codeaurora.org>
 <20160810172805.GH9681@localhost>
 <d09ebb5f-99ea-a4e9-da9c-693be89c7cd4@codeaurora.org>
Message-ID: <20160819024853.GR9681@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<sorry for delay, i was out>

On Wed, Aug 10, 2016 at 01:31:21PM -0400, Sinan Kaya wrote:
> On 8/10/2016 1:28 PM, Vinod Koul wrote:
> >> That's why, I preferred not to call the callback when I observe an error which I
> >> > think it makes more sense. 
> > That doesnt make sense. A client set a callback, it expect you to call one.
> > The result quried maybe txn completed or error. Since you have means, please
> > report..
> > 
> 
> If there is a good way to fix tx_status, I can certainly do so. I just need to make
> sure my implementation is robust and reliable.
> 
> I saw your reply that we need to keep this information around until terminate_all is
> called. 
> 
> What is a good implementation strategy?
> 
> Keep a size limited list with error cookies and flush them in terminate all?

I think so, terminate_all anyway cleans up the channel. Btw what is the
behaviour on error? Do you terminate or somthing else?

> What should I do if code reaches to the size limit?
> 
> Size the error cookie list double the size of available descriptors?

That won't help as you would have two values per cookie and we dont want
that :)

> >> Again, it will be a different patch than this one. I think v2 of this patch
> >> > needs to go in as it is.
> >> > 
> >> > https://lkml.org/lkml/2016/7/31/64
> > I havent looked at the patch. If it is not invoking callback set by user,
> > then I am not taking it. Sorry, we dont choose over client's wish.
> 
> Ok. The problem you are referring to is something else and needs to be addressed
> separately. I can create a series with first implement a reliable tx_status based
> on your recommendation above.
> 
> Then, change the current behavior so that client callback is always executed as you
> requested.
> 
> After that this patch to fix the free order.

-- 
~Vinod
