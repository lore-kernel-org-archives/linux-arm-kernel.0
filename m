From: viresh.kumar@st.com (viresh kumar)
Date: Fri, 29 Jul 2011 16:44:30 +0530
Subject: [PATCH 00/18] dmaengine/amba-pl08x updates
In-Reply-To: <20110729105759.GE25640@n2100.arm.linux.org.uk>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<20110729105759.GE25640@n2100.arm.linux.org.uk>
Message-ID: <4E329616.2030505@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Russell,

On 07/29/2011 04:27 PM, Russell King - ARM Linux wrote:
> Peripheral flow is broken beyond belief.  It doesn't work for at all
> for scatterlists.  The way peripheral flow control works on PL08x is
> as follows:
> 
> 1. You build a scatterlist which is a list of [address, length] pairs
> 2. You pass that to the DMA controller.  The DMA controller ignores the
>    length field.
> 3. The DMA controller reads/writes to [address] and increments it.
> 4. The DMA controller moves to the next SG entry when the peripheral
>    signals an end-of-transfer.
> 
> Please explain how you're getting around the issue where the scatterlist
> length is not respected by the DMA controller.

There can be two cases here:

- Memory addresses are contiguous and are not scattered.
Here, Only one sg will be passed by user driver, with memory address and
zero length. We pass this to controller and after the transfer it will
receive the last burst request from peripheral and so transfer finishes.

- Memory addresses are scattered and are not contiguous.
Here, Obviously as DMA controller doesn't know when a lli's transfer gets over,
it can't load next lli. So in this case, there has to be an assumption that only
one lli is supported. Thus, we can't have scattered addresses.

I haven't added any comment for second case anywhere in the code. Will do that
after i get first level of review comments.

-- 
viresh
