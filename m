From: balbi@ti.com (Felipe Balbi)
Date: Thu, 31 Jul 2014 08:43:44 -0500
Subject: Bad Page dump (help)
In-Reply-To: <53D9E10F.6040408@xenomai.org>
References: <20140729190700.GN17808@saruman.home>
 <53D9E10F.6040408@xenomai.org>
Message-ID: <20140731134344.GA19512@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 31, 2014 at 08:24:15AM +0200, Gilles Chanteperdrix wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 07/29/2014 09:07 PM, Felipe Balbi wrote:
> > Hi Russell,
> > 
> > I'm bringing up a new board on today's linux-next but I'm having a bunch
> > of bad_page() calls due to _mapcount not being zero (full logs
> > attached). What could cause that ? Any hints on how to debug ? It's as
> > if page_mapcount_reset() wasn't called for the pages which are causing
> > issues.
> 
> FWIW, the same issue appeared on a Cogent CSB637 board (the last board 
> I use not using DT) in between 3.13 and 3.14. I ran a bisect and found 
> that reverting the following commit:
> 
> commit 84f452b1e8fc73ac0e31254c66e3e2260ce5263d
> Author: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Date:   Sun Jun 30 00:28:46 2013 -0400
> 
>     ARM: mm: Remove bootmem code and switch to NO_BOOTMEM
>     
>     Now with dma_mask series merged and max*pfn has consistent meaning on ARM
>     as rest of the arch's thanks to RMK's mega series, lets switch ARM code
>     to NO_BOOTMEM. With NO_BOOTMEM change, now we use memblock allocator to
>     reserve space for crash kernel to have one less dependency with nobootmem
>     allocator wrapper.
>     
>     Tested with both flat memory and sparse (faked) memory models with highmem
>     enabled.

Thanks I'll give this a shot.

> Seemed to make the issue disappear. I later found out that changing the
> kernel options also made the issue disappear.

which kernel options did you change ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140731/53edcf6c/attachment.sig>
