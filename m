From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Feb 2015 16:50:18 +0900
Subject: [PATCH] spi: sirf: add reset controller dependency
In-Reply-To: <6170208.Z0Upu48JrX@wuerfel>
References: <4553005.HBquOfbqXe@wuerfel> <7767301.zaEX63gvjp@wuerfel>
 <20150221094458.GM6236@finisterre.sirena.org.uk>
 <6170208.Z0Upu48JrX@wuerfel>
Message-ID: <20150224075018.GM6236@finisterre.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 23, 2015 at 11:01:18PM +0100, Arnd Bergmann wrote:
> On Saturday 21 February 2015 18:44:58 Mark Brown wrote:

> > In that case a dependency seems wrong, I'd expect to see a select - it's
> > a bit obscure to have to grovel around to figure out what magic options
> > are needed to make things turn on and resets feel more like a utility
> > thing than a control bus (which tend to be the things we depend on).
> > Dunno, perhaps I'm wrong?

> Mixing 'select' and 'depends on' causes recursive dependencies, and
> there are already lots of drivers that do 'depends on RESET_CONTROLLER'.

Well, perhaps that's the cleanup we should be doing then...  one of the
big problems with some of the other randconfig work there's been is that
a lot of the patches just add dependencies without looking at if that
makes sense.

> Most users of this symbol seem to follow the strategy of selecting
> RESET_CONTROLLER when a driver is there to provide the functionality,
> but depending on it when a driver uses it. We are however a bit
> inconsistent here and it would be nice to clean it up.

Right, to me that feels the opposite way round to how we normally do
things - the drivers for the subsystem normally depend on the subsystem
(or are hidden by it).

> In this particular patch, I'm just following what others do.

> We should probably 'select ARCH_HAS_RESET_CONTROLLER' unconditionally
> for ARM ARCH_MULTIPLATFORM, as it's a bit silly to select both
> ARCH_HAS_RESET_CONTROLLER and RESET_CONTROLLER from platform code.

That does seem a bit odd.  TBH I'm never sure that ARCH_HAS_ is that
good an idea for the driver things, most of them can just as reasonably
be used by off-SoC things.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150224/831129e3/attachment.sig>
