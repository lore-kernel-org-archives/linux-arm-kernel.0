From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 8 Aug 2016 14:38:52 +0530
Subject: [PATCH] dmaengine: qcom_hidma: release the descriptor before the
 callback
In-Reply-To: <32339445-5a1c-5a3e-cd07-d64e35dce2c4@metafoo.de>
References: <1468465076-27324-1-git-send-email-okaya@codeaurora.org>
 <ccffcabf-1448-57a1-d18b-715cfd46e906@codeaurora.org>
 <20160724062425.GW9681@localhost>
 <971733d9-fd18-2a1b-07c0-349b47747d49@codeaurora.org>
 <20160804125525.GF9681@localhost>
 <71a15611-645f-7523-1c26-14b420aff667@codeaurora.org>
 <20160804144003.GV1041@n2100.armlinux.org.uk>
 <cff588a1-d85f-3d2c-ef61-1674d0d3ca92@codeaurora.org>
 <20160804153835.GY1041@n2100.armlinux.org.uk>
 <32339445-5a1c-5a3e-cd07-d64e35dce2c4@metafoo.de>
Message-ID: <20160808090852.GZ9681@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2016 at 05:59:30PM +0200, Lars-Peter Clausen wrote:
> On 08/04/2016 05:38 PM, Russell King - ARM Linux wrote:
> [...]
> > What you instead need to do is to find some way to record in your
> > driver that transaction 2 failed, and when dma_cookie_status() says
> > that a transaction has DMA_COMPLETE status, you need to look up to
> > see whether it failed.
> 
> In my opinion this is where the current API is broken by design. For each
> transfer that fails you need to store the cookie associated with that
> transfer in some kind of lookup table. Since there is no lifetime associated
> with a cookie entries in this table would need to be retained forever and it
> will grow unbound.

And how many drivers can report errors? And how many drivers can guarantee
DMA_COMPLETE implies transaction was succesful.

> Ideally we'd mark error reporting through this interface as deprecated and
> discourage new users of the interface. As far as I can see most of the few
> drivers that do return DMA_ERROR get it wrong anyway, e.g. return it
> unconditionally for all cookies when an error occurred for any of them.

Error reporting is quite tricky as detection is a problem. So yes if you
can do so, it is highly encouraged to report using new interface which is
better than client checking after callback.

Btw what is the behaviour after error? I would think that client will see an
error and report to upper layer while initiaite closure of transaction. So
does driver need to keep the state for a longer time :-)

-- 
~Vinod
