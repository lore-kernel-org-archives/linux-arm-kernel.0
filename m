From: grant.likely@secretlab.ca (Grant Likely)
Date: Sun, 21 Nov 2010 14:31:38 -0700
Subject: [PATCH v6 08/12] gpio: add ti-ssp gpio driver
In-Reply-To: <4CE97AE5.3040801@bluewatersys.com>
References: <1290182156-20104-1-git-send-email-cyril@ti.com>
	<1290182156-20104-9-git-send-email-cyril@ti.com>
	<4CE97AE5.3040801@bluewatersys.com>
Message-ID: <AANLkTikYu4H8aWOvK+q6g4YgUZxD_80UKBdr=eB__frF@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 21, 2010 at 1:02 PM, Ryan Mallon <ryan@bluewatersys.com> wrote:
> On 11/20/2010 04:55 AM, Cyril Chemparathy wrote:
>> TI's SSP controller pins can be directly read and written to behave like a
>> GPIO. ?This patch adds a GPIO driver that exposes such functionality.
>>
>> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
>> ---
>
>> +static int __devinit ti_ssp_gpio_probe(struct platform_device *pdev)
>> +{
>> + ? ? const struct ti_ssp_gpio_data *pdata = pdev->dev.platform_data;
>> + ? ? struct device *dev = &pdev->dev;
>> + ? ? struct ti_ssp_gpio_chip *gpio;
>> + ? ? int error;
>> +
>> + ? ? if (!pdata) {
>> + ? ? ? ? ? ? dev_err(dev, "platform data not found\n");
>> + ? ? ? ? ? ? return -EINVAL;
>> + ? ? }
>> +
>> + ? ? gpio = kzalloc(sizeof(*gpio), GFP_KERNEL);
>> + ? ? if (!gpio) {
>> + ? ? ? ? ? ? dev_err(dev, "cannot allocate driver data\n");
>> + ? ? ? ? ? ? return -ENOMEM;
>> + ? ? }
>> +
>> + ? ? gpio->dev = dev;
>> + ? ? gpio->iosel = SSP_PIN_SEL(0, SSP_IN) | SSP_PIN_SEL(1, SSP_IN) |
>> + ? ? ? ? ? ? ? ? ? SSP_PIN_SEL(2, SSP_IN) | SSP_PIN_SEL(3, SSP_IN);
>> + ? ? error = ti_ssp_set_iosel(gpio->dev, gpio->iosel);
>> + ? ? if (error < 0) {
>> + ? ? ? ? ? ? dev_err(dev, "gpio io setup failed (%d)\n", error);
>> + ? ? ? ? ? ? goto error;
>> + ? ? }
>> +
>> + ? ? spin_lock_init(&gpio->lock);
>> + ? ? platform_set_drvdata(pdev, gpio);
>
> This looks wrong. gpio is of type ti_ssp_gpio_chip, but the ssp core
> functions, ssp_read, etc, use dev_to_ssp:

This sets the child device's private data pointer, not the parents.
dev_to_ssp still correctly returns the parent device private data.

>
> static inline struct ti_ssp *dev_to_ssp(struct device *dev)
> {
> ? ? ? ?return dev_get_drvdata(dev->parent);
> }
>
> If I understand correctly, the ssp core can only be used to for one
> peripheral at a time.

I believe the ssp has 2 channels; thus up to 2 child devices.

> Currently the code will allow you to install
> several peripherals at once, which will lead to odd behaviour at
> runtime. Maybe a better approach would be to have something like this in
> drivers/mfd/ti-ssp.c:

Only the ssp core itself is allowed to register the peripheral
devices, and so using the parent pointer is perfectly valid.  I think
Cyril's approach is fine.

g.
