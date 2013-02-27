From: kyungsik.lee@lge.com (Kyungsik Lee)
Date: Wed, 27 Feb 2013 16:36:47 +0900
Subject: [RFC PATCH v2 0/4] Add support for LZ4-compressed kernel
In-Reply-To: <512D1C12.4080109@oberhumer.com>
References: <1361859870-15751-1-git-send-email-kyungsik.lee@lge.com>
 <512D1C12.4080109@oberhumer.com>
Message-ID: <20130227073646.GA22333@Corona>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 26, 2013 at 09:33:22PM +0100, Markus F.X.J. Oberhumer wrote:
> On 2013-02-26 07:24, Kyungsik Lee wrote:
> > Hi,
> > 
> > [...]
> > 
> > Through the benchmark, it was found that -Os Compiler flag for
> > decompress.o brought better decompression performance in most of cases
> > (ex, different compiler and hardware spec.) in ARM architecture.
> > 
> > Lastly, CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is not always the best
> > option even though it is supported. The decompression speed can be
> > slightly slower in some cases.
> > 
> > This patchset is based on 3.8.
> > 
> > Any comments are appreciated.
> 
> Did you actually *try* the new LZO version and the patch (which is attached
> once again) as explained in https://lkml.org/lkml/2013/2/3/367 ?
> 
> Because the new LZO version is faster than LZ4 in my testing, at least
> when comparing apples with apples and enabling unaligned access in
> BOTH versions:
> 
> armv7 (Cortex-A9), Linaro gcc-4.6 -O3, Silesia test corpus, 256 kB block-size:
> 
>                    compression speed   decompression speed
> 
>   LZO-2012    :          44 MB/sec          117 MB/sec     no unaligned access
>   LZO-2013-UA :          47 MB/sec          167 MB/sec     Unaligned Access
>   LZ4 r88  UA :          46 MB/sec          154 MB/sec     Unaligned Access
>

I agree that the new LZO version provided shows better decompression
speed than 3.7 based. It is much improved especially for UA.

Compiler: Linaro ARM gcc 4.6.2
2. ARMv7, 1.7GHz based board
   Kernel: linux 3.7
   Uncompressed Kernel Size: 14MB
         Compressed Size  Decompression Speed
    LZO  6.0MB            34.1MB/s            Old
         ----------------------------------------
         6.0MB            34.7MB/s            New
         6.0MB            52.2MB/s(UA)
    =============================================
    LZ4  6.5MB            86.7MB/s
UA: Unaligned memory Access support

One thing I can say that the code you may have used, guessing
"lz4demo" is not the same code provided in this patch.
It has been ported for the kernel and uses different function
not like the "lz4demo". 

Thanks,
Kyungsik
