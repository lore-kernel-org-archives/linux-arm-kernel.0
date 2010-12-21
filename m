From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Dec 2010 10:36:52 +0000
Subject: [PATCH 1/2] ARM: convert dma-mapping to asm-generic API
In-Reply-To: <1292926802-12326-1-git-send-email-jamie@jamieiles.com>
References: <1292926802-12326-1-git-send-email-jamie@jamieiles.com>
Message-ID: <20101221103652.GL28157@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 21, 2010 at 10:20:01AM +0000, Jamie Iles wrote:
> Note: this patch also requires "ARM: dmabounce: fix partial sync in
> dma_sync_single_* API" from FUJITA Tomonori:
> 
> 	http://www.spinics.net/lists/netdev/msg126826.html
> 
> which allows us to do fuzzy matching of the buffers when using
> dmabounce.

Which I've already said no to.

I don't believe that the direction taken there is anywhere near the right
one - the approach we have (implementing the whole buffer sync in terms
of the partial buffer sync) is the far more logical, simpler and safer
way, and doesn't lead to the possibility of two partially overlapping
mappings causing the wrong one to be operated upon.

The debug code doesn't check for overlapping mappings in any way, so we
can't say that they never occur.

With the way that the DMA API has gone, I view the "generic" stuff as
a disaster.
