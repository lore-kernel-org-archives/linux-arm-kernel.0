From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Fri, 26 Jan 2018 19:13:32 +0200
Subject: [RFC PATCH 2/2] gpio: provide a consumer when requesting a gpio
In-Reply-To: <20180126073213.GW3055@rfolt0960.corp.atmel.com>
References: <20180115162407.6314-1-ludovic.desroches@microchip.com>
 <20180115162407.6314-3-ludovic.desroches@microchip.com>
 <CACRpkdbsYyHRz826K0QA=Y7Dvf_sm714o5601KBD7Zo4+1hrQA@mail.gmail.com>
 <20180118152228.GX2989@rfolt0960.corp.atmel.com>
 <20180124130705.GN3055@rfolt0960.corp.atmel.com>
 <CAHp75VeuX8kGumtiu6iBhJ+AL+Ug3dm5Pb_tQ8YYYU9SH+QSZA@mail.gmail.com>
 <20180126073213.GW3055@rfolt0960.corp.atmel.com>
Message-ID: <CAHp75Vfe_Zf1bqOEmTprxiy=o0ROUnj4F5aZKP7=q3CjiXT5oA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 26, 2018 at 9:32 AM, Ludovic Desroches
<ludovic.desroches@microchip.com> wrote:
> On Wed, Jan 24, 2018 at 05:42:15PM +0200, Andy Shevchenko wrote:
>> On Wed, Jan 24, 2018 at 3:07 PM, Ludovic Desroches
>> <ludovic.desroches@microchip.com> wrote:
>> > On Thu, Jan 18, 2018 at 04:22:28PM +0100, Ludovic Desroches wrote:
>> >> On Thu, Jan 18, 2018 at 11:30:00AM +0100, Linus Walleij wrote:

>> >> > Can't we just look up the associated gpio_chip from the GPIO range,
>> >> > and in case the pin is connected between the pin controller and
>> >> > the GPIO chip, then we allow the gpiochip to also take a
>> >> > reference?
>>
>> How do you find my proposal about introducing ownership level (not
>> requested yet; exclusive; shared)?

> Yes but I don't see how I can fix my issue with these levels. In my
> case, I need an exclusive ownership at device level not at pin level. In
> reality, it is at pin level but I am in this situation because my pin
> controler was introduced as non strict and also because I need to set
> the configuration of the pin which is going to be used as a GPIO.
>
> If the ownership is exclusive, pinmuxing coming from pinctrl-default
> will be accepted but the GPIO request will fail even if it comes from the
> same device.

The problem here is to declare a right consumer of the resource.

My understanding that consumer at the end is device or device(s):

none: resource is free to acquire
exclusive: certain device has access to the resource (pin)
shared: several devices may access to the resource

In both cases couple of caveats:
- power management has a special access level to the resource on
behalf of the owner(s)
- it can have some flags, like 'locked', which means no more owners
can be changed / added, but still possible to free resource by all
owners to go to state 'none'

> If the ownership is shared then, pinmuxing coming from pinctrl-default
> will be accepted but a GPIO request from another device will be accepted
> too.
>
> Both situations are incorrect in my case.

Yes, since the ownership design is based on subsystem rather consumer device.

> Let me know if I have not well understood your proposal. My concern is
> to get out of this situation without breaking current DTs.

See above, hope it clarifies a bit.

-- 
With Best Regards,
Andy Shevchenko
