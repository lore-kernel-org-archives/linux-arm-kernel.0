From: dianders@chromium.org (Doug Anderson)
Date: Tue, 10 Jun 2014 13:21:50 -0700
Subject: [PATCH 1/2 v2] spi: s3c64xx: use "cs-gpios" from spi node instead
 of "cs-gpio"
In-Reply-To: <539763BF.1030209@gmail.com>
References: <1402394881-31564-1-git-send-email-ch.naveen@samsung.com>
 <1402394881-31564-2-git-send-email-ch.naveen@samsung.com>
 <53976154.60308@gmail.com>
 <CAD=FV=X5nLM3Yqkvk+UqVZPFzVNHmPDn3y+euYDwZ3M2bG+0Cg@mail.gmail.com>
 <539763BF.1030209@gmail.com>
Message-ID: <CAD=FV=V9Qd=aYDAkJuic2DbBaY=0E5UpNnnBHfEBqE5rvYLKVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz,

On Tue, Jun 10, 2014 at 12:59 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On 10.06.2014 21:58, Doug Anderson wrote:
>> Tomasz,
>>
>> On Tue, Jun 10, 2014 at 12:49 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>>> This is wrong. The "cs-gpios" property is supposed to be an array,
>>> indexed by chip select number of SPI devices (indicated by their "reg"
>>> properties).
>>>
>>> Moreover, is there a need to parse this manually in this driver? I can
>>> see respective parsing code in of_spi_register_master().
>>
>> I noticed this too (see my response), but I was confused about the
>> fact that nobody else uses the array created by
>> of_spi_register_master().  Any idea why?
>
> Hmm, I can see of_spi_register_master() assigning allocated pointer to
> master->cs_gpios, which is then used in spi_add_device() as follows:
>
>         if (master->cs_gpios)
>                 spi->cs_gpio = master->cs_gpios[spi->chip_select];

OK.  I haven't traced through all the code, but I did notice:

* spi-gpio.c: has its own cs_gpios[0], initted with of_get_named_gpio()
* spi-dw-mmio.c, spi-efm32.c, spi-imx.c, spi-pl022.c, spi-sirf.c all
seem to be looking at "cs-gpios" directly.

...but I see now that you're right that most drivers don't need to
actually look at cs_gpios and can just look at the device itself.

-Doug
