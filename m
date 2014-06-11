From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Wed, 11 Jun 2014 11:40:40 +0530
Subject: [PATCH 1/2 v2] spi: s3c64xx: use "cs-gpios" from spi node instead
 of "cs-gpio"
In-Reply-To: <CAD=FV=WgvyF-P+69SdmCGX0jxJ3FVxpa+AcgQKg-Emya_W-w3Q@mail.gmail.com>
References: <1402394881-31564-1-git-send-email-ch.naveen@samsung.com>
 <1402394881-31564-2-git-send-email-ch.naveen@samsung.com>
 <CAD=FV=WgvyF-P+69SdmCGX0jxJ3FVxpa+AcgQKg-Emya_W-w3Q@mail.gmail.com>
Message-ID: <CAHfPSqBrAPa6eo63OFk0-TQtKY9GcOv1AXrN0rtsCxfU6fC5uQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Doug,

On 10 June 2014 23:56, Doug Anderson <dianders@chromium.org> wrote:
> Naveen,
>
> Not a full review, but a few quick things I happened to notice:
>
> On Tue, Jun 10, 2014 at 3:08 AM, Naveen Krishna Chatradhi
> <ch.naveen@samsung.com> wrote:
>> @@ -94,7 +93,6 @@ Example:
>>                         spi-max-frequency = <10000>;
>>
>>                         controller-data {
>> -                               cs-gpio = <&gpa2 5 1 0 3>;
>>                                 samsung,spi-feedback-delay = <0>;
>
> In a future patch (not this one!) it might make sense to also move
> spi-feedback-delay out.
After this change, "cs->line" in the struct s3c64xx_spi_csinfo {} is useless.
Will take others opinion and remove "fb_delay" too.
>
>
>> +static struct s3c64xx_spi_csinfo *s3c64xx_get_cs_gpios(struct spi_device *spi)
>
> I believe that you can make use of the fact that the SPI core already
> got these GPIOs for you.  See of_spi_register_master().  Everything
> you need ought to be in master->num_chipselect and master->cs_gpios.
cs->line is a duplicate and can be replaced with master->cs_gpios from SPI core.
>
> Strangely, it doesn't look like any other drivers use this, so
> possibly I'm confused...
>
>
>> @@ -806,9 +815,14 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
>>         struct s3c64xx_spi_info *sci;
>>         int err;
>>
>> +       if (!spi->dev.of_node) {
>> +               dev_err(&spi->dev, "device node not found\n");
>> +               return -EINVAL;
>> +       }
>
> This seems incredibly broken.  You're saying that the SPI driver no
> longer works without the device tree?  I don't think that's desirable,
> but I suppose I could be wrong.
I will move this check to the s3c64xx_get_slave_ctrldata() function.


I guess the non-DT version of the driver is broken too.
For non-DT driver sdd->cs_gpio is true, but the cs->line is never initialized.
>
> Also note that you still left an "if" test below for trying to deal
> with the fact that there is no "of_node".

>
>
> -Doug



-- 
Shine bright,
(: Nav :)
