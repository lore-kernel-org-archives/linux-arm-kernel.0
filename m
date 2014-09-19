From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Fri, 19 Sep 2014 13:08:39 +0200
Subject: SPI and module auto-loading
In-Reply-To: <20140915225820.GI7960@sirena.org.uk>
References: <54119DB6.8020807@collabora.co.uk>
 <20140911193325.GT4015@sirena.org.uk> <5412C1DF.3040707@collabora.co.uk>
 <20140912101442.GR7960@sirena.org.uk>
 <1410768612.22941.1.camel@collabora.co.uk>
 <20140915225820.GI7960@sirena.org.uk>
Message-ID: <1411124919.29071.7.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-09-15 at 15:58 -0700, Mark Brown wrote:
> On Mon, Sep 15, 2014 at 10:10:12AM +0200, Sjoerd Simons wrote:
> > On Fri, 2014-09-12 at 11:14 +0100, Mark Brown wrote:

> > So for things to be consistent for both cases the options are to either:
> > a) the generated MODALIAS uevent variable should be an OF based alias
> >   + Upside is that both kernel and userspace can use the full OF
> >     information for matching
> >   + Downside is that that would mean adding OF match tables to all
> >     drivers that can possible used on a DT based system otherwise module
> >     auto-loading for those will be broken.
> 
> This isn't a disadvantage for the drivers, anything being used with OF
> should have an explicit match table defined.

Doing a very rough grep for (spi) drivers that do use OF (or are
mentioned in the devicetree documentation or any of the upstream .dts
files use them) but which don't have an OF table. It looks like there
are about 10-15 drivers which are broken in this regard.

Most commonly used and probably trickiest offender seems to be the
m25p80, which exposes a ~125 different SPI Nor chips (all including
driver data) via an id_table but has no OF table to match.


> > b) Stop using OF style matching and rely solely on the SPI id table
> >   + Downside here is that the vendor prefix isn't used anymore for
> >     matching. Otoh that's the current status quo for drivers without an
> >     OF match table and for how userspace matches modules currently.
> >   + Upside is that no extra work is required for drivers that currently
> >     work with DT even if they don't have any direct OF support.
> 
> There's also the option of providing both bits of information in the
> event which is less disruptive all round.

Well neither option i mentioned prevents you from having the same
information in both tables and that doesn't matter at for the kernel
internally (as that can gracefully fall back). 

However for module loading, unless there are userspace changes, you have
to pick between of: and spi: ahead of time as the modalias is expected
to just be a single item.

So i guess we have our next steps :).. First fix up the drivers and then
we can properly submit Javiers strawman patch that was inlined in the
mail that started this tread.
 
-- 
Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Collabora Ltd.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 6170 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140919/0a18417a/attachment-0001.bin>
