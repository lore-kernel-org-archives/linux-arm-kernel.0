From: karl.beldan@gmail.com (Karl Beldan)
Date: Tue, 31 Jul 2012 10:30:22 +0200
Subject: About dma_sync_single_for_{cpu,device}
In-Reply-To: <50178A69.8050906@ladisch.de>
References: <20120730202401.GA4947@gobelin> <20120731064557.GA4676@gobelin>
 <50178249.7090306@ladisch.de>
 <CACYmx9O_TJoSmhiai_Mv09JE3HZ+-V=w8KobTn3zPXtkWbojkw@mail.gmail.com>
 <50178A69.8050906@ladisch.de>
Message-ID: <20120731083022.GA5026@ed-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2012 at 09:34:01AM +0200, Clemens Ladisch wrote:
> Karl Beldan wrote:
> > On 7/31/12, Clemens Ladisch <clemens@ladisch.de> wrote:
> >> Karl Beldan wrote:
> >>> To tx a chunk of data from the SoC => network device, we :
> >>> - prepare a buffer with a leading header embedding a pattern,
> >>> - trigger the xfer and wait for an irq
> >>> // The device updates the pattern and then triggers an irq
> >>> - upon irq we check the pattern for the xfer completion
> >>>
> >>> I was expecting the following to work:
> >>> 	addr = dma_map_single(dev, buffer, size, DMA_TO_DEVICE);
> >>
> >> Of both the CPU and the device write to the buffer, you must use
> >> DMA_BIDIRECTIONAL.
> >
> > This does not work (tested) :  seems to me BIDIRECTIONAL would just
> > add invalidate, and invalidate before the ram has been updated, as
> > stated, does not work.
> 
> Please show the exact sequence of dma_* calls, and also show when and
> how the CPU and the device access the buffer.
> 
Hmm, so I just spotted a line where we peek in the buffer after
invalidating .. cannot believe I missed it .. so sorry for the noise ..
now it's working.
I felt I would find the culprit right after posting ;)
Thanks Clemens !
