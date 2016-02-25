From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 25 Feb 2016 18:24:14 +0100
Subject: [PATCH v2] tty/serial: at91: restore dynamic driver binding
In-Reply-To: <CAGkQfmOYEiXbQbe14iybu_4BFQYtoAj4QWoxdhPvUJOCOm6sbw@mail.gmail.com>
References: <1456392221-30401-1-git-send-email-romain.izard.pro@gmail.com>
 <56CED0E3.5070308@atmel.com> <20160225160929.GA20373@kroah.com>
 <CAGkQfmOYEiXbQbe14iybu_4BFQYtoAj4QWoxdhPvUJOCOm6sbw@mail.gmail.com>
Message-ID: <56CF38BE.9030304@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 25/02/2016 18:08, Romain Izard a ?crit :
> 2016-02-25 17:09 GMT+01:00 Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>:
>> On Thu, Feb 25, 2016 at 11:01:07AM +0100, Nicolas Ferre wrote:
>>> Le 25/02/2016 10:23, Romain Izard a ?crit :
>>>> In commit c39dfebc7798956fd2140ae6321786ff35da30c3, the modular
>>>> support code for atmel_serial was removed, as the driver cannot be
>>>> built as a module. Because no use case was proposed, the dynamic
>>>> driver binding support was removed as well.
>>>>
>>>> The atmel_serial driver can manage up to 7 serial controllers,
>>>> which are multiplexed with other functions. For example, in the
>>>> Atmel SAMA5D2, the Flexcom controllers can work as USART, SPI or
>>>> I2C controllers, and on all Atmel devices serial lines can be
>>>> reconfigured as GPIOs.
>>>>
>>>> My use case uses GPIOs to transfer a firmware update using a custom
>>>> protocol on the lines used as a serial port during the normal life
>>>> of the device. If it is not possible to unbind the atmel_serial
>>>> driver, the GPIO lines remain reserved and prevent this case from
>>>> working.
>>>>
>>>> This patch reinstates the atmel_serial_remove function, and fixes
>>>> it as it failed to clear the "clk" field on removal, triggering an
>>>> oops when a device was bound again after being unbound.
>>>>
>>>> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
>>>
>>> Even if you didn't follow my advice for not including unneeded
>>> changes in of the last patch chunk, there's no use delaying the patch
>>> just for this. So, here is my:
>>
>> Yes there is, I'm not going to take this, Romain please fix it
>> properly.
> 
> Are we really arguing about the alignement of of_match_table in the
> platform_driver initializer?
> 
> Among other things, Paul's patch changed the alignment to match the
> width of the "suppress_bind_attrs" member. As I simply used 'git revert
> -p' to revert the parts of the patch that bothered me, the alignment
> returned to what it was before.
> 
> Or am I missing something else ?

Romain,

We are just saying that a patch with:

-		.name			= "atmel_usart",
-		.of_match_table		= of_match_ptr(atmel_serial_dt_ids),
-		.suppress_bind_attrs    = true,
+		.name	= "atmel_usart",
+		.of_match_table	= of_match_ptr(atmel_serial_dt_ids),

Is less readable than a patch with only the relevant part, the single line:

-		.suppress_bind_attrs = true,

So, whichever is the history of the patch, it has to simply modify the needed
lines so that we don't even ask ourselves what is the purpose of some of the changes.

Bye,
-- 
Nicolas Ferre
