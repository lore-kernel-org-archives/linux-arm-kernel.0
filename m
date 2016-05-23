From: robh@kernel.org (Rob Herring)
Date: Mon, 23 May 2016 16:18:13 -0500
Subject: [PATCH v3 4/4] soc: Add SoC driver for Freescale Vybrid platform
In-Reply-To: <ffef165d05f71a1b19437171d8fdb4bc78f6b1e3.1463737502.git.maitysanchayan@gmail.com>
References: <cover.1463737502.git.maitysanchayan@gmail.com>
 <ffef165d05f71a1b19437171d8fdb4bc78f6b1e3.1463737502.git.maitysanchayan@gmail.com>
Message-ID: <20160523211813.GA30237@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 20, 2016 at 03:32:05PM +0530, Sanchayan Maity wrote:
> This adds a SoC driver to be used by Freescale Vybrid SoC's.
> Driver utilises syscon and nvmem consumer API's to get the
> various register values needed and expose the SoC specific
> properties via sysfs.
> 
> A sample output from Colibri Vybrid VF61 is below:
> 
> root at colibri-vf:~# cd /sys/bus/soc/devices/soc0
> root at colibri-vf:/sys/bus/soc/devices/soc0# ls
> family     machine    power      revision   soc_id     subsystem  uevent
> root at colibri-vf:/sys/bus/soc/devices/soc0# cat family
> Freescale Vybrid VF610
> root at colibri-vf:/sys/bus/soc/devices/soc0# cat machine
> Freescale Vybrid
> root at colibri-vf:/sys/bus/soc/devices/soc0# cat revision
> 00000013
> root at colibri-vf:/sys/bus/soc/devices/soc0# cat soc_id
> df6472a6130f29d4
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> ---
>  .../bindings/arm/freescale/fsl,vf610-soc.txt       |  20 +++
>  drivers/soc/Kconfig                                |   1 +
>  drivers/soc/fsl/Kconfig                            |  10 ++
>  drivers/soc/fsl/Makefile                           |   1 +
>  drivers/soc/fsl/soc-vf610.c                        | 198 +++++++++++++++++++++
>  5 files changed, 230 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,vf610-soc.txt
>  create mode 100644 drivers/soc/fsl/Kconfig
>  create mode 100644 drivers/soc/fsl/soc-vf610.c
> 
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-soc.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-soc.txt
> new file mode 100644
> index 0000000..338905d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-soc.txt
> @@ -0,0 +1,20 @@
> +Vybrid System-on-Chip
> +---------------------
> +
> +Required properties:
> +
> +- compatible: "fsl,vf610-soc"
> +- rom-revision: phandle to the on-chip ROM node
> +- mscm: phandle to the MSCM CPU configuration node
> +- nvmem-cells: phandles to two OCOTP child nodes ocotp_cfg0 and ocotp_cfg1
> +- nvmem-cell-names: should contain string names "cfg0" and "cfg1"

I still have similar concerns as the discussion on the last version. 
This version only proves that you aren't describing h/w, but rather just 
a collection of data that some driver wants.

A driver can just as easily look-up all the nodes directly that these 
phandles point to.

And as long as we have inconsistent use of soc_device, I don't want to 
see any compatible strings related to it.

Rob
