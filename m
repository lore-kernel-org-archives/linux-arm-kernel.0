From: lsun@mellanox.com (Liming Sun)
Date: Fri, 26 Oct 2018 19:18:30 +0000
Subject: [PATCH v4 2/4] arm64: Add Mellanox BlueField SoC config option
In-Reply-To: <CAK8P3a1jTsvzYhS4CxvmK6tOgPn_g7=1S4xAcca2K4v70vhyEA@mail.gmail.com>
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
 <1540403734-137721-1-git-send-email-lsun@mellanox.com>
 <1540403734-137721-2-git-send-email-lsun@mellanox.com>
 <CAK8P3a1jTsvzYhS4CxvmK6tOgPn_g7=1S4xAcca2K4v70vhyEA@mail.gmail.com>
Message-ID: <AM4PR05MB32204021433BBB853C50FF30A1F00@AM4PR05MB3220.eurprd05.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Arnd for the comments!  Please see my response inline.

- Liming

> -----Original Message-----
> From: arndbergmann at gmail.com [mailto:arndbergmann at gmail.com] On
> Behalf Of Arnd Bergmann
> Sent: Thursday, October 25, 2018 11:38 AM
> To: Liming Sun <lsun@mellanox.com>
> Cc: Olof Johansson <olof@lixom.net>; David Woods
> <dwoods@mellanox.com>; Robin Murphy <robin.murphy@arm.com>; arm-
> soc <arm@kernel.org>; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v4 2/4] arm64: Add Mellanox BlueField SoC config option
> 
> On 10/24/18, Liming Sun <lsun@mellanox.com> wrote:
> > This commit introduces config option for Mellanox BlueField SoC,
> > which can be used to build the SoC specific drivers, and enables
> > it by default in configs/defconfig.
> >
> > Reviewed-by: David Woods <dwoods@mellanox.com>
> > Signed-off-by: Liming Sun <lsun@mellanox.com>
> > ---
> >  arch/arm64/Kconfig.platforms | 6 ++++++
> >  arch/arm64/configs/defconfig | 1 +
> >  2 files changed, 7 insertions(+)
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> I'm sorry for missing your series in the past. We should definitely merge
> the platform support soon. Do you also have device tree files for reference
> systems or even production hardware?

We have obsoleted the device tree, and mainly support ACPI now
on Reference/Production HW. Below is the TMFIFO definition in the ACPI
DSDT table.

    // RShim TMFIFO
    Device(RSH0) {
      Name(_HID, "MLNXBF01")
      Name(_UID, Zero)
      Name(_CCA, 1)
      Name(_CRS, ResourceTemplate() {
        Memory32Fixed(ReadWrite, 0x00800a20, 0x00000018)
        Memory32Fixed(ReadWrite, 0x00800a40, 0x00000018)
        Interrupt(ResourceConsumer, Edge, ActiveHigh, Exclusive)
          { BF1_RSH0_TM_HTT_LWM_INT,
            BF1_RSH0_TM_HTT_HWM_INT,
            BF1_RSH0_TM_TTH_LWM_INT,
            BF1_RSH0_TM_TTH_HWM_INT
          }
      })
    }

The full ACPI implementation can be found in the 1.0 release:
http://www.mellanox.com/downloads/BlueField/BlueField-1.0.0.10521/BlueField-1.0.0.10521.tar.xz
Inside this tarball, we can see the "src/edk2/" directory which has the edk2 patch file including all the ACPI implementation.

> 
> I need to have a separate look at the fifo driver.
> 
> Unfortunately, you have sent these patches during the merge window,
> which is the time during which we don't pick up new work. Let's plan
> to pick these up after 4.20-rc1, and please resend to arm at kernel.org
> if we manage to forget about it again.
> 
>       Arnd

Thanks for the information. I'll resend it to make sure not to miss the date.
