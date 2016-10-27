From: eric@anholt.net (Eric Anholt)
Date: Wed, 26 Oct 2016 17:57:24 -0700
Subject: [PATCH v2] staging: vc04_services: Replace dmac_map_area with
 dmac_map_sg
In-Reply-To: <20161026022327.19055-1-mzoran@crowfest.net>
References: <20161026022327.19055-1-mzoran@crowfest.net>
Message-ID: <87pommwqvf.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Zoran <mzoran@crowfest.net> writes:

> The original arm implementation uses dmac_map_area which is not
> portable.  Replace it with an architecture neutral version
> which uses dma_map_sg.
>
> As you can see that for larger page sizes, the dma_map_sg
> implementation is faster then the original unportable dma_map_area
> implementation.
>
> Test                       dmac_map_area   dma_map_page dma_map_sg
> vchiq_test -b 4 10000      51us/iter       76us/iter    76us
> vchiq_test -b 8 10000      70us/iter       82us/iter    91us
> vchiq_test -b 16 10000     94us/iter       118us/iter   121us
> vchiq_test -b 32 10000     146us/iter      173us/iter   187us
> vchiq_test -b 64 10000     263us/iter      328us/iter   299us
> vchiq_test -b 128 10000    529us/iter      631us/iter   595us
> vchiq_test -b 256 10000    2285us/iter     2275us/iter  2001us
> vchiq_test -b 512 10000    4372us/iter     4616us/iter  4123us

Reviewed-by: Eric Anholt <eric@anholt.net>

Nice work!  More portability and better performance at the same time.

A possible future improvement would be to track the pagelist, num_pages,
and pagelist_size in a struct in the bulk->remote_data so we didn't need
to recalculate them at free time.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161026/a859dc35/attachment.sig>
