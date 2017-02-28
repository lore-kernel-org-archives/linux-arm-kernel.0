From: kashyap.desai@broadcom.com (Kashyap Desai)
Date: Tue, 28 Feb 2017 16:04:35 +0530
Subject: ARM64 CONFIG_ZONE_DMA for 32-bit devices
Message-ID: <6eab56bb5a4ffd8812d8b59ffa8a7cce@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi -

I was reading below articles. Mine is not similar issue, but  I understand
few things about ARM64 SWIOTLB interface from below discussion.
Any input will be a great help to resolve/understand the issue.

https://patchwork.codeaurora.org/patch/143833/
https://patchwork.kernel.org/patch/9495893/

Current problem statement is -
"Trying to load kdump kernel from above 4GB memory does not work on ARM64
platform as <megaraid_sas> driver require certain DMA buffer from below
4GB memory range."

Looking for alternative/workaround for time being. Long term plan is to
remove limitation of <megaraid_sas> driver to remove 32 bit DMA mask for
SAS3.0 onwards controller.

1) I found below code @arch/arm64/mm/init.c . ARM64 kernel has provision
to support 32-bit DMA as well.  I am not sure about why CONFIG_ZONE_DMA
option is an configurable option for ARM64 ?

        /* 4GB maximum for 32-bit only capable devices */
        if (IS_ENABLED(CONFIG_ZONE_DMA))
                arm64_dma_phys_limit = max_zone_dma_phys();
        else
                arm64_dma_phys_limit = PHYS_MASK + 1;
        dma_contiguous_reserve(arm64_dma_phys_limit);

One of the reason I think "kdump" kernel can load from above 4GB memory
range provided crashkernel=<>, high and crashkernel=0, low option. So I
guess ARM64 kdump kernel may have disabled CONFIG_ZONE_DMA option, but
base kernel must have enabled CONFIG_ZONE_DMA option to support 32-bit
only capable devices.

Still it is not clear as kdump kernel works in ARM64 without
CONFIG_ZONE_DMA, means base kernel can also work without CONFIG_ZONE_DMA
set. It means looks like CONFIG_ZONE_DMA is just temporary arrangement.

Is there any plan that ARM64 will remove CONFIG_ZONE_DMA and require all
devices to be 64-bit capable.


2.)

Typically - SWIOTLB uses DMA buffer from below 4GB range only. ARM64 is
the only architecture which support Low memory definition as per ARCH
specified. See below

[root@ linux]# grep -R ARCH_LOW_ADDRESS_LIMIT arch/
arch/s390/include/asm/processor.h:#define ARCH_LOW_ADDRESS_LIMIT
0x7fffffffUL
arch/arm64/include/asm/processor.h:#define ARCH_LOW_ADDRESS_LIMIT
(arm64_dma_phys_limit - 1)

For only ARM64, it is possible to get SWTBL DMA buffer above 4GB. See
below snippet from crashed kernel on ARM64.

[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000005fc0000000-0x0000005fffffffff]
[    0.000000]   Normal   empty

SWIOTLB can map 64MB buffer from above 4GB only on ARM64 machine and that
is causing problem for <megaraid_sas> driver.
Current megaraid_sas driver wants certain resources from below 4GB memory
and that is why it request consistent dma mask as below -
pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32)).

If I do the same on x86_64, SWTBL INIT will fail because there is no Low
memory below 4GB. See below prints from x86_64 machine.

[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000407effffff]
  [    0.000000] Movable zone start for each node
   ..
   [    0.000000] Cannot allocate SWIOTLB buffer

Question is - "ARM64 platform can't allocate memory for crash kernel in
below 4GB range ?"

Thanks, Kashyap
