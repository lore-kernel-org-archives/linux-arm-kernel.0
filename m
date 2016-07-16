From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 16 Jul 2016 12:18:40 +0200
Subject: [PATCH] dt: bindings: Add a generic ethernet device binding
In-Reply-To: <1788846.r3134d1VMR@wuerfel>
References: <1468405204-5845-1-git-send-email-hdegoede@redhat.com>
 <1788846.r3134d1VMR@wuerfel>
Message-ID: <289d5b2e-6232-2c91-f11d-774265e05125@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 15-07-16 22:42, Arnd Bergmann wrote:
> On Wednesday, July 13, 2016 12:20:04 PM CEST Hans de Goede wrote:
>> +&mmc1 {
>> +       non-removable;
>> +       status = "okay";
>> +
>> +       sdio_wifi: sdio_wifi at 1 {
>> +               compatible = "generic,ethernet"
>> +               reg = <1>;
>> +       };
>> +};
>
> For discoverable buses, we normally use a compatible property that
> reflects the device ID on that bus, e.g. on PCI we have "pci1A2B:3C4D"
> and I think that makes more sense than having to come up with strings
> for sdio devices.

2 things:

1) The problem here is that different batches of the same board
(cheap chinese tablet) have different sdio wifi modules, so we
actually cannot specify a vendor / product id as in your example.

2) In some cases we do want an actual compatible because some devices
have some oob (out-of-band) going with e.g. gpio-s which cannot be
handled by mmc-pwrseq.

> In fact, Linux completely ignores the compatible strings on those
> buses (pci, usb, sdio, ...),

You're mostly right, but at least the brcmfmac driver looks for a
compatible in the mmc-host child node describing its sdio function
to see if it should check for oob irq information there.

> so I think we can just do the same thing
> using no compatible string at all.

I'm all for not using any compatible string at all, actually I submitted
a patch for a sunxi dt file which did that and Maxime pointed out that
the compatible is listed as Required in:
Documentation/devicetree/bindings/mmc/mmc-card.txt

If we can agree to make it optional, then I'll happily submit a patch
with that change and Maxime can take my sunxi dts patch as is :)

Regards,

Hans
