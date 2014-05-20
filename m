From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 19 May 2014 23:13:47 -0400 (EDT)
Subject: [PATCH v3] arm: ioremap: Fix static vm area boundary check.
In-Reply-To: <9258c0b00a33484a8d289378047f8cd4@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1400232920-25079-1-git-send-email-Li.Xiubo@freescale.com>
 <alpine.LFD.2.11.1405161403400.17310@knanqh.ubzr>
 <9258c0b00a33484a8d289378047f8cd4@BY2PR03MB505.namprd03.prod.outlook.com>
Message-ID: <alpine.LFD.2.11.1405192306390.17310@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 May 2014, Li.Xiubo at freescale.com wrote:

> > > For each vmalloc area, there is one guard page at the end of it.
> > > so the vm->size = PAGE_ALIGN(offset + request size) + guard page size.
> > 
> > Nope.  There is no guard page for statically created vmalloc areas.
> > 
> 
> Yes, you are right, I'm thinking why the static area has no guard page?

The virtual addresses being used are provided by the static mapping 
descriptions themselves.  Sometimes those mappings are large and 
contiguous, covering multiple peripherals at once with a single TLB, 
etc.  There is simply no room for a guard page, or no guard page at all 
between different areas covered by a single section mapping (1MB worth 
of mapping from a single page table entry).

All this to say that trying to enforce a guard page in those cases is 
likely to throw away all the performance advantage and conplexify 
things.


Nicolas
