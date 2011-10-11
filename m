From: olof@lixom.net (Olof Johansson)
Date: Tue, 11 Oct 2011 14:40:31 -0700
Subject: [PATCH v2 3/4] gpio/tegra: Convert to a platform device
In-Reply-To: <20111011212915.GA706@quad.lixom.net>
References: <1318364638-20191-1-git-send-email-swarren@nvidia.com>
	<1318364638-20191-4-git-send-email-swarren@nvidia.com>
	<20111011212915.GA706@quad.lixom.net>
Message-ID: <CAOesGMgeNcFcOc3D2uNefU_4RGoqSDp42piqdzsBX=F2ZUuxSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2011 at 2:29 PM, Olof Johansson <olof@lixom.net> wrote:
>> @@ -333,28 +336,55 @@ static struct irq_chip tegra_gpio_irq_chip = {
>> ? */
>> ?static struct lock_class_key gpio_lock_class;
>>
>> -static int __init tegra_gpio_init(void)
>> +static int __init tegra_gpio_probe(struct platform_device *pdev)
>> ?{
>> + ? ? struct resource *res;
>> ? ? ? struct tegra_gpio_bank *bank;
>> ? ? ? int gpio;
>> ? ? ? int i;
>> ? ? ? int j;
>>
>> + ? ? for (i = 0; i < ARRAY_SIZE(tegra_gpio_banks); i++) {
>> + ? ? ? ? ? ? res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
>> + ? ? ? ? ? ? if (!res) {
>> + ? ? ? ? ? ? ? ? ? ? dev_err(&pdev->dev, "Missing IRQ resource\n");
>> + ? ? ? ? ? ? ? ? ? ? return -ENODEV;
>> + ? ? ? ? ? ? }
>> +
>> + ? ? ? ? ? ? bank = &tegra_gpio_banks[i];
>> + ? ? ? ? ? ? bank->bank = i;
>> + ? ? ? ? ? ? bank->irq = res->start;
>> + ? ? }
>> +
>> + ? ? res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> + ? ? if (!res) {
>> + ? ? ? ? ? ? dev_err(&pdev->dev, "Missing MEM resource\n");
>> + ? ? ? ? ? ? return -ENODEV;
>> + ? ? }
>> +
>> + ? ? if (!devm_request_mem_region(&pdev->dev, res->start,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?resource_size(res),
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?dev_name(&pdev->dev))) {
>> + ? ? ? ? ? ? dev_err(&pdev->dev, "Couldn't request MEM resource\n");
>> + ? ? ? ? ? ? return -ENODEV;
>> + ? ? }
>> +
>> + ? ? regs = devm_ioremap(&pdev->dev, res->start, resource_size(res));
>> + ? ? if (!regs) {
>> + ? ? ? ? ? ? dev_err(&pdev->dev, "Couldn't ioremap regs\n");
>> + ? ? ? ? ? ? return -ENODEV;
>
> Should you release the mem region requested above here?

As discussed on irc, this is handled by the driver core in case of
failed probe, so nevermind.


-Olof
