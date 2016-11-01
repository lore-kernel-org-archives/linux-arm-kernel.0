From: vinod.koul@intel.com (Koul, Vinod)
Date: Tue, 1 Nov 2016 13:46:26 +0000
Subject: [PATCH 01/14] dma: sun6i-dma: Add burst case of 4
In-Reply-To: <CAGb2v67SSZF6XL-HXv83nuwTKpJc53h8gsrb2r2V98LNZBzqEA@mail.gmail.com>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
 <3a2404510b5f8b16ae3bb193982d70f158700b2b.1475571575.git.mylene.josserand@free-electrons.com>
 <20161004124011.d7f5754a082d5f17d5185fc4@free.fr>
 <20161004165553.GS5228@lukather>
 <20161023183107.5b75b6aad62853378713299f@free.fr>
 <20161027175154.v4kuhyvm3r5n6tdo@lukather>
 <CAGb2v67SSZF6XL-HXv83nuwTKpJc53h8gsrb2r2V98LNZBzqEA@mail.gmail.com>
Message-ID: <1477922460.2837.5.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2016-10-30 at 10:06 +0800, Chen-Yu Tsai wrote:
> Looking at the dmaengine API, I believe we got it wrong.
> 
> max_burst in dma_slave_config denotes the largest amount of data
> a single transfer should be, as described in dmaengine.h:

Not a single transfer but smallest transaction within a transfer of a
block. So dmaengines transfer data in bursts from source to destination,
this parameter decides the size of that bursts

> 
> ?* @src_maxburst: the maximum number of words (note: words, as in
> ?* units of the src_addr_width member, not bytes) that can be sent
> ?* in one burst to the device. Typically something like half the
> ?* FIFO depth on I/O peripherals so you don't overflow it. This
> ?* may or may not be applicable on memory sources.
> ?* @dst_maxburst: same as src_maxburst but for destination target
> ?* mutatis mutandis.
> 
> The DMA engine driver should be free to select whatever burst size
> that doesn't exceed this. So for max_burst = 4, the driver can select
> burst = 4 for controllers that do support it, or burst = 1 for those
> that don't, and do more bursts.

Nope, the client configures these parameters and dmaengine driver
validates and programs

> 
> This also means we can increase max_burst for the audio codec, as
> the FIFO is 64 samples deep for stereo, or 128 samples for mono.

Beware that higher bursts means chance of underrun of FIFO. This value
is selected with consideration of power and performance required. Lazy
allocation would be half of FIFO size..

--?
~Vinod
