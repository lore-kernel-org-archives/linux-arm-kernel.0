From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Jan 2013 12:15:31 +0000
Subject: [RFC PATCH 0/4] Add support for LZ4-compressed kernels
In-Reply-To: <34874167.ghObrToI03@fb07-iapwap2>
References: <1359179447-31118-1-git-send-email-kyungsik.lee@lge.com>
 <20130128142510.68092e10.akpm@linux-foundation.org>
 <20130129101549.GP23505@n2100.arm.linux.org.uk>
 <34874167.ghObrToI03@fb07-iapwap2>
Message-ID: <20130129121530.GS23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 12:43:20PM +0100, Egon Alter wrote:
> Am Dienstag, 29. Januar 2013, 10:15:49 schrieb Russell King - ARM Linux:
> > On Mon, Jan 28, 2013 at 02:25:10PM -0800, Andrew Morton wrote:
> > > What's this "with enabled unaligned memory access" thing?  You mean "if
> > > the arch supports CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS"?  If so,
> > > that's only x86, which isn't really in the target market for this
> > > patch, yes?
> > > 
> > > It's a lot of code for a 50ms boot-time improvement.  Does anyone have
> > > any opinions on whether or not the benefits are worth the cost?
> > 
> > Well... when I saw this my immediate reaction was "oh no, yet another
> > decompressor for the kernel".  We have five of these things already.
> > Do we really need a sixth?
> > 
> > My feeling is that we should have:
> > - one decompressor which is the fastest
> > - one decompressor for the highest compression ratio
> > - one popular decompressor (eg conventional gzip)
> 
> the problem gets more complicated as the "fastest" decompressor usually 
> creates larger images which need more time to load from the storage, e.g. a 
> one MB larger image on a 10 MB/s storage (note: bootloaders often configure 
> the  storage controllers in slow modes) gives 100 ms more boot time, thus 
> eating the gain of a "fast decompressor".

Ok.

We already have:

- lzma: 33% smaller than gzip, decompression speed between gzip and bzip2
- xz: 30% smaller than gzip, decompression speed similar to lzma
- bzip2: 10% smaller than gzip, slowest decompression
- gzip: reference implementation
- lzo: 10% bigger than gzip, fastest

And now:

- lz4: 8% bigger than lzo, 16% faster than lzo?
  (I make that 16% bigger than gzip)

So, image size wise, on a 2MB compressed gzip image, we're looking at
the difference between LZO at 2.2MB and LZ4 at 2.38MB.

But let's not stop there - the figures given for a 13MB decompressed
image were:

lzo: 6.3MB, 301ms
lz4: 6.8MB, 251ms(167ms, with enabled unaligned memory access)

At 10MB/s (your figure), it takes .68s to read 6.8MB as opposed to .63s
for LZO.  So, totalling up these figures gives to give the overall figure:

lzo: 301ms + 630ms = 931ms
lz4: 167ms + 680ms = 797ms

Which gives the tradeoff at 10MB/s of 14% faster (but only with efficient
unaligned memory access.)  So... this faster decompressor is still the
fastest even with your media transfer rate factored in.

That gives an argument for replacing lzo with lz4...
