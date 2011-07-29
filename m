From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Jul 2011 11:57:59 +0100
Subject: [PATCH 00/18] dmaengine/amba-pl08x updates
In-Reply-To: <cover.1311936523.git.viresh.kumar@st.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
Message-ID: <20110729105759.GE25640@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 29, 2011 at 04:19:10PM +0530, Viresh Kumar wrote:
> Hi Linus,
> 
> This patchset contains patches for ARM's pl08x DMA controller driver.
> Main changes introduced by this patchset are:
> - Formatting fixes
> - Logical Fixes
> - Support for Peripheral as flow controller

Peripheral flow is broken beyond belief.  It doesn't work for at all
for scatterlists.  The way peripheral flow control works on PL08x is
as follows:

1. You build a scatterlist which is a list of [address, length] pairs
2. You pass that to the DMA controller.  The DMA controller ignores the
   length field.
3. The DMA controller reads/writes to [address] and increments it.
4. The DMA controller moves to the next SG entry when the peripheral
   signals an end-of-transfer.

Please explain how you're getting around the issue where the scatterlist
length is not respected by the DMA controller.
