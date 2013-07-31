From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 31 Jul 2013 21:01:35 +0100
Subject: [PATCH v2 RFC 2/8] arm: introduce a global dma_ops pointer
In-Reply-To: <1375300452-12545-2-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1307312048511.4893@kaball.uk.xensource.com>
 <1375300452-12545-2-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <20130731200135.GZ24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 08:54:06PM +0100, Stefano Stabellini wrote:
> Initially set dma_ops to arm_dma_ops.
> Use dma_ops instead of arm_dma_ops in dmabounce.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> CC: will.deacon at arm.com
> CC: linux at arm.linux.org.uk

If you're using swiotlb, there's little point in converting dmabounce
to be able to use it, because it's basically providing the same
functionality - dmabounce is there to do software buffer bouncing within
the DMA to move streaming buffers from DMA-inaccessible memory into
DMA-accessible memory.

It's original use is with older SoCs with buggy DMA (eg, those which
can only address alternate 1MB chunks of memory for example) but also
got used in situations where alternative solutions would've been better
(like using swiotlb.)  I've been discouraging its use as it's suffered
from memory exhaustion problems (there's a number of threads and bug
reports which were never solved about IXP4xx(?) platforms suffering
this due to this bouncing.)
