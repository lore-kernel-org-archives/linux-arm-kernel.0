From: stigge@antcom.de (Roland Stigge)
Date: Fri, 28 Sep 2012 10:51:46 +0200
Subject: [PATCH RFC 1/2] gpio: Add a block GPIO API to gpiolib
In-Reply-To: <20120928075145.GW17667@game.jcrosoft.org>
References: <1348780923-27428-1-git-send-email-stigge@antcom.de>
 <20120928024744.GV17667@game.jcrosoft.org> <50654E57.3080201@antcom.de>
 <20120928075145.GW17667@game.jcrosoft.org>
Message-ID: <50656522.1050900@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On 09/28/2012 09:51 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> Right - will add checking for the request state of the respective GPIOs.
>>
>> The list of GPIOs to handle is defined by the offset (specified GPIO)
>> and bitmapped list.
>>
>> If it looks more natural, I can change this to a list of ints specifying
>> GPIOs directly.
> you pass the correctly information to the gpiolib
> 
> as if you do not request the gpio the gpiolib will auto request the gpios
> so you api will be 
> int gpio_get_block(unsigned int *gpios, u8* values, size_t size);
> 
> return an error
> 
> int gpio_set_block(unsigned int *gpios, u8* set, size_t size);
> 
> so you do not care about the banks you work on the gpiolib framework will call
> each gpio_chip seperatly. If the set_block get_block is not availlable the
> gpiolib could fallback to get/set
> 
> inside of the gpiolib that you call each bank with a bitmapped list is correct
> but not in the public gpiolib API

Good idea! Talking about the public API (your above gpio_set_block()):
*gpios is a list of GPIOs, but set is still bitmapped (mapped onto the
list specified in *gpios)? To prevent confusion about what the size
argument means (number of gpios in *gpios _or_ number of bytes in the
bitmap *set) - wouldn't it be clearer to have a "bool *set" and "bool
*values" list?

>>> And how you can hope to describe this via DT
>>
>> Haven't had planned that yet. Finally, this interface should just be
>> another view on the GPIOs already requested / assigned. Or which
>> additional info do you mean?
> how do you plan to give the gpio base vai DT to the driver as via DT we just
> pass the list of GPIO to work on

Right. If I understand correctly, with the above discussed changes, this
"GPIO base" issue is gone...

Thanks for your feedback!

Roland
