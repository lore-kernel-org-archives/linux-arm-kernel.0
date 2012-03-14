From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 14 Mar 2012 11:20:21 -0500
Subject: [PATCH v4 00/11] ep93xx: Move SoC private bits to core
In-Reply-To: <201203141351.06200.arnd@arndb.de>
References: <1331592502-9083-1-git-send-email-rmallon@gmail.com>
 <201203131235.53593.arnd@arndb.de> <4F5FC8AD.4070505@gmail.com>
 <201203141351.06200.arnd@arndb.de>
Message-ID: <ADE657CA350FB648AAC2C43247A983F0020695AB9B9B@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, March 14, 2012 6:51 AM, Arnd Bergmann wrote:
> On Tuesday 13 March 2012, Ryan Mallon wrote:
>>> There are currently eight board files (since all the dev boards got
>>> merged into one file), which seems very manageable and there should be
>>> no problem adding a few more over the years to come, if necessary.
>> 
>> I doubt there will be many new boards added.
>> 
>>> At the same time, the platform seems simple enough that you could
>>> also do a device tree port in rather in a fairly short time if you
>>> like, which would let you obsolete all the board files and add new
>>> machines just through device tree blobs.
>> 
>> 
>> Yeah, converting to device tree is one of my goals. I need to spend some
>> time reading through the device tree specification first.
>
> Ok, great!
>
> A number of ARM9 and XScale based platforms have started the conversion
> now, and there is a lot you can learn by looking at the others. I would
> recommend waiting for 3.4-rc1 before you get serious with this, because
> patches are pending in various trees at the moment.
>
> There is no strict need for you to do the conversion, because you say
> that the platform is basically dead and there is not much churn to be
> expected in the future, but you are definitely welcome to join in.
>
> As the first steps (after reading Documentation/devicetree/booting-without-of.txt)
> the best way forward is probably to take you favourite board file and
> add a DT_MACHINE_START section so you can boot the same machine
> when passing an empty devicetree rather than ATAGS. Then add the interrupt
> controller (should be simple for VIC), followed by gpio (needs bindings,
> see Documentation/devicetree/bindings/gpio/*.txt), i2c and spi. After
> you have all that infrastructure in place, you can convert every other
> device, one at a time. Some (anything without platform_data) will be
> Trivial, others require you to come up with a new binding document
> and properties to replace the platform_data. Many people try to do
> the ones from board files first because it lets them remove the board
> files, and only after that look at converting the core devices, but you
> can do any order you like.

The main problem I see with converting the ep93xx platform to device tree
is that it requires modifying the bootloader. Correct me if I am wrong.

Most of the ep93xx boards use RedBoot for the bootloader. Unfortunately
Cirrus never released the ep93xx port to eCos so the source is not available.
You can dig it out of the stuff Cirrus has on http://arm.cirrus.com but it's
based on a pretty old version of eCos/RedBoot and might be quite a task
getting it current.

A couple years ago I tried getting Cirrus to release the source to eCos. It got
to the point where it appeared they would but nothing ever happened.

Some of the ep93xx boards use U-Boot for the bootloader but I think that
port has recently been dropped from the tree.

Regards,
Hartley
