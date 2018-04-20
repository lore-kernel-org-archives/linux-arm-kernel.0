From: Eugeniy.Paltsev@synopsys.com (Eugeniy Paltsev)
Date: Fri, 20 Apr 2018 15:53:30 +0000
Subject: [RFC 0/2] dw_mmc: add multislot support
In-Reply-To: <CAPDyKFqxZLtx_=0UU9NgBnW0Vmw=456q2FFbMBK4LKEaF-ua7A@mail.gmail.com>
References: <20180417121130.25281-1-Eugeniy.Paltsev@synopsys.com>
 <CAPDyKFqxZLtx_=0UU9NgBnW0Vmw=456q2FFbMBK4LKEaF-ua7A@mail.gmail.com>
Message-ID: <1524239609.10138.47.camel@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On Fri, 2018-04-20 at 09:35 +0200, Ulf Hansson wrote:
> [...]
> 
> > 
> > 2. Add missing stuff to support multislot mode in DesignWare MMC driver.
> >  * Add missing slot switch to __dw_mci_start_request() function.
> >  * Refactor set_ios function:
> >    a) Calculate common clock which is
> >       suitable for all slots instead of directly use clock value
> >       provided by mmc core. We calculate common clock as the minimum
> >       among each used slot clocks. This clock is calculated in
> >       dw_mci_calc_common_clock() function which is called
> >       from set_ios()
> >    b) Disable clock only if no other slots are ON.
> >    c) Setup clock directly in set_ios() only if no other slots
> >       are ON. Otherwise adjust clock in __dw_mci_start_request()
> >       function before slot switch.
> >    d) Move timings and bus_width setup to separate funcions.
> >  * Use timing field in each slot structure instead of common field in
> >    host structure.
> >  * Add locks to serialize access to registers.
> 
> Sorry, but this is a hack to *try* to make multi-slot work and this
> isn't sufficient. There were good reasons to why the earlier
> non-working multi slot support was removed from dw_mmc.

Previous multi slot implementation was removed as nobody used it and
nobody tested it. There are lots of mistakes in previous implementation
which are not related to request serialization
like lack of slot switch / lack of adding slot id to CIU commands / ets...
So obviously it was never tested and never used at real multi slot hardware.

> Let me elaborate a bit for your understanding. The core uses a host
> lock (mmc_claim|release_host()) to serialize operations and commands,
> as to confirm to the SD/SDIO/(e)MMC specs. The above changes gives no
> guarantees for this. To make that work, we would need a "mmc bus lock"
> to be managed by the core.

In current implementation data transfers and commands to different
hosts (slots) are serialized internally in the dw_mmc driver. We have
request queue and when .request() is called we add new request to the
queue. We take new request from the queue only if the previous one
has already finished.

So although hosts (slots) have separate locks (mmc_claim|release_host())
the requests to different slots are serialized by driver.

Isn't that enough?
I'm not very familiar with SD/SDIO/(e)MMC specs so my assumptions might be wrong
in that case please correct me.

> However, inventing a "mmc bus lock" would lead to other problems
> related to I/O scheduling for upper layers - it simply breaks. For
> example, I/O requests for one card/slot can then starve I/O requests
> reaching another card/slot.
> 

Nevertheless we had to deal somehow with existing hardware which
has multislot dw mmc controller and both slots are used...

This patch at least shouldn't break anything for current users (which use
it in single slot mode)

Moreover we tested this dual-slot implementation and don't catch any problems
(probably yet) except bus performance decrease in dual-slot mode (which is
quite expected).

> 
> Kind regards
> Uffe
-- 
 Eugeniy Paltsev
