From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Jul 2012 17:10:53 +0000
Subject: [PATCH V2 6/7] ARM: SPEAr13xx: Add auxdata for Ethernet
 controller.
In-Reply-To: <20120725073406.GM19660@localhost.localdomain>
References: <cover.1342171151.git.vipulkumar.samar@st.com>
 <201207250631.54157.arnd@arndb.de>
 <20120725073406.GM19660@localhost.localdomain>
Message-ID: <201207251710.53683.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 July 2012, Shiraz Hashim wrote:
> 
> On Wed, Jul 25, 2012 at 06:31:53AM +0000, Arnd Bergmann wrote:
> > Can you post here the complete set of callback implementations
> > that you have in your development trees at the moment? That should
> > help us determine which case we're talking about here.
> 
> There are following types of callbacks (involving SoC/platform) seen
> generally in our case,
> 
>   * parent clk selection -
>         driver is not aware about various clock sources (which also
>         varies from platform to platform) and hence can only be
>         programmed by corresponding platform.
> 
>         This is the case in Ethernet, audio, etc.
>
>   * sata controller
>         Similar to OTG case which involves clock initialization.
 
This should definitely be moved into the drivers. A lot of drivers
enable and program clocks using the generic clock interfaces, so
there is no point using a callback.

Note that since stmmac is an architecture independent driver, this
depends on Mark Brown's patch to provide empty stubs for
the clock management functions on architectures that don't yet
use it.

>   * spi controller
>         This is little hack in the h/w. As part of s/w controlled chip
>         select/deselect in spi-pl022, we need to write to some system
>         specific register.
> 
>   * OTG controller
>         phy clock initialization which involves series of steps
>         including powering down, etc.
> 
>   * NAND controller
>         bank selection on runtime by writing to system registers

I don't understand any of these, so unless you post the code
that you want help with as I asked above, I'll assume that you find
the solution yourself and don't need a callback ;-)

	Arnd
