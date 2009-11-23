From: mcuos.com@gmail.com (Wan ZongShun)
Date: Mon, 23 Nov 2009 18:05:01 +0800
Subject: [rtc-linux] [PATCH] ARM: NUC900: add rtc controller driver
	support for NUC900
In-Reply-To: <6A307B6986654E208CF0CA87C603BAB0@usish.com.cn>
References: <e68bb3470911190026q5bcf73a0r5431de4ce285ed92@mail.gmail.com>
	<e68bb3470911200656k16245526la863f2865a3aa4d1@mail.gmail.com>
	<D7863ABD8A8A4912A693215721E64C8D@usish.com.cn>
	<e68bb3470911230130j7ce8e81cp355de325c5fab759@mail.gmail.com>
	<6A307B6986654E208CF0CA87C603BAB0@usish.com.cn>
Message-ID: <e68bb3470911230205u7c40abfdhafac945a74185cd0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Okay, thanks a lot for your reviewing.

2009/11/23 jack wang <jack_wang@usish.com>:
>
> Hi jack,
>
> 2009/11/23 jack wang <jack_wang@usish.com>:
>> +static int __devinit nuc900_rtc_probe(struct platform_device *pdev)
>> +{
>> + ? ? ? struct resource *res;
>> + ? ? ? struct nuc900_rtc *nuc900_rtc;
>> + ? ? ? int err;
>> +
>> + ? ? ? nuc900_rtc = kzalloc(sizeof(struct nuc900_rtc), GFP_KERNEL);
>> + ? ? ? if (!nuc900_rtc) {
>> + ? ? ? ? ? ? ? err = -ENOMEM;
>> + ? ? ? ? ? ? ? goto fail1;
>> [jack] Here goto fail1 is not quite right, You'd better just return err
>> instead or just use if (!nu900_rtc) return -ENOMEM;
>
> Hmmm, good, it is right, but why did not 'CC' other people? :)
>
> Thanks !
>
> [Jack]I am not subscribe arm dev list, just review from
> http://www.spinics.net/lists , but now CC'ing added :-)
>
> Wang Jinpu
>
>> + ? ? ? }
>> +
>> + ? ? ? res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> + ? ? ? if (!res) {
>> + ? ? ? ? ? ? ? err = -ENXIO;
>> + ? ? ? ? ? ? ? goto fail1;
>> + ? ? ? }
>> +
>> + ? ? ? if (!request_mem_region(res->start, resource_size(res),
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? pdev->name)) {
>> + ? ? ? ? ? ? ? err = -EBUSY;
>> + ? ? ? ? ? ? ? goto fail1;
>> + ? ? ? }
>> +
>> + ? ? ? nuc900_rtc->rtc_reg = ioremap(res->start, resource_size(res));
>> + ? ? ? if (!nuc900_rtc->rtc_reg) {
>> + ? ? ? ? ? ? ? err = -ENOMEM;
>> + ? ? ? ? ? ? ? goto fail2;
>> + ? ? ? }
>> +
>> + ? ? ? nuc900_rtc->irq_num = platform_get_irq(pdev, 0);
>> + ? ? ? if (request_irq(nuc900_rtc->irq_num, nuc900_rtc_interrupt,
>> + ? ? ? ? ? ? ? ? ? ? ? IRQF_DISABLED, "nuc900rtc", nuc900_rtc)) {
>> + ? ? ? ? ? ? ? err = -EBUSY;
>> + ? ? ? ? ? ? ? goto fail3;
>> + ? ? ? }
>> +
>> + ? ? ? nuc900_rtc->rtcdev = rtc_device_register(pdev->name, &pdev->dev,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? &nuc900_rtc_ops,
>> THIS_MODULE);
>> + ? ? ? if (IS_ERR(nuc900_rtc->rtcdev)) {
>> + ? ? ? ? ? ? ? err = PTR_ERR(nuc900_rtc->rtcdev);
>> + ? ? ? ? ? ? ? goto fail4;
>> + ? ? ? }
>> +
>> + ? ? ? platform_set_drvdata(pdev, nuc900_rtc->rtcdev);
>> + ? ? ? nuc900_rtc_enbale_timeirq(nuc900_rtc, 1);
>> +
>> + ? ? ? return 0;
>> +
>> +fail4: free_irq(nuc900_rtc->irq_num, nuc900_rtc);
>> +fail3: iounmap(nuc900_rtc->rtc_reg);
>> +fail2: release_mem_region(res->start, resource_size(res));
>> +fail1: kfree(nuc900_rtc);
>> + ? ? ? return err;
>> +}
>
>



-- 
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
