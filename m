From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 28 Sep 2012 12:28:22 +0200
Subject: [PATCH RFC 1/2] gpio: Add a block GPIO API to gpiolib
In-Reply-To: <20120928090848.GX17667@game.jcrosoft.org>
References: <1348780923-27428-1-git-send-email-stigge@antcom.de>
 <20120928024744.GV17667@game.jcrosoft.org>
 <50654E57.3080201@antcom.de>
 <20120928075145.GW17667@game.jcrosoft.org>
 <50656522.1050900@antcom.de>
 <20120928090848.GX17667@game.jcrosoft.org>
Message-ID: <20120928102822.GY17667@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:08 Fri 28 Sep     , Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 10:51 Fri 28 Sep     , Roland Stigge wrote:
> > Hi!
> > 
> > On 09/28/2012 09:51 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > >> Right - will add checking for the request state of the respective GPIOs.
> > >>
> > >> The list of GPIOs to handle is defined by the offset (specified GPIO)
> > >> and bitmapped list.
> > >>
> > >> If it looks more natural, I can change this to a list of ints specifying
> > >> GPIOs directly.
> > > you pass the correctly information to the gpiolib
> > > 
> > > as if you do not request the gpio the gpiolib will auto request the gpios
> > > so you api will be 
> > > int gpio_get_block(unsigned int *gpios, u8* values, size_t size);
> > > 
> > > return an error
> > > 
> > > int gpio_set_block(unsigned int *gpios, u8* set, size_t size);
> > > 
> > > so you do not care about the banks you work on the gpiolib framework will call
> > > each gpio_chip seperatly. If the set_block get_block is not availlable the
> > > gpiolib could fallback to get/set
> > > 
> > > inside of the gpiolib that you call each bank with a bitmapped list is correct
> > > but not in the public gpiolib API
> > 
> > Good idea! Talking about the public API (your above gpio_set_block()):
> > *gpios is a list of GPIOs, but set is still bitmapped (mapped onto the
> > list specified in *gpios)? To prevent confusion about what the size
> > argument means (number of gpios in *gpios _or_ number of bytes in the
> > bitmap *set) - wouldn't it be clearer to have a "bool *set" and "bool
> > *values" list?
> public API list of gpio as example
> 
> gpios = {1, 33, 34, 55};
> set = {1, 0, 0 ,1};
> 
> gpio_set_blocks(gpios, set, 4);
> 
> private you do just provide the array related to the gpio_chip
> lets assume 4 bank with 32 gpio each
> 
> gpio0 = {1};
> set0 = {1};
> 
> gpio1 = {33, 34};
here should be

pin0 = {1};
set0 = {1};

pin1 = {1, 2, 23};
set1 = {0, 0, 1};

set_blocks(gpio_chip0, pin0, set0, 1);
set_blocks(gpio_chip1, pin1, set1, 3);

You may need to add a prepare to do not do the conversion between array and
gpio_chip array as I guess you will work on gpio block with multiple time
acces

Best Regards,
J.
