From: alandpearson@gmail.com (Alan Pearson)
Date: Tue, 9 Nov 2010 15:40:19 +0000
Subject: w1-gpio oops
In-Reply-To: <AAD30849854E4B829FAF535B604B1B34@wipblrx0099946>
References: <E0675DE1-DC0C-40AE-947B-D4BD96C18993@gmail.com>
	<86F2C9C455334D048B154F93A214DF12@wipblrx0099946>
	<BFBAEA51-E7E6-4960-848D-5904BB209102@gmail.com>
	<AAD30849854E4B829FAF535B604B1B34@wipblrx0099946>
Message-ID: <8D0E58DD-1923-4321-A0B3-9FBD2DDA3529@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> ----- Original Message ----- From: "Alan Pearson" <alandpearson@gmail.com>
>> To: <linux-arm-kernel@lists.infradead.org>
>> Sent: Tuesday, November 09, 2010 7:29 PM
>> Subject: w1-gpio oops
>> 
>> 
>>> Hi Guys,
>>> 
>>> First post to list, so be kind :)
>>> 
>>> I'm trying to get w1 (one wire) working over GPIO and despite my best efforts this results in a nasty oops.
>>> Firstly, I'd like to say I'm no kernel hacker and my knowledge of Ooops and kernel debugging is limited, but I'm willing to learn:)
>> 
>> Common cause for these errors could be nonexistent or incorrect platform data. Might be worth checking if w1_gpio_platform_data
>> is proper in your board file. You could look for examples in other board files like arch/arm/mach-pxa/raumfeld.c
>> 
> 
> <CHOP>
> 
> Ok, I had understood the platform data was being set in the w1_gpio_custom module by the loadable options.
> Is this not the case, or does it also need defined in the board file, which I presume is guruplug_setup.c ?
> It's currently not defined there. But as I said I expected the other module to do this, am I wrong ?
> 
> 
> Looking at the function w1_gpio_probe, it doesnot seem to be using module params. So u might need to define those
> in your board file.
> 

OK, I've modified my board file like so (guruplug-setup.c) :


static struct w1_gpio_platform_data guru_gpio_platform_data = {
        .pin                    = MPP38_GPIO,
        .is_open_drain          = 0,
};

struct platform_device guru_w1_gpio_device = {
        .name   = "w1-gpio",
        .id   = -1,
        .dev    = {
                .platform_data = &guru_gpio_platform_data
        }
};

static void __init guru_w1_init(void)
{

        platform_device_register(&guru_w1_gpio_device);
}



and called guru_w1_init from it's main init function.

Loading w1-gpio without the custom module produces :
FATAL: Error inserting w1_gpio (/lib/modules/2.6.37-rc1/kernel/drivers/w1/masters/w1-gpio.ko): No such device

And loading the w1_gpio_custom with the correct parameters produces the same oops.


So I think somehow I haven't correctly defined the platform data in my board file, and the w1_gpio_custom module allows me to specify this with parameters.
You can see w1-gpio-custom here :  https://dev.openwrt.org/browser/branches/8.09/package/w1-gpio-custom/src/w1-gpio-custom.c

So any clues as to what I've done wrong with the platform data, or does it not matter as w1-gpio-custom is doing this for me ?

Again,
Thanks

Alan
