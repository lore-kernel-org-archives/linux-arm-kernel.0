From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Jul 2011 12:19:20 +0100
Subject: [PATCH 00/18] dmaengine/amba-pl08x updates
In-Reply-To: <4E329616.2030505@st.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<20110729105759.GE25640@n2100.arm.linux.org.uk>
	<4E329616.2030505@st.com>
Message-ID: <20110729111920.GK25640@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 29, 2011 at 04:44:30PM +0530, viresh kumar wrote:
> There can be two cases here:
> 
> - Memory addresses are contiguous and are not scattered.
> Here, Only one sg will be passed by user driver, with memory address and
> zero length. We pass this to controller and after the transfer it will
> receive the last burst request from peripheral and so transfer finishes.
> 
> - Memory addresses are scattered and are not contiguous.
> Here, Obviously as DMA controller doesn't know when a lli's transfer gets over,
> it can't load next lli. So in this case, there has to be an assumption that only
> one lli is supported. Thus, we can't have scattered addresses.

Ok, so lets have the driver explicitly enforce one SG entry if peripheral
flow is set.  It would also be a good idea to pass not zero length, but
the real transfer size in the SG entry for the sake of having the API
know the full information about the transfer.

(Ok, it already only supports one SG entry, but that's something else
which needs fixing - which may be possible now that you've cleaned up
the LLI creation code.)
