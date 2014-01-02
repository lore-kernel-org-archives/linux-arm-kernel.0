From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 02 Jan 2014 14:45:29 +0100
Subject: [PATCH 1/4] input: Add new sun4i-lradc-keys drivers
In-Reply-To: <1700375.GaI3zFl6RI@phil>
References: <1388604610-20380-1-git-send-email-hdegoede@redhat.com>
 <20140101205603.GA1141@core.coreip.homeip.net> <52C5336B.9010903@redhat.com>
 <1700375.GaI3zFl6RI@phil>
Message-ID: <52C56D79.1060506@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/02/2014 12:59 PM, Heiko St?bner wrote:
> Hi Hans, Dmitry,
>
> Am Donnerstag, 2. Januar 2014, 10:37:47 schrieb Hans de Goede:
>> Hi,
>>
>> On 01/01/2014 09:56 PM, Dmitry Torokhov wrote:
>>> Hi Hans,
>>>
>>> On Wed, Jan 01, 2014 at 08:30:07PM +0100, Hans de Goede wrote:
>>>> +Required properties:
>>>> + - compatible: "allwinner,sun4i-lradc-keys"
>>>> + - reg: mmio address range of the chip
>>>> + - interrupts: interrupt to which the chip is connected
>>>> + - allwinner,chan0-step: step in mV between keys must be 150 or 200
>>>> + - allwinner,chan0-keycodes: array of include/uapi/linux/input.h KEY_
>>>> codes>
>>> I think this should be "linux,chan0-keycodes".
>>
>> Right, because the codes are Linux specific, will fix in v2.
>
> but the property with its "chan0-" thingy would be allwinner-specific if I'm
> not mistaken.

Correct, but denoting that this is linux only is more important, so as to
avoid namespace collisions.

>
> Also, instead of inventing yet another vendor-specific property, why not re-use
> a button binding similar to gpio-keys like:
>
>         lradc: lradc at 01c22800 {
>                 compatible = "allwinner,sun4i-lradc-keys";
>                 reg = <0x01c22800 0x100>;
>                 interrupts = <31>;
>                 allwinner,chan0-step = <200>;
>
> 		#address-cells = <1>;
> 		#size-cells = <0>;
>
> 		button at 0 {
> 			reg = <0>; /* your channel index from above */
> 			linux,code = <115>; /* already used as dt-property */
> 		};
>
> 		button at 1 {
> 			reg = <1>;
> 			linux,code = <114>;
> 		};

Ugh no. Having a vendor specific property which is KISS certainly beats this,
both wrt ease of writing dts files as well as wrt the dts parsing code in the driver.

Regards,

Hans
