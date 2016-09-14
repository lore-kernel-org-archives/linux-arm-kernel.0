From: hzpeterchen@gmail.com (Peter Chen)
Date: Wed, 14 Sep 2016 14:15:35 +0800
Subject: [PATCH/REBASED] usb: chipidea: Properly mark little endian
 descriptors
In-Reply-To: <20160914055302.1132-1-stephen.boyd@linaro.org>
References: <20160914025045.GD30760@b29397-desktop>
 <20160914055302.1132-1-stephen.boyd@linaro.org>
Message-ID: <20160914061534.GF30760@b29397-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 13, 2016 at 10:53:02PM -0700, Stephen Boyd wrote:
> The DMA descriptors are little endian, and we do a pretty good
> job of handling them with the proper le32_to_cpu() markings, but
> we don't actually mark them as __le32. This means checkers like
> sparse can't easily find new bugs. Let's mark the members of
> structures properly and fix the few places where we're missing
> conversions.
> 
> Cc: Peter Chen <peter.chen@nxp.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
> 
> Peter Chen wrote:
> >
> > I am afraid I can't apply for testing
> > 
> > Applying: usb: chipidea: Properly mark little endian descriptors
> > fatal: sha1 information is lacking or useless
> > (drivers/usb/chipidea/udc.c).
> > error: could not build fake ancestor
> > Patch failed at 0001 usb: chipidea: Properly mark little endian
> > descriptors
> > The copy of the patch that failed is found in: .git/rebase-apply/patch
> > When you have resolved this problem, run "git am --continue".
> > If you prefer to skip this patch, run "git am --skip" instead.
> > To restore the original branch and stop patching, run "git am --abort".
> > 
> > Would you please rebase my ci-for-usb-next branch?
> 
> Sure no problem. Maybe you shouldn't specify a 3 way merge so that
> it attempts to apply without building a fake ancestor? Anyway, here
> it is.

I tried w/o 3 ways merge, the new one can be applied.

Peter

> 
>  drivers/usb/chipidea/udc.c |  6 +++---
>  drivers/usb/chipidea/udc.h | 12 ++++++------
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
> index 661f43fe0f9e..a9b07befd398 100644
> --- a/drivers/usb/chipidea/udc.c
> +++ b/drivers/usb/chipidea/udc.c
> @@ -365,7 +365,7 @@ static int add_td_to_list(struct ci_hw_ep *hwep, struct ci_hw_req *hwreq,
>  		if (hwreq->req.length == 0
>  				|| hwreq->req.length % hwep->ep.maxpacket)
>  			mul++;
> -		node->ptr->token |= mul << __ffs(TD_MULTO);
> +		node->ptr->token |= cpu_to_le32(mul << __ffs(TD_MULTO));
>  	}
>  
>  	temp = (u32) (hwreq->req.dma + hwreq->req.actual);
> @@ -504,7 +504,7 @@ static int _hardware_enqueue(struct ci_hw_ep *hwep, struct ci_hw_req *hwreq)
>  		if (hwreq->req.length == 0
>  				|| hwreq->req.length % hwep->ep.maxpacket)
>  			mul++;
> -		hwep->qh.ptr->cap |= mul << __ffs(QH_MULT);
> +		hwep->qh.ptr->cap |= cpu_to_le32(mul << __ffs(QH_MULT));
>  	}
>  
>  	ret = hw_ep_prime(ci, hwep->num, hwep->dir,
> @@ -529,7 +529,7 @@ static void free_pending_td(struct ci_hw_ep *hwep)
>  static int reprime_dtd(struct ci_hdrc *ci, struct ci_hw_ep *hwep,
>  					   struct td_node *node)
>  {
> -	hwep->qh.ptr->td.next = node->dma;
> +	hwep->qh.ptr->td.next = cpu_to_le32(node->dma);
>  	hwep->qh.ptr->td.token &=
>  		cpu_to_le32(~(TD_STATUS_HALTED | TD_STATUS_ACTIVE));
>  
> diff --git a/drivers/usb/chipidea/udc.h b/drivers/usb/chipidea/udc.h
> index e66df0020bd4..2ecd1174d66c 100644
> --- a/drivers/usb/chipidea/udc.h
> +++ b/drivers/usb/chipidea/udc.h
> @@ -22,11 +22,11 @@
>  /* DMA layout of transfer descriptors */
>  struct ci_hw_td {
>  	/* 0 */
> -	u32 next;
> +	__le32 next;
>  #define TD_TERMINATE          BIT(0)
>  #define TD_ADDR_MASK          (0xFFFFFFEUL << 5)
>  	/* 1 */
> -	u32 token;
> +	__le32 token;
>  #define TD_STATUS             (0x00FFUL <<  0)
>  #define TD_STATUS_TR_ERR      BIT(3)
>  #define TD_STATUS_DT_ERR      BIT(5)
> @@ -36,7 +36,7 @@ struct ci_hw_td {
>  #define TD_IOC                BIT(15)
>  #define TD_TOTAL_BYTES        (0x7FFFUL << 16)
>  	/* 2 */
> -	u32 page[5];
> +	__le32 page[5];
>  #define TD_CURR_OFFSET        (0x0FFFUL <<  0)
>  #define TD_FRAME_NUM          (0x07FFUL <<  0)
>  #define TD_RESERVED_MASK      (0x0FFFUL <<  0)
> @@ -45,18 +45,18 @@ struct ci_hw_td {
>  /* DMA layout of queue heads */
>  struct ci_hw_qh {
>  	/* 0 */
> -	u32 cap;
> +	__le32 cap;
>  #define QH_IOS                BIT(15)
>  #define QH_MAX_PKT            (0x07FFUL << 16)
>  #define QH_ZLT                BIT(29)
>  #define QH_MULT               (0x0003UL << 30)
>  #define QH_ISO_MULT(x)		((x >> 11) & 0x03)
>  	/* 1 */
> -	u32 curr;
> +	__le32 curr;
>  	/* 2 - 8 */
>  	struct ci_hw_td		td;
>  	/* 9 */
> -	u32 RESERVED;
> +	__le32 RESERVED;
>  	struct usb_ctrlrequest   setup;
>  } __attribute__ ((packed, aligned(4)));
>  
> -- 
> 2.9.0.rc2.8.ga28705d
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 

Best Regards,
Peter Chen
