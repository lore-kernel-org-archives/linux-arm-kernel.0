From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 09 Apr 2014 09:09:36 +0200
Subject: Big endian working?
In-Reply-To: <20140409073016.72060cd3@skate>
References: <20140408095446.0520dd28@skate>
 <CAA3XUr3gR-R1X6+CxP-Z0fv7kiSzENtm0NsYd539BNVWKCgdNw@mail.gmail.com>
 <20140409073016.72060cd3@skate>
Message-ID: <7521814.ApkjdzgJjE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 April 2014 07:30:16 Thomas Petazzoni wrote:
> On Tue, 8 Apr 2014 21:46:05 -0700, Victor Kamensky wrote:
> 
> > > If I remember correctly, those are for booting a BE kernel on hardware
> > > that initializes in LE mode and expects a LE kernel.  Since the zImage
> > > header values are defined to be words, those must be swapped so they
> > > read as LE even if the kernel is BE.  Of course the kernel is then
> > > responsible for switching the endian mode when entered.
> > 
> > My understanding is that CPU_BE8_BOOT_LE was needed only for
> > atags boot case. Since now practically nobody uses atags, but rather
> > fdt those patches were not pushed into main stream.
> 
> Well it would still be nice to have ATAGs support, as a few people are
> still using old, non fdt-capable bootloaders.

My point was actually that it should never be wrong to use
CPU_BE8_BOOT_LE on a BE8 kernel. We have at no point supported
a boot loader that uses a big-endian boot protocol for ARMv6/v7
upstream kernel, and there is a danger of people expecting it
to work in the future if the kernel does it now.

If we ensure that we only support boot loaders that expect
little-endian numbers in these fields, any kernel (DT or ATAGS,
little-endian or big-endian) should work on any boot loader
that has matching boot data.

	Arnd
