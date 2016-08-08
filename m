From: okaya@codeaurora.org (okaya at codeaurora.org)
Date: Mon, 08 Aug 2016 08:10:51 -0400
Subject: [PATCH] dmaengine: qcom_hidma: release the descriptor before the
 callback
In-Reply-To: <20160808085155.GX9681@localhost>
References: <1468465076-27324-1-git-send-email-okaya@codeaurora.org>
 <ccffcabf-1448-57a1-d18b-715cfd46e906@codeaurora.org>
 <20160724062425.GW9681@localhost>
 <971733d9-fd18-2a1b-07c0-349b47747d49@codeaurora.org>
 <20160804125525.GF9681@localhost>
 <71a15611-645f-7523-1c26-14b420aff667@codeaurora.org>
 <20160808085155.GX9681@localhost>
Message-ID: <001a1ffff4ea639cb94d0dfbcb3e14d1@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-08-08 04:51, Vinod Koul wrote:
> 
>> This patch is needed to fix a race condition as the commit message 
>> describes.
>> The callback is called before returning the descriptor back to free 
>> pool.
>> 
>> If the client calls free resources, the descriptor that was not 
>> returned to free pool gets lost due
>> to race condition.
> 
> Hmmm, if you have txn's pending and client wants to free up, shouldn't
> the pending txn's be cleaned up? Sound like a different bug to me..
> 
> So if I submit 5 txn's and now want to freeup, will you still leak
> descriptors? Doesn't sound as right behaviour to me.
> 

If free is called from the callback, current code will leak the current 
descriptor where free was called. It will release the other 4.

Because of ordering problem, descriptor is not in the active, pending or 
free pool.

I check pending txn by looking at active and queued lists when free is 
called.

After the callback, I put the descriptor back to free pool. At this 
moment, it is already too late.


>> I'll refactor the code after Dave's change for passing the error code 
>> while calling the
>> callback. That will be a different patch anyhow.
> 
> Yes the error reporting is different
