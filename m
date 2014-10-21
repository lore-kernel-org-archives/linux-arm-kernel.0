From: ankit.jindal@linaro.org (Ankit Jindal)
Date: Tue, 21 Oct 2014 11:53:54 +0530
Subject: [PATCH v3 4/6] uio: Add X-Gene QMTM UIO driver
In-Reply-To: <5445FA5F.8010407@gmail.com>
References: <1413871011-4101-1-git-send-email-ankit.jindal@linaro.org>
 <1413871011-4101-5-git-send-email-ankit.jindal@linaro.org>
 <5445F781.7010804@gmail.com>
 <CAPTm99U7ugS3=__4A2HSzhhcUVpP0cPg6E8DRHaNgoS4Kr6vbw@mail.gmail.com>
 <5445FA5F.8010407@gmail.com>
Message-ID: <CAPTm99VOdi6wBH_QK8w4kSFBBC7sRkh-cRuiKXmY2hJmE_8rvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 October 2014 11:47, Varka Bhadram <varkabhadram@gmail.com> wrote:
> On 10/21/2014 11:46 AM, Ankit Jindal wrote:
>>
>> On 21 October 2014 11:34, Varka Bhadram <varkabhadram@gmail.com> wrote:
>>>
>>> On 10/21/2014 11:26 AM, Ankit Jindal wrote:
>>>>
>>>> The Applied Micro X-Gene SOC has on-chip QMTM (Queue manager
>>>> and Traffic manager) which is hardware based Queue or Ring
>>>> manager. This QMTM device can be used in conjunction with
>>>> other devices such as DMA Engine, Ethernet, Security Engine,
>>>> etc to assign work based on queues or rings.
>>>>
>>>> This patch allows user space access to X-Gene QMTM device.
>>>>
>>>> Signed-off-by: Ankit Jindal <ankit.jindal@linaro.org>
>>>> Signed-off-by: Tushar Jagad <tushar.jagad@linaro.org>
>>>
>>>
>>> (...)
>>>
>>>
>>>> +
>>>> +static int qmtm_probe(struct platform_device *pdev)
>>>> +{
>>>> +       struct uio_info *info;
>>>> +       struct uio_qmtm_dev *qmtm_dev;
>>>> +       struct resource *csr;
>>>> +       struct resource *fabric;
>>>> +       struct resource qpool;
>>>> +       unsigned int num_queues;
>>>> +       unsigned int devid;
>>>> +       phandle qpool_phandle;
>>>> +       struct device_node *qpool_node;
>>>> +       int ret;
>>>> +
>>>> +       qmtm_dev = devm_kzalloc(&pdev->dev, sizeof(struct uio_qmtm_dev),
>>>> +                               GFP_KERNEL);
>>>> +       if (!qmtm_dev)
>>>> +               return -ENOMEM;
>>>> +
>>>> +       qmtm_dev->info = devm_kzalloc(&pdev->dev, sizeof(*info),
>>>> GFP_KERNEL);
>>>> +       if (!qmtm_dev->info)
>>>> +               return -ENOMEM;
>>>> +
>>>> +       /* Power on qmtm in case its not done as part of boot-loader */
>>>> +       qmtm_dev->qmtm_clk = devm_clk_get(&pdev->dev, NULL);
>>>> +       if (IS_ERR(qmtm_dev->qmtm_clk)) {
>>>> +               dev_err(&pdev->dev, "Failed to get clock\n");
>>>> +               ret = PTR_ERR(qmtm_dev->qmtm_clk);
>>>> +               return ret;
>>>> +       }
>>>> +
>>>> +       csr = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>> +       if (!csr) {
>>>> +               ret = -ENODEV;
>>>> +               dev_err(&pdev->dev, "No QMTM CSR resource specified\n");
>>>> +               goto out_err;
>>>> +       }
>>>> +
>>>
>>>
>>> This error check is not required. *csr* is checked in
>>> devm_ioremap_resource().
>>
>> I think its better to do sanity check before calling any function.
>
>
> It will be the duplication of code for sanity check. This sanity check is
> happening
> with devm_ioremap_resource(). No need to check it explicitly.

Okie, will remove it in next revision.

>
>>>> +       if (!csr->start) {
>>>> +               ret = -EINVAL;
>>>> +               dev_err(&pdev->dev, "Invalid CSR resource\n");
>>>> +               goto out_err;
>>>> +       }
>>>> +
>>>> +       fabric = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>>>> +       if (!fabric) {
>>>> +               ret = -ENODEV;
>>>> +               dev_err(&pdev->dev, "No QMTM Fabric resource
>>>> specified\n");
>>>> +               goto out_err;
>>>> +       }
>>>> +
>>>
>>>
>>> same
>>
>> We do not ioremap this address.
>
>
> Ok..
>
> --
> Regards,
> Varka Bhadram.
>
Thanks,
Ankit
