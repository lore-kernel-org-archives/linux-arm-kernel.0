From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 28 Jun 2015 23:45:43 +0100
Subject: dma-mapping: support for DMA_ATTR_NON_CONSISTENT DMA attribute
In-Reply-To: <CAF6-1L5c-PbK_wfpvz1xdRkquXyuQDv4mvKfYp8fwA1LK9ZOyw@mail.gmail.com>
References: <CAF6-1L5c-PbK_wfpvz1xdRkquXyuQDv4mvKfYp8fwA1LK9ZOyw@mail.gmail.com>
Message-ID: <20150628224543.GW7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 28, 2015 at 10:32:41PM +0200, Sylvain Munaut wrote:
> I've found this patch from several month ago :
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/325489.html
> 
> And I find it very useful, but I couldn't find why it wasn't merged ?

It's wrong.

> What was the problem with it ?

It's based on a bad assumption, the same bad assumption that you seem to
be making below, which is an abuse of the DMA API.

> In my use case, I need to allocate fairly large buffers (holding video
> data) and the hardware requires them to be contiguous.

So, you're allocating the buffers using the *coherent* DMA API...

> I ensure the consistency by using the DMA streaming API
> (dma_sync_single_for_{cpu,device}) and so when the buffer is "owned"
> by the CPU, I definitely want cached access because coherent memory
> speed is just abysmal ... (about 10x slower to read the whole buffer
> sequentially).

... and then using the *streaming* API dma_sync_* calls on it.  That
is invalid, and will lead to undefined results on implementations of
dma_alloc_coherent() which return remapped memory (as for older ARMs.)
This is an abuse of the API.

See Documentation/DMA-API.txt.  The API is split into two separate major
chunks, the coherent API, and the streaming API.  It is not permissible
to use functions from one API with memory obtained from the other API.

Enable DMA debug (part III of that document) to have the kernel tell you
that you're abusing the API. :)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
