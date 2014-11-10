From: lautriv@coldplug.net (lautriv)
Date: Mon, 10 Nov 2014 21:17:03 +0100
Subject: [PATCH] mmc: wmt-sdmmc: fix unmatched release_mem_region
In-Reply-To: <CABjd4YxyUJi6RaGWicFeoJ7C27qhUFsAbq-nJTreACrt-voeYA@mail.gmail.com>
References: <1415567571-6144-1-git-send-email-alchark@gmail.com>	<CAOMZO5C+O4h=f=vtLTdBZktnfVWzfeLjOQG-oecxh_c9u-QMqA@mail.gmail.com>	<545FE821.5060107@coldplug.net>
 <CABjd4YxyUJi6RaGWicFeoJ7C27qhUFsAbq-nJTreACrt-voeYA@mail.gmail.com>
Message-ID: <54611D3F.2010903@coldplug.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/2014 06:15 AM, Alexey Charkov wrote:
> 2014-11-10 1:18 GMT+03:00 lautriv <lautriv@coldplug.net>:
>> On 11/09/2014 10:55 PM, Fabio Estevam wrote:
>>> On Sun, Nov 9, 2014 at 7:12 PM, Alexey Charkov <alchark@gmail.com> wrote:
>>>
>>>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>> +       if (!res) {
>>>> +               ret = -ENODEV;
>>>> +               goto fail1;
>>> You could save this NULL check...
>>>
>>>> +       }
>>>>           mmc = mmc_alloc_host(sizeof(struct wmt_mci_priv), &pdev->dev);
>>>>           if (!mmc) {
>>>>                   dev_err(&pdev->dev, "Failed to allocate mmc_host\n");
>>>> @@ -813,7 +819,7 @@ static int wmt_mci_probe(struct platform_device
>>>> *pdev)
>>>>           if (of_get_property(np, "cd-inverted", NULL))
>>>>                   priv->cd_inverted = 1;
>>>>
>>>> -       priv->sdmmc_base = of_iomap(np, 0);
>>> If you move ' res = platform_get_resource' right here as
>>> devm_ioremap_resource() already does the NULL check.
>>>
>>>> +       priv->sdmmc_base = devm_ioremap_resource(&pdev->dev, res);
>>>>           if (!priv->sdmmc_base) {
>>>>                   dev_err(&pdev->dev, "Failed to map IO space\n");
>>>>                   ret = -ENOMEM;
>> This was the original intention but it would fall between the failX jumps, i
>> discussed that with Alexey and we decided to change it with the cleanup to
>> hold this patch small.
> I think Fabio means something slightly different than what we
> discussed. We haven't realized that the first thing
> devm_ioremap_resource does is exactly that (!res) check, so we can
> skip ours altogether.
>
> Looking at the function code a bit closer, we should also make the
> check look like "if (IS_ERR(priv->sdmmc_base)", kill the dev_err call
> (as it's also done internally), and then just do "ret =
> PTR_ERR(priv->sdmmc_base)" and jump to the label.
>
> Thanks a lot,
> Alexey
>
Sorry for the delay, 8880's are used to crash a lot since
we have not enought information ;)
Attached a changed patch which will hopefully meet all needs.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-mmc-vt8500-change-resource-mapping-to-devm_.patch
Type: text/x-patch
Size: 2730 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141110/5719b62b/attachment.bin>
