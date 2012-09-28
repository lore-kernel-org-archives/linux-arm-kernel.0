From: stigge@antcom.de (Roland Stigge)
Date: Fri, 28 Sep 2012 09:14:31 +0200
Subject: [PATCH RFC 1/2] gpio: Add a block GPIO API to gpiolib
In-Reply-To: <20120928024744.GV17667@game.jcrosoft.org>
References: <1348780923-27428-1-git-send-email-stigge@antcom.de>
 <20120928024744.GV17667@game.jcrosoft.org>
Message-ID: <50654E57.3080201@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On 09/28/2012 04:47 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> +Block GPIO (optional)
>> +---------------------
>> +
>> +The above described interface concentrates on handling single GPIOs.  However,
>> +in applications where it is critical to set several GPIOs at once, this
>> +interface doesn't work well, e.g. bit-banging protocols via GPIO lines.
>> +Consider a GPIO controller that is connected via a slow I2C line. When
>> +switching two or more GPIOs one after another, there can be considerable time
>> +between those events. This is solved by an interface called Block GPIO:
>> +
>> +void gpio_get_block(unsigned int gpio, u8* values, size_t size);
>> +void gpio_set_block(unsigned int gpio, u8* set, u8* clr, size_t size);
>> +
>> +The function gpio_get_block() detects the current state of several GPIOs at
>> +once, practically by doing only one query at the hardware level (e.g. memory
>> +mapped or via bus transfers like I2C). There are some limits to this interface:
>> +A certain gpio_chip (see below) must be specified via the gpio parameter as the
>> +first GPIO in the gpio_chip group. The Block GPIO interface only supports
>> +simultaneous handling of GPIOs in the same gpio_chip group since different
>> +gpio_chips typically map to different GPIO hardware blocks.
> so basicaly you use a gpio numberthat you do not request, that is maybe
> requested. This is broken if you want to get or set block you need to pass the
> list of GPIO you want to control not some fancy magic

Right - will add checking for the request state of the respective GPIOs.

The list of GPIOs to handle is defined by the offset (specified GPIO)
and bitmapped list.

If it looks more natural, I can change this to a list of ints specifying
GPIOs directly.

> And how you can hope to describe this via DT

Haven't had planned that yet. Finally, this interface should just be
another view on the GPIOs already requested / assigned. Or which
additional info do you mean?

Thanks for your notes!

Roland
