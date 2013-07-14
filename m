From: w@1wt.eu (Willy Tarreau)
Date: Sun, 14 Jul 2013 08:13:54 +0200
Subject: Call for testing/opinions: Optimized memset/memcpy
In-Reply-To: <loom.20130713T232124-511@post.gmane.org>
References: <loom.20130713T172357-560@post.gmane.org>
 <20130713172445.GL32054@1wt.eu> <loom.20130713T232124-511@post.gmane.org>
Message-ID: <20130714061354.GS32054@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jul 13, 2013 at 09:51:18PM +0000, Harm Hanemaaijer wrote:
> Willy Tarreau <w <at> 1wt.eu> writes:
> 
> > OK I've run bench.script on the following platforms :
> 
> Thanks, that's incredibly helpful!
> 
> Note that Thumb2 mode usually doesn't do much in synthetic benchmarks,
> because the benchmark code will fit into the L1 instruction cache; the
> benefit of Thumb2 happens in real-world usage when the active code
> footprint becomes larger.
> 
> To summarize, memset seems to be in good shape and also the "fast path"
> for common word-aligned memcpy of size <= 256 seems to be working well.
> 
> However, the copy_page and memcpy results for larger sizes seem to suggest
> that the prefetch strategy isn't working well on these platforms. Note also
> that on the quad core the existing copy_page is also highly sub-optimal.
> 
> Fixing the preload strategy for these platforms may simply be a case of
> changing the configurable constant PREFETCH_DISTANCE from 3 to 2 (from an
> offset of 192 bytes to 128 bytes), which more closely mimics the original
> kernel memcpy. I have added PREFETCH_DISTANCE as a configurable parameter
> in the Makefile in the latest version of test-arm-kernel-memcpy. It will
> be interesting to see the results of testing with a PREFETCH_DISTANCE
> of 2 especially on the quad-core platform or a similar one.

No problem, I ran it on the two in armv7+thumb mode again.

Please find the results attached. It seems that memcpy improved by 0.8%
though that's not even certain.

Regards,
Willy

