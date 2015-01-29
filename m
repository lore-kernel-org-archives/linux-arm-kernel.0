From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Jan 2015 15:47:18 +0000
Subject: [RFCv3 2/2] dma-buf: add helpers for sharing attacher
 constraints with dma-parms
In-Reply-To: <CAO_48GEOQ1pBwirgEWeVVXW-iOmaC=Xerr2VyYYz9t1QDXgVsw@mail.gmail.com>
References: <1422347154-15258-1-git-send-email-sumit.semwal@linaro.org>
 <1422347154-15258-2-git-send-email-sumit.semwal@linaro.org>
 <20150129143908.GA26493@n2100.arm.linux.org.uk>
 <CAO_48GEOQ1pBwirgEWeVVXW-iOmaC=Xerr2VyYYz9t1QDXgVsw@mail.gmail.com>
Message-ID: <20150129154718.GB26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 29, 2015 at 09:00:11PM +0530, Sumit Semwal wrote:
> So, short answer is, it is left to the exporter to decide. The dma-buf
> framework should not even attempt to decide or enforce any of the
> above.
> 
> At each dma_buf_attach(), there's a callback to the exporter, where
> the exporter can decide, if it intends to handle these kind of cases,
> on the best way forward.
> 
> The exporter might, for example, decide to migrate backing storage,

That's a decision which the exporter can not take.  Think about it...

If subsystem Y has mapped the buffer, it could be accessing the buffer's
backing storage at the same time that subsystem Z tries to attach to the
buffer.

Once the buffer has been exported to another user, the exporter has
effectively lost control over mediating accesses to that buffer.

All that it can do with the way the dma-buf API is today is to allocate
a _different_ scatter list pointing at the same backing storage which
satisfies the segment size and number of segments, etc.

There's also another issue which you haven't addressed.  What if several
attachments result in lowering max_segment_size and max_segment_count
such that:

	max_segment_size * max_segment_count < dmabuf->size

but individually, the attachments allow dmabuf->size to be represented
as a scatterlist?

If an exporter were to take notice of the max_segment_size and
max_segment_count, the resulting buffer is basically unrepresentable
as a scatterlist.

> > Please consider the possible sequences of use (such as the scenario
> > above) when creating or augmenting an API.
> >
> 
> I tried to think of the scenarios I could think of, but If you still
> feel this approach doesn't help with your concerns, I'll graciously
> accept advice to improve it.

See the new one above :)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
