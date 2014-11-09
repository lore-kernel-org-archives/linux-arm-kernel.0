From: lautriv@coldplug.net (lautriv)
Date: Sun, 09 Nov 2014 23:18:09 +0100
Subject: [PATCH] mmc: wmt-sdmmc: fix unmatched release_mem_region
In-Reply-To: <CAOMZO5C+O4h=f=vtLTdBZktnfVWzfeLjOQG-oecxh_c9u-QMqA@mail.gmail.com>
References: <1415567571-6144-1-git-send-email-alchark@gmail.com>
 <CAOMZO5C+O4h=f=vtLTdBZktnfVWzfeLjOQG-oecxh_c9u-QMqA@mail.gmail.com>
Message-ID: <545FE821.5060107@coldplug.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/2014 10:55 PM, Fabio Estevam wrote:
> On Sun, Nov 9, 2014 at 7:12 PM, Alexey Charkov <alchark@gmail.com> wrote:
>
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       if (!res) {
>> +               ret = -ENODEV;
>> +               goto fail1;
> You could save this NULL check...
>
>> +       }
>>          mmc = mmc_alloc_host(sizeof(struct wmt_mci_priv), &pdev->dev);
>>          if (!mmc) {
>>                  dev_err(&pdev->dev, "Failed to allocate mmc_host\n");
>> @@ -813,7 +819,7 @@ static int wmt_mci_probe(struct platform_device *pdev)
>>          if (of_get_property(np, "cd-inverted", NULL))
>>                  priv->cd_inverted = 1;
>>
>> -       priv->sdmmc_base = of_iomap(np, 0);
> If you move ' res = platform_get_resource' right here as
> devm_ioremap_resource() already does the NULL check.
>
>> +       priv->sdmmc_base = devm_ioremap_resource(&pdev->dev, res);
>>          if (!priv->sdmmc_base) {
>>                  dev_err(&pdev->dev, "Failed to map IO space\n");
>>                  ret = -ENOMEM;
This was the original intention but it would fall between the failX 
jumps, i discussed that with Alexey and we decided to change it with the 
cleanup to hold this patch small.
