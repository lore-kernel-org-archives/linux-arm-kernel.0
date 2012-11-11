From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sun, 11 Nov 2012 14:38:07 -0700
Subject: [PATCH] Add support for generic BCM SoC chipsets
In-Reply-To: <509FA975.6060203@broadcom.com>
References: <1352391196-9984-1-git-send-email-csd@broadcom.com>
 <509C7771.9020400@wwwdotorg.org> <509FA975.6060203@broadcom.com>
Message-ID: <50A01ABF.6050009@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/2012 06:34 AM, Christian Daudt wrote:
> On 12-11-08 07:24 PM, Stephen Warren wrote:
>> On 11/08/2012 09:13 AM, Christian Daudt wrote:

>>> +	uart at 3e000000 {
>>> +		compatible = "snps,dw-apb-uart";
>>
>> You probably want to include SoC-specific compatible values for all the
>> IP blocks too.
>
> I don't follow this part. Do you mean to replace that line with
> something like 'compatible = "snps,sw-apb-uart", "bcm, bcm28x11-uart"' ?
> If so, I don't think that that is necessary - right now there is nothing
> BCM specific about this.

I would expect:

compatible = "bcm,bcm28x11-uart", "snps,sw-apb-uart";

The device-tree convention is for the compatible value to always include
a specific representation of the exact instance of the HW first (i.e.
"bcm,bcm28x11-uart"), and then also describe any base value that the HW
is compatible with, or describes the IP block that was instantiated
(i.e. "snps,sw-apb-uart"). While the first more-specific value may not
be strictly required to make the code work from the start, it is
required so that if in the future it is discovered that the HW needs
some unexpected quirk or workaround in the driver, the compatible
property (for any old device tree that was loaded onto the HW
previously) already includes the required value to indicate the specific
HW, and hence allow the workaround to be applied.
