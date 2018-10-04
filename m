From: leedom@chelsio.com (Casey Leedom)
Date: Thu, 4 Oct 2018 19:13:06 +0000
Subject: How is the Linux kernel API dma_alloc_coherent() typically
 implemented for the ARM Architecture?
In-Reply-To: <41f7c1e1-066a-b984-53cd-17b5c25420d4@arm.com>
References: <BYAPR12MB2791F73EC1033F998FF533BAC8E90@BYAPR12MB2791.namprd12.prod.outlook.com>
 <866a698a-aa61-6c48-0258-f2dd97973e87@arm.com>
 <20181003180843.GY30658@n2100.armlinux.org.uk>,
 <41f7c1e1-066a-b984-53cd-17b5c25420d4@arm.com>
Message-ID: <BYAPR12MB2791AB6C94175B4693EBBA4CC8EA0@BYAPR12MB2791.namprd12.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

| From: Robin Murphy <robin.murphy@arm.com>
| Sent: Thursday, October 4, 2018 4:05 AM
|
| On 03/10/18 19:08, Russell King - ARM Linux wrote:
| >
| > That's one of the reasons
| > for having the DMA API - to provide a consistent cross-platform
| > cross-architecture way to deal with the DMA coherency issues.
|
| Fully agreed that driver authors shouldn't care about this and can trust the
| kernel to provide the best thing it can, but Casey's initial question
| implied that a bit more architectural background might be useful (especially
| now given the response).

Yes, I'm basically trying to advise a Hardware Team on what work they need
to do in order to successfully integrate a 4-Core ARM Complex into an
existing SoC.

Their initial plan was to make this completely I/O Coherent which would have
causes _*ALL*_ I/O to flow through a bandwidth limited Coherency Switch.
But that's definitely not necessary (or desirable because of the bandwidth
issue) for the actual Data being transferred.

But the TX/RX Rings on the other hand ... that could be an issue.  As noted,
these are mapped with the Linux dma_alloc_coherent() API and I was trying to
understand what mapping this actually ended up with on various ARM platform
implementations.  It ~looked like~ this resulted in an UNCACHED Mapping, but
I couldn't tell for sure.  The levels of API Abstraction made it very
difficult to see what's happening.

Casey
