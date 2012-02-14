From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Feb 2012 18:20:59 +0000
Subject: [PATCH 13/15] ARM: make mach/io.h include optional
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F001F41FCB510C@AUSP01VMBX24.collaborationhost.net>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <201202140106.32856.arnd@arndb.de>
 <ADE657CA350FB648AAC2C43247A983F001F41FCB510C@AUSP01VMBX24.collaborationhost.net>
Message-ID: <201202141821.00192.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 February 2012, H Hartley Sweeten wrote:

> outb(v,p)
> {
>         __iowmb();
>         __raw_writeb(v, /* not sure what happens to the (void)p */ (void __iomem *)0);
> }
> 
> To me the original one looks more correct. With Rob's change it looks to me like all
> the in/out macros end up reading/writing to address 0.

Correct.

> I don't get what's happening in Rob's change. Could you enlighten me?

This is the version that gets used when you have neither PCI nor ISA/PCMCIA.

Ideally we would turn outb into an undefined symbol so that we get a 
build error if someone tries to create a kernel that uses outb while
not providing any buses on which it has an effect. Doing that would
depend on a patch series that I started before but never completed,
to ensure that we don't actually try to build device drivers with port
I/O unless we also support one of the buses. The main problem is the 8250
device driver.

The macro from Rob's version always does a NULL pointer dereference, which
is still a bug, but much better than having a potential root hole from
letting (incorrectly built) ISA drivers poke at random addresses.

I guess it would make sense to split this patch into two separate ones,
one that moves all bogus definitions into a common place, and one that
changes them to the NULL pointer dereference.

	Arnd
