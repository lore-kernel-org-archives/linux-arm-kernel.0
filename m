From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Jan 2012 11:48:36 +0000
Subject: [PATCH 2/2] ARM: sa1100: Refactor mcp-sa11x0 to use platform
 resources.
In-Reply-To: <4F16AD45.6030906@scram.de>
References: <1322427655-914-1-git-send-email-jochen@scram.de>
 <1322427655-914-2-git-send-email-jochen@scram.de>
 <20120114092129.GO1068@n2100.arm.linux.org.uk> <4F154255.2020605@scram.de>
 <20120117201256.GV1068@n2100.arm.linux.org.uk> <4F16AD45.6030906@scram.de>
Message-ID: <20120118114836.GD1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2012 at 12:30:13PM +0100, Jochen Friedrich wrote:
> Hi Russell,
>
>>> Accessing some random SoC registers and in the assabet case even board
>>> specific registers from device drivers is even worse IMHO. We don't get
>>> a clean solution until we have a pinmux/pinctrl device driver owning
>>> these peripheral control registers. At least having the setup in the
>>> board files avoids a potential race condition accessing PPDR and PPSR
>>> registers from multiple drivers.
>>
>> Yes, but do we really need the exact same code repeated time and time
>> again in each different board file?  Could we not have a function which
>> sets the pins up for MCP?
>
> Yes, this would be a good idea. One should do the same for the sa1100  
> serial driver. Here we even have the bug that the driver unconditionally  
> sets up pins for UART1 and 3 no matter what platform devices are present.

If you'd care to pay attention to the code, you'll notice that UARTs 1 and
3 are always unconditionally registered.  Therefore, this is not a bug.
It's a question of code organization, one which may be sub-standard by
todays standards.

It was decided _long_ ago that the _drivers_ would setup the PPC
configuration, because on some platforms the PPC configuration depends on
what drivers you've configured into the kernel and loaded (which depends
on how you jumper some of these early boards) rather than what board is
being used.

So, unless you're being extremely careful about moving stuff around,
you're going to break stuff.

>> I'm not complaining about this one - the MCCR1 shares its 64K space with
>> the peripheral pin controller, and I suspect we won't get to the point
>> where that's controlled by a driver.
>
> Why not? gpio-generic should be able to handle the PPC registers out of  
> the box.

And then we're going to see a whole slew of additional gpio calls needing
to be added throughout the code... this kind of large scale modification
sounds like a recipe for things going wrong.

And no, I don't agree that SA-1100 stuff should be pushed towards device
tree.  Leave it be, it's legacy stuff, and it's not providing much pain
as it is.  And some of the problems within there are extremely difficult
to solve (hell, some of them can't be solved using platform data alone -
a lot are procedural problems which can't be expressed in data.)
