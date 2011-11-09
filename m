From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 9 Nov 2011 10:34:45 +0800
Subject: [PATCH v6 11/11] ARM: pxa: add clk support in gpio driver
In-Reply-To: <20111108232810.GM12913@n2100.arm.linux.org.uk>
References: <1320747859-8366-1-git-send-email-haojian.zhuang@marvell.com>
 <1320747859-8366-12-git-send-email-haojian.zhuang@marvell.com>
 <20111108232810.GM12913@n2100.arm.linux.org.uk>
Message-ID: <CAN1soZwJLBvPHs6twSAxSN8_VmAdgMPfeZrot-46g7P++j-hDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 9, 2011 at 7:28 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Nov 08, 2011 at 06:24:19PM +0800, Haojian Zhuang wrote:
>> diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
>> index bfd7555..1a6b150 100644
>> --- a/drivers/gpio/gpio-pxa.c
>> +++ b/drivers/gpio/gpio-pxa.c
>> @@ -11,6 +11,8 @@
>> ? * ?it under the terms of the GNU General Public License version 2 as
>> ? * ?published by the Free Software Foundation.
>> ? */
>> +#include <linux/clk.h>
>> +#include <linux/err.h>
>> ?#include <linux/gpio.h>
>> ?#include <linux/gpio-pxa.h>
>> ?#include <linux/init.h>
>> @@ -466,6 +468,7 @@ static int __devinit pxa_gpio_probe(struct platform_device *pdev)
>> ?{
>> ? ? ? struct pxa_gpio_chip *c;
>> ? ? ? struct resource *res;
>> + ? ? struct clk *clk;
>> ? ? ? int gpio, irq;
>> ? ? ? int irq0 = 0, irq1 = 0, irq_mux, gpio_offset = 0;
>>
>> @@ -489,6 +492,15 @@ static int __devinit pxa_gpio_probe(struct platform_device *pdev)
>> ? ? ? if (irq0 > 0)
>> ? ? ? ? ? ? ? gpio_offset = 2;
>>
>> + ? ? clk = clk_get(&pdev->dev, NULL);
>> + ? ? if (IS_ERR(clk)) {
>> + ? ? ? ? ? ? dev_err(&pdev->dev, "Error %ld to get gpio clock\n",
>> + ? ? ? ? ? ? ? ? ? ? PTR_ERR(clk));
>> + ? ? ? ? ? ? iounmap(gpio_reg_base);
>> + ? ? ? ? ? ? return PTR_ERR(clk);
>> + ? ? }
>> + ? ? clk_enable(clk);
>
> Please also ensure that you have proper error checking on this.
> Also, extending this to clk_prepare() now would be a good idea so that
> such a change doesn't need to be made separately in the future. ?(A
> dummy clk_prepare() is already provided.) ?Thanks.
>
Yes, current error check is enough. I'll submit a new version with
clk_prepare() support.

Thanks
Haojian
