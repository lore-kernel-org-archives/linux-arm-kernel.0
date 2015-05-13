From: maitysanchayan@gmail.com (maitysanchayan at gmail.com)
Date: Wed, 13 May 2015 23:32:58 +0530
Subject: [RFC 0/2] Implement SoC bus support for Vybrid
In-Reply-To: <cover.1431319599.git.maitysanchayan@gmail.com>
References: <cover.1431319599.git.maitysanchayan@gmail.com>
Message-ID: <20150513180258.GA5046@Sanchayan-Arch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Ping? Any inputs?
 
On 15-05-11 10:41:37, Sanchayan Maity wrote:
> Hello,
> 
> Currently this patchset is based of on our local branch but would like 
> some comments before I push this to mainline through Shawn's tree.
> 
> This patchset implements the following
> https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-devices-soc
> 
> Currently the required information is more or less read across the whole 
> SoC, but I guess we cannot change that since these are the locations 
> with the required information.
> 
> There seem to be three options for the revision field:
> - ROM revision (see https://community.freescale.com/docs/DOC-94802)
> - ANADIG revision (ANADIG_DIGIPROC, as used for the i.MX SoC's)
> - OCOTP revision
> 
> Some numbers:
> 
> Colibri VF61 1.1A (2N02G)
> - 0x00000013
> - 0x00610000
> - 0x01000000
> - 0x410000c8
> 
> Colibri VF61 V1.0B (1N02G)
> - 0x00000011
> - 0x00610000
> - 0x01000000
> - 0x410000c8
> 
> Colibri VF61 V1.0A (which is actually a VF600 SoC, no L2 cache, since
> that was the only one we could buy back then, 1N02G printed on it)
> - 0x00000011
> - 0x00610000
> - 0x01000000
> - none...
> 
> Colibri VF50 V1.0A (1N02G)
> - 0x00000011
> - 0x00610000
> - 0x01000000
> - none...
> 
> Vybrid Tower Rev J (1N02G)
> - 0x00000011
> - 0x00610000
> - 0x01000000
> - 0x410000c8
> 
> Read from u-boot
> md.l 0x80 1
> md.l 0x40050260 1
> md.l 0x400A5090 1
> 
> 
> The ROM revision seems to differ most. So we would like to go with the 
> revision from the ROM register 0x80.
> 
> Now coming to the primary question. This ROM revision register is not 
> really within any of the peripheral maps and I would like to access it 
> for the versioning information. Currently, I used ioremap like below
> 
> ioremap(ROM_REVISION_REGISTER, SZ_1);
> 
> which I guess probably is not the right way to do it. What would be the 
> correct or better way to do this? 
> 
> Also comments or feedback or any of the other parts of the patch are 
> also welcome.
> 
> Some Sample outputs are below:
> On Colibri VF61 V1.1A:
> root at colibri-vf:/sys/devices/soc0# ls
> backlight      fxosc          regulators     sound          uevent
> bl_on          gpio-keys      revision       subsystem
> clk16m         machine        soc            sxosc
> family         power          soc_id         syscon-reboot
> root at colibri-vf:/sys/devices/soc0# cat revision
> 00000013
> root at colibri-vf:/sys/devices/soc0# cat soc_id
> dbc8435c211629d4
> root at colibri-vf:/sys/devices/soc0# cat family
> Freescale Vybrid VF610
> 
> On Colibri VF50 V1.1A:
> root at colibri-vf:/sys/devices/soc0# ls
> backlight               machine                 subsystem
> bl_on                   power                   sxosc
> clk16m                  regulators              syscon-reboot
> family                  revision                toradex,vf50_touchctrl
> fxosc                   soc                     uevent
> gpio-keys               soc_id
> root at colibri-vf:/sys/devices/soc0# cat revision
> 00000013
> root at colibri-vf:/sys/devices/soc0# cat soc_id
> df63c12a2e2161d4
> root at colibri-vf:/sys/devices/soc0# cat family
> Freescale Vybrid VF500
> root at colibri-vf:/sys/devices/soc0# cat machine
> Freescale Vybrid
> 
> Thanks & Regards,
> Sanchayan Maity.
> 
> Sanchayan Maity (2):
>   ARM: dts: vfxxx: Add OCOTP node
>   ARM: vf610: Add SoC bus support for Vybrid
> 
>  arch/arm/boot/dts/vfxxx.dtsi   |  5 +++
>  arch/arm/mach-imx/mach-vf610.c | 76 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 80 insertions(+), 1 deletion(-)
> 
> -- 
> 2.4.0
> 
