From: stigge@antcom.de (Roland Stigge)
Date: Fri, 07 Dec 2012 18:33:28 +0100
Subject: [PATCH 0/6 v10] gpio: Add block GPIO
In-Reply-To: <20121207170215.0057f791@pyramind.ukuu.org.uk>
References: <1354830456-17590-1-git-send-email-stigge@antcom.de>
 <20121207103643.34ca6dc5@pyramind.ukuu.org.uk> <50C1DBD4.1040007@antcom.de>
 <50C1DE21.8050709@antcom.de> <20121207170215.0057f791@pyramind.ukuu.org.uk>
Message-ID: <50C22868.4070405@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/07/2012 06:02 PM, Alan Cox wrote:
>>>> Currently we can set different permissions on different GPIO lines. Your
>>>> driver change drives a truck through this facility.
>>
>> What I maybe misread in your concern: The dev interface is actually an
>> "alternative to sysfs for block GPIO", not considered as a replacement
>> for the current sysfs interface for _single_ GPIOs.
> 
> That is the problem. If you add the driver then you can no longer
> implement the same permissions per node. If I've got a typical hardened
> embedded device running something like SMACK I can tie a few gpio lines
> to specific tasks in the security model.
> 
> The moment there is another driver anyone who can open that driver can
> bypass all the security rules being imposed.
> 
> The basic problem is that right now our mapping is
> 
> "gpio line is a file system object"
> 
> you change it to
> 
> "all gpio lines are a single file system object"

No - maybe that's still not documented well enough: Upon defining a GPIO
block, you can specify each individual GPIO that's contained therein.
Define as many (disjoint) blocks as you want with as many permission
sets as you want, right away.

In the extreme case, define blocks with only a single GPIO in each of
them, and the interface should still be faster than the sysfs one. Each
block is a separate device node with separate permissions.

Further, block GPIOs only need to be present on systems where firmware
tells via DT (or the kernel itself in setup code) explicitely which
GPIOs should be in a certain block to be accessed efficiently.

Sysfs can still work as expected, at least for the remaining GPIOs.

So I don't see a contradiction here, considering that you can still
organize permissions for the (optional) GPIO block, as you do currently
via sysfs.

You can also compare sysfs and block GPIO interfaces to block devices
where you create file systems on top. Userspace can access both, but
it's not very useful to access the underlying block device at the same
time when it's also mounted as an fs. The good thing about the sysfs and
block GPIO case is that you can use both at the same time: Consider a
single controller/gpio_chip containing 32 lines. You can define a GPIO
block of 16 of them for use as an efficient 16 bit bus, and use the rest
via single GPIO sysfs as you described.

Thanks for considering,

Roland
