From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 16 Jun 2016 14:42:24 +0200
Subject: [PATCH] dma: mv_xor_v2: new driver
In-Reply-To: <20160615164131.GB16910@localhost>
References: <1455523083-25506-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160222032730.GU19598@localhost>
 <20160615160837.64377829@free-electrons.com>
 <20160615164131.GB16910@localhost>
Message-ID: <20160616144224.2e687a14@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 15 Jun 2016 22:11:31 +0530, Vinod Koul wrote:

> > This is probably the only thing that I have not changed. The mv_xor
> > driver is already using the same strategy, and enqueuing in
> > issue_pending() would force us to add the request to a temporary linked
> > list, which would be dequeued in issue_pending(). This is quite a bit
> > of additional processing, while pushing the new requests directly to
> > the engine works fine.  
> 
> Well that is wrong! And patch is welcome for mv_xor as well :)
> 
> The DMAengine API mandates that we should submit a descriptor to a queue and
> then push them by invoking issue_pending.
> 
> The users are also expected to follow this

I have just sent a v4 that fixes this for the mv_xor_v2 driver. Now, in
->tx_submit() we only fill in the HW descriptors, but do not tell the
engine to process them. It's only at ->issue_pending() time that we
tell the engine that there N new descriptors to process.

I'll have a look at mv_xor a bit later.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
