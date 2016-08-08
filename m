From: hzpeterchen@gmail.com (Peter Chen)
Date: Mon, 8 Aug 2016 09:57:22 +0800
Subject: [PATCH v4 0/6] power: add power sequence library
In-Reply-To: <d7c11574a1218263c02b117d79b59601@naiandei.net>
References: <1470108652-16812-1-git-send-email-peter.chen@nxp.com>
 <d7c11574a1218263c02b117d79b59601@naiandei.net>
Message-ID: <20160808015722.GA17680@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 06, 2016 at 02:00:08PM +0200, Oscar wrote:
> El 2016-08-02 05:30, Peter Chen escribi?:
> >Hi all,
> >
> >This is a follow-up for my last power sequence framework patch set
> >[1].
> >According to Rob Herring and Ulf Hansson's comments[2], I use a
> >generic
> >power sequence library for parsing the power sequence elements on DT,
> >and implement generic power sequence on library. The host driver
> >can allocate power sequence instance, and calls pwrseq APIs
> >accordingly.
> >
> >In future, if there are special power sequence requirements, the
> >special
> >power sequence library can be created.
> >
> >This patch set is tested on i.mx6 sabresx evk using a dts change,
> >I use
> >two hot-plug devices to simulate this use case, the related binding
> >change is updated at patch [1/6], The udoo board changes were tested
> >using my last power sequence patch set.[3]
> >
> >Except for hard-wired MMC and USB devices, I find the USB ULPI PHY
> >also
> >need to power on itself before it can be found by ULPI bus.
> >
> >[1] http://www.spinics.net/lists/linux-usb/msg142755.html
> >[2] http://www.spinics.net/lists/linux-usb/msg143106.html
> >[3] http://www.spinics.net/lists/linux-usb/msg142815.html
> >
> >Changes for v4:
> >- Create the patch on next-20160722
> >- Fix the of_node is not NULL after chipidea driver is unbinded
> >[Patch 5/6]
> >- Using more friendly wait method for reset gpio [Patch 2/6]
> >- Support multiple input clocks [Patch 2/6]
> >- Add Rob Herring's ack for DT changes
> >- Add Joshua Clayton's Tested-by
> >
> >Changes for v3:
> >- Delete "power-sequence" property at binding-doc, and change
> >related code
> >  at both library and user code.
> >- Change binding-doc example node name with Rob's comments
> >- of_get_named_gpio_flags only gets the gpio, but without setting
> >gpio flags,
> >  add additional code request gpio with proper gpio flags
> >- Add Philipp Zabel's Ack and MAINTAINER's entry
> >
> >Changes for v2:
> >- Delete "pwrseq" prefix and clock-names for properties at dt binding
> >- Should use structure not but its pointer for kzalloc
> >- Since chipidea core has no of_node, let core's of_node equals glue
> >  layer's at core's probe
> >
> >Peter Chen (6):
> >  binding-doc: power: pwrseq-generic: add binding doc for generic
> >power
> >    sequence library
> >  power: add power sequence library
> >  binding-doc: usb: usb-device: add optional properties for power
> >    sequence
> >  usb: core: add power sequence handling for USB devices
> >  usb: chipidea: let chipidea core device of_node equal's glue layer
> >    device of_node
> >  ARM: dts: imx6qdl-udoo.dtsi: fix onboard USB HUB property
> >
> 
> Hi Peter,
> 
> I tried the last version on my udoo board but I got these compile
> errors:
> 
> [21330s] ERROR: "pwrseq_get" [drivers/usb/core/usbcore.ko] undefined!
> [21330s] ERROR: "pwrseq_free" [drivers/usb/core/usbcore.ko] undefined!
> [21330s] ERROR: "pwrseq_put" [drivers/usb/core/usbcore.ko] undefined!
> [21330s] ERROR: "pwrseq_off" [drivers/usb/core/usbcore.ko] undefined!
> [21330s] ERROR: "pwrseq_on" [drivers/usb/core/usbcore.ko] undefined!
> 
> Will you do another version?
> 

Thanks, I forgot to export above symbols, I will fix it at next
version. Below fix should work for you, I have tested.

diff --git a/drivers/power/pwrseq/core.c b/drivers/power/pwrseq/core.c
index 60f1e4e..6861a21 100644
--- a/drivers/power/pwrseq/core.c
+++ b/drivers/power/pwrseq/core.c
@@ -29,6 +29,7 @@ int pwrseq_get(struct device_node *np, struct pwrseq *p)
 
 	return -ENOTSUPP;
 }
+EXPORT_SYMBOL(pwrseq_get);
 
 int pwrseq_on(struct device_node *np, struct pwrseq *p)
 {
@@ -37,24 +38,28 @@ int pwrseq_on(struct device_node *np, struct pwrseq *p)
 
 	return -ENOTSUPP;
 }
+EXPORT_SYMBOL(pwrseq_on);
 
 void pwrseq_off(struct pwrseq *p)
 {
 	if (p && p->off)
 		p->off(p);
 }
+EXPORT_SYMBOL(pwrseq_off);
 
 void pwrseq_put(struct pwrseq *p)
 {
 	if (p && p->put)
 		p->put(p);
 }
+EXPORT_SYMBOL(pwrseq_put);
 
 void pwrseq_free(struct pwrseq *p)
 {
 	if (p && p->free)
 		p->free(p);
 }
+EXPORT_SYMBOL(pwrseq_free);

-- 

Best Regards,
Peter Chen
