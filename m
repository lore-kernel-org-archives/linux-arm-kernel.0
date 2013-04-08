From: fabian@ritter-vogt.de (Fabian Vogt)
Date: Mon, 08 Apr 2013 22:06:29 +0200
Subject: [RFC PATCH arm: initial TI-Nspire support]
In-Reply-To: <201304082138.15875.arnd@arndb.de>
References: <6FE4B33E-A503-4A75-AEED-831CB2C06D83@gmail.com>
 <896CB251-17FC-4327-BA4E-A8FD9ED1BEC7@gmail.com>
 <op.wu8k5pwqu7prd4@fabians-laptop.fritz.box>
 <201304082138.15875.arnd@arndb.de>
Message-ID: <op.wu8ng3wyu7prd4@fabians-laptop.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Monday 08 April 2013, Fabian Vogt wrote:
>> The latest kernel it seems to get stuck at
>> console_lock() in do_register_framebuffer (drivers/video/fbmem.c:1655)
>> if the LCD-controller is enabled. (Early printk and serial console works
>> fine)
>> CONFIG_NO_HZ is not activated, it works completely.
>> Could this be a kernel bug or is this an issue with our timer
>> configuration?
>
> This usually happens when the console driver or anything it uses
> calls a function that does a printk(), which means you get a recursive
> call into the console code and try to get the same lock again.
Yes, I've heard that before, but than it would work/not work independently
of NO_HZ. Can printk's be executet within console_lock() ..  
console_unlock() blocks?
If not, it could be fb_notifier_call_chain, too, but that wouldn't be  
likely at all.
I also tried spinlock/mutex debugging and soft lockup detection,
but neither of them outputs anything.
