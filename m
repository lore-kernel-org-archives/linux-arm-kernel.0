From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Mon, 15 Sep 2014 10:10:12 +0200
Subject: SPI and module auto-loading
In-Reply-To: <20140912101442.GR7960@sirena.org.uk>
References: <54119DB6.8020807@collabora.co.uk>
 <20140911193325.GT4015@sirena.org.uk> <5412C1DF.3040707@collabora.co.uk>
 <20140912101442.GR7960@sirena.org.uk>
Message-ID: <1410768612.22941.1.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-09-12 at 11:14 +0100, Mark Brown wrote:
> On Fri, Sep 12, 2014 at 11:50:23AM +0200, Javier Martinez Canillas wrote:
> > On 09/11/2014 09:33 PM, Mark Brown wrote:
> 
> > > I'm not sure I see that as an interesting use case, it seems better to
> > > have drivers usable without DT and it's trivial to do so.
> 
> > Yes, it's trivial but seems like an unnecessary duplication for me. AFAICT the
> > OF tables are only used to match the devices in spi_match_device() but if both
> > the OF and SPI tables must be kept in sync to properly report the module
> > aliases to user-space then I wonder if the OF tables shouldn't just be removed
> > from the SPI drivers since spi_match_device() will succeed anyways when
> > calling spi_match_id().
> 
> The vendor identifier is an important part of the OF device ID, vendors
> can and do end up with different devices of the same name.

Indeed, which actually points at a problem with module loading for SPI
as the vendor prefix gets dropped when generating the modalias for the
uevent. So if there is a case where we have two SPI devices with the
same device name (but a different vendor identifier), module loading
can't work as the generated modalias for both will be spi:devicename
even if OF can properly distinguish between both.

The core of the "issue" here really is that the way userspace matches an
SPI device to a kernel module and how the kernel matches an SPI to a
driver don't match up (same issue as there is with I2C). While the
kernel can take advantage of the OF table, userspace needs to resolve
the simpler spi: alias, thus essentially using the SPI table. Where as
for the ACPI case, both userspace and kernel will use the ACPI table.

So for things to be consistent for both cases the options are to either:
a) the generated MODALIAS uevent variable should be an OF based alias
  + Upside is that both kernel and userspace can use the full OF
    information for matching
  + Downside is that that would mean adding OF match tables to all
    drivers that can possible used on a DT based system otherwise module
    auto-loading for those will be broken.

b) Stop using OF style matching and rely solely on the SPI id table
  + Downside here is that the vendor prefix isn't used anymore for
    matching. Otoh that's the current status quo for drivers without an
    OF match table and for how userspace matches modules currently.
  + Upside is that no extra work is required for drivers that currently
    work with DT even if they don't have any direct OF support.



-- 
Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Collabora Ltd.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 6170 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140915/921c96b0/attachment.bin>
