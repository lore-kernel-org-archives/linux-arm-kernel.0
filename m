From: maitysanchayan@gmail.com (maitysanchayan at gmail.com)
Date: Mon, 28 Mar 2016 11:05:16 +0530
Subject: [PATCH v1 0/4] Implement SoC bus driver for Vybrid
In-Reply-To: <cover.1457684688.git.maitysanchayan@gmail.com>
References: <cover.1457684688.git.maitysanchayan@gmail.com>
Message-ID: <20160328053516.GA1443@Sanchayan-Arch.toradex.int>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Ping.

- Sanchayan.

On 16-03-11 14:29:27, Sanchayan Maity wrote:
> Hello,
> 
> This patchset implements SoC bus support for Freescale Vybrid platform,
> implementing the following
> https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-devices-soc
> 
> This a reworked version of an older patchset series posted in June 2015
> which was at v5 then [1]. Since the NVMEM framework was then getting
> introduced, we decided that first a NVMEM driver for OCOTP peripheral
> being in place would be better.
> 
> Compared to the older revisions, this driver now relies on NVMEM
> consumer API using the NVMEM based vf610_ocotp driver which has
> already been in mainline for a while now. Also now a new syscon
> abstraction "syscon_regmap_read_from_offset" is implemented and
> exported from syscon allowing accessing a register from a syscon
> reference like this
> 
> ocotp-cfg1 = <&ocotp 0x20>;
> 
> avoiding code repetition in the driver.
> 
> One point on which we were not sure here is whether we really should
> introduce a new Kconfig symbol as being introduced here. While we
> could just enable it when SOC_VF610 is selected, this however would
> introduce circular dependencies.
> 
> This patch series is based on top of shawn's for-next branch and
> tested on Colibri Vybrid VF50 and VF61 modules.
> 
> Feedback is most welcome.
> 
> [1] Older v5:
> http://lkml.iu.edu/hypermail/linux/kernel/1506.0/03787.html
> Even earlier versions:
> Version 4 of the patchset can be found here
> https://lkml.org/lkml/2015/5/26/199
> Version 3 of the patchset can be found here
> http://www.spinics.net/lists/arm-kernel/msg420847.html
> Version 2 of the patchset can be found here
> http://www.spinics.net/lists/devicetree/msg80654.html
> Version 1 of the patchset can be found here
> http://www.spinics.net/lists/devicetree/msg80257.html
> The RFC version can be found here
> https://lkml.org/lkml/2015/5/11/13
> 
> Regards,
> Sanchayan.
> 
> Sanchayan Maity (4):
>   mfd: syscon: Introduce syscon_regmap_read_from_offset
>   ARM: dts: vfxxx: Add device tree node for OCOTP
>   ARM: dts: vfxxx: Add OCROM and phandle entries for Vybrid SoC bus driver
>   soc: Add SoC bus driver for Freescale Vybrid Platform
> 
>  arch/arm/boot/dts/vfxxx.dtsi |  28 +++++++-
>  drivers/mfd/syscon.c         |  30 ++++++++
>  drivers/soc/Kconfig          |   1 +
>  drivers/soc/fsl/Kconfig      |  10 +++
>  drivers/soc/fsl/Makefile     |   1 +
>  drivers/soc/fsl/soc-vf610.c  | 160 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/syscon.h   |  10 +++
>  7 files changed, 239 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/soc/fsl/Kconfig
>  create mode 100644 drivers/soc/fsl/soc-vf610.c
> 
> -- 
> 2.7.2
> 
