From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Tue, 20 Mar 2018 08:51:59 -0600
Subject: [PATCH v4 4/6] infiniband: cxgb4: Eliminate duplicate barriers
 on weakly-ordered archs
In-Reply-To: <1521514068-8856-5-git-send-email-okaya@codeaurora.org>
References: <1521514068-8856-1-git-send-email-okaya@codeaurora.org>
 <1521514068-8856-5-git-send-email-okaya@codeaurora.org>
Message-ID: <20180320145159.GG19744@ziepe.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2018 at 10:47:46PM -0400, Sinan Kaya wrote:
> Code includes wmb() followed by writel(). writel() already has a barrier on
> some architectures like arm64.
> 
> This ends up CPU observing two barriers back to back before executing the
> register write.
> 
> Since code already has an explicit barrier call, changing writel() to
> writel_relaxed().
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>  drivers/infiniband/hw/cxgb4/t4.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/cxgb4/t4.h b/drivers/infiniband/hw/cxgb4/t4.h
> index 8369c7c..6e5658a 100644
> +++ b/drivers/infiniband/hw/cxgb4/t4.h
> @@ -457,7 +457,7 @@ static inline void pio_copy(u64 __iomem *dst, u64 *src)
>  	int count = 8;
>  
>  	while (count) {
> -		writeq(*src, dst);
> +		writeq_relaxed(*src, dst);
>  		src++;
>  		dst++;
>  		count--;

This is another case where writes can be re-ordered.. IIRC dst is WC
BAR memory, so the NIC should tolerate re-ordering, but Steve will
have to ack this.

Jason
