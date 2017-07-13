From: stockhausen@collogia.de (Markus Stockhausen)
Date: Thu, 13 Jul 2017 17:51:19 +0000
Subject: AW: [PATCH 1/2] md/raid6: use faster multiplication for ARM NEON
 delta syndrome
In-Reply-To: <20170713171601.25440-2-ard.biesheuvel@linaro.org>
References: <20170713171601.25440-1-ard.biesheuvel@linaro.org>,
 <20170713171601.25440-2-ard.biesheuvel@linaro.org>
Message-ID: <12EF8D94C6F8734FB2FF37B9FBEDD173010E029C61@EXCHANGE.collogia.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Von: Ard Biesheuvel [ard.biesheuvel at linaro.org]
> Gesendet: Donnerstag, 13. Juli 2017 19:16
> An: linux-arm-kernel at lists.infradead.org; linux-raid at vger.kernel.org
> Cc: shli at kernel.org; Markus Stockhausen; linux at armlinux.org.uk; will.deacon at arm.com; catalin.marinas at arm.com; Ard Biesheuvel
> Betreff: [PATCH 1/2] md/raid6: use faster multiplication for ARM NEON delta syndrome
> 
> The P/Q left side optimization in the delta syndrome simply involves
> repeatedly multiplying a value by polynomial 'x' in GF(2^8). Given
> that 'x * x * x * x' equals 'x^4' even in the polynomial world, we
> can accelerate this substantially by performing up to 4 such operations
> at once, using the NEON instructions for polynomial multiplication.
> 
> Results on a Cortex-A57 running in 64-bit mode:
> 
>   Before:
>   -------
>   raid6: neonx1   xor()  1680 MB/s
>   raid6: neonx2   xor()  2286 MB/s
>   raid6: neonx4   xor()  3162 MB/s
>   raid6: neonx8   xor()  3389 MB/s
> 
>   After:
>   ------
>   raid6: neonx1   xor()  2281 MB/s
>   raid6: neonx2   xor()  3362 MB/s
>   raid6: neonx4   xor()  3787 MB/s
>   raid6: neonx8   xor()  4239 MB/s

Nice optimiziation. Nevertheless the test algorithm favours this implementation. See:

int start = (disks>>1)-1, stop = disks-3; /* work on the second half of the disks */

What gives the before/after test if you work on the middle data disks and not on 
the right ones? In the 4K page size this should be  start = 3, stop = 11 instead of
start = 7, stop = 13. Given the large gain you see the impact should be lower but 
at least in the >10% range. 

Markus
 
> While we're at it, simplify MASK() by using a signed shift rather than
> a vector compare involving a temp register.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ...
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: InterScan_Disclaimer.txt
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170713/e6453487/attachment.txt>
