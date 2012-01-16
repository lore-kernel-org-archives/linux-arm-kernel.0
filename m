From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Jan 2012 10:54:48 +0000
Subject: [PATCH 7/8] dmaengine/dw_dmac: Unmap all memory buffers after
 completion of slave transfers
In-Reply-To: <5e5d0fcff79b9b78e64c7424317d6b77736eca43.1326707233.git.viresh.kumar@st.com>
References: <cover.1326707233.git.viresh.kumar@st.com>
 <5e5d0fcff79b9b78e64c7424317d6b77736eca43.1326707233.git.viresh.kumar@st.com>
Message-ID: <20120116105448.GT1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2012 at 03:20:35PM +0530, Viresh Kumar wrote:
> Currently, after completion of transfer, source address or destination address
> of only the first LLI descriptor is unmapped. And length passed for unmap is
> total length of all descriptors in the list. Which means unmapping code assumed
> that the memory buffers pointed to by the descriptors will be physically
> contiguous, which might not be the case. It is possible for other drivers to
> pass sglist to slave_sg(), in which all buffers are scattered throughout the
> memory.
> 
> This patch intends to fix this wrong expectation of dw_dmac. Now, first desc
> will not contain total length of transfer. But individual descriptors will
> contain their individual lengths. Finally, we will call unmap for all
> descriptors.

Note that DMA engine drivers are not responsible for unmapping the buffers
when the transfer completes - that is the responsibility of the caller.

The automatic buffer unmapping is required for the async_tx APIs and
offload APIs.
