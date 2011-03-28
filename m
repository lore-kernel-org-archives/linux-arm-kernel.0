From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Mon, 28 Mar 2011 05:01:31 +0000
Subject: [PATCH 1/1] ARM: dmabounce: fix dmabounce may cause crash issue
In-Reply-To: <20110325083630.GA26481@n2100.arm.linux.org.uk>
References: <1300965400-28304-1-git-send-email-b29396@freescale.com>
	<20110325083630.GA26481@n2100.arm.linux.org.uk>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F77214AB97@039-SN1MPN1-001.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Friday, March 25, 2011 4:37 PM
> To: Dong Aisheng-B29396
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 1/1] ARM: dmabounce: fix dmabounce may cause crash
> issue
> 
> On Thu, Mar 24, 2011 at 07:16:40PM +0800, Aisheng.Dong wrote:
> > The map_single does not check if dev is NULL which may cause kernel
> > panic like follows:
> > Unable to handle kernel NULL pointer dereference at virtual address
> > 000000bc pgd = 80004000 [000000bc] *pgd=00000000 Internal error: Oops:
> > 5 [#1] PREEMPT last sysfs file:
> > Modules linked in:
> > CPU: 0    Not tainted  (2.6.35.3-00845-g204c152-dirty #112)
> > PC is at dma_map_single+0x2c/0x2a0
> > LR is at fec_enet_interrupt+0x1d4/0x450
> > pc : [<8003cf04>]    lr : [<802936b8>]    psr: 60000193
> > sp : 80809ec8  ip : 00000080  fp : 99308040
> > r10: 99308040  r9 : 00000002  r8 : 99074f00
> > r7 : fa0a5000  r6 : 00000000  r5 : 00000060  r4 : 992e4000
> > r3 : 00000002  r2 : 8080cac0  r1 : 99308040  r0 : 00000000
> >
> > The patch checks the dev to avoid this issue and align with the
> > original dma_map_single to allow dev is NULL.
> 
> Is there a reason that the FEC code can't pass the appropriate struct
> device?

No special reason.
But dma_map_single allows the 'dev' passed in to be NULL, so, may it be better to also check it for dmabounce in case such a using?
I searched the kernel, there are also many other places calling dma_map_single without passing a dev.
Thus, they may also face the same issue if they use dmabounce.
