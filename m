From: domenico.andreoli@linux.com (Domenico Andreoli)
Date: Mon, 14 Apr 2014 16:25:39 +0200
Subject: Forcing DEBUG_UART_{PHYS, VIRT} changes when switching between
 v7 platforms?
In-Reply-To: <20140320124648.GS7528@n2100.arm.linux.org.uk>
References: <CAGVrzcZT+3VuuM9wdLTAu7wtbYTFcwSnMaYE7PcR8Eo4PmTnhg@mail.gmail.com>
 <8099777.qvOx0M5YBS@wuerfel>
 <20140320101127.GN7528@n2100.arm.linux.org.uk>
 <201403201245.34108.arnd@arndb.de>
 <20140320124648.GS7528@n2100.arm.linux.org.uk>
Message-ID: <20140414142539.GA21490@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 20, 2014 at 12:46:48PM +0000, Russell King - ARM Linux wrote:
> On Thu, Mar 20, 2014 at 12:45:33PM +0100, Arnd Bergmann wrote:
> > 
> > Ok, thanks for the clarification. On a semi-related topic, we have
> > (once more) discussed adding an early printk implementation during
> > the Linaro Connect meeting this month. I think this would all become
> > much less painful if we had a way to handle console output in a
> > platform independent way before the regular console kicks in, like
> > a few other architectures do.
 
This reminds me a related investigation I did:

http://thread.gmane.org/gmane.linux.ports.arm.kernel/177186

> > debug_ll is great for debugging the extremely early code, since
> > it works basically from the first instruction on, but a lot of
> > problems actually happen much later. The early console code
> > runs from parse_early_param(), which comes after setup_arch(),
> > so we can't use to debug that part but it means we already
> > have an unflattened device tree to work with for finding typical
> > 8250 or pl011 ports. At the moment, pl011 doesn't even have a
> > console_initcall, so it comes up only at arch_initcall time,
> > which is about the earliest a normal tty driver can get registered,
> > and a lot can go wrong between parse_early_param() and
> > arch_initcall().
> 
> It depends how much crap you want to shovel into serial drivers.  Fixing
> stuff to work at console_initcall time basically means that the driver
> has to have some way to find where the console is independent of the
> driver model - because the driver model won't be up and running at that
> point.

Indeed there was some "early console" driver model and some crap to push
this through the decompressor throat.

> Yes, we could have a console_initcall() in there parsing the device tree
> for a console port, but what console= parameter would that correspond
> with?  You wouldn't know which ttyAM* port it should tie up with because
> you don't have that information at that point in time - and it's important
> to know that so that /dev/console in userspace works.

there was decomp-console-dt.patch saying:

| This is the very minimal support of DT that currently the decompressor
| console provides. That is reading the command line from the DT.
|
| This means that pure DT machines currently need some console data to
| be shipped to the decompressor (tags have their DT table) although they
| already provide all the required info in the DT, where the decompressor
| should ideally take them.
|
| So the current blocker here is what to extract from DT. Or, what to _put_
| into the DT for the decompressor.

I think that the match of console= + DT serial drivers + "early console"
driver model (which establishes the ttyXXXYY <-> DT compatible property,
in the serial driver itself) is enough to get the thing working.

Maybe it would not look so horrible, is it worth a try?

Regards,
Domenico
