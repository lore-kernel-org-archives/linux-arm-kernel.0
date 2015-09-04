From: maitysanchayan@gmail.com (maitysanchayan at gmail.com)
Date: Fri, 4 Sep 2015 13:51:31 +0530
Subject: [PATCH v9 0/4] Implement OCOTP driver for Vybrid using NVMEM
In-Reply-To: <55E95470.2010406@linaro.org>
References: <cover.1439384645.git.maitysanchayan@gmail.com>
 <20150904055031.GA5090@Sanchayan-Arch.toradex.int>
 <55E95470.2010406@linaro.org>
Message-ID: <20150904082131.GB5090@Sanchayan-Arch.toradex.int>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 15-09-04 09:21:04, Srinivas Kandagatla wrote:
> Hi Sanchayan,
> 
> On 04/09/15 06:50, maitysanchayan at gmail.com wrote:
> > Hello,
> >
> > Ping? Anything preventing this from being accepted? I can rework it then if
> > so.
> Thanks for your patience,
> 
> We are in the middle of merge window, I will pick the driver for 4.4 
> after 4.3-rc1 is released for linux-next testing.

Thank you very much for the update Srinivas.

- Sanchayan.

> 
> --srini
> 
> >
> > Thanks.
> >
> > - Sanchayan.
> >
> > On 15-08-12 18:49:17, Sanchayan Maity wrote:
> >> Hello,
> >>
> >> This patchset is based on top of v9 of Srinivas's NVMEM framework patches.
> >> Tested on Greg's tree char-misc-next branch along with Stefan's NAND driver
> >> patchset.
> >>
> >> Sample output on Colibri VF50
> >>
> >> root at colibri-vf:/sys/bus/nvmem/devices/ocotp0# uname -a
> >> Linux colibri-vf 4.2.0-rc6-00130-g24fcfdc #3 SMP Wed Aug 12 18:31:24 IST 2015 armv7l GNU/Linux
> >>
> >> root at colibri-vf:/sys/bus/nvmem/devices/ocotp0# hexdump nvmem
> >> 0000000 0000 0000 0000 0000 0000 0000 0000 0000
> >> *
> >> 0000410 72a6 df64 0000 0000 0000 0000 0000 0000
> >> 0000420 11d4 2c14 0000 0000 0000 0000 0000 0000
> >> 0000430 0000 0000 0000 0000 0000 0000 0000 0000
> >> *
> >> 0000450 0280 0000 0000 0000 0000 0000 0000 0000
> >> 0000460 0000 0000 0000 0000 0000 0000 0000 0000
> >> *
> >> 0000880 8f01 0000 0000 0000 0000 0000 0000 0000
> >> 0000890 0000 0000 0000 0000 0000 0000 0000 0000
> >> *
> >> 00008c0 0000 1000 0000 0000 0000 0000 0000 0000
> >> 00008d0 3202 0800 0000 0000 0000 0000 0000 0000
> >> 00008e0 0000 e100 0000 0000 0000 0000 0000 0000
> >> 00008f0 0000 0000 0000 0000 0000 0000 0000 0000
> >> *
> >> 0000c80 bada bada 0000 0000 0000 0000 0000 0000
> >> *
> >> 0000cc0 0000 0000 0000 0000 0000 0000 0000 0000
> >> *
> >> 0000cf0
> >>
> >> The driver has changed quite a bit from the first version
> >> relying on of_platform_populate in mach file, to using
> >> SoC driver under drivers/soc and finally to NVMEM.
> >>
> >> Feedback and comments most welcome.
> >>
> >> Version 8 patches can be found here
> >> https://lkml.org/lkml/2015/8/10/566
> >>
> >> Version 7 patches can be found here
> >> https://lkml.org/lkml/2015/8/6/440
> >>
> >> Version 6 RFC patches can be found here
> >> http://lkml.iu.edu/hypermail/linux/kernel/1506.2/05123.html
> >>
> >> Version 5 of the patchset can be found here
> >> http://lkml.iu.edu/hypermail/linux/kernel/1506.0/03787.html
> >>
> >> Version 4 of the patchset can be found here
> >> https://lkml.org/lkml/2015/5/26/199
> >>
> >> Version 3 of the patchset can be found here
> >> http://www.spinics.net/lists/arm-kernel/msg420847.html
> >>
> >> Version 2 of the patchset can be found here
> >> http://www.spinics.net/lists/devicetree/msg80654.html
> >>
> >> Version 1 of the patchset can be found here
> >> http://www.spinics.net/lists/devicetree/msg80257.html
> >>
> >> The RFC version can be found here
> >> https://lkml.org/lkml/2015/5/11/13
> >>
> >> Changes since v8:
> >> 1. Fix three lines over 80 characters
> >> 2. Rebase on top of Greg's char-misc-next branch
> >>
> >> Changes since v7:
> >> 1. Add COMPILE_TEST to Kconfig
> >> 2. Use GENMASK and BIT macros where applicable
> >> 3. Fix a code alignment issue
> >> 4. Get the max_register value for regmap config using
> >> resource_size()
> >> 5. Also add copyright info as the driver logic is based off
> >> on ocotp code in barebox
> >> 6. Add missing info related to clock in DT binding doc
> >>
> >> Changes since v6:
> >> 1. Use the v9 of NVMEM framework patchset
> >> 2. Add a few comments
> >> 3. Initialise buffer address not part of the fuse map to 0
> >> instead of only handling buffer locations with valid fuse
> >> addresses.
> >>
> >> Changes since v5:
> >> Use NVMEM framework by Srinivas and Maxime
> >>
> >> Changes since v4:
> >> 1. Use devm_* family of functions and use a struct to get rid of
> >> global variables (suggested by Joachim Eastwood)
> >> 2. Make Kconfig govern the compilation with tristate, instead of
> >> earlier bool. Paul Bolle raised a valid point that perhaps this
> >> should have been built in with the bool, however I had not taken
> >> into consideration generic distro kernels and it makes sense to
> >> have this tristated. (comments from Paul Bolle and Andreas Farber)
> >>
> >> Changes since v3:
> >> Instead of using the syscon_regmap_lookup_by_compatible function
> >> use a phandle in the device tree along with offsets specified in
> >> this phandle node and then read the offset along with the device
> >> node in the driver for reading from the required region.
> >>
> >> Changes since v2:
> >> Implement the SoC bus code as a driver in drivers/soc
> >> by registering with fsl,mscm-cpucfg as per Arnd's feedback
> >>
> >> Changes since v1:
> >> Sort the headers in alphabetical order
> >>
> >> Changes since RFC:
> >> Use a DT entry for the ROM area while specifying it as syscon.
> >>
> >> Thanks & Regards,
> >> Sanchayan Maity.
> >>
> >> Sanchayan Maity (4):
> >>    clk: clk-vf610: Add clock for Vybrid OCOTP controller
> >>    ARM: dts: vfxxx: Add OCOTP node
> >>    drivers: nvmem: Add Vybrid OCOTP support
> >>    nvmem: Add DT binding documentation for Vybrid OCOTP driver
> >>
> >>   .../devicetree/bindings/nvmem/vf610-ocotp.txt      |  21 ++
> >>   arch/arm/boot/dts/vfxxx.dtsi                       |   9 +
> >>   drivers/clk/imx/clk-vf610.c                        |   1 +
> >>   drivers/nvmem/Kconfig                              |  10 +
> >>   drivers/nvmem/Makefile                             |   2 +
> >>   drivers/nvmem/vf610-ocotp.c                        | 302 +++++++++++++++++++++
> >>   include/dt-bindings/clock/vf610-clock.h            |   3 +-
> >>   7 files changed, 347 insertions(+), 1 deletion(-)
> >>   create mode 100644 Documentation/devicetree/bindings/nvmem/vf610-ocotp.txt
> >>   create mode 100644 drivers/nvmem/vf610-ocotp.c
> >>
> >> --
> >> 2.5.0
> >>
