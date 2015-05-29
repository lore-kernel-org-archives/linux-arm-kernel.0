From: eric@anholt.net (Eric Anholt)
Date: Fri, 29 May 2015 14:03:50 -0700
Subject: [PATCH] mmc: sdhci-bcm2835: Actually enable the clock
In-Reply-To: <20150529083541.GH2067@n2100.arm.linux.org.uk>
References: <1432857792-7421-1-git-send-email-eric@anholt.net>
 <20150529083541.GH2067@n2100.arm.linux.org.uk>
Message-ID: <87eglzcczt.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Thu, May 28, 2015 at 05:03:12PM -0700, Eric Anholt wrote:
>> We're currently using a fixed frequency clock specified in the DT, so
>> enabling is a no-op.  However, the RPi firmware-based clocks driver
>> can actually disable unused clocks, so when switching to use it we
>> ended up losing our MMC clock once all devices were probed.
>> 
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>>  drivers/mmc/host/sdhci-bcm2835.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdhci-bcm2835.c
>> index 0ef0343..09aff3a 100644
>> --- a/drivers/mmc/host/sdhci-bcm2835.c
>> +++ b/drivers/mmc/host/sdhci-bcm2835.c
>> @@ -172,6 +172,11 @@ static int bcm2835_sdhci_probe(struct platform_device *pdev)
>>  		ret = PTR_ERR(pltfm_host->clk);
>>  		goto err;
>>  	}
>> +	ret = clk_prepare_enable(pltfm_host->clk);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "failed to enable host clk\n");
>> +		goto err;
>> +	}
>>  
>>  	return sdhci_add_host(host);
>
> Where's the error clean-up path for a failed sdhci_add_host()?

We were already missing required cleanup in that path, so I didn't
notice.  Sending a new version with a fix for that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150529/40b0dfcb/attachment-0001.sig>
