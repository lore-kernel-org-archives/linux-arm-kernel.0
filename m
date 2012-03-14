From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Mar 2012 13:51:05 +0000
Subject: [PATCH v4 00/11] ep93xx: Move SoC private bits to core
In-Reply-To: <4F5FC8AD.4070505@gmail.com>
References: <1331592502-9083-1-git-send-email-rmallon@gmail.com>
 <201203131235.53593.arnd@arndb.de> <4F5FC8AD.4070505@gmail.com>
Message-ID: <201203141351.06200.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 March 2012, Ryan Mallon wrote:
> > There are currently eight board files (since all the dev boards got
> > merged into one file), which seems very manageable and there should be
> > no problem adding a few more over the years to come, if necessary.
> 
> I doubt there will be many new boards added.
> 
> > At the same time, the platform seems simple enough that you could
> > also do a device tree port in rather in a fairly short time if you
> > like, which would let you obsolete all the board files and add new
> > machines just through device tree blobs.
> 
> 
> Yeah, converting to device tree is one of my goals. I need to spend some
> time reading through the device tree specification first.

Ok, great!

A number of ARM9 and XScale based platforms have started the conversion
now, and there is a lot you can learn by looking at the others. I would
recommend waiting for 3.4-rc1 before you get serious with this, because
patches are pending in various trees at the moment.

There is no strict need for you to do the conversion, because you say
that the platform is basically dead and there is not much churn to be
expected in the future, but you are definitely welcome to join in.

As the first steps (after reading Documentation/devicetree/booting-without-of.txt)
the best way forward is probably to take you favourite board file and
add a DT_MACHINE_START section so you can boot the same machine
when passing an empty devicetree rather than ATAGS. Then add the interrupt
controller (should be simple for VIC), followed by gpio (needs bindings,
see Documentation/devicetree/bindings/gpio/*.txt), i2c and spi. After
you have all that infrastructure in place, you can convert every other
device, one at a time. Some (anything without platform_data) will be
trivial, others require you to come up with a new binding document
and properties to replace the platform_data. Many people try to do
the ones from board files first because it lets them remove the board
files, and only after that look at converting the core devices, but you
can do any order you like.

	Arnd
