From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 21 Jun 2018 13:37:26 +0200
Subject: [PATCH 1/1] arm64: dts: rockchip: correct voltage selector
 Firefly-RK3399
In-Reply-To: <3b6e37c8-0ee2-1723-1aa8-499fcb30471c@gmx.de>
References: <20180604171523.28454-1-xypron.glpk@gmx.de>
 <cd7447bc-1c3d-29ca-9671-144b1f474711@gmx.de>
 <3b6e37c8-0ee2-1723-1aa8-499fcb30471c@gmx.de>
Message-ID: <5740207.Zs2D9gmsc0@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 21. Juni 2018, 02:57:02 CEST schrieb Heinrich Schuchardt:
> On 06/20/2018 09:57 PM, Heinrich Schuchardt wrote:
> > On 06/20/2018 11:15 AM, Heiko St?bner wrote:
> >> Hi Heinrich,
> >>
> >> Am Mittwoch, 20. Juni 2018, 07:59:34 CEST schrieb Heinrich Schuchardt:
> >>> On 06/20/2018 01:21 AM, Heiko Stuebner wrote:
> >>>> Am Donnerstag, 14. Juni 2018, 14:55:27 CEST schrieb Heiko Stuebner:
> >>>>> Am Montag, 4. Juni 2018, 19:15:23 CEST schrieb Heinrich Schuchardt:
> >>>>>> Without this patch the Firefly-RK3399 board boot process hangs after
> >>>>>> these
> >>>>>>
> >>>>>> lines:
> >>>>>>    fan53555-regulator 0-0040: FAN53555 Option[8] Rev[1] Detected!
> >>>>>>    fan53555-reg: supplied by vcc_sys
> >>>>>>    vcc1v8_s3: supplied by vcc_1v8
> >>>>>>
> >>>>>> Blacklisting driver fan53555 allows booting.
> >>>>>>
> >>>>>> The device tree uses a value of fcs,suspend-voltage-selector different
> >>>>>> to
> >>>>>> any other board.
> >>>>>>
> >>>>>> Changing this setting to the usual value is sufficient to enable
> >>>>>> booting.
> >>>>>>
> >>>>>> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >>>>>
> >>>>> applied for 4.19.
> >>>>
> >>>> and dropped again.
> >>>>
> >>>> Sadly it looks like the patch causes conflicts with at least one firefly
> >>>> board in a kernelci lab. My own is currently not ready to use, so I cannot
> >>>> look myself right now.
> >>>>
> >>>> The issue kernelci people described sounded quite a lot like the one
> >>>> in your commit message, so my current theory is that the
> >>>> suspend-voltage-selector must in some form corespond to the
> >>>> cpu_b_sleep_h gpio setting we're currently not handling at all, which
> >>>> would therefore depend on how the bootloader sets this up.
> >>>
> >>> please, provide a link to the log displaying the issue and the contact
> >>> who can provide the exact setup.
> >>>
> >>> I have been testing with U-Boot as boot loader.
> >>
> >> failing boot can be found on
> >> https://kernelci.org/boot/id/5b2a053d59b514569079a872/
> >>
> >> As this board is sitting in the "lab-baylibre-seattle", I guess
> >> Kevin Hilman (Cc'ed now) is the one that can say a bit more about the
> >> board setup.
> >>
> >>
> >> The more interesting question would be how to make sure we don't
> >> die with possible different bootloader versions. As I don't really thing 
> >> "upgrade your bootloader" is an always valid option.
> >>
> >>
> >> Heiko
> >>
> > 
> > Hi Kevin,
> > 
> > the RK3399-Firefly was booted on lab-baylibre-seattle with
> > U-Boot 2017.05-rc3-00131-gf79fd58d5f5c-dirty
> > 
> > f79fd58d5f5c is not a commit in U-Boot master.
> > The version number tells us it is 131 patches ahead of U-Boot 2017.05-rc3.
> > Dirty means the source contained uncommitted changes.
> > 
> > Unfortunately this is not a reproducible test environment.
> > Could you, please, provide the build recipe to reproduce the U-Boot
> > BayLibre is using?
> > Would it be possible to use mainline U-Boot in kernelci for this board?
> > 
> > Best regards
> > 
> > Heinrich
> > 
> 
> I have now built the last available release of U-Boot (v2018.05)
> according to the following recipe:
> 
> git clone https://github.com/xypron/u-boot-build.git
> cd u-boot-build/
> git checkout firefly-rk3399-rkloader
> # commit 251b12fb4f0eabfff2d0552d0807d8ddc44ae2aa
> # tag firefly-rk3399-rkloader-v2018.05
> make
> make install DESTDIR=foo
> cd foo/usr/lib/u-boot/firefly-rk3399/
> # be careful to specify your SD card as device!
> ./sd_fusing /dev/sdX
> 
> # in U-Boot 2018.05 (Jun 21 2018 - 02:33:12 +0200)
> load mmc 1:1 ${fdt_addr_r} 2018-06-20/rk3399-firefly.dtb
> load mmc 1:1 ${kernel_addr_r} 2018-06-20/Image
> booti ${kernel_addr_r} - ${fdt_addr_r}
> 
> The error observed in kernelci when initializing the FAN53555 driver
> does not occur.
> 
> The console log is here:
> https://gist.github.com/xypron/34b6485deabfc8172f978b5a99705466

For one, the kernelci board uses the uboot SPL not rkloader as 1st stage.
But I also think the real culprit might be the unconfigured cpu_b_sleep_h
gpio. 

So far I haven't seen any code that touches this pin at all, so it is probably
floating and both mine as well as the kernelci board are from an early
production run, so I guess it is possible that either rkloader configures
this pin or some board change between ours and your board could make
the pin take another state.

Requiring replacement of a bootloader still isn't the best way forward,
so my current idea would be to let the driver know the vsel-gpio via the
devicetree and have the driver then make sure the gpio is set correctly
_after_ setting the regulator voltage.


Heiko
