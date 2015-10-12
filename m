From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 12 Oct 2015 23:07:28 +0200
Subject: [PATCH] pxa: remove incorrect __init annotation on
 pxa27x_set_pwrmode
In-Reply-To: <5395757.goqVg4VzNo@wuerfel> (Arnd Bergmann's message of "Mon, 12
 Oct 2015 21:20:17 +0200")
References: <5287252.pkh9x0t1Y6@wuerfel> <874mhw6mj1.fsf@belgarion.home>
 <87r3kz6hq9.fsf@belgarion.home> <5395757.goqVg4VzNo@wuerfel>
Message-ID: <87fv1f6bjj.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

>> It looks to me the powermode should be initialized once and for all in the
>> machine init code. So unless I've overseen something, I'll keep Thierry's patch.
>
> Ah, sorry. I should have looked at the link you sent.
>
> Thierry's patch indeed looks much nicer if that works, but I'm not entirely
> sure if it is safe or not. Only two other pxa27x machines set the PWRMODE_DEEPSLEEP
> flag, so it looks like there is a reason for some machines not to set it.
Yes, the reason is that the default is set PWRMODE_SLEEP as set in pxa27x.c
This is the only choice for suspend to RAM, as it :
 - disables a lot of power islands
 - and yet keeps Vcc_Mem powered for suspend to RAM

> The z2 in particular never did, except in the powerdown handler. So if it
> is unable to wake up reliably from DEEPSLEEP, that may be a reason to use
> that flag only in the poweroff function but not during normal operation.
My first thought was :
	This flag's only use is for Suspend to RAM.  There might be special
	wirings where the voltage to the RAM is provided out of SYS_EN pin
	control, and therefore PWRMODE_DEEPSLEEP is possible. But the most
	common pattern would be a PMIC, providing voltage to the DRAM through
	Vcc_Mem.

But having a closer look, you're right, I have misunderstood the way z2 poweroff
was designed. The setting of poweroff to PWRMODE_DEEPSLEEP +
pxa27x_cpu_pm_enter() is a whole, it is the closest to a platform halt where no
external chip handles the poweroff phase, and memory is shutdown in deep sleep.

Therefore I'll drop Thierry's patch (which would actually break suspend to RAM I
think) and take yours.

Cheers.

-- 
Robert
