From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Thu, 31 Jul 2014 08:24:15 +0200
Subject: Bad Page dump (help)
In-Reply-To: <20140729190700.GN17808@saruman.home>
References: <20140729190700.GN17808@saruman.home>
Message-ID: <53D9E10F.6040408@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/29/2014 09:07 PM, Felipe Balbi wrote:
> Hi Russell,
> 
> I'm bringing up a new board on today's linux-next but I'm having a bunch
> of bad_page() calls due to _mapcount not being zero (full logs
> attached). What could cause that ? Any hints on how to debug ? It's as
> if page_mapcount_reset() wasn't called for the pages which are causing
> issues.

FWIW, the same issue appeared on a Cogent CSB637 board (the last board 
I use not using DT) in between 3.13 and 3.14. I ran a bisect and found 
that reverting the following commit:

commit 84f452b1e8fc73ac0e31254c66e3e2260ce5263d
Author: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date:   Sun Jun 30 00:28:46 2013 -0400

    ARM: mm: Remove bootmem code and switch to NO_BOOTMEM
    
    Now with dma_mask series merged and max*pfn has consistent meaning on ARM
    as rest of the arch's thanks to RMK's mega series, lets switch ARM code
    to NO_BOOTMEM. With NO_BOOTMEM change, now we use memblock allocator to
    reserve space for crash kernel to have one less dependency with nobootmem
    allocator wrapper.
    
    Tested with both flat memory and sparse (faked) memory models with highmem
    enabled.

Seemed to make the issue disappear. I later found out that changing the
kernel options also made the issue disappear.

- -- 
                                                                Gilles.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iD8DBQFT2eEOGpcgE6m/fboRAkFaAJ9HjiqSweTu2cW7wkzotqTN3fMtFQCggbW6
N7GIG1/5qSRjl6fRo3FM2fk=
=2g0q
-----END PGP SIGNATURE-----
