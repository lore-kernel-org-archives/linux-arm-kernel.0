From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 08 Mar 2011 15:16:11 +0100
Subject: [PATCH 0/2] ARM: EXYNOS4: Enhancement of System MMU
In-Reply-To: <1299460768-4077-1-git-send-email-pullip.cho@samsung.com>
References: <1299460768-4077-1-git-send-email-pullip.cho@samsung.com>
Message-ID: <000701cbdd9b$634c3840$29e4a8c0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Monday, March 07, 2011 2:19 AM KyongHo Cho wrote:

> This patch includes the following enhancements for System MMU:
> - Enhanced readability
> - Removal of unused data structures or their members
> - Simplified function definitions
> - Corrections of some logical errors
> - Full compliance with Linux coding style
> - Simpler way of registering callback functions of System MMU faults
> - Add clock gating for System MMU

Thanks for updating the driver, I have however some comments.

EXYNOS4 platform has total of 16 sysmmu blocks. Each of them is exactly the
same - each has a register region, an interrupt and clock. However your driver
uses a single platform device for all 16 units and a large resource array (see
arch/arm/mach-exynos4). This approach also complicates the clock management 
(you need to create custom names for sysmmu clocks, this will cause a lot of
problems in the future update to clkdev!). This also heavily complicates the
driver (you need the arrays of all the resources all over the driver) and is
against the Linux driver model. In the proper model one should create a
platform driver for a single module and instantiate it many times for each hw
module found in the system. For a reference please take a look at the sysmmu
Andrzej has developed in parallel to You: 
http://www.mail-archive.com/linux-media at vger.kernel.org/msg28871.html

For a reference please also check the Samsung Power Domains driver 
(arch/arm/mach-exynos4/dev-pd.c and arch/arm/plat-s5p/pd.c).

The second problem I've noticed is the s5p_sysmmu_set_tablebase_pgd() call. 
In my opinion it simplifies the sysmmu api too much. This function assumes
that the sysmmu client (i.e. a multimedia device driver or videobuf2-allocator
or vcmm) has a knowledge about the pgd/pte descriptors format. As you know the
format of pgd/pte descriptors is hardware dependent (it may even change in the
future version of SoCs), so constructing the pgd and pte tables is a low-level
operation that should be performed by sysmmu driver. Keeping this call in the
current form results in a requirement that each sysmmu client MUST know the
hardware details of the sysmmu module. In my opinion SysMMU client should only
manage the virtual space and have the ability to add or remove a mapping for
particular range of pages/memory on particular sysmmu chip. 

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
