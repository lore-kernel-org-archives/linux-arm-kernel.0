From: katsuki.uwatoko@toshiba.co.jp (katsuki.uwatoko at toshiba.co.jp)
Date: Wed, 12 Aug 2015 00:56:25 +0000
Subject: PROBLEM: XFS on ARM corruption 'Structure needs cleaning'
In-Reply-To: <20150612225209.GA20262@dastard>
References: <5579B804.9050707@skylable.com>
 <20150612122108.GB60661@bfoster.bfoster> <557AD4D4.3010901@skylable.com>
 <20150612225209.GA20262@dastard>
Message-ID: <C6D0D499B56584katsuki.uwatoko@toshiba.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 13 Jun 2015 08:52:09 +1000, Dave Chinner wrote:

> Yup, that's looking like a toolchain bug. Thread about arm directory
> read corruption:

I think that this is not a toolchain bug, this is related to 
Subject: [PATCH v2 1/1] ARM : missing corrupted reg in __do_div_asm
http://www.spinics.net/lists/arm-kernel/msg426684.html

--

The problematic line in xfs is: 
irecs->br_startblock = XFS_DADDR_TO_FSB(mp, mappedbno)
in xfs_dabuf_map()/fs/xfs/xfs_da_btree.c.

The expansion of it is: 

  ld = mappedbno >> mp->m_blkbb_log;
  do_div(ld, mp->m_sb.sb_agblocks);
  startblock = ld << mp->m_sb.sb_agblklog;
  ld = mappedbno >> mp->m_blkbb_log;
  startblock |= do_div(ld, mp->m_sb.sb_agblocks);
  irecs->br_startblock = startblock;

The assembler of these are:

:
	bl	__do_div64
	ldr	r1, [sp, #44]
	subs	r3, r7, #32
	orr	r1, r1, r2, lsr r5
	add	r5, sp, #80
	str	r5, [sp, #64]
	ldr	r5, [sp, #60]
	movpl	r1, r2, asl r3
	mov	r2, r2, asl r7
	str	r2, [sp, #40]
	str	r1, [sp, #44]
	mov	r1, r9
	str	r5, [sp, #96]
	mov	r7, #0
	ldr	r2, [sp, #96]
	mov	r5, #1
	ldr	fp, [sp, #64]
	str	r7, [sp, #84]
	mov	r9, r2, asr #31
	str	r7, [sp, #104]
	bl	__do_div64
:

by GCC 4.7.2 with -O2 option.

Because a result of do_div is stored in the 1st arg (r0),
r0, which is "ld" in the C,  must be reloaded after the 1st call of do_div, before the 2nd call of do_div.
But it is not reloaded in the above assembler.
The problem is macro __do_div_asm, as the patch describes.

I confirmed that the patch fixed this problem.

	mov	r1, sl
	str	r2, [sp, #56]
	mov	r0, fp
	bl	__do_div64
	ldr	ip, [sp, #36]
	rsb	r6, r5, #32
	subs	r3, r5, #32
	ldr	r1, [sp, #56]
	orr	ip, ip, r2, lsr r6
	str	r7, [sp, #96]
	mov	r6, #1
	str	r8, [sp, #80]
	mov	r0, ip
	str	r1, [sp, #52]
	movpl	r0, r2, asl r3
	mov	r2, r2, asl r5
	str	r0, [sp, #36]
	mov	r1, sl
	str	r2, [sp, #32]
	mov	r0, fp
	bl	__do_div64

by GCC 4.7.2 with -O2 option and the patch.

Thank you,
-- 
UWATOKO
