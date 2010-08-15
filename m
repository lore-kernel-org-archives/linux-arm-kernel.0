From: grinberg@compulab.co.il (Igor Grinberg)
Date: Sun, 15 Aug 2010 10:29:54 +0300
Subject: [PATCH 3/3] usb/otg/ulpi: extend the generic ulpi driver.
In-Reply-To: <20100813132717.GA6986@as23.pp.htv.fi>
References: <1279198816-30367-1-git-send-email-grinberg@compulab.co.il>
	<1279198816-30367-4-git-send-email-grinberg@compulab.co.il>
	<20100813132717.GA6986@as23.pp.htv.fi>
Message-ID: <4C679772.3090802@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/13/10 16:27, Heikki Krogerus wrote:
> Hi,
>
> This patch has already been applied and I have totally missed it,
> sorry about that, but I have to ask..
>   

Hi,

It was on the list more then a week, I think, and then in linux-next.
I really wanted some eyes on it involved, so may be we could design
something better then what I've done, but it is never too late ;)

> On Thu, Jul 15, 2010 at 04:00:16PM +0300, Igor Grinberg wrote:
>   
>> 1) Introduce ulpi specific flags for control of the ulpi phy
>> 2) Extend the generic ulpi driver with support for Function and
>> Interface control of upli phy
>> 3) Update the platforms using the generic ulpi driver with new ulpi
>> flags
>> 4) Remove the otg control flags not in use
>>
>> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
>>     
> <snip>
>
>   
>> diff --git a/include/linux/usb/ulpi.h b/include/linux/usb/ulpi.h
>> index 900d97b..82b1507 100644
>> --- a/include/linux/usb/ulpi.h
>> +++ b/include/linux/usb/ulpi.h
>> @@ -15,6 +15,41 @@
>>  /*-------------------------------------------------------------------------*/
>>  
>>  /*
>> + * ULPI Flags
>> + */
>> +#define ULPI_OTG_ID_PULLUP		(1 << 0)
>> +#define ULPI_OTG_DP_PULLDOWN_DIS	(1 << 1)
>> +#define ULPI_OTG_DM_PULLDOWN_DIS	(1 << 2)
>> +#define ULPI_OTG_DISCHRGVBUS		(1 << 3)
>> +#define ULPI_OTG_CHRGVBUS		(1 << 4)
>> +#define ULPI_OTG_DRVVBUS		(1 << 5)
>> +#define ULPI_OTG_DRVVBUS_EXT		(1 << 6)
>> +#define ULPI_OTG_EXTVBUSIND		(1 << 7)
>>     
> Why are you redefining these? If you look through the file you'll find
> the same bits are already there for OTG Control?
>   

Well, trust me I went through the file and more then one time.
If you overlook the changes in the ulpi.h, you can see that I've added
the comment before register bits, so it will be clearer.

The idea of the flags is to provide a control of the ulpi phy by the ulpi
driver only, so whoever wants to use it (any platform, not just imx),
will only specify the flags different from the default of the ulpi spec.
and the ulpi driver will take care of the rest (perfect case).

This makes any platform independent from the ulpi registers,
thus separating the interface from the implementation.
Makes possible for some changes (if ever) in ulpi spec. be
transparent to the ulpi driver users.
Lowers the legitimation for using the ulpi registers directly in
the platform code (like it is currently done in imx ehci glue).
Lets ulpi_create() method stay only with one parameter (flags)
instead of adding two more parameters for IC and FC.

Moreover, the best thing to do is to place the register bits only
inside ulpi.c and provide functional methods (like the
ulpi_set_host/peripheral(), etc..) and the flags above to control
their behavior.
I wanted to do this in first place, but currently, the ulpi driver
we have is not ready to deal with all the control of the ulpi phy
(it will never be, if nobody will contribute to it), I cannot afford
to myself this amount of work right now and I don't have
the imx hardware to test the changes in imx-ehci glue.

>   
>> +#define ULPI_IC_6PIN_SERIAL		(1 << 8)
>> +#define ULPI_IC_3PIN_SERIAL		(1 << 9)
>> +#define ULPI_IC_CARKIT			(1 << 10)
>> +#define ULPI_IC_CLKSUSPM		(1 << 11)
>> +#define ULPI_IC_AUTORESUME		(1 << 12)
>> +#define ULPI_IC_EXTVBUS_INDINV		(1 << 13)
>> +#define ULPI_IC_IND_PASSTHRU		(1 << 14)
>> +#define ULPI_IC_PROTECT_DIS		(1 << 15)
>>     
> Why bit offsets starting from (1 << 8)?

This is because they are not bits, but flags, so they can start
wherever you want. This provides the separation between the
interface and the implementation (I've already explained it above).

>  I took a look at ulpi.c and
> you are still using ULPI_IFC_CTRL register, so these offsets can't
> possibly work.

Of course I use the registers, it is the ulpi spec. is what defines
them, but the right thing is to move the registers and bits into
the ulpi driver (as I've explained above).

>  There are also existing definitions for ULPI Interface
> Control bits in any case.
>   

I wanted to make the flags somewhat consistent with the
registers bits and also fit one u32 parameter variable of
ulpi_create().

>   
>> +#define ULPI_FC_HS			(1 << 16)
>> +#define ULPI_FC_FS			(1 << 17)
>> +#define ULPI_FC_LS			(1 << 18)
>> +#define ULPI_FC_FS4LS			(1 << 19)
>> +#define ULPI_FC_TERMSEL			(1 << 20)
>> +#define ULPI_FC_OP_NORM			(1 << 21)
>> +#define ULPI_FC_OP_NODRV		(1 << 22)
>> +#define ULPI_FC_OP_DIS_NRZI		(1 << 23)
>> +#define ULPI_FC_OP_NSYNC_NEOP		(1 << 24)
>> +#define ULPI_FC_RST			(1 << 25)
>> +#define ULPI_FC_SUSPM			(1 << 26)
>>     
> Same here?
>
> I'm asking in case I'm missing something and there is a reason the
> above, before sending any patches.
>   

I hope the reason is clear now :)
Also, I'm trying to get more attention of the imx guys.
There is a ulpi driver, please use/develop it where
possible/appropriate instead of locking the code in
platforms (e.g. imx-ehci glue).
This way more platforms can benefit from your contribution.

> br,
>
>   

-- 
Regards,
Igor.
