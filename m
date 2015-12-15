From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Dec 2015 21:38:41 +0100
Subject: [PATCH v3 3/5] soc: rockchip: add reboot notifier driver
In-Reply-To: <20151215174234.GB24031@ulmo.nvidia.com>
References: <1447840044-19689-1-git-send-email-andy.yan@rock-chips.com>
 <3759218.6sItdW65UG@wuerfel> <20151215174234.GB24031@ulmo.nvidia.com>
Message-ID: <15127971.1juVbocOjP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 December 2015 18:42:36 Thierry Reding wrote:
> On Tue, Dec 15, 2015 at 05:34:00PM +0100, Arnd Bergmann wrote:
> > On Tuesday 15 December 2015 17:31:22 Thierry Reding wrote:
> > > On Mon, Dec 14, 2015 at 12:39:44PM +0100, Arnd Bergmann wrote:
> > > > On Wednesday 18 November 2015 17:56:22 Andy Yan wrote:
> > > > > rockchip platform have a protocol to pass the kernel reboot
> > > > > mode to bootloader by some special registers when system reboot.
> > > > > By this way the bootloader can take different action according
> > > > > to the different kernel reboot mode, for example, command
> > > > > "reboot loader" will reboot the board to rockusb mode, this is
> > > > > a very convenient way to get the board enter download mode.
> > > > > 
> > > > > Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> > > > 
> > > > Adding John Stultz to Cc
> > > > 
> > > > I just saw this thread pop up again, and had to think of John's recent
> > > > patch to unify this across platforms.
> > > > 
> > > > John, can you have a look at this driver too, and see how it fits in?
> > > > I think this is yet another variant, using an MMIO register rather than
> > > > RAM (as HTC / NVIDIA does) or SRAM (as Qualcomm does), but otherwise
> > > > it conceptually fits in with what you had.
> > > 
> > > FWIW, Tegra typically does use an MMIO register as well. See
> > > drivers/soc/tegra/pmc.c:tegra_pmc_restart_notify(). I don't know what
> > > HTC does, but if it's writing somewhere in RAM it isn't using the
> > > standard way of resetting the SoC. There's early boot ROM code which I
> > > think evaluates the PMC_SCRATCH0 register on Tegra to determine which
> > > mode to boot into. That's before even any firmware gets the chance of
> > > doing anything.


I just checked the android lollipop tree, and I could not find a pmc_restart_notify
function, only this file

https://android.googlesource.com/kernel/tegra/+/android-tegra-flounder-3.10-lollipop-release/drivers/htc_debug/stability/reboot_params.c

with the device that stores into RAM. It looks like HTC ported over
a driver that they were already using on some Qualcomm MSM8960 device,
as in 

https://gitlab.com/MaC/android_kernel_htc_msm8960/blob/859977fc723f59a6b707df1d70e80826ee1dccc4/arch/arm/mach-msm/htc/htc_restart_handler.c

On Android marshmallow (Flounder), that file again does not exist, and
I don't see how it's done.

> > HTC apparently uses a separate RAM area to pass the reboot reason,
> > and they have a driver to store that, which is separate from the
> > driver that they use for actually rebooting the machine.
> 
> I wasn't very clear, but the PMC_SCRATCH0 register is used to store the
> reset reason. It supports the recovery mode, which I think is really an
> Android thing, "bootloader" will typically cause the bootloader not to
> boot anything, and "forced-recovery" will go into a recovery mode that
> is used to bootstrap the device (usually by uploading a "miniloader"
> that initializes RAM, downloads a bootloader for booting or flashing an
> operating system, ...).
> 
> The write that resets the SoC is to a different register.

So is this scratch register interpreted by some maskrom code, or by code that
can be provided by the OEM?

	Arnd
