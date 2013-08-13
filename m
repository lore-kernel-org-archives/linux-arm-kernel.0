From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 13 Aug 2013 17:23:13 +0530
Subject: [PATCH v2] dmaengine: sirf: add PM entries for sleep and runtime
In-Reply-To: <20130813121813.GL23006@n2100.arm.linux.org.uk>
References: <1375177474-27583-1-git-send-email-Baohua.Song@csr.com>
 <20130813113200.GE32147@intel.com>
 <20130813121813.GL23006@n2100.arm.linux.org.uk>
Message-ID: <20130813115313.GF32147@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 13, 2013 at 01:18:13PM +0100, Russell King - ARM Linux wrote:
> On Tue, Aug 13, 2013 at 05:02:00PM +0530, Vinod Koul wrote:
> > On Tue, Jul 30, 2013 at 05:44:34PM +0800, Barry Song wrote:
> > Although putting runtime_get/put in submit and callback would be much more
> > better than alloc/free implementation
> 
> When the prepare/submit is called from non-process context, the runtime
> API tends to complain, so it's not that easy.
only the pm_runtime_get_sync() is the problem here. you can do pm_runtime_get() and
submit the descriptor

Then on .runtime_resume you can start the pending transaction.

I found it very useful when working with serial dma's where the serial driver
would like to keep the dma channel and not free it.

> Also you can end up in situations which cause lockdep to complain,
> especially when some of the runtime stuff calls out to an i2c controller
> which then uses the dmaengine, but the dma engine also calls out to the
> runtime api.  (I don't rememeber the exact details, I just remember having
> to drop the runtime API from such places in the past.)
hmmm, i havent seen such dependency. Can you recall what were you testing in
that scenario

~Vinod

-- 
