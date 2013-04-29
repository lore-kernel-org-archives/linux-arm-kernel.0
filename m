From: syin@broadcom.com (Sherman Yin)
Date: Mon, 29 Apr 2013 23:46:51 +0000
Subject: Adding a void * to pinctrl_pin_desc
In-Reply-To: <CACRpkdY2vWvvE_NToQ5rkxGC32hCJgMjNpkF+KEGJ+-o4My4-Q@mail.gmail.com>
References: <051069C10411E24D9749790C498526FA1BCF4FC6@SJEXCHMB12.corp.ad.broadcom.com>
 <CACRpkdYxJOWYMfwmrEGhqgjushVjWyc=FyKMaZNLnn=0jrTs9A@mail.gmail.com>
 <051069C10411E24D9749790C498526FA1BCF54B1@SJEXCHMB12.corp.ad.broadcom.com>
 <CACRpkdY2vWvvE_NToQ5rkxGC32hCJgMjNpkF+KEGJ+-o4My4-Q@mail.gmail.com>
Message-ID: <051069C10411E24D9749790C498526FA1BCF58EB@SJEXCHMB12.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Hmm, while it would be easy to create a macro to fill the static foo_pin_desc array
>> in the driver, this array would not be suitable for use with pinctrl_register().
> 
> Now I start to change opinion. You're right about this.
> 
>> I would have to, in the probe function, loop through the foo_pin_desc array and
>> create another pinctrl_pin_desc array to use for pinctrl_desc.pins.
> 
> Yeah that sucks.
> 
>> I think I'll just use a separate struct in the driver to keep track of other pin-specific data.
> 
> No I think I have changed opinion. Can you send a patch adding a void * to
> struct pinctrl_pin_desc  as patch [1/n] when you send your driver, and
> I think I'll be happy with it.

Great!  This will definitely work for my chip, and I can do it as the first of n patches 
for my driver later.  While we are considering a change to pinctrl_pin_desc, I just 
want to point out a more forward-thinking solution:

The void* method works well for my chip where each pin can be one of only 
3 types, such as:

=====
static const int std_pin = PIN_TYPE_STD;
static const int i2c_pin = PIN_TYPE_I2C;

#define FOO_PIN(a,b,c) {.number=a, .name=b, .drv_data=&c)

static const struct pinctrl_pin_desc foo_pins[] = {
  FOO_PIN(PIN_NUM_1, "pin name 1", std_pin),
  FOO_PIN(PIN_NUM_2, "pin name 2", i2c_pin),
  FOO_PIN(PIN_NUM_3, "pin name 3", i2c_pin),
  ...
};
=====

but this may not work well for drivers where the private data is unique for every 
pin.  drv_data is a void*, so the data has to be defined first (potentially, this is another 
long array) before the pinctrl_pin_desc MACRO can refer to the address like the 
code above.  

I think ultimately the most flexible solution would be to let each driver define their own 
pin_desc like pin groups and pin functions.  This would involve some changes 
to the core:
- instead of having a pinctrl_pin_desc array in pinctrl_desc, expand it to 2 arrays - 
unsigned pin_number array and const char pin_name array
- APIs such as pinctrl_register() and pinctrl_free_pindescs() will have to similarly 
expand pinctrl_pin_desc into its 2 components.

Right now, I don't think it is worth the effort to change all the drivers and core code for
this flexibility, since no driver currently uses it.  Just wanted to point this out for 
consideration.

Thanks,
Sherman
