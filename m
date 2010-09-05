From: eric.y.miao@gmail.com (Eric Miao)
Date: Sun, 5 Sep 2010 19:08:47 +0800
Subject: [PATCH] pxa168fb: Add .remove function
In-Reply-To: <201008301943.48077.marek.vasut@gmail.com>
References: <1283128337-4605-1-git-send-email-haojian.zhuang@marvell.com>
	<201008301943.48077.marek.vasut@gmail.com>
Message-ID: <AANLkTim6g-=R1gStpecbGuyLu3d2JkGVkY2Ct7691oJN@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 31, 2010 at 1:43 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Dne Po 30. srpna 2010 02:32:16 Haojian Zhuang napsal(a):
>> The pxa168fb driver is missing .remove function so the framebuffer isn't
>> correctly shut down when the module is removed.
>>
>> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>> ---
>> ?drivers/video/pxa168fb.c | ? 47
>> ++++++++++++++++++++++++++++++++++++++++++++++ 1 files changed, 47
>> insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
>> index c91a7f7..ec2ddb2 100644
>> --- a/drivers/video/pxa168fb.c
>> +++ b/drivers/video/pxa168fb.c
>> @@ -784,12 +784,53 @@ failed:
>> ? ? ? return ret;
>> ?}
>>
>> +static int __devexit pxa168fb_remove(struct platform_device *pdev)
>> +{
>> + ? ? struct pxa168fb_info *fbi = platform_get_drvdata(pdev);
>> + ? ? struct fb_info *info;
>> + ? ? int irq;
>> + ? ? unsigned int data;
>> +
>> + ? ? if (!fbi)
>> + ? ? ? ? ? ? return 0;
>> +
>> + ? ? /* disable DMA transfer */
>> + ? ? data = readl(fbi->reg_base + LCD_SPU_DMA_CTRL0);
>> + ? ? data &= ~CFG_GRA_ENA_MASK;
>> + ? ? writel(data, fbi->reg_base + LCD_SPU_DMA_CTRL0);
>> +
>> + ? ? info = fbi->info;
>> +
>> + ? ? unregister_framebuffer(info);
>> +
>
> Haojian, is this line below correct?
>
> If so, for this modified version, find my:
>
> Acked-by: Marek Vasut <marek.vasut@gmail.com>
>

Applied to 'devel'.
