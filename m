From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 26 Jun 2017 02:45:35 -0700
Subject: [PATCH v5 2/7] dma: Add simple dma_noop_mmap
In-Reply-To: <8670225a-30a5-d567-0979-c96fd115a50f@arm.com>
References: <1495621472-9323-1-git-send-email-vladimir.murzin@arm.com>
 <1495621472-9323-3-git-send-email-vladimir.murzin@arm.com>
 <20170620132324.GA11370@infradead.org>
 <8670225a-30a5-d567-0979-c96fd115a50f@arm.com>
Message-ID: <20170626094535.GD21570@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 22, 2017 at 01:46:09PM +0100, Vladimir Murzin wrote:
> On 20/06/17 14:23, Christoph Hellwig wrote:
> > On Wed, May 24, 2017 at 11:24:27AM +0100, Vladimir Murzin wrote:
> >> This patch adds a simple implementation of mmap to dma_noop_ops.
> > 
> > Currently we use dma_common_mmap as the generic fallback if a dma_ops
> > instance doesn't implement a mmap method.  Can you just fix up
> > dma_common_mmap for your nommu case - it looks like yours is basically
> > a subset.
> 
> dma_common_map() is guarded with CONFIG_MMU and I'm not dare to change that
> since I have no idea 1) why it was done 2) how it affects other arches :(

That's still not a good reason for duplicating it.  Please instead
make all the existing nommu architecture select
CONFIG_ARCH_NO_COHERENT_DMA_MMAP as a prep patch, then provide an
arch helper to abstract away the pgprot_noncached, then lift
CONFIG_ARCH_NO_COHERENT_DMA_MMAP for arm nommu.  Bonus points
for lifting it elsewhere or consolidating various copy & paste
versions of the function.
