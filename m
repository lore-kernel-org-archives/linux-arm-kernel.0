From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 19 Jan 2014 20:20:19 +0100
Subject: [RFC v3 06/13] ahci-platform: Add support for devices with more
 then 1 clock
In-Reply-To: <20140119123854.GP15937@n2100.arm.linux.org.uk>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
 <1390088935-7193-7-git-send-email-hdegoede@redhat.com>
 <20140119123854.GP15937@n2100.arm.linux.org.uk>
Message-ID: <52DC2573.4020308@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/19/2014 01:38 PM, Russell King - ARM Linux wrote:
> On Sun, Jan 19, 2014 at 12:48:48AM +0100, Hans de Goede wrote:
>> +static int ahci_enable_clks(struct device *dev, struct ahci_host_priv *hpriv)
>> +{
>> +	int c, rc;
>> +
>> +	for (c = 0; c < AHCI_MAX_CLKS && hpriv->clks[c]; c++) {
>
> 	for (c = 0; c < AHCI_MAX_CLKS && !IS_ERR(hpriv->clks[c]); c++) {

That won't work, hpriv->clks == NULL for clks entries which are not used,
and before we get into a discussion about leaving any PTR_ERR returns
from clk_get in-place. I've had similar discussions when doing similar
changes to ohci-platform.c and ehci-platform.c and there the conclusion
was that "if (clk)" is just much more nice to read then "if (!IS_ERR(clk))",
I would like to avoid having the same discussion again.

More-over all clk_foo() methods check for and will safely handle clk == NULL,
and will crash and burn with clk == IS_ERR(clk).

I've chosen to still explicitly check for clk == NULL as that makes it much more
clear when reading the code that clk maybe NULL.


>> +		rc = clk_prepare_enable(hpriv->clks[c]);
>> +		if (rc) {
>> +			dev_err(dev, "clock prepare enable failed");
>> +			goto disable_unprepare_clk;
>> +		}
>> +	}
>> +	return 0;
>> +
>> +disable_unprepare_clk:
>> +	while (--c >= 0)
>> +		clk_disable_unprepare(hpriv->clks[c]);
>> +	return rc;
>> +}
>> +
>> +static void ahci_disable_clks(struct ahci_host_priv *hpriv)
>> +{
>> +	int c;
>> +
>> +	for (c = AHCI_MAX_CLKS - 1; c >= 0; c--)
>> +		if (hpriv->clks[c])
>
> 		if (!IS_ERR(hpriv->clks[c]))
>

Idem.

>> +			clk_disable_unprepare(hpriv->clks[c]);
>> +}
>> +
>> +static void ahci_put_clks(struct ahci_host_priv *hpriv)
>> +{
>> +	int c;
>> +
>> +	for (c = 0; c < AHCI_MAX_CLKS && hpriv->clks[c]; c++)
>
> 	for (c = 0; c < AHCI_MAX_CLKS && !IS_ERR(hpriv->clks[c]); c++)
>

Idem.

>> +		clk_put(hpriv->clks[c]);
>> +}
>
> Better still for this one, consider using devm_clk_get() - in which case
> the above is even more important to get right.

The above depends on how errors are handled when calling clk_get (or variants),
which in the case of this patch is such that hpriv->clks[i] == NULL when not
present.

> We really should have a devm_of_clk_get() too.

Agreed, but that seems something for another patch-set, this one is big
enough as is.

Regards,

Hans
