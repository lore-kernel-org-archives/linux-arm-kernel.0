From: javier.martin@vista-silicon.com (javier Martin)
Date: Mon, 9 Jul 2012 09:37:25 +0200
Subject: [PATCH] [v3] i.MX27: Fix emma-prp clocks in mx2_camera.c
In-Reply-To: <20120709072809.GP30009@pengutronix.de>
References: <1341572162-29126-1-git-send-email-javier.martin@vista-silicon.com>
 <20120709072809.GP30009@pengutronix.de>
Message-ID: <CACKLOr25yb1Cx4XNriyPceBcqmc5T4jDpJXFpve9JCXpP7iMLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 July 2012 09:28, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Fri, Jul 06, 2012 at 12:56:02PM +0200, Javier Martin wrote:
>> This driver wasn't converted to the new clock changes
>> (clk_prepare_enable/clk_disable_unprepare). Also naming
>> of emma-prp related clocks for the i.MX27 was not correct.
>> ---
>> Enable clocks only for i.MX27.
>>
>
> Indeed,
>
>>
>> -     pcdev->clk_csi = clk_get(&pdev->dev, NULL);
>> -     if (IS_ERR(pcdev->clk_csi)) {
>> -             dev_err(&pdev->dev, "Could not get csi clock\n");
>> -             err = PTR_ERR(pcdev->clk_csi);
>> -             goto exit_kfree;
>> +     if (cpu_is_mx27()) {
>> +             pcdev->clk_csi = devm_clk_get(&pdev->dev, "ahb");
>> +             if (IS_ERR(pcdev->clk_csi)) {
>> +                     dev_err(&pdev->dev, "Could not get csi clock\n");
>> +                     err = PTR_ERR(pcdev->clk_csi);
>> +                     goto exit_kfree;
>> +             }
>
> but why? Now the i.MX25 won't get a clock anymore.

What are the clocks needed by i.MX25? csi only?

By the way, is anybody using this driver with i.MX25?

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
