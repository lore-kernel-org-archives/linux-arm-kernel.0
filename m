From: ext-heikki.krogerus@nokia.com (Heikki Krogerus)
Date: Mon, 16 Aug 2010 12:37:24 +0300
Subject: [PATCH 3/3] usb/otg/ulpi: extend the generic ulpi driver.
In-Reply-To: <4C679772.3090802@compulab.co.il>
References: <1279198816-30367-1-git-send-email-grinberg@compulab.co.il>
	<1279198816-30367-4-git-send-email-grinberg@compulab.co.il>
	<20100813132717.GA6986@as23.pp.htv.fi>
	<4C679772.3090802@compulab.co.il>
Message-ID: <20100816093724.GA2916@esdhcp041123.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Aug 15, 2010 at 09:29:54AM +0200, ext Igor Grinberg wrote:
>On 08/13/10 16:27, Heikki Krogerus wrote:
>> This patch has already been applied and I have totally missed it,
>> sorry about that, but I have to ask..
>
> It was on the list more then a week, I think, and then in linux-next.
> I really wanted some eyes on it involved, so may be we could design
> something better then what I've done, but it is never too late ;)

I was on vacation, and only now saw your patches. Sorry about the late
comments.
 
>> On Thu, Jul 15, 2010 at 04:00:16PM +0300, Igor Grinberg wrote:
>>>  /*
>>> + * ULPI Flags
>>> + */
>>> +#define ULPI_OTG_ID_PULLUP		(1 << 0)
>>> +#define ULPI_OTG_DP_PULLDOWN_DIS	(1 << 1)
>>> +#define ULPI_OTG_DM_PULLDOWN_DIS	(1 << 2)
>>> +#define ULPI_OTG_DISCHRGVBUS		(1 << 3)
>>> +#define ULPI_OTG_CHRGVBUS		(1 << 4)
>>> +#define ULPI_OTG_DRVVBUS		(1 << 5)
>>> +#define ULPI_OTG_DRVVBUS_EXT		(1 << 6)
>>> +#define ULPI_OTG_EXTVBUSIND		(1 << 7)
>>>     
>> Why are you redefining these? If you look through the file you'll find
>> the same bits are already there for OTG Control?
>>   
>
> Well, trust me I went through the file and more then one time.
> If you overlook the changes in the ulpi.h, you can see that I've added
> the comment before register bits, so it will be clearer.
> 
> The idea of the flags is to provide a control of the ulpi phy by the ulpi
> driver only, so whoever wants to use it (any platform, not just imx),
> will only specify the flags different from the default of the ulpi spec.
> and the ulpi driver will take care of the rest (perfect case).
> 
> This makes any platform independent from the ulpi registers,
> thus separating the interface from the implementation.
> Makes possible for some changes (if ever) in ulpi spec. be
> transparent to the ulpi driver users.
> Lowers the legitimation for using the ulpi registers directly in
> the platform code (like it is currently done in imx ehci glue).
> Lets ulpi_create() method stay only with one parameter (flags)
> instead of adding two more parameters for IC and FC.
> 
> Moreover, the best thing to do is to place the register bits only
> inside ulpi.c and provide functional methods (like the
> ulpi_set_host/peripheral(), etc..) and the flags above to control
> their behavior.
> I wanted to do this in first place, but currently, the ulpi driver
> we have is not ready to deal with all the control of the ulpi phy
> (it will never be, if nobody will contribute to it), I cannot afford
> to myself this amount of work right now and I don't have
> the imx hardware to test the changes in imx-ehci glue.

OK, I get your idea now with the flags now. Should have read the code
more carefully. I'm not sure if it's the right way though, but if you
can show that they are beneficial in more then one case, then I'm sure
there is no problem with them. Please consider the following.

It seems that many ulpi transceivers are autonomous as they say.
There is little if any need to access ulpi registers expect the
vendor specific ones. The vendor specific stuff will require register
access in any case and in some cases they need the transceivers to be
programmed in a specific way. Right now to me using the flags for the
common parts and then separately programming the vendor specific stuff
does not seem very efficient. 

I need to re-send the charger driver for isp170x. These transceivers
are fairly commonly used with musb, and most platform probable only
need nop-usb-xceiv.c with them. However, the charger detection needs
access to the common ulpi registers as well as the vendor specific
ones. If you see that you can make this kind of functions work with
the flags, then I'm OK with them. 

The twl4030-usb has a few places where it needs to program some common
ulpi registers. Those would need to be removed, or the file would need
separate definitions for the ulpi registers if you want to only define
the register only in ulpi.c. Maybe you could give it a quick look
and see how would it be handled with the flags.

br,
-- 
heikki
