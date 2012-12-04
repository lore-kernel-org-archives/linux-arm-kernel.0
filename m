From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 04 Dec 2012 18:54:25 +0800
Subject: at91: Status of NAND flash access
In-Reply-To: <91586D499ADFD74FBCFB8425266A5DE4013765CC370A@pluto.melinkcorp.local>
References: <91586D499ADFD74FBCFB8425266A5DE4013765CC370A@pluto.melinkcorp.local>
Message-ID: <50BDD661.7070803@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Bryan

On 12/3/2012 10:39 PM, Bryan Evenson wrote:
> I have a kernel build of 3.7-rc5 that is built for the AT91SAM9G25.  The kernel has issues when it tries to read the filesystem from NAND flash.  If I change to an NFS setup then the filesystem loads.
According to your question, it is not very clear to me, so could you 
give more detail then I can help.

What type (ubi, jffs2, or others) of your filesystem is used? How do you 
flush the file system into the nand flash, by SAM-BA, or U-Boot? With or 
without pmecc?
And what ecc type (pmecc, soft, none) do you enabled in the kernel?

> I've seen some patches on this list lately related to AT91 NAND flash (specifically this thread: http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/133748.html) and I believe my problems may be related to this issue.  But, I'm having trouble following the thread to find the current status.
>
> Can anyone tell me what the status is on NAND flash access for the AT91 series with the 3.7-rc5 kernel?  If this version has a known bug, is there a different suggested version I use that fixes the issue?
In 3.7-rc5, I think the atmel nand driver should work well with 
AT91SAM9G25EK board even without the patch you mentioned in above URL.

Just for PMECC, you need add following code in 
arch/arm/boot/dts/at91sam9x5cm.dtsi:
-                        nand-ecc-mode = "soft";
+                       nand-ecc-mode = "hw";
+                        atmel,has-pmecc;        /* Enable PMECC */
+                        atmel,pmecc-cap = <2>;    /* PMECC error bits*/
+                        atmel,pmecc-sector-size = <512>;  /* sector 
size for PMECC, it is not page size */

Also you can check the readme file in: 
Documentation/devicetree/bindings/mtd/atmel-nand.txt

Best Regards,
Josh Wu

>
> Thanks,
> Bryan
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
