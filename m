From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 23 Jun 2014 11:28:25 +0200
Subject: [PATCH v2 07/10] regulator: Add driver for Maxim 77802 PMIC
 regulators
In-Reply-To: <20140621204026.GH22657@sirena.org.uk>
References: <1402941758-11216-1-git-send-email-javier.martinez@collabora.co.uk>
 <1402941758-11216-8-git-send-email-javier.martinez@collabora.co.uk>
 <20140616192500.GJ5099@sirena.org.uk> <53A01D54.10506@collabora.co.uk>
 <20140617141254.GP5099@sirena.org.uk> <53A06749.1010606@collabora.co.uk>
 <20140621204026.GH22657@sirena.org.uk>
Message-ID: <53A7F339.7050608@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

On 06/21/2014 10:40 PM, Mark Brown wrote:
> On Tue, Jun 17, 2014 at 06:05:29PM +0200, Javier Martinez Canillas wrote:
>> On 06/17/2014 04:12 PM, Mark Brown wrote:
> 
>> >> I just looked at regulator_register() and saw that it does rdev->dev.parent =
>> >> dev, so yes this has to be the MFD.
> 
>> I noticed that many drivers set config.dev = &pdev->dev. The original Chrome OS
>> max77xxx driver and max77686 are two examples but others drivers do the same:
> 
> Not all drivers are DT drivers that bother specifying supplies.
> 
>> And also I see that mfd_add_device() calls
>> devm_regulator_bulk_register_supply_alias(&pdev->dev,...) so I'm confused now
>> about what the correct device should be...
> 
> Right, but to do that you need to set those aliases up - have you done
> so?
> 
>> > Do the regulators manage to get their supplies?
> 
>> There are no current support in mainline for the devices that use the regulators
>> in this PMIC so I can't tell you if consumers manage to get their supplies
>> correctly (e.g: if regulator_dev_lookup succeeds).
> 
> That's not really relevant here - I'm asking if the regulators get their
> own supplies rather than if anything uses them.
>

Sorry if I keep misunderstanding your question but the regulators in this PMIC
don't have a parent supply/regulator node.

If by own supplies you mean the regulators power outputs (voltage/current
constraints), then yes, the regulators manage to get their own voltage output
correctly regardless of the value set in config.dev (&pdev->dev or
pdev->dev.parent).

I see in regulator_register() that config.dev is used to set the value of struct
regulator_dev .dev.parent and that is used in two places in regulator core:

1) In regulator_register() to get the regmap if config->regmap is not set.
2) In regulator_dev_lookup() checks if r->dev.parent is set.

For 1) config.regmap is explicitly set to the MFD regmap in max77802 driver so
config.dev is not used in this case and for 2) the value does not matter since
it only checks that it's not NULL.

Having said that, when I was preparing v3 of the patch-set I noticed that
regulator_register() does:

dev = config->dev;
...
rdev->dev.parent = dev;

So I changed to use MFD device instead of &pdev->dev in the version I posted
last week since the MFD device is the regulator parent.

Best regards,
Javier
