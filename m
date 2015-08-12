From: david@fromorbit.com (Dave Chinner)
Date: Wed, 12 Aug 2015 13:14:07 +1000
Subject: PROBLEM: XFS on ARM corruption 'Structure needs cleaning'
In-Reply-To: <C6D0D499B56584katsuki.uwatoko@toshiba.co.jp>
References: <5579B804.9050707@skylable.com>
 <20150612122108.GB60661@bfoster.bfoster>
 <557AD4D4.3010901@skylable.com> <20150612225209.GA20262@dastard>
 <C6D0D499B56584katsuki.uwatoko@toshiba.co.jp>
Message-ID: <20150812031407.GB20596@dastard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 12:56:25AM +0000, katsuki.uwatoko at toshiba.co.jp wrote:
> On Sat, 13 Jun 2015 08:52:09 +1000, Dave Chinner wrote:
> 
> > Yup, that's looking like a toolchain bug. Thread about arm directory
> > read corruption:
> 
> I think that this is not a toolchain bug, this is related to 
> Subject: [PATCH v2 1/1] ARM : missing corrupted reg in __do_div_asm
> http://www.spinics.net/lists/arm-kernel/msg426684.html

Interesting! Very good work finding that bug, Katsuki-san. 

FWIW, I suspect this fix will need to go back into stable kernels,
too.

> --
> 
> The problematic line in xfs is: 
> irecs->br_startblock = XFS_DADDR_TO_FSB(mp, mappedbno)
> in xfs_dabuf_map()/fs/xfs/xfs_da_btree.c.
> 
> The expansion of it is: 
> 
>   ld = mappedbno >> mp->m_blkbb_log;
>   do_div(ld, mp->m_sb.sb_agblocks);
>   startblock = ld << mp->m_sb.sb_agblklog;
>   ld = mappedbno >> mp->m_blkbb_log;
>   startblock |= do_div(ld, mp->m_sb.sb_agblocks);
>   irecs->br_startblock = startblock;
> 
> The assembler of these are:
> 
> :
> 	bl	__do_div64
> 	ldr	r1, [sp, #44]
> 	subs	r3, r7, #32
> 	orr	r1, r1, r2, lsr r5
> 	add	r5, sp, #80
> 	str	r5, [sp, #64]
> 	ldr	r5, [sp, #60]
> 	movpl	r1, r2, asl r3
> 	mov	r2, r2, asl r7
> 	str	r2, [sp, #40]
> 	str	r1, [sp, #44]
> 	mov	r1, r9
> 	str	r5, [sp, #96]
> 	mov	r7, #0
> 	ldr	r2, [sp, #96]
> 	mov	r5, #1
> 	ldr	fp, [sp, #64]
> 	str	r7, [sp, #84]
> 	mov	r9, r2, asr #31
> 	str	r7, [sp, #104]
> 	bl	__do_div64
> :
> 
> by GCC 4.7.2 with -O2 option.

To close the loop, what code do the other versions GCC produce for
this macro?  Evidence so far says that the result depends on the
compiler version, so I would like to have confirmation that other
versions of the compiler generate working code.  There are other
XFS_DADDR_TO_FSB() calls in the XFS code, too - do they demonstrate
the same problem, maybe with different compiler versions?

Basically I'm asking what is the scope of the problem you've found?
i.e. when was the bug introduced, what compilers expose it, etc
so that when ARM users report XFS corruptions we have some idea of
whether their kernel/compiler combination might have caused the
issue they are seeing...

Cheers,

Dave.
-- 
Dave Chinner
david at fromorbit.com
