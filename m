From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 28 Sep 2012 18:01:05 +0200
Subject: [PATCH RFC 1/2] gpio: Add a block GPIO API to gpiolib
In-Reply-To: <50658AD0.1050501@antcom.de>
References: <1348780923-27428-1-git-send-email-stigge@antcom.de>
 <20120928024744.GV17667@game.jcrosoft.org>
 <50654E57.3080201@antcom.de>
 <20120928075145.GW17667@game.jcrosoft.org>
 <50656522.1050900@antcom.de>
 <20120928090848.GX17667@game.jcrosoft.org>
 <20120928102822.GY17667@game.jcrosoft.org>
 <50658AD0.1050501@antcom.de>
Message-ID: <20120928160105.GA17667@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13:32 Fri 28 Sep     , Roland Stigge wrote:
> On 09/28/2012 12:28 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >> gpio0 = {1};
> >> set0 = {1};
> >>
> >> gpio1 = {33, 34};
> > here should be
> > 
> > pin0 = {1};
> > set0 = {1};
> > 
> > pin1 = {1, 2, 23};
> > set1 = {0, 0, 1};
> > 
> > set_blocks(gpio_chip0, pin0, set0, 1);
> > set_blocks(gpio_chip1, pin1, set1, 3);
> > 
> > You may need to add a prepare to do not do the conversion between array and
> > gpio_chip array as I guess you will work on gpio block with multiple time
> > acces
> 
> Maybe like this, for some struct block *?
> 
> block = set_block_prepare(gc, pins, values, size);
> if (block) {
> 	set_block(gc, block);
> 	...
> 	set_block_unprepare(gc, block);
> }
> 
> Would mean that all supported drivers would need to implement those 3
> new functions... Need to be careful about not introducing bloat...
the prepare is gpiolib specific, it will be a helper to conver a gpio list to
a gpio block list

I was thinking more

block = gpio_block_prepare(pins, size);

gpio_block_set_value(pin0, val);
gpio_block_set_value(pin1, val);
gpio_block_set_value(pin2, val);
gpio_block_set(block);

andfor get

gpio_block_get(block)
val = gpio_block_get_value(block, pin0);
val = gpio_block_get_value(block, pin1);

for the gpio driver ti's transparent

Best Regards,
J.
