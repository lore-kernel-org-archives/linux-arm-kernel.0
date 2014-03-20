From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 20 Mar 2014 13:28:19 +0100
Subject: [PATCH v6 04/18] ahci-platform: Add support for devices with
 more then 1 clock
In-Reply-To: <20140219145203.GC10134@htj.dyndns.org>
References: <1392811320-3132-1-git-send-email-hdegoede@redhat.com>
 <1392811320-3132-5-git-send-email-hdegoede@redhat.com>
 <20140219145203.GC10134@htj.dyndns.org>
Message-ID: <532ADEE3.6070901@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/02/14 15:52, Tejun Heo wrote:
> On Wed, Feb 19, 2014 at 01:01:46PM +0100, Hans de Goede wrote:
>> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
>> index 434ab89..aaa0c08 100644
>> --- a/drivers/ata/ahci_platform.c
>> +++ b/drivers/ata/ahci_platform.c
>> @@ -87,6 +87,44 @@ static struct scsi_host_template ahci_platform_sht = {
>>   	AHCI_SHT("ahci_platform"),
>>   };
>>
>> +
>> +int ahci_platform_enable_clks(struct ahci_host_priv *hpriv)
>
> Throughout the series, there are mixtures of one and two blank lines
> in front of functions, let's just do one consistently.  Also, can you
> please add proper function comments on top of the exported functions?
>
>> +{
>> +	int c, rc;
>> +
>> +	for (c = 0; c < AHCI_MAX_CLKS && hpriv->clks[c]; c++) {
>> +		rc = clk_prepare_enable(hpriv->clks[c]);
>> +		if (rc)
>> +			goto disable_unprepare_clk;
>> +	}
>> +	return 0;
>> +
>> +disable_unprepare_clk:
>> +	while (--c >= 0)
>> +		clk_disable_unprepare(hpriv->clks[c]);
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_GPL(ahci_platform_enable_clks);
>> +
>> +void ahci_platform_disable_clks(struct ahci_host_priv *hpriv)
>> +{
>> +	int c;
>> +
>> +	for (c = AHCI_MAX_CLKS - 1; c >= 0; c--)
>> +		if (hpriv->clks[c])
>> +			clk_disable_unprepare(hpriv->clks[c]);
>> +}
>> +EXPORT_SYMBOL_GPL(ahci_platform_disable_clks);
>> +
>> +
>> +static void ahci_put_clks(struct ahci_host_priv *hpriv)
>> +{
>> +	int c;
>> +
>> +	for (c = 0; c < AHCI_MAX_CLKS && hpriv->clks[c]; c++)
>> +		clk_put(hpriv->clks[c]);
>> +}
>
> Urgh, clk can't do devm?  ahci_platform itself should be able to build
> devmized interface using devres_alloc() or devm_add_action().
> Eh.... maybe later.

There is devm_clk_get()


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
