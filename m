From: Ariel.Elior@cavium.com (Elior, Ariel)
Date: Thu, 29 Mar 2018 09:17:43 +0000
Subject: [PATCH v7 3/7] bnx2x: Replace doorbell barrier() with wmb()
In-Reply-To: <1521988761-30344-4-git-send-email-okaya@codeaurora.org>
References: <1521988761-30344-1-git-send-email-okaya@codeaurora.org>
 <1521988761-30344-4-git-send-email-okaya@codeaurora.org>
Message-ID: <CY1PR0701MB133742146E2848330CA89FB290A20@CY1PR0701MB1337.namprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: [PATCH v7 3/7] bnx2x: Replace doorbell barrier() with wmb()
> 
> barrier() doesn't guarantee memory writes to be observed by the hardware on
> all architectures. barrier() only tells compiler not to move this code
> with respect to other read/writes.
> 
> If memory write needs to be observed by the HW, wmb() is the right choice.

The wmb() is there (a couple of lines above). Your modification adds an
unnecessary fence which would hurt high pps scenarios. The memory
writes which the HW needs to observe are the buffer descriptors, not the
producer update message. The producer is written to the HW, and exists
on the stack. The barrier() is there to prevent the compiler from mixing the
order of the prod update message preparation and writing it to the host.
A possible alternative would be to move the existing wmb() to where
the barrier() is, achieving both goals, although in the existing design each
barrier has a distinct purpose. The comment location is misleading, though.

Thanks,
Ariel
