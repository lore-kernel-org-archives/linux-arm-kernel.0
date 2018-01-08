From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 8 Jan 2018 12:22:39 +0100
Subject: [PATCH] Revert "ARM: dts: bcm283x: Fix DTC warnings about missing
 phy-cells"
In-Reply-To: <dd0372b5-e16c-ce77-ce39-2c4ffa61f663@i2se.com>
References: <1515332212-23593-1-git-send-email-stefan.wahren@i2se.com>
 <87incdjp9k.fsf@anholt.net> <df3db2e7-5d0f-9c1c-b005-41cf00e7d851@i2se.com>
 <CAK8P3a3qfiX_ZsD8pLmoTJZ2+Q8PkHGmfTFW=NL8P8QFML_dLw@mail.gmail.com>
 <dd0372b5-e16c-ce77-ce39-2c4ffa61f663@i2se.com>
Message-ID: <CAK8P3a0bv=BX49Je08Ka-XXtRC9NhcAYbq=aOjhXE+wxgnia2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 8, 2018 at 10:36 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> Am 08.01.2018 um 10:27 schrieb Arnd Bergmann:
>>
>> On Mon, Jan 8, 2018 at 10:15 AM, Stefan Wahren <stefan.wahren@i2se.com>
>> wrote:
>>>
>>> Hi Eric,
>>> Am 07.01.2018 um 23:08 schrieb Eric Anholt:
>>>>
>>>> Stefan Wahren <stefan.wahren@i2se.com> writes:
>>>>
>>>>> This reverts commit 014d6da6cb2525d7f48fb08c705cb130cc7b5f4a.
>>>>>
>>>>> The DT clean up could trigger an endless deferred probe of DWC2 USB
>>>>> driver
>>>>> on the Raspberry Pi 2/3. So revert the change until we fixed the
>>>>> probing
>>>>> issue.
>>>>
>>>> Why's that?  I found that I needed to enable the generic no-op phy
>>>> driver, but other than that it was fine.
>>>
>>>
>>> in order to avoid this regression. Changing the configuration is not a
>>> solution for the kernelci guys.
>>>
>>> Btw
>>>
>>> CONFIG_NOP_USB_XCEIV=y
>>>
>>> is already enabled in arm64/defconfig and the issue still occured. Do you
>>> mean a different option?
>>
>> Obviously we need to fix this, but I really want to understand what
>> exactly
>> happened so we can fix the code if possible rather than making the
>> dts file incompatible with the binding again.
>
>
> i fully agree, but dwc2 "hacking" usually requires more time than reverting
> this change.
>
>>
>> Do you have any more insight into how we get into the deferred probe
>> situation?
>
>
> I send this bug report [1] on Friday to linux-usb.
>
> Stefan
>
> [1] - https://marc.info/?l=linux-usb&m=151518314314753&w=2

Ok, I looked at the code now and it seems that the generic phy layer
returns -EINVAL for a phy reference to an invalid node, but not a
reference to a valid node without a driver, here it returns
-EPROBE_DEFER, which by itself is reasonable behavior.

In this case, the NOP_USB_XCEIV driver is using the old usb-phy
framework, and the dwc2 driver tries both but bails out when the
generic phy returns -EPROBE_DEFER.

It sounds like the problem is not limited to raspberry pi then, but
the same thing would happen on any other machine using the
same algorithm. I looked at the other USB drivers that support
both generic-phy and usb-phy drivers:

- the generic usb-hcd code (usb_add_hcd) tries usb-phy first
  and then tries generic-phy, but appears to also return
  with -EPROBE_DEFER if either of the two asks for deferral.
  other return codes are ignored.
- dwc2 (as show above) tries generic-phy first, propagates
  -EPROBE_DEFER before trying usb-phy.
- dwc3 tries usb-phy first, and propagates -EPROBE_DEFER
  from generic-phy even if usb-phy had succeeded.

- chipidea tries both and uses whichever one works, returning
  -EPROBE_DEFER as long as both fail.
- musb/da8xx_probe propagates any error from generic-phy including
  -EPROBE_DEFER, it then registers a generic phy and uses
  that internally.
- musb/musb_dsps tries both, it fails if usb-phy is not working, but
  ignores errors from generic-phy
- musb/omap2430 needs both usb-phy and generic-phy
- musb/sunxi needs a generic-phy and then registers a usb-phy
- renesas_usbhs tries both if they are enabled and fails
  if one of them returns any error.

It's hard to tell what exactly is affected by the usb-hcd change,
most importantly since this is configuration dependent: if
the generic-phy layer is disabled, nothing changes, but otherwise
it would be broken the same way as dwc2 and dwc3.

The best idea I have so far is to had a hack into the generic
phy code with a full list of compatible strings that the must
never return -EPROBE_DEFER because that would break
the usb-phy handling:

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index b4964b067aec..6b9c3a1e7ce5 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -387,6 +387,24 @@ int phy_calibrate(struct phy *phy)
 }
 EXPORT_SYMBOL_GPL(phy_calibrate);

+static struct of_device_id legacy_usbphy[] = {
+       { .compatible = "fsl,imx23-usbphy" },
+       { .compatible = "fsl,imx6q-usbphy" },
+       { .compatible = "fsl,imx6sl-usbphy" },
+       { .compatible = "fsl,imx6sx-usbphy" },
+       { .compatible = "fsl,imx6ul-usbphy" },
+       { .compatible = "fsl,vf610-usbphy" },
+       { .compatible = "nvidia,tegra20-usb-phy" },
+       { .compatible = "nvidia,tegra30-usb-phy" },
+       { .compatible = "nxp,isp1301" },
+       { .compatible = "ti,am335x-usb-ctrl-module" },
+       { .compatible = "ti,am335x-usb-phy" },
+       { .compatible = "ti,keystone-usbphy" },
+       { .compatible = "ti,twl6030-usb" },
+       { .compatible = "usb-nop-xceiv" },
+       {},
+};
+
 /**
  * _of_phy_get() - lookup and obtain a reference to a phy by phandle
  * @np: device_node for which to get the phy
@@ -410,6 +428,15 @@ static struct phy *_of_phy_get(struct device_node
*np, int index)
        if (ret)
                return ERR_PTR(-ENODEV);

+       /*
+        * Some USB host controllers use a "phys" property to refer to
+        * a device that does not have a generic phy driver but that
+        * has a driver for the older usb-phy framework.
+        * We must not return -EPROBE_DEFER for those, so bail out early.
+        */
+       if (of_match_node(legacy_usbphy, args.np))
+               return ERR_PTR(-ENODEV);
+
        mutex_lock(&phy_provider_mutex);
        phy_provider = of_phy_provider_lookup(args.np);
        if (IS_ERR(phy_provider) || !try_module_get(phy_provider->owner)) {

      Arnd
