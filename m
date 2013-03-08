From: kyungsik.lee@lge.com (Kyungsik Lee)
Date: Fri, 8 Mar 2013 15:39:01 +0900
Subject: [PATCH v3 -next 0/5] Add support for LZ4-compressed kernel
In-Reply-To: <20130305150616.cb737f9b217b8c82051b2ccb@linux-foundation.org>
References: <1362484056-9778-1-git-send-email-kyungsik.lee@lge.com>
 <20130305150616.cb737f9b217b8c82051b2ccb@linux-foundation.org>
Message-ID: <20130308063901.GB4779@Corona>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Mar 05, 2013 at 03:06:16PM -0800, Andrew Morton wrote:
> On Tue,  5 Mar 2013 20:47:31 +0900 Kyungsik Lee <kyungsik.lee@lge.com> wrote:
> 
> > This is the third version. In this version, Some codes are fixed
> > and more description and note are added. I would like to thank David Sterba
> > for his review.
> > 
> > The Last patch[5/5] of the patch set is for making x86 and arm default to
> > LZ4-compressed for testing the LZ4 code in the linux-next.
> > It was requested by Andrew Morton in the patch set v2.
> > 
> > Currently, A preliminary version of LZ4 de/compression tool is supported.
> > However, It is expected that we will have a tool with more features
> > once its format is finished.
> 
> What happened to the changelog?  The earlier version at least had some
> rudimentary benchmarking results, but now we don't even have that. 
> 
> Someone should prepare the information explaining why we added this to
> Linux, and I'd prefer that person be you rather than me!  Certainly it
> should include performance measurements - both speed and space.  Also
> it should capture our thinking regarding all the other decompressors,
> explaining why we view it as acceptable to add yet another one.
> 
> Please, put yourself in the position of someone reading these commits
> in 2017 wondering "why did they merge this".  We should tell them.

Sorry for the inconvenience regarding changelog. Another patch(v4)
is not required so this is the information you mentioned.
I'm not sure that I captured what we had discussed regarding all the other
decompressors properly.


Benchmark Results(PATCH v3)
Compiler: Linaro ARM gcc 4.6.2

1. ARMv7, 1.5GHz based board
   Kernel: linux 3.4
   Uncompressed Kernel Size: 14MB
        Compressed Size  Decompression Speed
   LZO  6.7MB            20.1MB/s, 25.2MB/s(UA)
   LZ4  7.3MB            29.1MB/s, 45.6MB/s(UA)

2. ARMv7, 1.7GHz based board
   Kernel: linux 3.7
   Uncompressed Kernel Size: 14MB
        Compressed Size  Decompression Speed
   LZO  6.0MB            34.1MB/s, 52.2MB/s(UA)
   LZ4  6.5MB            86.7MB/s
- UA: Unaligned memory Access support
- Latest patch set for LZO applied


This patch set is for adding support for LZ4-compressed Kernel.
LZ4 is a very fast lossless compression algorithm and it also features
an extremely fast decoder [1].

But we have five of decompressors already and one question which does arise,
however, is that of where do we stop adding new ones? This issue had been
discussed and came to the conclusion [2].
Russell King said that
we should have:
- one decompressor which is the fastest
- one decompressor for the highest compression ratio
- one popular decompressor (eg conventional gzip)
If we have a replacement one for one of these, then it should do exactly that:
replace it.

The benchmark shows that an 8% increase in image size vs a 66% increase
in decompression speed compared to LZO(which has been known as the fastest
decompressor in the Kernel). Therefore the "fast but may not be small"
compression title has clearly been taken by LZ4 [3].

[1] http://code.google.com/p/lz4/
[2] http://thread.gmane.org/gmane.linux.kbuild.devel/9157
[3] http://thread.gmane.org/gmane.linux.kbuild.devel/9347


Thanks,
Kyungsik
