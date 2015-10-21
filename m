From: dledford@redhat.com (Doug Ledford)
Date: Wed, 21 Oct 2015 16:57:17 -0400
Subject: [PATCH] RDMA/cxgb4: re-fix 32-bit build warning
In-Reply-To: <13543971.LQ3Q8CCxhL@wuerfel>
References: <13543971.LQ3Q8CCxhL@wuerfel>
Message-ID: <5627FC2D.9000402@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2015 08:10 AM, Arnd Bergmann wrote:
> Casting a pointer to __be64 produces a warning on 32-bit architectures:
> 
> drivers/infiniband/hw/cxgb4/mem.c:147:20: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>     req->wr.wr_lo = (__force __be64)&wr_wait;
> 
> This was fixed at least twice for this driver in different places,
> and accidentally reverted once more. This puts the correct version
> back in place.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 6198dd8d7a6a7 ("iw_cxgb4: 32b platform fixes")

Thanks, applied.

> 
> diff --git a/drivers/infiniband/hw/cxgb4/mem.c b/drivers/infiniband/hw/cxgb4/mem.c
> index 026b91ebd5e2..140415d31bcc 100644
> --- a/drivers/infiniband/hw/cxgb4/mem.c
> +++ b/drivers/infiniband/hw/cxgb4/mem.c
> @@ -144,7 +144,7 @@ static int _c4iw_write_mem_inline(struct c4iw_rdev *rdev, u32 addr, u32 len,
>  		if (i == (num_wqe-1)) {
>  			req->wr.wr_hi = cpu_to_be32(FW_WR_OP_V(FW_ULPTX_WR) |
>  						    FW_WR_COMPL_F);
> -			req->wr.wr_lo = (__force __be64)&wr_wait;
> +			req->wr.wr_lo = (__force __be64)(unsigned long)&wr_wait;
>  		} else
>  			req->wr.wr_hi = cpu_to_be32(FW_WR_OP_V(FW_ULPTX_WR));
>  		req->wr.wr_mid = cpu_to_be32(
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Doug Ledford <dledford@redhat.com>
              GPG KeyID: 0E572FDD


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 884 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151021/f618245f/attachment-0001.sig>
