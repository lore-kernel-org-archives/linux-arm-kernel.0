From: horms@verge.net.au (Simon Horman)
Date: Tue, 11 Sep 2012 14:18:38 +0900
Subject: Booting DT kernel on a non-DT bootloader
In-Reply-To: <20120903085428.GA18323@verge.net.au>
References: <20120903085428.GA18323@verge.net.au>
Message-ID: <20120911051838.GH23356@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 03, 2012 at 05:54:29PM +0900, Simon Horman wrote:
> Hi,
> 
> it has come to pass that for some of the boards under mach-shmobile
> we are in the following situation:
> 
> * The kernel requires a device tree for booting
> * The default boot loader for the board does not support device tree;
>   and in general it is not practical for developers to upload the
>   boot-loader.
> 
> Fortunately there is a solution, which is to append a device tree to
> the kernel image and boot that by the normal means supported by the
> boot loader.
> 
> Here is how to achieve that:
> 
> 1. Make sure you have CONFIG_ARM_APPENDED_DTB=y in your .config
> 
> 2. Create original zImage
> 
>     ARCH=arm make zImage

      If you intend to create a uImage (step 5) then you should run

      ARCH=arm make uImage

      This ensures that arch/arm/boot/.uImage.cmd is up to date

> 3. Create flattened device tree (run this in kernel tree)
> 
>    i) There is code in the next branch of my renesas tree to allow
>       this to be achieved using
> 
>       # make dtbs
> 
>       This will create the device tree for the prevaling kernel config,
>       if one exists.
> 
>       e.g For Armadillo 800 EVA
> 
>       # make dtbs
>       scripts/kconfig/conf --silentoldconfig Kconfig
>         DTC     arch/arm/boot/r8a7740-armadillo800eva.dtb
>       DTC: dts->dtb  on file "arch/arm/boot/dts/r8a7740-armadillo800eva.dts"
> 
>       Else it will do nothing
>       # make dtbs
>       scripts/kconfig/conf --silentoldconfig Kconfig
>       make[1]: Nothing to be done for `arch/arm/boot/dtbs'.
> 
> 
>    ii) If you are running a current or other kernel, which does not
>        support "make dtbs" for mach-shmobile boards, then the dtb
>        may manually be compiled using dtc.
> 
>        e.g. For the Armadillo 800 EVA
> 
>        dtc -I dts -O dtb arch/arm/boot/dts/r8a7740-armadillo800eva.dts \
>            -o arch/arm/boot/dts/r8a7740-armadillo800eva.dtb
> 
>     Note: Please make sure you have a recent version of dtc.
>           I have verified that the above works with DTC 1.3.0 from
> 	  the Debian device-tree-compiler 1.3.0-2 package.
> 	  I have had reports that it fails using DTC 1.2.0.
> 
> 4. Append device tree to zImage (very high-tech!)
> 
>    cat arch/arm/boot/zImage \
> 	arch/arm/boot/dts/r8a7740-armadillo800eva.dtb >
> 	arch/arm/boot/zImage.dtb
> 
> 5. Create uImage (optional)
> 
>    If you need to create a uImage then this may be done using
>    the new zImage + dtb as follows:
> 
>    # cp arch/arm/boot/zImage.dtb arch/arm/boot/zImage
>    # $(cut -f 3- -d ' ' < arch/arm/boot/.uImage.cmd)
> 
> 6. You should now be able to either boot the resulting zImage.dtb
>    or uImage, use whichever suits the needs of the bootloader in use.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
