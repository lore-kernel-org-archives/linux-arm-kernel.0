From: sr@denx.de (Stefan Roese)
Date: Mon, 19 Nov 2012 17:13:27 +0100
Subject: [PATCH 4/4] ARM: sunxi: Add sunxi restart function via onchip
 watchdog
In-Reply-To: <50AA53A0.2040404@free-electrons.com>
References: <1353323383-11827-1-git-send-email-sr@denx.de>
 <1353323383-11827-4-git-send-email-sr@denx.de>
 <50AA53A0.2040404@free-electrons.com>
Message-ID: <50AA5AA7.9070705@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19/2012 04:43 PM, Maxime Ripard wrote:
> While I've taken the three other patches, I'm more concerned about this one.
> 
> On a general basis, I would rather see this code into the machine source
> file, since it doesn't directly relate to the timer driver. If at some
> point someone wants to write a proper watchdog driver alongside with the
> timer driver, I'll be fine with moving the code there, but for now,
> let's keep it simple.

I thought about that too. But it would either a) result in code
duplication (finding and mapping this timer device node) or b) we would
have to make this "timer_base" an ugly global variable so that we can
reference it from the platform code. That's why I placed it the timer
source.

<snip>

>> +void sunxi_restart(char mode, const char *cmd)
>> +{
>> +	/* Use watchdog to reset system */
>> +
>> +	/* Enable timer and set reset bit */
>> +	writel(3, timer_base + WATCH_DOG_MODE_REG);
>> +	writel(0xa57 << 1 | 1, timer_base + WATCH_DOG_CTRL_REG);
>> +
>> +	while(1)
>> +		;
>> +}
> 
> Here, your code looks way more obscure and "complicated" than the one
> from linux-sunxi found here:
> https://github.com/linux-sunxi/linux-sunxi/blob/sunxi-3.4/arch/arm/mach-sun4i/core.c#L289
> 
> Why is that?

"Way more obscure" sounds a bit exaggerated for 3 lines of code. ;)

The delays have been removed as they are not necessary. So its even
"cleaner" than the code that you referenced. And the code at linux-sunxi
also has incorrect register definitions (CTRL_REG is not 0x94 but 0x90).

The main difference is the added write to the real CTRL_REG (0x90) to
rearm the wdog. This has been suggested by Henrik Norstr?m, who has done
most of the U-Boot work (preparing for mainlining as well).

So since Arnd seem to be fine with this patch, I suggest to leave it as
is for now.

Thanks,
Stefan
