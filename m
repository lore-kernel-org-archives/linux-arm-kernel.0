From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 06 Nov 2014 20:55:35 +0100
Subject: [PATCH] usb: gadget: udc: pxa27x: fix build warning when !OF
In-Reply-To: <545B196F.2020303@zonque.org> (Daniel Mack's message of "Thu, 06
 Nov 2014 07:47:11 +0100")
References: <1415249759-6219-1-git-send-email-balbi@ti.com>
 <545B196F.2020303@zonque.org>
Message-ID: <87ppd0xfwo.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack <daniel@zonque.org> writes:

> On 11/06/2014 05:55 AM, Felipe Balbi wrote:
>> in case kernel is built without CONFIG_OF there
>> will be a build warning (see below) due to of_match_ptr()
>> being defined to NULL.
>> 
>> Because of_match_ptr() is pretty pointless anyway,
>> let's just remove it and fix the warning.
>
> The alternative, of course, would be to wrap the udc_pxa_dt_ids
> declaration in IS_ENABLED(CONFIG_OF), but I'm not sure whether it's
> worth it.

Ah, wasn't the patch named "[PATCH v1] usb: gadget: pxa27x_udc: fix warning in
non device-tree build" sent October the 29th fixing this issue (in [1]) ?

Cheers.

--
Robert

[1] Patch
From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v1] usb: gadget: pxa27x_udc: fix warning in non device-tree build
To: Felipe Balbi <balbi@ti.com>
Cc: linux-usb at vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>
Date: Wed, 29 Oct 2014 21:58:33 +0100 (1 week, 22 hours, 56 minutes ago)
Message-Id: <1414616313-8212-1-git-send-email-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.1.0

The recent change bringing device-tree support triggers a warning in a
non device-tree build :
  drivers/usb/gadget/udc/pxa27x_udc.c:2405:28: warning: 'udc_pxa_dt_ids'
  defined but not used [-Wunused-variable]

Fix the warning with a preprocessor condition.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/usb/gadget/udc/pxa27x_udc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/udc/pxa27x_udc.c b/drivers/usb/gadget/udc/pxa27x_udc.c
index 69e7b816..9b03fab 100644
--- a/drivers/usb/gadget/udc/pxa27x_udc.c
+++ b/drivers/usb/gadget/udc/pxa27x_udc.c
@@ -2400,11 +2400,13 @@ static struct pxa_udc memory = {
 	}
 };
 
+#if defined(CONFIG_OF)
 static struct of_device_id udc_pxa_dt_ids[] = {
 	{ .compatible = "marvell,pxa270-udc" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, udc_pxa_dt_ids);
+#endif
 
 /**
  * pxa_udc_probe - probes the udc device
-- 
2.1.0
