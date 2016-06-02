From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 02 Jun 2016 09:24:25 +0200
Subject: [PATCH 09/32] bcm2837-rpi-3-b.dts for 32bit arm
In-Reply-To: <1464850565.24775.40.camel@redhat.com>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
 <5616246.RRQ2rLjLud@wuerfel> <1464850565.24775.40.camel@redhat.com>
Message-ID: <3336185.FIBLI6ezsy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 2, 2016 8:56:05 AM CEST Gerd Hoffmann wrote:
> On Do, 2016-06-02 at 00:39 +0200, Arnd Bergmann wrote:
> > On Wednesday, June 1, 2016 3:30:35 PM CEST Eric Anholt wrote:
> > > Arnd Bergmann <arnd@arndb.de> writes:
> > > 
> > > > On Wednesday, June 1, 2016 11:43:18 PM CEST Gerd Hoffmann wrote:
> > > >> diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> > > >> new file mode 100644
> > > >> index 0000000..36178a6
> > > >> --- /dev/null
> > > >> +++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> > > >> @@ -0,0 +1 @@
> > > >> +#include "../../../arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts"
> > > >> -- 
> > > >> 1.8.3.1
> > > >> 
> > > >
> > > > What does this gain you?
> > > 
> > > Many Raspberry Pi users use a small set of SD cards that they swap
> > > between various versions of the hardware.  It would be good to have
> > > their 32-bit OS images work on the Pi3 as well.
> > 
> > Sure, but you already have the dts file in the other directory,
> > and the dtb is the same.
> > 
> > According to the comment in the other patch, the idea was to have
> > the file in the arm64 directory because it's a 64-bit platform,
> > but now you have it here as well.
> 
> Well, it just includes the arm64 version as-is, so we don't have
> duplication.  I'm open to suggestions to how handle this better.  
> 
> Symbolic link?
> 
> Reference to ../../../arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
> directly in the Makefile?
> 
> I've seen arch/arm/boot/dts/Makefile uses globs on *.dts, so I suspect
> the later wouldn't be that straight forward.

It's just weird that the arm64 file includes the .dtsi files from arch/arm/
and is then again included back from another file there.

I can see two possible ways to handle this better:

- leave the complete set of bcm2837 files in arch/arm and then have one
  reference from arch/arm64 per .dts that refers to just that file.

- come up with a rule to also build the .dtb files in arch/arm64 when
  we run 'make dtbs' for arch/arm and leave this file there. The argument
  that one could use the same dtb with a 32-bit kernel should basically
  hold true for any arm64 system, it's not specific to rpi-3 really.
  We don't normally test 32-bit kernels on 64-bit SoCs because 64-bit
  kernels are more efficient in a number of ways, and I'm sure there
  are bugs that prevent some systems from working (aside from how some
  machines cannot work because they don't have RAM below 4GB), but if
  this is now something that users are interested in, making it just
  work seems nicer than having a couple of board specific hacks.

	Arnd
