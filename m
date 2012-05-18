From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 May 2012 20:49:59 +0000
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <4FB43F69.1070608@wwwdotorg.org>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <201205161942.20296.arnd@arndb.de> <4FB43F69.1070608@wwwdotorg.org>
Message-ID: <201205182050.00095.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 May 2012, Stephen Warren wrote:
> Simple case:
> 
> /* e.g. FIFO TX DMA req - 2 DMACs possible */
> dma-req-0 = <&dmac1 DMAC1_DMA_REQ_6>;
> /* e.g. FIFO RX DMA req 1 DMAC possible */
> dma-req-1 = <&dmac1 DMAC1_DMA_REQ_8>;
> 
> Multiple DMAC case:
> 
> /* e.g. FIFO TX DMA req - 2 DMACs possible */
> dma-req-0 = <&dmac1 DMAC1_DMA_REQ_6 &dmac2 DMA_2_DMA_REQ_8>;
> /* e.g. FIFO RX DMA req 1 DMAC possible */
> dma-req-1 = <&dmac1 DMAC1_DMA_REQ_8>;
> 
> Then, when the DMA client calls the standard API to "get DMA channel for
> my outbound DMA request "n", the core code will kasprintf("dma-req-%d",
> n); to generate the property name. That's how pinctrl works.
> 
> Does that seem better?

Yes, that is one way that I suggested at an earlier point. After some
discussion, I would use a different syntax for these though, to the exact
same effect, writing it as


	dmas = <&dmac1 DMAC1_DMA_REQ_6>,  <&dmac2 DMA_2_DMA_REQ_8>,  <&dmac1 DMAC1_DMA_REQ_8>;
	dma-names = "tx", "tx", "rx";

The driver can still request the dma line by name "tx" and the subsystem
would pick one out of those with the same name.

For the majority of cases, we would only need a single dma request line
and could leave out the dma-names property, so when you don't ask for a
specific name, you just get any dma line out of the dmas array.

	Arnd
