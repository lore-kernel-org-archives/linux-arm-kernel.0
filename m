From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 13 Aug 2013 13:18:13 +0100
Subject: [PATCH v2] dmaengine: sirf: add PM entries for sleep and runtime
In-Reply-To: <20130813113200.GE32147@intel.com>
References: <1375177474-27583-1-git-send-email-Baohua.Song@csr.com>
 <20130813113200.GE32147@intel.com>
Message-ID: <20130813121813.GL23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 13, 2013 at 05:02:00PM +0530, Vinod Koul wrote:
> On Tue, Jul 30, 2013 at 05:44:34PM +0800, Barry Song wrote:
> > this patch adds PM ops entries in sirf-dma drivers, so that this
> > driver can support suspend/resume, hibernation and runtime PM.
> > 
> > while suspending, sirf-dma will lose all registers, so we save
> > them at suspend and restore in resume for active channels.
> > 
> > Signed-off-by: Barry Song <Baohua.Song@csr.com>
> > Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
> Applied, thanks
> 
> Although putting runtime_get/put in submit and callback would be much more
> better than alloc/free implementation

When the prepare/submit is called from non-process context, the runtime
API tends to complain, so it's not that easy.

Also you can end up in situations which cause lockdep to complain,
especially when some of the runtime stuff calls out to an i2c controller
which then uses the dmaengine, but the dma engine also calls out to the
runtime api.  (I don't rememeber the exact details, I just remember having
to drop the runtime API from such places in the past.)
