From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Wed, 18 Sep 2013 19:03:34 +0200
Subject: [PATCH usb 2/2] usb: musb: Call atomic_notifier_call_chain when
 status is changed
In-Reply-To: <20130918164816.GN21559@radagast>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <201309181843.49850@pali> <20130918164816.GN21559@radagast>
Message-ID: <201309181903.34696@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

More power supply drivers depends on vbus events and without it they not
working. Power supply drivers using usb_register_notifier, so to deliver
events it is needed to call atomic_notifier_call_chain.

So without atomic notifier power supply driver isp1704 not retrieving
vbus status and reporting bogus values to userspace and also to board
platform data functions. Without proper data charger drivers trying to
charge battery also when charger is disconnected or do not start charging
when wallcharger connects.

Atomic notifier in musb driver was used before v3.5 and was replaced with
omap mailbox. This patch adding atomic_notifier_call_chain call from
function omap_musb_set_mailbox.

Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index f44e8b5..5c40252 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -305,6 +305,9 @@ static void omap_musb_set_mailbox(struct omap2430_glue *glue)
 	default:
 		dev_dbg(dev, "ID float\n");
 	}
+
+	atomic_notifier_call_chain(&musb->xceiv->notifier,
+			musb->xceiv->last_event, NULL);
 }
 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130918/1407c00d/attachment.sig>
