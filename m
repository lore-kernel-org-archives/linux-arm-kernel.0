From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Feb 2015 23:01:18 +0100
Subject: [PATCH] spi: sirf: add reset controller dependency
In-Reply-To: <20150221094458.GM6236@finisterre.sirena.org.uk>
References: <4553005.HBquOfbqXe@wuerfel> <7767301.zaEX63gvjp@wuerfel>
 <20150221094458.GM6236@finisterre.sirena.org.uk>
Message-ID: <6170208.Z0Upu48JrX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 21 February 2015 18:44:58 Mark Brown wrote:
> On Thu, Feb 19, 2015 at 04:01:29PM +0100, Arnd Bergmann wrote:
> 
> > So the stubs are provided for all functions except device_reset() and
> > reset_control_get(), and drivers using the API need to either call the
> > stubbed-out _optional() versions of these functions or have the explicit
> > dependency.
> 
> In that case a dependency seems wrong, I'd expect to see a select - it's
> a bit obscure to have to grovel around to figure out what magic options
> are needed to make things turn on and resets feel more like a utility
> thing than a control bus (which tend to be the things we depend on).
> Dunno, perhaps I'm wrong?

Mixing 'select' and 'depends on' causes recursive dependencies, and
there are already lots of drivers that do 'depends on RESET_CONTROLLER'.

Most users of this symbol seem to follow the strategy of selecting
RESET_CONTROLLER when a driver is there to provide the functionality,
but depending on it when a driver uses it. We are however a bit
inconsistent here and it would be nice to clean it up.

In this particular patch, I'm just following what others do.

We should probably 'select ARCH_HAS_RESET_CONTROLLER' unconditionally
for ARM ARCH_MULTIPLATFORM, as it's a bit silly to select both
ARCH_HAS_RESET_CONTROLLER and RESET_CONTROLLER from platform code.

	Arnd
