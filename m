From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Dec 2015 16:35:46 +0100
Subject: [PATCH v3 3/5] soc: rockchip: add reboot notifier driver
In-Reply-To: <20151228092054.GA29195@ulmo.nvidia.com>
References: <1447840044-19689-1-git-send-email-andy.yan@rock-chips.com>
 <15127971.1juVbocOjP@wuerfel> <20151228092054.GA29195@ulmo.nvidia.com>
Message-ID: <2250962.OgUpqMgY4k@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 December 2015 10:20:56 Thierry Reding wrote:
> > > > HTC apparently uses a separate RAM area to pass the reboot reason,
> > > > and they have a driver to store that, which is separate from the
> > > > driver that they use for actually rebooting the machine.
> > > 
> > > I wasn't very clear, but the PMC_SCRATCH0 register is used to store the
> > > reset reason. It supports the recovery mode, which I think is really an
> > > Android thing, "bootloader" will typically cause the bootloader not to
> > > boot anything, and "forced-recovery" will go into a recovery mode that
> > > is used to bootstrap the device (usually by uploading a "miniloader"
> > > that initializes RAM, downloads a bootloader for booting or flashing an
> > > operating system, ...).
> > > 
> > > The write that resets the SoC is to a different register.
> > 
> > So is this scratch register interpreted by some maskrom code, or by code that
> > can be provided by the OEM?
> 
> My understanding is that its interpreted both by what's called BootROM
> on Tegra (I guess that's what you call "maskrom code") and the system's
> bootloader. The BootROM cannot typically be replaced by the OEM, but it
> is quite typical for the bootloader to differ between devices.

Ok, so not maskrom (which would not be OEM specific, but hardcoded for
the chip) but rather some form of PROM. This means we can only guess
that all OEMs use the same protocol but in theory someone could have
implemented an incompatible BootROM, but it's also possible that HTC
just ignore the register entirely and implement the same thing separately.

> The BootROM will interpret a subset of the bits in that register. Most
> notable the "force recovery" bit. That will cause the BootROM to go into
> a mode which can be used to bootstrap the device. It implements a simple
> protocol (RCM) which can be used to upload a loader (usually referred to
> as mini-loader) to the device's IRAM which in turn will initialize the
> memory and which can download a proper bootloader (such as U-Boot) to
> memory using a slightly more complex protocol (the standard protocol is
> called nv3p, but the particular choice of protocol no longer matters at
> this point).
> 
> The bootloader can also access this register and will interpret the
> "bootloader" and "recovery" bits. On the, argueably small, sample of
> Android devices I've worked with, the "bootloader" bit will make the
> bootloader go into fastboot mode, whereas the "recovery" bit will make
> it initiate the RCK mode, which is used to update through OTA.
> 
> There are a couple of other bits in this register, but they are badly
> documented and don't seem to relate to reboot.

Ok.

	Arnd
