From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 24 Aug 2015 10:25:34 +0200
Subject: [PATCH v2 16/21] ARM: pxa: magician: Add support for alternative
 LCD backlight
In-Reply-To: <55DA3357.6050304@tul.cz> (Petr Cvek's message of "Sun, 23 Aug
 2015 22:55:51 +0200")
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D25A60.7000900@tul.cz>
 <878u95685t.fsf@belgarion.home> <55DA3357.6050304@tul.cz>
Message-ID: <87mvxh2iv5.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> Dne 20.8.2015 v 22:01 Robert Jarzmik napsal(a):
>> Petr Cvek <petr.cvek@tul.cz> writes:
>> 
>>> Add support for alternative LCD backlight with GPIO (no brightness).
>> Here, I don't understand, the commit message is too short.
>> 
>> Are there 2 brightness controls on magician, or are these 2 different magicians
>> (hardware wise), each having a different backlight control ? Or is it there is a
>> GPIO to light up the screen and a PWM backlight ?
>> 
>> I have to understand first.
>> 
> I have aimed for a configuration, where user can use PWM xor GPIO backlight.
You probably know that in a backlight case GPIO is just a subcase of PWM, with
frequency equal to either 0 or max_backlight_freq.

> As pin mux can set GPIO or PWM (or UART :-D) on PWM pin, you can choose if you
> spare few kB (as magician has only 64MB RAM and 64MB flash) on GPIO or will
> have smooth backlight with PWM.

I'm in front of the same dilemna for 5 years ago with the mioa701 (64MB RAM, 2 *
32MB flash). I chose PWM, judging the PWM stack was worth it.

Moreover, pwm can be a module, loaded or not : what memory do you spare in that
case if you don't load the module ?

> I have tested both (I think I have added the gpio backlight for debugging a regression in pwm_bl).
> Only ugly thing is the GPIO definition:
>
> #if IS_ENABLED(CONFIG_PWM_PXA)
> 	/* PWM 0 - LCD backlight */
> 	GPIO16_PWM0_OUT,
> #else
> 	/* Ensure static backlight without any driver */
> 	MFP_CFG_OUT(GPIO16, AF0, DRIVE_LOW),    /* Backlight enabled */
> #endif
>
> Hmmm.. I think I can do this better in pwm-backlight init/exit (same way as
> pxa_ficp). During init the pin mux will switch to Alternate Function (PWM) and
> during exit it will switch to GPIO (which can be used by gpio-backlight). This
> will remove ugly ifdef.

I don't like changing the muxing after initialization that much : the pin muxing
should represent what there is in hardware, and that is a backlight frequency
switched input pin. The one exception is for hardware workarounds such as the
AC97 reset pin.

I won't take an init/exit with a manipulation of an mfp. I'll let you choose one
way instead :
 - either the GPIO
 - or the PWM (module or not)
Don't forget that this init/exit thing won't be available for a devicetree
magician (if that happens).

Cheers.

-- 
Robert
