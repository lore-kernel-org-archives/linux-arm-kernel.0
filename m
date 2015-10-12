From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 12 Oct 2015 18:08:19 +0100
Subject: HANG at bootup on 3.10 kernel at memset in early_alloc_aligned
 with CMA
In-Reply-To: <1773685879.894081444667895180.JavaMail.weblogic@epmlwas09a>
References: <1773685879.894081444667895180.JavaMail.weblogic@epmlwas09a>
Message-ID: <20151012170818.GA3659@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 12, 2015 at 04:38:15PM +0000, VIKAS SAJJAN C wrote:
> Hi,

Hi,

>  we are recently migrating to 3.10 kernel on a 32bit SoC, I see that
>  while boot up, the kernel HANGS in function early_alloc_aligned() at
>  memset(ptr, 0, sz);
> 
> we are reserving memory using CMA 
> 
> 
> we have 4 banks :
> 
> bank 1 : 0x200000000,  size 0x10000000
> 
> bank 2 : 0x300000000,  size 0x10000000
> 
> bank 3 : 0x400000000,  size 0x10000000
> 
> bank 4 : 0x500000000,  size 0x0f500000

As this isn't 2M-aligned, this certainly could be the same issue.

> arm_lowmem_limit is set to 0x4f000000 and mapping is created for
> section: 20000000 ~ 4f000000
> 
>  I came across your patch "ARM: 8356/1: mm: handle non-pmd-aligned end
>  of RAM"
> 
> Was wondering whether patch is back ported to 3.10 stable branch, if
> so can you point me to the patch?

To the best of my knowledge, it was not. If you haven't seen it in the
v3.10.x commit logs, it presumably wasn't.

> if not, can you let us know the changes needed for 3.10  kernel.

I do not know. Have you tried backporting the patch?

I believe that you will also need to backport commit 3de1f52a3ae82326
("ARM: 8394/1: update memblock limit after mapping lowmem"). See [1,2].

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/353496.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/353602.html
