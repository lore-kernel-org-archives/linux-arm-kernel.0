From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 15 Aug 2013 17:22:14 +0200
Subject: [PATCH 00/20] ARM: pxa: move core and drivers to dmaengine
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
 <87zjsqzdg8.fsf@free.fr> <52061C53.4050905@gmail.com>
 <20130814100010.GO32147@intel.com>
Message-ID: <8761v7nfmh.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod Koul <vinod.koul@intel.com> writes:
>> Yes, Vinod and and Dan are certainly the best ones to comment on that I
>> think.
> I read the file esp the "DMA flow" and "DMA hot chaining timeslice issue". I can
> say with "properly" implemented dmaengine driver this is very much doable.
Great.
>
>
> Have you guys read: Documentation/dmaengine.txt?
Yes. I had not understood the "hot chaining" was implied in it, but now I
understand it is part of it, and at the discretion of the slave engine driver.

> So for "hot chaning" it would work as follows:
>
> Client, allocates and channel and prepares the descriptors A B & C
> Client (video), submits buffer A, Buffer B. Both are queued by dma driver
> Client calls dma_async_issue_pending
> DMA driver will start Buffer A. It gets the completetion for A and then Starts
> B. It will invoke callbakc for A.
>
> If you submit C, and invoke dma_async_issue_pending(), C is queued
> On B completetion, the DMA driver will start C and invoke callback for B.
>
> If B completes before C is submitted, after submit and invoking
> dma_async_issue_pending(), the C buffer will be queued and started.
OK, that settles it then. The API allows hot chaining, and if I understand
Daniel's driver properly, he already thought about it (in
append_pending_queue()).

I have some homework now Daniel, I'll send you my work to include into your
patch serie for the review, and my tests of your patches.

I need a bit of time (1 or 2 weeks), because of holidays, for my patch.

Cheers.

-- 
Robert
