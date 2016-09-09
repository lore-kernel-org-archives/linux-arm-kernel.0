From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Thu, 8 Sep 2016 21:30:12 -0700
Subject: [PATCH v2 01/17] rpmsg: Enable matching devices with drivers
 based on DT
In-Reply-To: <eaf4753b0be45873adf29f04cb315e02@codeaurora.org>
References: <1472768889-3906-1-git-send-email-bjorn.andersson@linaro.org>
 <1472768889-3906-2-git-send-email-bjorn.andersson@linaro.org>
 <eaf4753b0be45873adf29f04cb315e02@codeaurora.org>
Message-ID: <20160909043012.GE405@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 07 Sep 18:46 PDT 2016, spjoshi at codeaurora.org wrote:

> On 2016-09-01 15:27, Bjorn Andersson wrote:
> >Make it possible to match rpmsg devices based on device tree node, in
> >addition to the id table. In some of these cases the rpmsg driver would
> >not have a id_table, so make this optional.
> >
> >Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> >---
> >
> >Changes since v1:
> >- None
> >
> > drivers/rpmsg/virtio_rpmsg_bus.c | 10 ++++++----
> > 1 file changed, 6 insertions(+), 4 deletions(-)
> >
> >diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c
> >b/drivers/rpmsg/virtio_rpmsg_bus.c
> >index 4a4374cc6a59..495fa0a282d3 100644
> >--- a/drivers/rpmsg/virtio_rpmsg_bus.c
> >+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> >@@ -33,6 +33,7 @@
> > #include <linux/wait.h>
> > #include <linux/rpmsg.h>
> > #include <linux/mutex.h>
> >+#include <linux/of_device.h>
> >
> > /**
> >  * struct virtproc_info - virtual remote processor state
> >@@ -175,11 +176,12 @@ static int rpmsg_dev_match(struct device *dev,
> >struct device_driver *drv)
> > 	const struct rpmsg_device_id *ids = rpdrv->id_table;
> > 	unsigned int i;
> >
> >-	for (i = 0; ids[i].name[0]; i++)
> >-		if (rpmsg_id_match(rpdev, &ids[i]))
> >-			return 1;
> >+	if (ids)
> >+		for (i = 0; ids[i].name[0]; i++)
> >+			if (rpmsg_id_match(rpdev, &ids[i]))
> >+				return 1;
> >
> >-	return 0;
> >+	return of_driver_match_device(dev, drv);
> 
> Do we care falling back to acpi_driver_match_device if
> of_driver_match_device fails (something similar to what platform_match
> does)?
> 

I'm not sure how this would look in the case of ACPI, so I would prefer
if we defer that until such case arise.

Regards,
Bjorn
