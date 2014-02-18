From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 18 Feb 2014 10:59:37 +0100
Subject: [PATCH v3 0/7] tty/serial: Add helpers to use GPIOs to control
 modem lines and implement atmel_serial.c
In-Reply-To: <1392659594.887845512@f137.i.mail.ru>
References: <1392656247-3351-1-git-send-email-richard.genoud@gmail.com>
 <1392659594.887845512@f137.i.mail.ru>
Message-ID: <53032F09.9040705@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/02/2014 18:53, Alexander Shiyan wrote:
> Hello.
> 
> ???????????, 17 ??????? 2014, 17:57 +01:00 ?? Richard Genoud <richard.genoud@gmail.com>:
>> The USART controller on sam9x5 chips (and also all AT91/SAMA5 chips
>> but at91rm9200) are not capable of handling DTR/DSR/DCD/RI signal.
>> Moreover, even if the controller can handle CTS/RTS, the dedicated
>> CTS/RTS pins are already muxed for other peripherals (LCDC/EMAC/MMC).
>>
>> So this patchset adds the possibility to control those lines via GPIO,
>> as it is done for RTS in the patch "switch atmel serial to use gpiolib"
>>
>> As it was suggested by Alexander Shiyan, I made that available for
>> every board.
>>
>> Patch 1 implements the generic helpers to control modem lines via GPIO
>> Patches 2 and 3 are just a little tidy up of atmel_serial.c.
>> Patch 4 implements modem control lines in atmel_serial atmel_serial.
>> Patches 5 and 6 implement the get_direction() gpio call for at91, as
>> it is needed by gpiod_get_direction().
>> Patch 7 implement the interrupts of CTS/DSR/DCD/RI.
> 
> I still recommend split this series. The first patch must be a separate,
> 2 and 3 - independent to this series, 5 and 6 - to the appropriate mailing lists,
> and finally as soon as all of the previous will be applied - you can send 7.

Well, I did this because I think:
- it's easier to review a patch when you have an implementation, like
atmel_serial, that follows.
- it's also easier to test atmel_serial patches if the patches it needs
are in the same thread. Testers/reviewers won't have to dig the MLs for
needed patches.
- having all those patches in one thread shows their order, and prevents
from breaking kernel compilation between patches (it's really annoying
when you hunt a bug with git bisect and at some point the kernel doesn't
compile anymore). If the series is split and patches goes in different
trees, nothing will prevent patch 1 to be applied after patch 7 and
break kernel compilation in between (AFAIK).
- maintainers are Cced to this thread, so they can easily speak to
each-other to say if one should take the whole series in its tree or if
it should go to several tree or...

But, I'm not a maintainer, so I may not see all the pros and cons of this...

Richard.