-------------- next part --------------
libc memcpy:
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 870.97 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 870.98 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 870.96 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 870.88 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 870.63 MB/s
kernel memcpy (original):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 955.68 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 955.36 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 955.71 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 955.41 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 955.66 MB/s
kernel memcpy (optimized):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 850.25 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 850.26 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 850.16 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 849.91 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 850.27 MB/s
libc memcpy:
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 454.00 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 457.50 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 453.22 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 456.13 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 454.23 MB/s
kernel memcpy (original):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 508.77 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 508.95 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 509.26 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 509.19 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 509.46 MB/s
kernel memcpy (optimized):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 523.20 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 523.22 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 523.31 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 523.09 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 523.62 MB/s
libc memcpy:
Mixed multiples of 4 from 4 to 130, word aligned: 389.04 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 388.08 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 387.82 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 387.74 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 387.92 MB/s
kernel memcpy (original):
Mixed multiples of 4 from 4 to 130, word aligned: 429.52 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 430.19 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 430.10 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 430.02 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 429.45 MB/s
kernel memcpy (optimized):
Mixed multiples of 4 from 4 to 130, word aligned: 473.75 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 474.00 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 473.59 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 473.24 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 473.65 MB/s
kernel copy_from_user (optimized):
Mixed multiples of 4 from 4 to 130, word aligned: 452.37 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 452.11 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 452.91 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 451.84 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 452.71 MB/s
kernel copy_to_user (optimized):
Mixed multiples of 4 from 4 to 130, word aligned: 427.17 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 427.11 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 426.57 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 426.67 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 427.11 MB/s
libc memcpy:
4096 bytes page aligned: 2703.64 MB/s
4096 bytes page aligned: 2702.35 MB/s
4096 bytes page aligned: 2705.23 MB/s
4096 bytes page aligned: 2702.31 MB/s
4096 bytes page aligned: 2703.18 MB/s
kernel memcpy (original):
4096 bytes page aligned: 2735.75 MB/s
4096 bytes page aligned: 2736.98 MB/s
4096 bytes page aligned: 2739.54 MB/s
4096 bytes page aligned: 2736.56 MB/s
4096 bytes page aligned: 2735.81 MB/s
kernel memcpy (optimized):
4096 bytes page aligned: 2019.77 MB/s
4096 bytes page aligned: 2019.01 MB/s
4096 bytes page aligned: 2019.78 MB/s
4096 bytes page aligned: 2019.88 MB/s
4096 bytes page aligned: 2018.68 MB/s
kernel copy_page (original):
4096 bytes page aligned: 1533.13 MB/s
4096 bytes page aligned: 1532.51 MB/s
4096 bytes page aligned: 1534.12 MB/s
4096 bytes page aligned: 1532.53 MB/s
4096 bytes page aligned: 1533.16 MB/s
kernel copy_page (optimized):
4096 bytes page aligned: 2012.66 MB/s
4096 bytes page aligned: 2013.76 MB/s
4096 bytes page aligned: 2013.53 MB/s
4096 bytes page aligned: 2013.34 MB/s
4096 bytes page aligned: 2013.62 MB/s
libc memcpy:
Mixed from 1 to 1023 (power law), unaligned: 641.26 MB/s
Mixed from 1 to 1023 (power law), unaligned: 641.16 MB/s
Mixed from 1 to 1023 (power law), unaligned: 640.95 MB/s
Mixed from 1 to 1023 (power law), unaligned: 641.30 MB/s
Mixed from 1 to 1023 (power law), unaligned: 640.65 MB/s
kernel memcpy (original):
Mixed from 1 to 1023 (power law), unaligned: 677.55 MB/s
Mixed from 1 to 1023 (power law), unaligned: 677.50 MB/s
Mixed from 1 to 1023 (power law), unaligned: 677.51 MB/s
Mixed from 1 to 1023 (power law), unaligned: 677.09 MB/s
Mixed from 1 to 1023 (power law), unaligned: 676.69 MB/s
kernel memcpy (optimized):
Mixed from 1 to 1023 (power law), unaligned: 660.80 MB/s
Mixed from 1 to 1023 (power law), unaligned: 660.89 MB/s
Mixed from 1 to 1023 (power law), unaligned: 660.50 MB/s
Mixed from 1 to 1023 (power law), unaligned: 660.72 MB/s
Mixed from 1 to 1023 (power law), unaligned: 661.12 MB/s
libc memset:
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1241.64 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1242.02 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1241.66 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1241.32 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1241.57 MB/s
kernel memset (original):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1603.86 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1608.36 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1605.22 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1606.88 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1606.02 MB/s
kernel memset (optimized):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1733.22 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1729.46 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1737.01 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1734.14 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1733.59 MB/s
kernel memzero (original):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1509.90 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1507.44 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1508.64 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1508.11 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1505.42 MB/s
kernel memzero (optimized):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1616.59 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1616.74 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1617.85 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1613.74 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1621.71 MB/s
libc memset:
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 742.55 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 742.68 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 742.64 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 742.52 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 742.60 MB/s
kernel memset (original):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 893.16 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 893.35 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 893.18 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 893.45 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 893.39 MB/s
kernel memset (optimized):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1028.50 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1028.49 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1028.30 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1028.37 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1028.22 MB/s
kernel memzero (original):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 839.00 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 838.75 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 839.01 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 838.93 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 838.96 MB/s
kernel memzero (optimized):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 930.07 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 930.04 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 930.11 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 930.09 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 930.08 MB/s
libc memset:
4096 bytes page aligned: 2787.64 MB/s
4096 bytes page aligned: 2788.50 MB/s
4096 bytes page aligned: 2788.44 MB/s
4096 bytes page aligned: 2788.39 MB/s
4096 bytes page aligned: 2788.18 MB/s
kernel memset (original):
4096 bytes page aligned: 4285.78 MB/s
4096 bytes page aligned: 4286.76 MB/s
4096 bytes page aligned: 4285.85 MB/s
4096 bytes page aligned: 4286.59 MB/s
4096 bytes page aligned: 4285.58 MB/s
kernel memset (optimized):
4096 bytes page aligned: 4314.98 MB/s
4096 bytes page aligned: 4314.69 MB/s
4096 bytes page aligned: 4314.15 MB/s
4096 bytes page aligned: 4314.67 MB/s
4096 bytes page aligned: 4313.65 MB/s
kernel memzero (original):
4096 bytes page aligned: 4242.90 MB/s
4096 bytes page aligned: 4241.60 MB/s
4096 bytes page aligned: 4242.77 MB/s
4096 bytes page aligned: 4241.56 MB/s
4096 bytes page aligned: 4243.05 MB/s
kernel memzero (optimized):
4096 bytes page aligned: 4265.52 MB/s
4096 bytes page aligned: 4264.31 MB/s
4096 bytes page aligned: 4265.14 MB/s
4096 bytes page aligned: 4264.22 MB/s
4096 bytes page aligned: 4265.74 MB/s
libc memset:
Mixed from 1 to 1023 (power law), unaligned: 1083.33 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1083.76 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1083.22 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1083.63 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1083.44 MB/s
kernel memset (original):
Mixed from 1 to 1023 (power law), unaligned: 1361.29 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1362.14 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1361.44 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1362.91 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1361.52 MB/s
kernel memset (optimized):
Mixed from 1 to 1023 (power law), unaligned: 1511.68 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1511.65 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1512.21 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1512.55 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1512.37 MB/s
kernel memzero (original):
Mixed from 1 to 1023 (power law), unaligned: 1259.19 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1259.69 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1260.27 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1259.07 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1260.15 MB/s
kernel memzero (optimized):
Mixed from 1 to 1023 (power law), unaligned: 1410.53 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1410.31 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1410.48 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1408.95 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1412.63 MB/s
-------------- next part --------------
libc memcpy:
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 944.18 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 943.83 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 944.12 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 943.90 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 944.20 MB/s
kernel memcpy (original):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 999.62 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 999.90 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 999.98 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 999.64 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1000.03 MB/s
kernel memcpy (optimized):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 869.93 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 870.49 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 870.24 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 870.35 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 870.49 MB/s
libc memcpy:
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 505.38 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 505.22 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 505.65 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 505.57 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 505.54 MB/s
kernel memcpy (original):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 541.06 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 541.00 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 540.94 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 541.01 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 541.03 MB/s
kernel memcpy (optimized):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 549.25 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 549.45 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 549.94 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 549.20 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 549.48 MB/s
libc memcpy:
Mixed multiples of 4 from 4 to 130, word aligned: 425.16 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 425.82 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 425.51 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 425.70 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 425.59 MB/s
kernel memcpy (original):
Mixed multiples of 4 from 4 to 130, word aligned: 458.28 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 458.62 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 459.25 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 458.18 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 459.43 MB/s
kernel memcpy (optimized):
Mixed multiples of 4 from 4 to 130, word aligned: 501.98 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 502.06 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 501.65 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 502.31 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 502.14 MB/s
kernel copy_from_user (optimized):
Mixed multiples of 4 from 4 to 130, word aligned: 484.64 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 484.08 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 483.97 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 485.09 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 485.96 MB/s
kernel copy_to_user (optimized):
Mixed multiples of 4 from 4 to 130, word aligned: 455.69 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 455.98 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 455.98 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 455.97 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 457.07 MB/s
libc memcpy:
4096 bytes page aligned: 2739.85 MB/s
4096 bytes page aligned: 2738.74 MB/s
4096 bytes page aligned: 2739.70 MB/s
4096 bytes page aligned: 2738.93 MB/s
4096 bytes page aligned: 2739.83 MB/s
kernel memcpy (original):
4096 bytes page aligned: 2770.15 MB/s
4096 bytes page aligned: 2772.07 MB/s
4096 bytes page aligned: 2771.84 MB/s
4096 bytes page aligned: 2770.57 MB/s
4096 bytes page aligned: 2771.75 MB/s
kernel memcpy (optimized):
4096 bytes page aligned: 2016.25 MB/s
4096 bytes page aligned: 2017.41 MB/s
4096 bytes page aligned: 2017.92 MB/s
4096 bytes page aligned: 2019.81 MB/s
4096 bytes page aligned: 2016.19 MB/s
kernel copy_page (original):
4096 bytes page aligned: 1537.52 MB/s
4096 bytes page aligned: 1537.46 MB/s
4096 bytes page aligned: 1536.99 MB/s
4096 bytes page aligned: 1537.60 MB/s
4096 bytes page aligned: 1536.97 MB/s
kernel copy_page (optimized):
4096 bytes page aligned: 2032.28 MB/s
4096 bytes page aligned: 2031.33 MB/s
4096 bytes page aligned: 2032.23 MB/s
4096 bytes page aligned: 2032.35 MB/s
4096 bytes page aligned: 2031.26 MB/s
libc memcpy:
Mixed from 1 to 1023 (power law), unaligned: 678.17 MB/s
Mixed from 1 to 1023 (power law), unaligned: 677.84 MB/s
Mixed from 1 to 1023 (power law), unaligned: 678.13 MB/s
Mixed from 1 to 1023 (power law), unaligned: 678.03 MB/s
Mixed from 1 to 1023 (power law), unaligned: 678.14 MB/s
kernel memcpy (original):
Mixed from 1 to 1023 (power law), unaligned: 706.55 MB/s
Mixed from 1 to 1023 (power law), unaligned: 706.16 MB/s
Mixed from 1 to 1023 (power law), unaligned: 706.71 MB/s
Mixed from 1 to 1023 (power law), unaligned: 706.09 MB/s
Mixed from 1 to 1023 (power law), unaligned: 706.90 MB/s
kernel memcpy (optimized):
Mixed from 1 to 1023 (power law), unaligned: 691.01 MB/s
Mixed from 1 to 1023 (power law), unaligned: 691.40 MB/s
Mixed from 1 to 1023 (power law), unaligned: 691.07 MB/s
Mixed from 1 to 1023 (power law), unaligned: 691.55 MB/s
Mixed from 1 to 1023 (power law), unaligned: 691.35 MB/s
libc memset:
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1279.54 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1280.04 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1279.75 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1279.82 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1279.46 MB/s
kernel memset (original):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1700.89 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1699.79 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1699.45 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1699.46 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1699.12 MB/s
kernel memset (optimized):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1859.00 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1855.05 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1857.88 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1858.97 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1855.57 MB/s
kernel memzero (original):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1603.50 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1603.51 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1602.76 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1603.89 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1604.60 MB/s
kernel memzero (optimized):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1653.52 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1652.73 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1654.63 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1652.44 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1654.76 MB/s
libc memset:
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 777.78 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 777.85 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 777.78 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 777.86 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 777.86 MB/s
kernel memset (original):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 966.31 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 966.26 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 966.17 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 966.31 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 966.12 MB/s
kernel memset (optimized):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1161.60 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1161.58 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1161.33 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1161.54 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1161.27 MB/s
kernel memzero (original):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 912.78 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 912.68 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 912.72 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 912.83 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 912.75 MB/s
kernel memzero (optimized):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 978.47 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 978.58 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 978.63 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 978.51 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 977.65 MB/s
libc memset:
4096 bytes page aligned: 2809.19 MB/s
4096 bytes page aligned: 2809.15 MB/s
4096 bytes page aligned: 2809.19 MB/s
4096 bytes page aligned: 2808.39 MB/s
4096 bytes page aligned: 2809.20 MB/s
kernel memset (original):
4096 bytes page aligned: 4286.67 MB/s
4096 bytes page aligned: 4287.73 MB/s
4096 bytes page aligned: 4287.69 MB/s
4096 bytes page aligned: 4287.50 MB/s
4096 bytes page aligned: 4287.77 MB/s
kernel memset (optimized):
4096 bytes page aligned: 4332.86 MB/s
4096 bytes page aligned: 4333.92 MB/s
4096 bytes page aligned: 4332.87 MB/s
4096 bytes page aligned: 4333.86 MB/s
4096 bytes page aligned: 4332.81 MB/s
kernel memzero (original):
4096 bytes page aligned: 4286.77 MB/s
4096 bytes page aligned: 4286.73 MB/s
4096 bytes page aligned: 4285.68 MB/s
4096 bytes page aligned: 4286.65 MB/s
4096 bytes page aligned: 4285.85 MB/s
kernel memzero (optimized):
4096 bytes page aligned: 4308.08 MB/s
4096 bytes page aligned: 4307.07 MB/s
4096 bytes page aligned: 4308.18 MB/s
4096 bytes page aligned: 4307.95 MB/s
4096 bytes page aligned: 4306.85 MB/s
libc memset:
Mixed from 1 to 1023 (power law), unaligned: 1156.13 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1156.08 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1156.25 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1156.23 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1156.31 MB/s
kernel memset (original):
Mixed from 1 to 1023 (power law), unaligned: 1491.20 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1491.11 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1491.80 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1491.44 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1491.66 MB/s
kernel memset (optimized):
Mixed from 1 to 1023 (power law), unaligned: 1690.43 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1691.03 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1693.37 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1691.31 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1691.96 MB/s
kernel memzero (original):
Mixed from 1 to 1023 (power law), unaligned: 1364.67 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1365.10 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1364.98 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1365.15 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1365.25 MB/s
kernel memzero (optimized):
Mixed from 1 to 1023 (power law), unaligned: 1475.90 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1476.30 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1476.07 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1476.49 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1476.28 MB/s
-------------- next part --------------
libc memcpy:
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 652.61 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 649.67 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 652.72 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 649.61 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 652.57 MB/s
kernel memcpy (original):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 673.87 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 677.13 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 677.32 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 677.41 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 677.17 MB/s
kernel memcpy (optimized):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 662.60 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 663.56 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 659.15 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 664.26 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 659.52 MB/s
libc memcpy:
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 364.58 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 364.71 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 362.93 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 364.58 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 363.00 MB/s
kernel memcpy (original):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 382.17 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 380.45 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 382.24 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 380.23 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 382.24 MB/s
kernel memcpy (optimized):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 424.01 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 421.91 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 423.94 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 421.65 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 423.90 MB/s
libc memcpy:
Mixed multiples of 4 from 4 to 130, word aligned: 311.50 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 312.98 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 311.42 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 312.96 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 312.97 MB/s
kernel memcpy (original):
Mixed multiples of 4 from 4 to 130, word aligned: 327.64 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 329.20 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 327.67 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 329.21 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 327.65 MB/s
kernel memcpy (optimized):
Mixed multiples of 4 from 4 to 130, word aligned: 367.15 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 365.31 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 367.18 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 367.12 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 365.37 MB/s
kernel copy_from_user (optimized):
Mixed multiples of 4 from 4 to 130, word aligned: 365.11 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 363.52 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 365.17 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 363.37 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 365.18 MB/s
kernel copy_to_user (optimized):
Mixed multiples of 4 from 4 to 130, word aligned: 368.24 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 368.29 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 368.23 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 366.48 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 368.24 MB/s
libc memcpy:
4096 bytes page aligned: 358.42 MB/s
4096 bytes page aligned: 360.12 MB/s
4096 bytes page aligned: 358.39 MB/s
4096 bytes page aligned: 360.09 MB/s
4096 bytes page aligned: 358.45 MB/s
kernel memcpy (original):
4096 bytes page aligned: 360.40 MB/s
4096 bytes page aligned: 358.72 MB/s
4096 bytes page aligned: 360.39 MB/s
4096 bytes page aligned: 358.79 MB/s
4096 bytes page aligned: 360.46 MB/s
kernel memcpy (optimized):
4096 bytes page aligned: 342.08 MB/s
4096 bytes page aligned: 343.69 MB/s
4096 bytes page aligned: 341.96 MB/s
4096 bytes page aligned: 343.70 MB/s
4096 bytes page aligned: 342.10 MB/s
kernel copy_page (original):
4096 bytes page aligned: 386.91 MB/s
4096 bytes page aligned: 385.04 MB/s
4096 bytes page aligned: 386.90 MB/s
4096 bytes page aligned: 385.13 MB/s
4096 bytes page aligned: 386.90 MB/s
kernel copy_page (optimized):
4096 bytes page aligned: 341.49 MB/s
4096 bytes page aligned: 343.25 MB/s
4096 bytes page aligned: 343.26 MB/s
4096 bytes page aligned: 343.20 MB/s
4096 bytes page aligned: 343.12 MB/s
libc memcpy:
Mixed from 1 to 1023 (power law), unaligned: 514.14 MB/s
Mixed from 1 to 1023 (power law), unaligned: 515.74 MB/s
Mixed from 1 to 1023 (power law), unaligned: 514.14 MB/s
Mixed from 1 to 1023 (power law), unaligned: 515.79 MB/s
Mixed from 1 to 1023 (power law), unaligned: 514.18 MB/s
kernel memcpy (original):
Mixed from 1 to 1023 (power law), unaligned: 540.90 MB/s
Mixed from 1 to 1023 (power law), unaligned: 537.63 MB/s
Mixed from 1 to 1023 (power law), unaligned: 539.82 MB/s
Mixed from 1 to 1023 (power law), unaligned: 540.33 MB/s
Mixed from 1 to 1023 (power law), unaligned: 537.00 MB/s
kernel memcpy (optimized):
Mixed from 1 to 1023 (power law), unaligned: 540.31 MB/s
Mixed from 1 to 1023 (power law), unaligned: 537.17 MB/s
Mixed from 1 to 1023 (power law), unaligned: 540.38 MB/s
Mixed from 1 to 1023 (power law), unaligned: 539.03 MB/s
Mixed from 1 to 1023 (power law), unaligned: 542.41 MB/s
libc memset:
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 881.70 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 881.68 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 881.56 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 877.40 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 881.52 MB/s
kernel memset (original):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 954.65 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 958.99 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 954.36 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 959.20 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 958.94 MB/s
kernel memset (optimized):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 999.30 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1004.01 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 999.36 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1004.03 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 999.32 MB/s
kernel memzero (original):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 925.38 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 925.25 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 920.83 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 925.23 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 920.99 MB/s
kernel memzero (optimized):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 933.68 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 929.32 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 933.83 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 933.73 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 933.68 MB/s
libc memset:
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 521.29 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 518.76 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 521.32 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 518.80 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 521.31 MB/s
kernel memset (original):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 588.12 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 590.97 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 591.00 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 588.13 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 590.94 MB/s
kernel memset (optimized):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 645.02 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 648.18 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 645.16 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 648.13 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 648.04 MB/s
kernel memzero (original):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 569.18 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 569.19 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 566.41 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 569.04 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 566.44 MB/s
kernel memzero (optimized):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 587.84 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 585.04 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 587.75 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 587.79 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 585.07 MB/s
libc memset:
4096 bytes page aligned: 2052.96 MB/s
4096 bytes page aligned: 2042.84 MB/s
4096 bytes page aligned: 2052.52 MB/s
4096 bytes page aligned: 2043.01 MB/s
4096 bytes page aligned: 2052.58 MB/s
kernel memset (original):
4096 bytes page aligned: 1912.63 MB/s
4096 bytes page aligned: 1922.23 MB/s
4096 bytes page aligned: 1921.84 MB/s
4096 bytes page aligned: 1912.60 MB/s
4096 bytes page aligned: 1921.86 MB/s
kernel memset (optimized):
4096 bytes page aligned: 1892.39 MB/s
4096 bytes page aligned: 1901.32 MB/s
4096 bytes page aligned: 1892.51 MB/s
4096 bytes page aligned: 1901.22 MB/s
4096 bytes page aligned: 1901.58 MB/s
kernel memzero (original):
4096 bytes page aligned: 1920.75 MB/s
4096 bytes page aligned: 1920.38 MB/s
4096 bytes page aligned: 1911.56 MB/s
4096 bytes page aligned: 1920.81 MB/s
4096 bytes page aligned: 1911.45 MB/s
kernel memzero (optimized):
4096 bytes page aligned: 1928.78 MB/s
4096 bytes page aligned: 1919.76 MB/s
4096 bytes page aligned: 1928.75 MB/s
4096 bytes page aligned: 1929.09 MB/s
4096 bytes page aligned: 1919.61 MB/s
libc memset:
Mixed from 1 to 1023 (power law), unaligned: 785.51 MB/s
Mixed from 1 to 1023 (power law), unaligned: 781.66 MB/s
Mixed from 1 to 1023 (power law), unaligned: 785.54 MB/s
Mixed from 1 to 1023 (power law), unaligned: 781.71 MB/s
Mixed from 1 to 1023 (power law), unaligned: 785.41 MB/s
kernel memset (original):
Mixed from 1 to 1023 (power law), unaligned: 816.79 MB/s
Mixed from 1 to 1023 (power law), unaligned: 820.37 MB/s
Mixed from 1 to 1023 (power law), unaligned: 820.29 MB/s
Mixed from 1 to 1023 (power law), unaligned: 817.25 MB/s
Mixed from 1 to 1023 (power law), unaligned: 820.35 MB/s
kernel memset (optimized):
Mixed from 1 to 1023 (power law), unaligned: 880.18 MB/s
Mixed from 1 to 1023 (power law), unaligned: 884.47 MB/s
Mixed from 1 to 1023 (power law), unaligned: 880.03 MB/s
Mixed from 1 to 1023 (power law), unaligned: 884.15 MB/s
Mixed from 1 to 1023 (power law), unaligned: 884.00 MB/s
kernel memzero (original):
Mixed from 1 to 1023 (power law), unaligned: 797.30 MB/s
Mixed from 1 to 1023 (power law), unaligned: 800.99 MB/s
Mixed from 1 to 1023 (power law), unaligned: 797.06 MB/s
Mixed from 1 to 1023 (power law), unaligned: 800.49 MB/s
Mixed from 1 to 1023 (power law), unaligned: 797.08 MB/s
kernel memzero (optimized):
Mixed from 1 to 1023 (power law), unaligned: 813.62 MB/s
Mixed from 1 to 1023 (power law), unaligned: 813.55 MB/s
Mixed from 1 to 1023 (power law), unaligned: 813.41 MB/s
Mixed from 1 to 1023 (power law), unaligned: 813.81 MB/s
Mixed from 1 to 1023 (power law), unaligned: 809.52 MB/s
-------------- next part --------------
libc memcpy:
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 628.06 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 623.94 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 626.71 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 623.43 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 627.13 MB/s
kernel memcpy (original):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 657.41 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 661.00 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 660.91 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 659.46 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 661.87 MB/s
kernel memcpy (optimized):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 657.37 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 661.33 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 659.10 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 662.16 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 658.66 MB/s
libc memcpy:
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 332.21 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 330.70 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 332.24 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 332.27 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 330.55 MB/s
kernel memcpy (original):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 363.62 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 361.89 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 363.65 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 361.77 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 363.54 MB/s
kernel memcpy (optimized):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 397.26 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 399.06 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 397.13 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 399.11 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 399.11 MB/s
libc memcpy:
Mixed multiples of 4 from 4 to 130, word aligned: 292.31 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 292.31 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 290.92 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 292.26 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 290.86 MB/s
kernel memcpy (original):
Mixed multiples of 4 from 4 to 130, word aligned: 311.41 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 309.88 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 311.35 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 309.86 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 311.41 MB/s
kernel memcpy (optimized):
Mixed multiples of 4 from 4 to 130, word aligned: 343.87 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 343.89 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 343.85 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 342.24 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 343.91 MB/s
kernel copy_from_user (optimized):
Mixed multiples of 4 from 4 to 130, word aligned: 336.13 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 337.70 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 336.16 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 337.76 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 336.12 MB/s
kernel copy_to_user (optimized):
Mixed multiples of 4 from 4 to 130, word aligned: 336.24 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 334.60 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 336.29 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 336.30 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 336.28 MB/s
libc memcpy:
4096 bytes page aligned: 350.93 MB/s
4096 bytes page aligned: 350.87 MB/s
4096 bytes page aligned: 350.86 MB/s
4096 bytes page aligned: 349.12 MB/s
4096 bytes page aligned: 350.82 MB/s
kernel memcpy (original):
4096 bytes page aligned: 349.41 MB/s
4096 bytes page aligned: 351.20 MB/s
4096 bytes page aligned: 349.45 MB/s
4096 bytes page aligned: 351.11 MB/s
4096 bytes page aligned: 349.44 MB/s
kernel memcpy (optimized):
4096 bytes page aligned: 335.77 MB/s
4096 bytes page aligned: 334.08 MB/s
4096 bytes page aligned: 335.69 MB/s
4096 bytes page aligned: 334.18 MB/s
4096 bytes page aligned: 335.80 MB/s
kernel copy_page (original):
4096 bytes page aligned: 376.23 MB/s
4096 bytes page aligned: 377.99 MB/s
4096 bytes page aligned: 376.22 MB/s
4096 bytes page aligned: 378.12 MB/s
4096 bytes page aligned: 376.26 MB/s
kernel copy_page (optimized):
4096 bytes page aligned: 335.23 MB/s
4096 bytes page aligned: 333.74 MB/s
4096 bytes page aligned: 335.35 MB/s
4096 bytes page aligned: 333.73 MB/s
4096 bytes page aligned: 335.24 MB/s
libc memcpy:
Mixed from 1 to 1023 (power law), unaligned: 491.15 MB/s
Mixed from 1 to 1023 (power law), unaligned: 494.03 MB/s
Mixed from 1 to 1023 (power law), unaligned: 491.42 MB/s
Mixed from 1 to 1023 (power law), unaligned: 493.73 MB/s
Mixed from 1 to 1023 (power law), unaligned: 493.67 MB/s
kernel memcpy (original):
Mixed from 1 to 1023 (power law), unaligned: 511.36 MB/s
Mixed from 1 to 1023 (power law), unaligned: 511.31 MB/s
Mixed from 1 to 1023 (power law), unaligned: 508.09 MB/s
Mixed from 1 to 1023 (power law), unaligned: 510.07 MB/s
Mixed from 1 to 1023 (power law), unaligned: 508.48 MB/s
kernel memcpy (optimized):
Mixed from 1 to 1023 (power law), unaligned: 504.81 MB/s
Mixed from 1 to 1023 (power law), unaligned: 502.20 MB/s
Mixed from 1 to 1023 (power law), unaligned: 504.56 MB/s
Mixed from 1 to 1023 (power law), unaligned: 502.11 MB/s
Mixed from 1 to 1023 (power law), unaligned: 504.76 MB/s
libc memset:
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 848.27 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 848.05 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 848.22 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 844.06 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 848.15 MB/s
kernel memset (original):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 904.37 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 908.54 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 904.19 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 908.48 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 903.71 MB/s
kernel memset (optimized):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 950.89 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 951.03 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 946.37 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 950.95 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 946.38 MB/s
kernel memzero (original):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 861.66 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 857.97 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 861.77 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 857.91 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 861.79 MB/s
kernel memzero (optimized):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 895.24 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 895.20 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 895.13 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 890.91 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 895.07 MB/s
libc memset:
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 501.37 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 503.81 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 501.35 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 503.73 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 501.30 MB/s
kernel memset (original):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 569.17 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 569.17 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 569.07 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 569.06 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 566.40 MB/s
kernel memset (optimized):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 621.23 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 618.26 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 621.15 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 618.15 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 621.22 MB/s
kernel memzero (original):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 535.10 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 537.69 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 537.67 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 535.13 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 537.73 MB/s
kernel memzero (optimized):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 566.99 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 569.74 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 567.10 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 569.83 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 567.03 MB/s
libc memset:
4096 bytes page aligned: 2041.83 MB/s
4096 bytes page aligned: 2032.34 MB/s
4096 bytes page aligned: 2042.07 MB/s
4096 bytes page aligned: 2042.09 MB/s
4096 bytes page aligned: 2031.88 MB/s
kernel memset (original):
4096 bytes page aligned: 1922.09 MB/s
4096 bytes page aligned: 1912.70 MB/s
4096 bytes page aligned: 1922.13 MB/s
4096 bytes page aligned: 1912.52 MB/s
4096 bytes page aligned: 1921.78 MB/s
kernel memset (optimized):
4096 bytes page aligned: 1913.71 MB/s
4096 bytes page aligned: 1923.03 MB/s
4096 bytes page aligned: 1913.67 MB/s
4096 bytes page aligned: 1922.56 MB/s
4096 bytes page aligned: 1923.01 MB/s
kernel memzero (original):
4096 bytes page aligned: 1888.00 MB/s
4096 bytes page aligned: 1897.21 MB/s
4096 bytes page aligned: 1887.74 MB/s
4096 bytes page aligned: 1896.99 MB/s
4096 bytes page aligned: 1887.97 MB/s
kernel memzero (optimized):
4096 bytes page aligned: 1898.35 MB/s
4096 bytes page aligned: 1888.97 MB/s
4096 bytes page aligned: 1897.97 MB/s
4096 bytes page aligned: 1889.20 MB/s
4096 bytes page aligned: 1898.33 MB/s
libc memset:
Mixed from 1 to 1023 (power law), unaligned: 735.51 MB/s
Mixed from 1 to 1023 (power law), unaligned: 732.16 MB/s
Mixed from 1 to 1023 (power law), unaligned: 735.44 MB/s
Mixed from 1 to 1023 (power law), unaligned: 731.94 MB/s
Mixed from 1 to 1023 (power law), unaligned: 735.37 MB/s
kernel memset (original):
Mixed from 1 to 1023 (power law), unaligned: 782.22 MB/s
Mixed from 1 to 1023 (power law), unaligned: 785.91 MB/s
Mixed from 1 to 1023 (power law), unaligned: 782.22 MB/s
Mixed from 1 to 1023 (power law), unaligned: 785.91 MB/s
Mixed from 1 to 1023 (power law), unaligned: 785.99 MB/s
kernel memset (optimized):
Mixed from 1 to 1023 (power law), unaligned: 818.63 MB/s
Mixed from 1 to 1023 (power law), unaligned: 818.80 MB/s
Mixed from 1 to 1023 (power law), unaligned: 815.12 MB/s
Mixed from 1 to 1023 (power law), unaligned: 818.64 MB/s
Mixed from 1 to 1023 (power law), unaligned: 814.92 MB/s
kernel memzero (original):
Mixed from 1 to 1023 (power law), unaligned: 748.04 MB/s
Mixed from 1 to 1023 (power law), unaligned: 745.01 MB/s
Mixed from 1 to 1023 (power law), unaligned: 748.67 MB/s
Mixed from 1 to 1023 (power law), unaligned: 744.85 MB/s
Mixed from 1 to 1023 (power law), unaligned: 748.90 MB/s
kernel memzero (optimized):
Mixed from 1 to 1023 (power law), unaligned: 784.81 MB/s
Mixed from 1 to 1023 (power law), unaligned: 781.09 MB/s
Mixed from 1 to 1023 (power law), unaligned: 784.40 MB/s
Mixed from 1 to 1023 (power law), unaligned: 780.62 MB/s
Mixed from 1 to 1023 (power law), unaligned: 784.59 MB/s
