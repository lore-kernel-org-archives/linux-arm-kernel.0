From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 03 Dec 2015 09:10:40 +0900
Subject: [PATCH 3/3] Addition of binding for firmware signals on peach-pi
In-Reply-To: <565EBB85.2030607@collabora.co.uk>
References: <1448997171-7064-1-git-send-email-martyn.welch@collabora.co.uk>
 <1448997171-7064-4-git-send-email-martyn.welch@collabora.co.uk>
 <565E327E.90404@samsung.com> <565EBB85.2030607@collabora.co.uk>
Message-ID: <565F8880.6000108@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02.12.2015 18:36, Martyn Welch wrote:
> 
> 
> On 01/12/15 23:51, Krzysztof Kozlowski wrote:
>> On 02.12.2015 04:12, Martyn Welch wrote:
>>> The peach pi has a GPIO connected to the firmware write protect,
>>> developer
>>> mode and recovery mode lines. This patch adds the required nodes to the
>>> device tree to configure the pinmuxing and allow these to be read from
>>> user space.
>>>
>>> Cc: Rob Herring <robh+dt@kernel.org>
>>> Cc: Pawel Moll <pawel.moll@arm.com>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
>>> Cc: Kumar Gala <galak@codeaurora.org>
>>> Cc: Russell King <linux@arm.linux.org.uk>
>>> Cc: Kukjin Kim <kgene@kernel.org>
>>> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>> Cc: devicetree at vger.kernel.org
>>> Cc: linux-arm-kernel at lists.infradead.org
>>> Cc: linux-samsung-soc at vger.kernel.org
>>> Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
>>> ---
>>>   arch/arm/boot/dts/exynos5800-peach-pi.dts | 40
>>> +++++++++++++++++++++++++++++++
>>>   1 file changed, 40 insertions(+)
>>
>> Hi,
>>
>> Thanks for the patch.
>>
>> Few points from my side:
>> 1. Please add a prefix to the subject: "ARM: dts:".
>>
> 
> Ok, sorry.
> 
>> 2. There is no need of such huge CC-list in the body of commit. This
>> CC-list comes from get_maintainer so there is no benefit of duplicating
>> it here. The CC is usually used to notify other people who might be
>> interested but get_maintainer does not point them.
>>
> 
> Ok, yes these were pulled from get_maintainer.
> 
>> 3. I received only this third patch. I did not receive cover letter
>> explaining possible dependencies so I am not sure how to deal with the
>> patch. It looks like there are no dependencies... but maybe there are?
>> Is this is a new binding or no? Please provide a cover letter (if it
>> exists already be sure to send it to all interested parties) or send
>> entire patchset so the big picture could be seen.
>>
> 
> I'll make sure I do that next time.
> 
> The cover letter read:
> 
> Some Chromebooks have gpio attached to signals used to cause the
> firmware to enter alternative modes of operation and/or control other
> device characteristics (such as write protection on flash devices). This
> patch adds a driver that exposes a read-only interface to allow these
> signals to be read from user space.
> 
> In addition this patch series provides the required bindings for this to
> the peach-pi Chromebook.
> 
> 
> This is a new binding, but the driver is based on functionality in the
> kernel shipped on Chromebooks. The binding has been modified based on
> the form of existing bindings in the mainline kernel.
> 
> Does that help?

Yes, that helps. With the changes above (subject and reduced CC-line in
commit message):
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

As there are no dependencies this should go through samsung-soc. Just
let us know about DT bindings being accepted/applied.

Best regards,
Krzysztof


> 
> Martyn
> 
>> The patch itself looks good but I'll wait with a review tag for #3.
>>
>> Best regards,
>> Krzysztof
>>
>>
>>>
>>> diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts
>>> b/arch/arm/boot/dts/exynos5800-peach-pi.dts
>>> index 49a4f43..485c18f 100644
>>> --- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
>>> +++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
>>> @@ -53,6 +53,25 @@
>>>           };
>>>       };
>>>
>>> +    chromeos-firmware {
>>> +        compatible = "google,gpio-firmware";
>>> +
>>> +        pinctrl-names = "default";
>>> +        pinctrl-0 = <&wp_gpio &dev_mode &rec_mode>;
>>> +
>>> +        write-protect {
>>> +            gpios = <&gpx3 0 GPIO_ACTIVE_LOW>;
>>> +        };
>>> +
>>> +        developer-switch {
>>> +            gpios = <&gpx1 3 GPIO_ACTIVE_HIGH>;
>>> +        };
>>> +
>>> +        recovery-switch {
>>> +            gpios = <&gpx0 7 GPIO_ACTIVE_LOW>;
>>> +        };
>>> +    };
>>> +
>>>       gpio-keys {
>>>           compatible = "gpio-keys";
>>>
>>> @@ -731,6 +750,13 @@
>>>           samsung,pin-val = <0>;
>>>       };
>>>
>>> +    rec_mode: rec-mode {
>>> +        samsung,pins = "gpx0-7";
>>> +        samsung,pin-function = <0>;
>>> +        samsung,pin-pud = <0>;
>>> +        samsung,pin-drv = <0>;
>>> +    };
>>> +
>>>       tpm_irq: tpm-irq {
>>>           samsung,pins = "gpx1-0";
>>>           samsung,pin-function = <0>;
>>> @@ -752,6 +778,13 @@
>>>           samsung,pin-drv = <0>;
>>>       };
>>>
>>> +    dev_mode: dev-mode {
>>> +        samsung,pins = "gpx1-3";
>>> +        samsung,pin-function = <0>;
>>> +        samsung,pin-pud = <3>;
>>> +        samsung,pin-drv = <0>;
>>> +    };
>>> +
>>>       ec_irq: ec-irq {
>>>           samsung,pins = "gpx1-5";
>>>           samsung,pin-function = <0>;
>>> @@ -773,6 +806,13 @@
>>>           samsung,pin-drv = <0>;
>>>       };
>>>
>>> +    wp_gpio: wp_gpio {
>>> +        samsung,pins = "gpx3-0";
>>> +        samsung,pin-function = <0>;
>>> +        samsung,pin-pud = <0>;
>>> +        samsung,pin-drv = <0>;
>>> +    };
>>> +
>>>       max77802_irq: max77802-irq {
>>>           samsung,pins = "gpx3-1";
>>>           samsung,pin-function = <0>;
>>>
>>
> 
> 
