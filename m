From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Sep 2011 18:37:31 +0100
Subject: Git pull request: mach/vmalloc.h removal, and ioremap
	optimizations
In-Reply-To: <4E8495D9.2030009@gmail.com>
References: <alpine.LFD.2.00.1109230908410.12663@xanadu.home>
	<4E8495D9.2030009@gmail.com>
Message-ID: <20110929173731.GB21718@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2011 at 10:59:21AM -0500, Rob Herring wrote:
> commit e0438e2f333005c217a2f65aacab23a39261c64c
> Author: Nicolas Pitre <nicolas.pitre@linaro.org>
> Date:   Thu Aug 25 00:35:59 2011 -0400
> 
>     ARM: move iotable mappings within the vmalloc region
> 
>     In order to remove the build time variation between different SOCs with
>     regards to VMALLOC_END, the iotable mappings are now allocated inside
>     the vmalloc region.  This allows for VMALLOC_END to be identical across
>     all machines.
> 
>     The value for VMALLOC_END is now set to 0xff000000 which is right where
>     the consistent DMA area starts.
> 
>     To accommodate all static mappings on machines with possible highmem
> usage,
>     the default vmalloc area size is changed to 240 MB so that VMALLOC_START
>     is no higher than 0xf0000000 by default in that case.
> 
>     Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> 
> It dies after "Data cache writeback" with BUG at vmalloc.c:1139.

My guess would be:

        }, {
                .virtual        =  IO_ADDRESS(VERSATILE_SCTL_BASE),
                .pfn            = __phys_to_pfn(VERSATILE_SCTL_BASE),
                .length         = SZ_4K * 9,
                .type           = MT_DEVICE
        },
#ifdef CONFIG_MACH_VERSATILE_AB
        {
                .virtual        =  IO_ADDRESS(VERSATILE_GPIO0_BASE),
                .pfn            = __phys_to_pfn(VERSATILE_GPIO0_BASE),
                .length         = SZ_4K,
                .type           = MT_DEVICE

#define VERSATILE_SCTL_BASE            0x101E0000	/* System controller */
#define VERSATILE_GPIO0_BASE           0x101E4000	/* GPIO port 0 */

I don't see why GPIO0 is explicitly listed here.
