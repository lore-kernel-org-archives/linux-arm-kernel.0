From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Tue, 28 Aug 2012 11:29:35 +0300
Subject: [PATCH v2 04/11] USB: chipidea: clear gadget struct at udc_start
 fail path
In-Reply-To: <1346137397-32374-5-git-send-email-richard.zhao@freescale.com>
References: <1346137397-32374-1-git-send-email-richard.zhao@freescale.com>
 <1346137397-32374-5-git-send-email-richard.zhao@freescale.com>
Message-ID: <87oblv2zdc.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Richard Zhao <richard.zhao@freescale.com> writes:

> States in gadget are not needed any more, set it to zero.

It's generally a good practice to mention in the commit message what is
it that you are fixing with this patch.

> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> ---
>  drivers/usb/chipidea/udc.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
> index c7a032a..9fb6394 100644
> --- a/drivers/usb/chipidea/udc.c
> +++ b/drivers/usb/chipidea/udc.c
> @@ -1746,6 +1746,7 @@ free_pools:
>  	dma_pool_destroy(ci->td_pool);
>  free_qh_pool:
>  	dma_pool_destroy(ci->qh_pool);
> +	memset(&ci->gadget, 0, sizeof(ci->gadget));

I understand that you're probably hitting "kobject already initialized"
warning here, but I think the real problem is that this function gets
called twice and fails the first time. Why does that happen?

In any case, please elaborate on the problem.

Regards,
--
Alex
