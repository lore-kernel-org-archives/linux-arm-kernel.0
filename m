From: balbi@ti.com (Felipe Balbi)
Date: Tue, 17 Sep 2013 10:48:59 -0500
Subject: [PATCH 1/4] usb: musb: Call atomic_notifier_call_chain when
 status is changed
In-Reply-To: <1378630239-10006-2-git-send-email-pali.rohar@gmail.com>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <1378630239-10006-2-git-send-email-pali.rohar@gmail.com>
Message-ID: <20130917154859.GK15645@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 08, 2013 at 10:50:36AM +0200, Pali Roh?r wrote:
> More power supply drivers depends on vbus events and without it they not
> working. Power supply drivers using usb_register_notifier, so to deliver
> events it is needed to call atomic_notifier_call_chain.
> 
> So without atomic notifier power supply driver isp1704 not retrieving
> vbus status and reporting bogus values to userspace and also to board
> platform data functions. Without proper data charger drivers trying to
> charge battery also when charger is disconnected or do not start charging
> when wallcharger connects.
> 
> Atomic notifier in musb driver was used before v3.5 and was replaced with
> omap mailbox. This patch adding atomic_notifier_call_chain call from
> function omap_musb_set_mailbox.
> 
> Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
> ---
>  drivers/usb/musb/omap2430.c       |    3 +++
>  drivers/usb/phy/phy-twl4030-usb.c |    2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index f44e8b5..5c40252 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -305,6 +305,9 @@ static void omap_musb_set_mailbox(struct omap2430_glue *glue)
>  	default:
>  		dev_dbg(dev, "ID float\n");
>  	}
> +
> +	atomic_notifier_call_chain(&musb->xceiv->notifier,
> +			musb->xceiv->last_event, NULL);

let's add a wrapper for this:

static inline int usb_phy_notify(struct usb phy *x, unsigned val, void *v)
{
	return atomic_notifier_call_chain(&x->notifier, val, v);
}

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130917/df17f742/attachment-0001.sig>
