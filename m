From: joelf@ti.com (Joel Fernandes)
Date: Thu, 1 Aug 2013 15:48:57 -0500
Subject: [PATCH 4/9] dma: edma: Find missed events and issue them
In-Reply-To: <51FAC50A.2020507@ti.com>
References: <1375104595-16018-1-git-send-email-joelf@ti.com>
 <1375104595-16018-5-git-send-email-joelf@ti.com> <51F7659E.3040302@ti.com>
 <51F89763.1010102@ti.com> <51F8D667.2040406@ti.com> <51F9C793.2000001@ti.com>
 <51F9FC87.3020706@ti.com> <51FAC50A.2020507@ti.com>
Message-ID: <51FAC9B9.3050903@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just some corrections here..

On 08/01/2013 03:28 PM, Joel Fernandes wrote:

>>> 2. If the interrupt handler for some reason doesn't complete or get
>>> service in time, we will end up DMA'ing incorrect data as events
>>> wouldn't stop coming in even if interrupt is not yet handled (in your
>>> example linked sets P1 or P2 would be old ones being repeated). Where as
>>> with my method, we are not doing any DMA once we finish the current
>>> MAX_NR_SG set even if events continue to come.
>>
>> Where is repetition and possibility of wrong data being transferred? We
>> have a linear list of PaRAM sets - not a loop. You would link the end to
>> PaRAM set chain to dummy PaRAM set which BTW will not cause missed
>> events. The more number of PaRAM sets you add to the chain, the more
> 
> There would have to be a loop, how else would you ensure continuity and
> uninterrupted DMA?
> 
> Consider if you have 2 sets of linked sets:
> L1 is the first set of Linked sets and L2 is the second.
> 
> When L1 is done, EDMA continues with L2 (due to the link) while
> interrupt handler prepares L1. The continuity depends on L1 being linked
> to L2. Only the absolute last break up of the MAX_NR_SG linked set will
> be linked to Dummy.
> 
> So consider MAX_NR_SG=10, and sg_len = 35
> 
> L1 - L2 - L1 - L1 - Dummy

Should be,
L1 - L2 - L1 - L2 - Dummy

> 
> The split would be in number of slots,
> 10 - 10 - 10 -  5 - Dummy
> 
>> time CPU gets to intervene before DMA eventually stalls. This is a
>> tradeoff system designers can manage.
> 
> Consider what happens in the case where MAX_SG_NR=1 or 2. In that case,
> there's a change we might not get enough time for the interrupt handler
> to setup next series of linked set.
> 
> Some how this limitation has to be overcome by advising in comments than
> MAX_SG_NR should always be greater than a certain number to ensure
> proper operation.

s/than/that/


Thanks,

-Joel
