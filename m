From: broonie@kernel.org (Mark Brown)
Date: Tue, 3 Jun 2014 22:04:24 +0100
Subject: [PATCH] arm64: topology: add MPIDR-based detection
In-Reply-To: <20140603173103.GA18004@red-moon>
References: <1401644249-23792-1-git-send-email-broonie@kernel.org>
 <20140603173103.GA18004@red-moon>
Message-ID: <20140603210424.GJ31751@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 03, 2014 at 06:31:03PM +0100, Lorenzo Pieralisi wrote:

> I refactored the patch (UP code path) and deliberately removed the
> code that packs affinity levels into the cluster id. I do not
> like packing the affinity levels and on second thoughts packing the
> unused affinity levels into cluster_id is as correct as packing
> the unused affinity levels into core_id (ie it is arbitrary), so I do

I'm having a really hard time seeing this as anything other than a step
back.  Your change causes us to discard the higher affinity levels which
seems like something we actively know to be misleading and means that we
will be handing the scheduler two different identically numbered cores
(all the affinity levels we do pay attention to will be identical) if we
ever encounter such a system which is actively broken.

> not think we should do it, that's the reason why we defined DT bindings
> to add a proper topology semantics and we should use them when the MPIDR
> values deviate from the "recommendations".

I'd agree with not going to great lengths unless someone defines
semantics for the higher affinity levels in the future however it does
seem like completely ignoring them when it's so easy to take some
account of them is insufficiently defensive - it's similar to things
like putting the of_node_put() calls in even though they don't do
anything at the minute.

> Patch attached, my ack included, should be ready to go, unless you
> object to that.

Well, I certainly don't object to getting something merged here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140603/817d97c1/attachment.sig>
