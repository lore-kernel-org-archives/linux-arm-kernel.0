From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Dec 2015 17:13:40 +0100
Subject: [PATCH] null_blk: use sector_div instead of do_div
In-Reply-To: <56596064.2070306@bjorling.me>
References: <3768541.ja0r6f0Odi@wuerfel> <4449032.oPBtpzlXyB@wuerfel>
 <56596064.2070306@bjorling.me>
Message-ID: <5665391.6n2Zq774pT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 28 November 2015 09:05:56 Matias Bj?rling wrote:
> 
> I had my head around the original code and kept references to the device 
> layout I had in mind. 256 being number of pages in a block, and the 2^16 
> being number of blocks in a lun and wanted to communicate that part.. 
> which led to producing silly code in the mean time.
> 
> Similarly, the bs is always fixed to 4k for lightnvm, until other bs 
> sizes are supported. We could optimize it out, I left it in for the same 
> reasons.

I still see the build warning in linux-next, can you merge your patch?

	Arnd

> diff --git i/drivers/block/null_blk.c w/drivers/block/null_blk.c
> index 5c8ba54..97c02fe 100644
> --- i/drivers/block/null_blk.c
> +++ w/drivers/block/null_blk.c
> @@ -510,17 +510,17 @@ static int null_lnvm_id(struct request_queue *q, 
> struct nvm_id *id)
>         id->ppaf.ch_offset = 56;
>         id->ppaf.ch_len = 8;
> 
> -       do_div(size, bs); /* convert size to pages */
> -       do_div(size, 256); /* concert size to pgs pr blk */
> +       sector_div(size, bs); /* convert size to pages */
> +       size >>= 8; /* convert size to pgs pr blk */
>         grp = &id->groups[0];
>         grp->mtype = 0;
>         grp->fmtype = 0;
>         grp->num_ch = 1;
>         grp->num_pg = 256;
>         blksize = size;
> -       do_div(size, (1 << 16));
> +       size >>= 16; /* convert size to num luns */
>         grp->num_lun = size + 1;
> -       do_div(blksize, grp->num_lun);
> +       sector_div(blksize, grp->num_lun);
>         grp->num_blk = blksize;
>         grp->num_pln = 1;
> 
> 
