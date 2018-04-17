From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 17 Apr 2018 10:13:28 -0400
Subject: [PATCH v2 2/2] parisc: define stronger ordering for the default
 readX()
In-Reply-To: <1523957852.3250.9.camel@HansenPartnership.com>
References: <1523938133-3224-1-git-send-email-okaya@codeaurora.org>
 <1523938133-3224-2-git-send-email-okaya@codeaurora.org>
 <1523957852.3250.9.camel@HansenPartnership.com>
Message-ID: <38a1d4e3-cabe-6c39-4355-8d8111637382@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

> 
> Perhaps if you gave an example of the actual problem you're trying to
> fix we could assess if it affects parisc.

Let me clarify myself here. Maybe, there is a better solution.

		/* assign ownership */
		desc->status = DEVICE_OWN;

		/* notify device of new descriptors */
		writel(DESC_NOTIFY, doorbell);

The difference between writel() and writel_relax() is writel() guarantees
memory transactions to be flushed to the device before the register write.
writel_relaxed() does not provide any guarantees about the memory and IO
operations.

Similarly, readl() provides following code to observe the DMA result while
readl_relaxed() does not provide this guarantee.

Ideally, you want to embed rmb() and wmb() into the writel() and readl()
to provide this guarantee.

PA-RISC doesn't seem to support neither one of the barrier types. If you are
familiar with the architecture, maybe you could guide us here.

Is __raw_writeX() enough to provide this guarantee for this architecture?

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
