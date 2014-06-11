From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Wed, 11 Jun 2014 17:08:00 +0530
Subject: [PATCH 1/2 v3] spi: s3c64xx: use "cs-gpios" from spi node instead
 of "cs-gpio"
In-Reply-To: <539839D6.1050305@collabora.co.uk>
References: <1402468318-7342-1-git-send-email-ch.naveen@samsung.com>
 <539839D6.1050305@collabora.co.uk>
Message-ID: <CAHfPSqCYqTRBBH56y81na-t18pvoPmyWobZwXNgkrtq=H_79CQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Javier,

On 11 June 2014 16:43, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> Hello Naveen,
>
> Thanks a lot for your patches and sorry that I didn't review your prior two
> versions but I didn't have the time yesterday.
>
> On 06/11/2014 08:31 AM, Naveen Krishna Chatradhi wrote:
>> Currently, spi-s3c64xx.c needs "cs-gpio" chip select GPIO to be
>> defined under "controller-data" node under each slave node.
>>
>
> I think that the commit message is not clear enough about the intentions behind
> your patch.
>
> It's not only that spi-s3c64xx needs a cs-gpio chip to be defined under
> controller-data dev node while all other SPI drivers expects cs-gpios at the top
> level, but more important that currently s3c64xx driver expects to have both
> cs-gpio (singular) at the top level *and* cs-gpio in controller data which
> doesn't make too much sense.
>
>> &spi_x {
>>       cs-gpios <>;
>>       ...
>
> As I said, currently it expects cs-gpio (singular) not cs-gpios (plural) as your
> example. It's important to have a correct commit message so future code
> archaeologists can have a proper picture of the situation if needed.
Will add some explanation in the example, for it to be clear.
>
>>       slave_node {
>>
>>               controller-data {
>>                       cs-gpio = <>;
>>                       ...
>>               };
>>               ...
>>       };
>>       ...
>> };
>>
>> Where as, SPI core and many other drivers uses "cs-gpios" for
>> from device tree node.
>>
>> Hence, make changes in spi-s3c64xx.c driver to make use of
>> "cs-gpios" from SPI node(parent) instead of "cs-gpio" defined in
>> slaves "controller-data"(child) node.
>>
>
> So, the problem is not that the binding is not consistent with other SPI drivers
> (that would have been bad but acceptable IMHO) but that it is completely broken.
> And since we have to fix it which means breaking the ABI anyways, it is better
> to make it consistent with other drivers and SPI core.
Will take this point for the while rewriting the commit messages
>
>> Also updates the Device tree Documentation.
>>
>
> While I agree with others that a binding that has been broken for a year is a
> binding that appears to not be used a lot, we should be more vocal about this
> and why breaking backward compatibility is the right approach in this case.
>
> So, in the (theoretical?) case that users find that their platform stopped to
> work with their current FDT, it will be easy for them to figure out what commit
> break it, what was the motivation to break the ABI and what changes are needed
> on their DTS to make it work again.
>
> Adding the sha1 of the culprit commit (3146bee spi: s3c64xx: Added provision for
> dedicated cs pin) that puts us in this situation will also be useful. Since the
> date of that commit is part of the rationale behind this change. (e.g: nobody
> cared about this binding and so can be changed).
Will take this point for the while rewriting the commit messages
>
>> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> Cc: Doug Anderson <dianders@chromium.org>
>> Cc: Tomasz Figa <t.figa@samsung.com>
>> ---
>> Changes since v2:
>> 1. updated the gpios usage in Documentation
>> 2. use the spi->cs_gpio in the driver, instead of parsing the node again.
>> 3. Corrected error check of the of.node and during gpio_free
>>
>>  .../devicetree/bindings/spi/spi-samsung.txt        |    8 +++-----
>>  drivers/spi/spi-s3c64xx.c                          |   18 ++++++------------
>>  2 files changed, 9 insertions(+), 17 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi-samsung.txt b/Documentation/devicetree/bindings/spi/spi-samsung.txt
>> index 86aa061..2d29dac 100644
>> --- a/Documentation/devicetree/bindings/spi/spi-samsung.txt
>> +++ b/Documentation/devicetree/bindings/spi/spi-samsung.txt
>> @@ -42,15 +42,13 @@ Optional Board Specific Properties:
>>  - num-cs: Specifies the number of chip select lines supported. If
>>    not specified, the default number of chip select lines is set to 1.
>>
>> +- cs-gpios: should specify GPIOs used for chipselects (see spi-bus.txt)
>> +
>>  SPI Controller specific data in SPI slave nodes:
>>
>>  - The spi slave nodes should provide the following information which is required
>>    by the spi controller.
>>
>> -  - cs-gpio: A gpio specifier that specifies the gpio line used as
>> -    the slave select line by the spi controller. The format of the gpio
>> -    specifier depends on the gpio controller.
>> -
>>    - samsung,spi-feedback-delay: The sampling phase shift to be applied on the
>>      miso line (to account for any lag in the miso line). The following are the
>>      valid values.
>> @@ -85,6 +83,7 @@ Example:
>>               #size-cells = <0>;
>>               pinctrl-names = "default";
>>               pinctrl-0 = <&spi0_bus>;
>> +             cs-gpios = <&gpa2 5 0>;
>>
>>               w25q80bw at 0 {
>>                       #address-cells = <1>;
>> @@ -94,7 +93,6 @@ Example:
>>                       spi-max-frequency = <10000>;
>>
>>                       controller-data {
>> -                             cs-gpio = <&gpa2 5 1 0 3>;
>>                               samsung,spi-feedback-delay = <0>;
>>                       };
>>
>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> index 75a5696..842b148 100644
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -772,24 +772,19 @@ static struct s3c64xx_spi_csinfo *s3c64xx_get_slave_ctrldata(
>>
>>       cs = kzalloc(sizeof(*cs), GFP_KERNEL);
>>       if (!cs) {
>> -             of_node_put(data_np);
>
> Why are you removing this?
>
> You are not removing the call to of_get_child_by_name(slave_np,
> "controller-data") so on failure data_np reference counter still needs to be
> decremented.
>
>>               return ERR_PTR(-ENOMEM);
>>       }
>>
>> -     /* The CS line is asserted/deasserted by the gpio pin */
>> -     if (sdd->cs_gpio)
>> -             cs->line = of_get_named_gpio(data_np, "cs-gpio", 0);
>> -
>> -     if (!gpio_is_valid(cs->line)) {
>> +     if (!gpio_is_valid(spi->cs_gpio)) {
>>               dev_err(&spi->dev, "chip select gpio is not specified or invalid\n");
>> -             kfree(cs);
>> -             of_node_put(data_np);
>
> Again, it's wrong to remove this of_node_put(data_np) call.
Actually, i wanted to move down the of_get_child_by_name() to before
of_property_read_u32() call.
>
>>               return ERR_PTR(-EINVAL);
>>       }
>> +     cs->line = spi->cs_gpio;
>>
>
> I wonder why are you keeping cs->line? AFAICT it's only used in
> s3c64xx_spi_setup() to request the GPIO and since you get the struct spi_device
> pointer as a parameter then you can just use spi->s_gpio instead.
I'm trying not to touch the non-DT part of the code.

struct s3c64xx_spi_csinfo *cs = spi->controller_data;

This will update the cs->line and cs->fb_delay in case of non-DT.
>
>>       of_property_read_u32(data_np, "samsung,spi-feedback-delay", &fb_delay);
>>       cs->fb_delay = fb_delay;
>>       of_node_put(data_np);
>> +
>
> Usually is better to not mix style and functionality changes in the same patch
> since it makes harder to review.
>
>>       return cs;
>>  }
>>
>> @@ -828,8 +823,6 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
>>                                       cs->line, err);
>>                               goto err_gpio_req;
>>                       }
>> -
>> -                     spi->cs_gpio = cs->line;
>>               }
>>
>>               spi_set_ctldata(spi, cs);
>> @@ -884,7 +877,8 @@ setup_exit:
>>       /* setup() returns with device de-selected */
>>       writel(S3C64XX_SPI_SLAVE_SIG_INACT, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
>>
>> -     gpio_free(cs->line);
>> +     if (cs->line)
>> +             gpio_free(cs->line);
>
> Same here, we can just get rid of cs->line and use gpio_free(spi->cs_gpio) instead.
This is to keep the non-DT part untouched.
>
>>       spi_set_ctldata(spi, NULL);
>>
>>  err_gpio_req:
>> @@ -1077,7 +1071,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
>>       sdd->sfr_start = mem_res->start;
>>       sdd->cs_gpio = true;
>>       if (pdev->dev.of_node) {
>> -             if (!of_find_property(pdev->dev.of_node, "cs-gpio", NULL))
>> +             if (!of_find_property(pdev->dev.of_node, "cs-gpios", NULL))
>>                       sdd->cs_gpio = false;
>
> I think we can get rid of sdd->cs_gpio as well. You can always use
> gpio_is_valid(spi->cs_gpio) or if (master->cs_gpios) to figure out if the SPI
> device has a cs-gpios array associated.
This is to keep the non-DT part untouched
>
>>
>>               ret = of_alias_get_id(pdev->dev.of_node, "spi");
>>
>
> Best regards,
> Javier
Will re-spin after waiting for a couple of more comments.
Thanks for your review.


-- 
Shine bright,
(: Nav :)
