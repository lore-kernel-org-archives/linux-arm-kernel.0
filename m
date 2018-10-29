From: lsun@mellanox.com (Liming Sun)
Date: Mon, 29 Oct 2018 14:58:21 +0000
Subject: [PATCH v4 2/4] arm64: Add Mellanox BlueField SoC config option
In-Reply-To: <CAK8P3a2=shWVjwrmnNTwwGwN_jhwyb+TmeALz4zzTstho51z8A@mail.gmail.com>
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
 <1540403734-137721-1-git-send-email-lsun@mellanox.com>
 <1540403734-137721-2-git-send-email-lsun@mellanox.com>
 <CAK8P3a1jTsvzYhS4CxvmK6tOgPn_g7=1S4xAcca2K4v70vhyEA@mail.gmail.com>
 <AM4PR05MB32204021433BBB853C50FF30A1F00@AM4PR05MB3220.eurprd05.prod.outlook.com>
 <CAK8P3a2=shWVjwrmnNTwwGwN_jhwyb+TmeALz4zzTstho51z8A@mail.gmail.com>
Message-ID: <DB6PR05MB32236AAD033C20DF6414C464A1F30@DB6PR05MB3223.eurprd05.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks! Please see response inline.

- Liming

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Friday, October 26, 2018 3:32 PM
> To: Liming Sun <lsun@mellanox.com>
> Cc: Olof Johansson <olof@lixom.net>; David Woods
> <dwoods@mellanox.com>; Robin Murphy <robin.murphy@arm.com>; arm-
> soc <arm@kernel.org>; DTML <devicetree@vger.kernel.org>; Linux ARM
> <linux-arm-kernel@lists.infradead.org>
> Subject: Re: [PATCH v4 2/4] arm64: Add Mellanox BlueField SoC config option
> 
> On Fri, Oct 26, 2018 at 9:18 PM Liming Sun <lsun@mellanox.com> wrote:
> > > -----Original Message-----
> > > From: arndbergmann at gmail.com [mailto:arndbergmann at gmail.com] On
> > > Behalf Of Arnd Bergmann
> > > Sent: Thursday, October 25, 2018 11:38 AM
> > > To: Liming Sun <lsun@mellanox.com>
> > > Cc: Olof Johansson <olof@lixom.net>; David Woods
> > > <dwoods@mellanox.com>; Robin Murphy <robin.murphy@arm.com>;
> arm-
> > > soc <arm@kernel.org>; devicetree at vger.kernel.org; linux-arm-
> > > kernel at lists.infradead.org
> > > Subject: Re: [PATCH v4 2/4] arm64: Add Mellanox BlueField SoC config
> option
> > >
> > > On 10/24/18, Liming Sun <lsun@mellanox.com> wrote:
> > > > This commit introduces config option for Mellanox BlueField SoC,
> > > > which can be used to build the SoC specific drivers, and enables
> > > > it by default in configs/defconfig.
> > > >
> > > > Reviewed-by: David Woods <dwoods@mellanox.com>
> > > > Signed-off-by: Liming Sun <lsun@mellanox.com>
> > > > ---
> > > >  arch/arm64/Kconfig.platforms | 6 ++++++
> > > >  arch/arm64/configs/defconfig | 1 +
> > > >  2 files changed, 7 insertions(+)
> > >
> > > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> > >
> > > I'm sorry for missing your series in the past. We should definitely merge
> > > the platform support soon. Do you also have device tree files for
> reference
> > > systems or even production hardware?
> >
> > We have obsoleted the device tree, and mainly support ACPI now
> > on Reference/Production HW. Below is the TMFIFO definition in the ACPI
> > DSDT table.
> >
> >     // RShim TMFIFO
> >     Device(RSH0) {
> >       Name(_HID, "MLNXBF01")
> >       Name(_UID, Zero)
> >       Name(_CCA, 1)
> >       Name(_CRS, ResourceTemplate() {
> >         Memory32Fixed(ReadWrite, 0x00800a20, 0x00000018)
> >         Memory32Fixed(ReadWrite, 0x00800a40, 0x00000018)
> >         Interrupt(ResourceConsumer, Edge, ActiveHigh, Exclusive)
> >           { BF1_RSH0_TM_HTT_LWM_INT,
> >             BF1_RSH0_TM_HTT_HWM_INT,
> >             BF1_RSH0_TM_TTH_LWM_INT,
> >             BF1_RSH0_TM_TTH_HWM_INT
> >           }
> >       })
> >     }
> >
> > The full ACPI implementation can be found in the 1.0 release:
> > http://www.mellanox.com/downloads/BlueField/BlueField-
> 1.0.0.10521/BlueField-1.0.0.10521.tar.xz
> > Inside this tarball, we can see the "src/edk2/" directory which has the edk2
> patch file including all the ACPI implementation.
> 
> It would be nice if you could still include the dts sources in the submission.
> Since this is not a classic server hardware, DT is probably more suitable
> here, and there are likely use cases that won't work with ACPI, so it's
> good to have a starting point for your users if they need to override
> the ACPI tables with a DT, or build systems with a simpler boot loader.

Sure, I'll keep this DT change for reference. A little explanation that
Mellanox BlueField SOC could be PCIe NIC or standalone device (server)  form which
can do PXE boot, CentOS installation even on the NIC, etc. The same software/driver 
works on both.  DT seems not working well for some requirement/features like 
NVDIMM (which requires ACPI DSM).  That's why we switched to ACPI though
DT support is preserved.

> 
>        Arnd
