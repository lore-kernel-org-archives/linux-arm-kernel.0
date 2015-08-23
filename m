From: petr.cvek@tul.cz (Petr Cvek)
Date: Sun, 23 Aug 2015 22:55:51 +0200
Subject: [PATCH v2 16/21] ARM: pxa: magician: Add support for alternative
 LCD backlight
In-Reply-To: <878u95685t.fsf@belgarion.home>
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D25A60.7000900@tul.cz>
 <878u95685t.fsf@belgarion.home>
Message-ID: <55DA3357.6050304@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 20.8.2015 v 22:01 Robert Jarzmik napsal(a):
> Petr Cvek <petr.cvek@tul.cz> writes:
> 
>> Add support for alternative LCD backlight with GPIO (no brightness).
> Here, I don't understand, the commit message is too short.
> 
> Are there 2 brightness controls on magician, or are these 2 different magicians
> (hardware wise), each having a different backlight control ? Or is it there is a
> GPIO to light up the screen and a PWM backlight ?
> 
> I have to understand first.
> 
I have aimed for a configuration, where user can use PWM xor GPIO backlight. As pin mux can set GPIO or PWM (or UART :-D) on PWM pin, you can choose if you spare few kB (as magician has only 64MB RAM and 64MB flash) on GPIO or will have smooth backlight with PWM.

I have tested both (I think I have added the gpio backlight for debugging a regression in pwm_bl).

Only ugly thing is the GPIO definition:

#if IS_ENABLED(CONFIG_PWM_PXA)
	/* PWM 0 - LCD backlight */
	GPIO16_PWM0_OUT,
#else
	/* Ensure static backlight without any driver */
	MFP_CFG_OUT(GPIO16, AF0, DRIVE_LOW),    /* Backlight enabled */
#endif

Hmmm.. I think I can do this better in pwm-backlight init/exit (same way as pxa_ficp). During init the pin mux will switch to Alternate Function (PWM) and during exit it will switch to GPIO (which can be used by gpio-backlight). This will remove ugly ifdef.

Best regards,
Petr
