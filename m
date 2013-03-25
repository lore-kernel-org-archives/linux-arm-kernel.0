From: jonathan.austin@arm.com (Jonathan Austin)
Date: Mon, 25 Mar 2013 18:44:54 +0000
Subject: [PATCH 0/3] Optimise cache-flushing system call and add iovec
 variant
In-Reply-To: <1364235486-17738-1-git-send-email-will.deacon@arm.com>
References: <1364235486-17738-1-git-send-email-will.deacon@arm.com>
Message-ID: <51509B26.1050909@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 25/03/13 18:18, Will Deacon wrote:
> Hello,
>
> This patch series has been sitting on my box for some time, pending
> benchmark results and analysis.
>
> The results are that, with the first two patches in this series, we see
> ~2% improvement in browser benchmark scores, which flush the cache fairly
> regularly in response to jitting JS code.
>
> The final patch is more of an RFC, since I don't have any software that
> uses it outside of my toy programs.
>
> All feedback welcome,
>

For all three patches
Tested-by: Jonathan Austin <Jonathan.Austin@arm.com>

The last one was tested with a modified jit that was hacked to use the 
new API as a direct replacement for the old one (IE no cleverness with 
delayed flushing/grouping of calls). The performance decrease from using 
the new call instead of the old one was well within the noise of the 
tests. We are, however, yet to test the improvement from actually 
*exploiting* the new mechanism. If there's a positive response to the 
idea then I can encourage the jit guys to have another look.

Jonny

> Will
>
>
> Will Deacon (3):
>    ARM: cacheflush: don't round address range up to nearest page
>    ARM: cacheflush: don't bother rounding to nearest vma
>    ARM: cacheflush: add new iovec-based cache flushing system call
>
>   arch/arm/include/asm/cacheflush.h  |  3 +--
>   arch/arm/include/uapi/asm/unistd.h |  1 +
>   arch/arm/kernel/traps.c            | 49 +++++++++++++++++++++++++++-----------
>   3 files changed, 37 insertions(+), 16 deletions(-)
>
