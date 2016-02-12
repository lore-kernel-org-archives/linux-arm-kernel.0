From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 12 Feb 2016 18:11:02 +0000
Subject: [PATCH 2/2] arm64: Mark kernel page ranges contiguous
In-Reply-To: <56BE1FE5.8080002@arm.com>
References: <1455293208-6763-1-git-send-email-jeremy.linton@arm.com>
 <1455293208-6763-3-git-send-email-jeremy.linton@arm.com>
 <20160212165707.GB20262@leverpostej> <56BE17C9.6090608@arm.com>
 <20160212175857.GE20262@leverpostej> <56BE1FE5.8080002@arm.com>
Message-ID: <20160212181102.GF20262@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 12, 2016 at 12:09:41PM -0600, Jeremy Linton wrote:
> On 02/12/2016 11:58 AM, Mark Rutland wrote:
> 
> (trimming)
> 
> >All create_mapping_late() calls should be performed with the same
> >physical/virtual start/end as earlier "chunk" mappings, and thus should
> >never result in a fuse/split or translation change -- only permission
> >changes (which we believe do not result in TLB conflicts, or we'd need
> >to do far more work to fix those up).
> >
> >If we split/fuse in any case other than EFI runtime table creation, that
> >is a bug that we need to fix. If you're seeing a case we do that, then
> >please let me know!
> 
> We are saying the same thing, and right now the biggest violator is
> probably the .rodata patch I just posted!

Ok, phew!

The simple fix is to make .text and .rodata separate "chunks", then it
all falls out in the wash.

Mark.
