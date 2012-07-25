From: zonque@gmail.com (Daniel Mack)
Date: Wed, 25 Jul 2012 21:09:31 +0200
Subject: [PATCH 2/7] MMC: pxa-mci: add DT bindings
In-Reply-To: <87ehnzvlcx.fsf@octavius.laptop.org>
References: <1343233066-15397-1-git-send-email-zonque@gmail.com>
 <1343233066-15397-3-git-send-email-zonque@gmail.com>
 <87ehnzvlcx.fsf@octavius.laptop.org>
Message-ID: <5010446B.60608@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.07.2012 18:47, Chris Ball wrote:
> Hi Daniel,
> 
> On Wed, Jul 25 2012, Daniel Mack wrote:
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>> Cc: Nicolas Pitre <nico@fluxnic.net>
>> Cc: Chris Ball <cjb@laptop.org>
>> ---
>>  Documentation/devicetree/bindings/mmc/pxa-mmc.txt |   24 ++++++++++
>>  drivers/mmc/host/pxamci.c                         |   50 +++++++++++++++++++++
>>  2 files changed, 74 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mmc/pxa-mmc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/pxa-mmc.txt b/Documentation/devicetree/bindings/mmc/pxa-mmc.txt
>> new file mode 100644
>> index 0000000..8f0ea58
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/pxa-mmc.txt
>> @@ -0,0 +1,24 @@
>> +* PXA MMC drivers
>> +
>> +Driver bindings for the PXA MCI (MMC/SDIO) interfaces
>> +
>> +Required properties:
>> +- compatible: Should be "mrvl,pxa-mmc".
>> +- reg: Should contain registers location and length
>> +- interrupts: Should contain the interrupt
>> +- vmmc-supply: A regulator for VMMC
>> +
>> +Optional properties:
>> +- mrvl,detect-delay-ms: sets the detection delay timeout in ms.
>> +- mrvl,gpio-card-detect: GPIO spec for the card detect pin
>> +- mrvl,gpio-card-readonly: GPIO spec for the card write protection pin
>> +- mrvl,gpio-power: GPIO spec for the card power enable pin
> 
> Please see Documentation/devicetree/bindings/mmc/mmc.txt.  It looks like
> you should be using cd-gpios and wp-gpios, and you should refer to
> mmc.txt instead of specifying reg/interrupts, with:
> 
> This file documents differences between the core properties in mmc.txt
> and the properties used by the pxa-mmc driver.

Ok, will do. Thanks for the review!

> I saw Arnd mention that we're moving from "mrvl," to "marvell,", but
> maybe that's not finalized yet.  (And there are other drivers using
> mrvl, so it'll presumably involve a large renaming patch.)

I have no strong opinion on that, really. But as this is a new driver,
we can as well do it right in the first place.

[snip]

>> @@ -866,6 +915,7 @@ static struct platform_driver pxamci_driver = {
>>  	.driver		= {
>>  		.name	= DRIVER_NAME,
>>  		.owner	= THIS_MODULE,
>> +		.of_match_table = of_match_ptr(pxa_mmc_dt_ids),
> 
> Have you tried compiling without CONFIG_OF?  This doesn't look to be
> inside #ifdef CONFIG_OF, which I think would cause a compile error.

of_match_ptr() validates to NULL for !CONFIG_OF. Quite nice :)


Daniel
