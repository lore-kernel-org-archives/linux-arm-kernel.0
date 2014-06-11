From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 11 Jun 2014 20:18:20 +0200
Subject: [PATCH 1/2 v3] spi: s3c64xx: use "cs-gpios" from spi node instead
 of "cs-gpio"
In-Reply-To: <539896FB.4050702@gmail.com>
References: <1402468318-7342-1-git-send-email-ch.naveen@samsung.com>
 <539839D6.1050305@collabora.co.uk>
 <CAHfPSqCYqTRBBH56y81na-t18pvoPmyWobZwXNgkrtq=H_79CQ@mail.gmail.com>
 <5398918F.4060800@collabora.co.uk> <539896FB.4050702@gmail.com>
Message-ID: <53989D6C.5080806@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Tomasz,

On 06/11/2014 07:50 PM, Tomasz Figa wrote:
> On 11.06.2014 19:27, Javier Martinez Canillas wrote:
>> On 06/11/2014 01:38 PM, Naveen Krishna Ch wrote:
>>> On 11 June 2014 16:43, Javier Martinez Canillas
>>> <javier.martinez@collabora.co.uk> wrote:
>>>> On 06/11/2014 08:31 AM, Naveen Krishna Chatradhi wrote:
> 
> [snip]
> 
>>>>
>>>>>               return ERR_PTR(-EINVAL);
>>>>>       }
>>>>> +     cs->line = spi->cs_gpio;
>>>>>
>>>>
>>>> I wonder why are you keeping cs->line? AFAICT it's only used in
>>>> s3c64xx_spi_setup() to request the GPIO and since you get the struct spi_device
>>>> pointer as a parameter then you can just use spi->s_gpio instead.
>>> I'm trying not to touch the non-DT part of the code.
>>>
>>> struct s3c64xx_spi_csinfo *cs = spi->controller_data;
>>>
>>> This will update the cs->line and cs->fb_delay in case of non-DT.
>> 
>> I see, then I prefer the opposite and do something like this on s3c64xx_spi_probe():
>> 
>> if (!pdev->dev.of_node)
>>        spi->cs_gpio = cs->line;
> 
> Hmm, as far as I understand, spi here is spi_device, not spi_master. I
> don't think you have access to SPI devices on your bus in controller
> probe().
> 

Right, I was actually looking at s3c64xx_spi_setup() when I wrote that but for
some reason I got confused and thought it was the probe() function.

Sorry for the confusion.

> What I think could work is reworking the driver to:
> 
> - in DT case, don't do anything in the driver about the GPIO chip
> select, because it will be handled automatically by the core.
> 
> - in non-DT case, in s3c64xx_spi_setup(), just take the GPIO pin from
> s3c64xx_spi_csinfo struct passed through spi->controller_data, request
> it and save it to spi->cs_gpio,
> 
> - in non-DT case, in s3c64xx_spi_cleanup(), free the GPIO requested in
> s3c64xx_spi_setup() and set spi->cs_gpio to -ENOENT (as done initially
> in spi_alloc_device()).
> 
> Best regards,
> Tomasz
> 

Best regards,
Javier
