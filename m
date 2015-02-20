From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 20 Feb 2015 17:02:57 +0100
Subject: [PATCH v4 2/4] mfd: lubbock_cplds: add lubbock IO board
In-Reply-To: <20150218080719.GB5781@x1> (Lee Jones's message of "Wed, 18 Feb
 2015 08:07:19 +0000")
References: <20150216130549.GF14545@x1>
 <1170550770.470129293.1424093248596.JavaMail.root@zimbra1-e1.priv.proxad.net>
 <20150216162712.GR14545@x1> <87fva5a4i2.fsf@free.fr>
 <20150217074310.GT14545@x1>
 <alpine.LFD.2.11.1502171221300.22104@knanqh.ubzr>
 <20150218080719.GB5781@x1>
Message-ID: <87a9088tam.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lee Jones <lee.jones@linaro.org> writes:
>> > Arnd, Greg,
>> > 
>> >   Perhaps you have some ideas WRT programmables (PLDs/CPLDs/FPGAs)?

Hi Arnd and Greg,

I have this driver I'm upstreaming, which comes out of
arch/arm/mach-pxa/lubbock.c. As for the reason it is extracted, see submitted
commit [1] for reference.

The main question is : where does it belong in the kernel ?

The driver is :
 - for the CPLDs on the Lubbock development platform, which is more or less an
   old motherboard for Intel Xscale pxa255 SoC (see [2] for more details)
 - these CPLDs control :
   - interrupt muxing towards the SoC
   - several leds
   - switches read back
   For the whole patch, see [4]

Lee's position is that it doesn't belong to drivers/mfd, see [3].

So where should I submit it ? And more generally, where should CPLDs drivers be
pushed in the kernel tree ?

If there is no solution, I'll fallback through arch/arm/plat-pxa, not very nice,
but it has to land somewhere, I don't want lubbock to remain broken.

Cheers.

--
Robert

[1] Reason of extraction / commit message
    mfd: lubbock_cplds: add lubbock IO board
    
    Lubbock () board is the IO motherboard of the Intel PXA25x Development
    Platform, which supports the Lubbock pxa25x soc board.
    
    Historically, this support was in arch/arm/mach-pxa/lubbock.c. When
    gpio-pxa was moved to drivers/pxa, it became a driver, and its
    initialization and probing happened at postcore initcall. The lubbock
    code used to install the chained lubbock interrupt handler at init_irq()
    time.
    
    The consequence of the gpio-pxa change is that the installed chained irq
    handler lubbock_irq_handler() was overwritten in pxa_gpio_probe(_dt)(),
    removing :
     - the handler
     - the falling edge detection setting of GPIO0, which revealed the
       interrupt request from the lubbock IO board.
    
    As a fix, move the gpio0 chained handler setup to a place where we have
    the guarantee that pxa_gpio_probe() was called before, so that lubbock
    handler becomes the true IRQ chained handler of GPIO0, demuxing the
    lubbock IO board interrupts.
    
    This patch moves all that handling to a mfd driver. It's only purpose
    for the time being is the interrupt handling, but in the future it
    should encompass all the motherboard CPLDs handling :
     - leds
     - switches
     - hexleds
    
    Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

[2] Board description by Nicolas
>> The Lubbock is an ancient development board (circa 2003) using a CPLD to 
>> multiplex a couple things on the board.  I really doubt anyone would 
>> reprogram this CPLD at this point. So I'd treat it just like another 
>> interrupt controller + random peripherals that will never change.  And 
>> yes, maybe a more appropriate name is needed.

[3] Lee's position
>> > I don't think this is correct either.  CPLD handling would probably be
>> > slightly less out of place in drivers/misc, but perhaps a new
>> > subsystem for PLDs/CPLDs/FPGAs would be more appropriate
>> > drivers/programmables or similar maybe.
>> >
...
>> > I'm pretty convinced that it doesn't belong in MFD now, but it doesn't
>> > mean I'm going to leave you on the curb.  I'd like to help you get it
>> > into a better home.
>> > 
>> > [...]
>> > > Is not only a irqchip because, as explained at the bottom of the commit message,
>> > > quoting myself :
>> > >   This patch moves all that handling to a mfd driver. It's only purpose
>> > >   for the time being is the interrupt handling, but in the future it
>> > >   should encompass all the motherboard CPLDs handling :
>> > >    - leds
>> > >    - switches
>> > >    - hexleds
>> > 
>> > I had a conversation about this on IRC yesterday and some good
>> > points/questions were posed.  This is a difficult area, because you
>> > can program these things to do whatever you like.  Depending on the
>> > 'intention' (and it is only an intention -- someone else can come
>> > along and reprogram these devices on a whim), the CPLD code could live
>> > anywhere.  If you wanted to put watchdog functionality in there, then
>> > there is an argument for it to live in drivers/watchdog, etc etc.  So
>> > just because the plan is to support a few (i.e. more than one) simple
>> > devices, it doesn't necessarily mean that the handling should be done
>> > in MFD.
>> > 
>> > Yesterday I was asked "Are you wanting to restrict drivers in
>> > drivers/mfd to those that make use of MFD_CORE functionality?".  My
>> > answer to that was "No, however; I only want devices which
>> > _intrinsically_ operate in multiple subsystems", which these
>> > programmables no not do.
>> > 
>> > FYI, you're not on your own here.  There is at least one of these
>> > devices in the kernel already and upon a short inspection there
>> > appears to be a number of Out-of-Tree (OoT) drivers out there which
>> > will require a home in Mainline sooner or later.
>> > 

[4] Whole patch
https://lkml.org/lkml/2015/1/24/90

-- 
Robert
