From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 06 Oct 2015 20:49:49 +0200
Subject: [PATCH 01/17] ARM: pxa: cm-x300: Use PWM lookup table
In-Reply-To: <20151006075347.GD18633@ulmo> (Thierry Reding's message of "Tue,
 6 Oct 2015 09:53:47 +0200")
References: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
 <1444034997-9805-2-git-send-email-thierry.reding@gmail.com>
 <87fv1pawu6.fsf@belgarion.home> <20151006075347.GD18633@ulmo>
Message-ID: <87bncbbzn6.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thierry Reding <thierry.reding@gmail.com> writes:

> On Mon, Oct 05, 2015 at 10:23:29PM +0200, Robert Jarzmik wrote:
>> Thierry Reding <thierry.reding@gmail.com> writes:
>> 
>> > @@ -305,11 +306,14 @@ static inline void cm_x300_init_lcd(void) {}
>> >  #endif
>> >  
>> >  #if defined(CONFIG_BACKLIGHT_PWM) || defined(CONFIG_BACKLIGHT_PWM_MODULE)
>> > +static struct pwm_lookup cm_x300_pwm_lookup[] = {
>> > +	PWM_LOOKUP("pxa27x-pwm.0", 1, "pwm-backlight.0", NULL, 10000,
>> > +		   PWM_POLARITY_NORMAL),
>> > +};
>> That looks weird. It was pwm_id = 2, and I can't find the "2" in the statement
>> above. I would gladly fix it myself, but I wonder where that "2" should go ...
>
> pwm_id = 2 should be equivalent to the 1 in the second argument of the
> PWM_LOOKUP macro (i.e. the PWM index). The rationale for that change is
> given in an old commit by Paul Parsons:
> With the lookup tables the situation is somewhat more complicated
> because the indices are relative to the provider. The above would
> therefore map to something like this:
>
> 	Address     Hardware  Device            Index
> 	0x40b00000  PWM0      pxa2{5,7}x-pwm.0  0
> 	0x40b00010  PWM2      pxa27x-pwm.0      1
> 	0x40c00000  PWM1      pxa2{5,7}x-pwm.1  0
> 	0x40c00010  PWM3      pxa27x-pwm.1      1
>
> Does that clarify the situation?
Yes, very much, thanks. That settles the situation for the patches I had not
understood so far, ie. patches 1, 14,16,17.

Therefore, I'll apply the whole serie this week. Thanks for your work.

Cheers.

-- 
Robert
