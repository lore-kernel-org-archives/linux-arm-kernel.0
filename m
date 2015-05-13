From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 May 2015 12:30:39 +0200
Subject: [GIT PULL] Allwinner drivers changes for 4.2
In-Reply-To: <20150513094348.GX10961@lukather>
References: <20150511193527.GA29690@lukather> <2615254.66Y5XGdzL1@wuerfel>
 <20150513094348.GX10961@lukather>
Message-ID: <2423239.y1LCAVXsLT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 May 2015 11:43:48 Maxime Ripard wrote:
> Hi Arnd,
> 
> On Tue, May 12, 2015 at 10:15:20PM +0200, Arnd Bergmann wrote:
> > On Monday 11 May 2015 21:35:27 Maxime Ripard wrote:
> > > Hi Arnd, Kevin, Olof,
> > > 
> > > Here is the first batch of drivers changes for the 4.2 merge window.
> > > 
> > > Thanks!
> > > Maxime
> > > 
> > > The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:
> > > 
> > >   Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)
> > > 
> > > are available in the git repository at:
> > > 
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-drivers-for-4.2
> > > 
> > > for you to fetch changes up to 44bb362ff9f2e6f9ab285e66ce92f55aee71808a:
> > > 
> > >   drivers: soc: sunxi: Introduce SoC driver to map SRAMs (2015-05-05 20:47:08 +0200)
> > > 
> > > ----------------------------------------------------------------
> > > Allwinner drivers patches for 4.2
> > > 
> > > This pull request contain a single driver to handle the SRAM mapping
> > > between the CPU and devices.
> > > 
> > 
> > Hi Maxime,
> > 
> > Sorry I hadn't looked at the new driver before, but I did now and need a little
> > clarification. It seems to me that the device should be compatible with the
> > generic DT binding we have in Documentation/devicetree/bindings/misc/sram.txt,
> > and use more generic code. At least I can't see much in here that is really sunxi
> > specific.
> >
> > Were you not aware of that generic binding, or did you have a good reason
> > not to use it?
> 
> I asked myself the same question, and I don't really think that this
> would be wise, since that in order to be accessible by the CPU it has
> to be mapped to it through this driver.
> 
> I felt like this alone justify a new compatible, even though we might
> end up using the same driver.

Have you discussed this with Heiko?

> > In the latter case, please document that in the patch description
> > (after replying here).
> 
> Ok.
> 
> > One small bug I found in the DT binding: the main DT node is lacking
> > a "ranges" property.
> 
> Which DT node are you talking about ?

I was referring to the ranges in this:

+soc at 01c00000 {
+       compatible = "simple-bus";
+       #address-cells = <1>;
+       #size-cells = <1>;
+       ranges;
+
+       sram at 00000000 {
+               compatible = "allwinner,sun4i-a10-sram";
+               reg = <0x00000000 0x4000>;
+               allwinner,sram-name = "A1";
+       };

but I now think I was misreading it, and the problem is different:
Rather than having separate devices for parts of the SRAM, you
are actually missing a node for the SRAM physical window. I think
the individual SRAM pieces should be nodes below one that describes
all of the SRAM, as we do in 
Documentation/devicetree/bindings/misc/sram.txt

	Arnd
