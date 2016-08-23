From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 23 Aug 2016 05:03:29 +0200
Subject: [PATCH v7 7/7] doc: bindings: act8945a-charger: Update properties
In-Reply-To: <1471848557-27278-8-git-send-email-wenyou.yang@atmel.com>
References: <1471848557-27278-1-git-send-email-wenyou.yang@atmel.com>
 <1471848557-27278-8-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20160823030329.zy6kgncj2ov5ypnj@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 22, 2016 at 02:49:17PM +0800, Wenyou Yang wrote:
> Due the driver improvements, update the properties,
>  - Remove "active-semi,check-battery-temperature" property.
>  - Add the properties, "active-semi,irq_gpio"
>    and "active-semi,lbo-gpios".
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> Acked-by: Rob Herring <robh@kernel.org>

I wonder if it's too late to slightly break the DT API by
introducing a proper sub-device for the charger and having all those
charger specific details described there. Not being able to use the
devm_ functions because all properties are assigned to the parent
device is not very nice.

We could easily support reading timeouts and threshold information
from the both (parent and sub-device) and just mark the parent
binding deprecated. The only real API break would be
"active-semi,chglev-gpios", which is currently broken anyways in the
driver as far as I can see (I should have reviewed this more
carefully previously).

In other words I suggest the following:

pmic at 5b {
    compatible = "active-semi,act8945a";
    reg = <0x5b>;
    status = "okay";

    /* the following 3 are deprecated, but still supported */
    //active-semi,input-voltage-threshold-microvolt = <6600>;
    //active-semi,precondition-timeout = <40>;
    //active-semi,total-timeout = <3>;

    /* no longer supported, never worked properly */
    //active-semi,chglev-gpios = <&pioA 12 GPIO_ACTIVE_HIGH>;

    /* this is new, mfd should register charger sub-dev independently
     * of the subnode for backwards compatibility. Then optional
     * gpios/irqs are not available. But those either never worked
     * or did not exist before this update. */
    charger {
        active-semi,chglev-gpios = <&pioA 12 GPIO_ACTIVE_HIGH>;
        active-semi,lbo-gpios = <&pioA 72 GPIO_ACTIVE_LOW>;
		interrupt-parent = <&pioA>;
        interrupts = <45 GPIO_ACTIVE_LOW>

        active-semi,input-voltage-threshold-microvolt = <6600>;
        active-semi,precondition-timeout = <40>;
        active-semi,total-timeout = <3>;
    };
};

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160823/f270d174/attachment-0001.sig>
