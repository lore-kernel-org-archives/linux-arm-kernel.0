From: jacek.anaszewski@gmail.com (Jacek Anaszewski)
Date: Wed, 9 Nov 2016 21:45:28 +0100
Subject: PM regression with LED changes in next-20161109
In-Reply-To: <20161109192301.GS26979@atomide.com>
References: <20161109192301.GS26979@atomide.com>
Message-ID: <28234714-3994-6747-9cf8-1ff0b3257f7a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On 11/09/2016 08:23 PM, Tony Lindgren wrote:
> Hi,
>
> Looks like commit 883d32ce3385 ("leds: core: Add support for poll()ing
> the sysfs brightness attr for changes.") breaks runtime PM for me.
>
> On my omap dm3730 based test system, idle power consumption is over 70
> times higher now with this patch! It goes from about 6mW for the core
> system to over 440mW during idle meaning there's some busy timer now
> active.
>
> Reverting this patch fixes the issue. Any ideas?

Thanks for the report. This is probably caused by sysfs_notify_dirent().
I'm afraid that we can't keep this feature in the current shape.
Hans, I'm dropping the patch. We probably will have to delegate this
call to a workqueue task. Think about use cases when the LED is blinked
with high frequency e.g. from ledtrig-disk.c.

Also, IMHO the notifications should be enabled only if explicitly
selected in the kernel config.

-- 
Best regards,
Jacek Anaszewski
