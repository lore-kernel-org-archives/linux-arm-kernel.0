From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 02 Jun 2016 11:01:45 +0200
Subject: [PATCH 4/4] Revert "powerpc/fsl: Move fsl_guts.h out of
 arch/powerpc"
In-Reply-To: <1464830660.22191.6.camel@buserror.net>
References: <1462417950-46796-1-git-send-email-yangbo.lu@nxp.com>
 <5513501.AmZs7h1vI2@wuerfel> <1464830660.22191.6.camel@buserror.net>
Message-ID: <3225846.9EJ0sHv0XK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, June 1, 2016 8:24:20 PM CEST Scott Wood wrote:
> On Mon, 2016-05-30 at 15:18 +0200, Arnd Bergmann wrote:
> > All users of this driver are PowerPC specific and the header file
> > has no business in the global include/linux/ hierarchy, so move
> > it back before anyone starts using it on ARM.
> > 
> > This reverts commit 948486544713492f00ac8a9572909101ea892cb0.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > This part of the series is not required for the eSDHC quirk,
> > but it restores the asm/fsl_guts.h header so it doesn't accidentally
> > get abused for this in the future. I found two drivers outside of
> > arch/powerpc that already accessed the registers directly, but the
> > functions look fairly contained, and can be easily hidden in an
> > #ifdef CONFIG_PPC
> 
> NACK
> 
> Besides adding ifdef pollution for no good reason, this register block is used
> on some ARM chips as well.  Why is it a problem if "anyone starts using it on
> ARM"?

It's just not a good interface when it's defined as "this is the layout of
a register area that any driver can ioremap() if they can figure out the
device node". It's not uncommon to have register areas like that, but
normally you have at the minimum a 'syscon' device to handle locking
between drivers accessing the same registers and to avoid having to map
the same area multiple times.

If we need to use 'guts' registers on ARM, we can find a way to abstract
them properly for the given use cases, using a syscon or a driver with
exported functions, but just making a PowerPC platform specific header
global to all Linux drivers by putting it into include/linux doesn't seem
right.

Note that the header file uses a structure definition rather than the more
common macros with register offsets, which is fine for a driver that has
its own registers and abstracts them, but it doesn't really work with
the regmap interface, so if we want to use it with syscon, it also needs to
be rewritten.

> BTW, of all the mailing lists you included on this CC, you seem to have left
> off the PPC list (I've added it).

Sorry, my mistake.

	Arnd
