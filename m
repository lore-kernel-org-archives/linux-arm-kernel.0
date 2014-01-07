From: b.brezillon@overkiz.com (boris brezillon)
Date: Tue, 07 Jan 2014 13:05:33 +0100
Subject: ohci-at91 mismerge build error
In-Reply-To: <20240208.HaoioSGuhF@wuerfel>
References: <20240208.HaoioSGuhF@wuerfel>
Message-ID: <52CBED8D.2010402@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

On 07/01/2014 12:54, Arnd Bergmann wrote:
> After commit 99f14bd4d1 "Merge 3.13-rc5 into usb-next" (in linux-next as of
> today), I'm getting this error building any at91 kernel:
>
> drivers/usb/host/ohci-at91.c: In function 'usb_hcd_at91_probe':
> drivers/usb/host/ohci-at91.c:190:4: error: label 'err' used but not defined
>      goto err;
>      ^
> drivers/usb/host/ohci-at91.c: At top level:
> drivers/usb/host/ohci-at91.c:206:2: warning: data definition has no type or storage class [enabled by default]
>    at91_stop_hc(pdev);
>    ^
> ...
>
> The problem is obviously a mismerge between two unrelated changes that
> resulted in missing opening braces.

Thanks for fixing this: I was about to propose the same patch to resolve
the issue introduced by this merge (reported by Olof yesterday).
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Boris BREZILLON <b.brezillon@overkiz.com>
> ---
> Please just ignore if this has been reported before
>
> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
> index 2d0ee5e..091ae49 100644
> --- a/drivers/usb/host/ohci-at91.c
> +++ b/drivers/usb/host/ohci-at91.c
> @@ -197,7 +197,7 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
>   	at91_start_hc(pdev);
>   
>   	retval = usb_add_hcd(hcd, irq, IRQF_SHARED);
> -	if (retval == 0)
> +	if (retval == 0) {
>   		device_wakeup_enable(hcd->self.controller);
>   		return retval;
>   	}
>
