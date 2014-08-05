From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 5 Aug 2014 21:55:45 +0530
Subject: [PATCH] Documentation: dmaengine: Add a documentation for the
 dma controller API
In-Reply-To: <20140802144925.GJ3952@lukather>
References: <1406736193-26685-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140730160607.GM8181@intel.com> <20140731074440.GY3952@lukather>
 <20140731115628.GQ8181@intel.com> <20140731162330.GE3952@lukather>
 <20140801171306.GF8181@intel.com> <20140802144925.GJ3952@lukather>
Message-ID: <20140805162545.GX8181@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 02, 2014 at 04:49:25PM +0200, Maxime Ripard wrote:
> > - residue callculation, though situation is much better now but still lots
> >   of driver do it worng and folks do get it wrong
> 
> What mistake in often made regarding the residue calculation?
- residue is for the descriptor asked
- not for the current active one
- we can store the size locally and return that when not processing
- arg txstate can be null

> Another extra questions arose during starting this.
> 
> In the case of the call to device_control, especially in the
> DMA_SLAVE_CONFIG case, but that also applies to pause/resume, are the
> changes supposed to be immediates or can they happen later?
> 
> I actually have in mind the case where we would use a vchan, that
> might or might not be actually mapped to a physical channel at the
> moment where the DMA_SLAVE_CONFIG call is made. In the case where it's
> not mapped and not transfering anything, it's pretty trivial, to
> handle, but in the case where it's actually mapped to a physical
> channel, should we push the new configuration to the physical channel
> right away, or can it wait until the transfer ends ?
Ah no. The model doesn't assume the config will be written runtime. So the
descriptor which are already prepared doesn't change with DMA_SLAVE_CONFIG
call. Only new descriptors will take those values

But yes the pause/resume would be syncronous

HTH
-- 
~Vinod

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140805/b070ba77/attachment.sig>
