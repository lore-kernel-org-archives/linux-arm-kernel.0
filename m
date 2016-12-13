From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 13 Dec 2016 14:07:11 +0000
Subject: [RFC v2 PATCH 0/3] Fix dma_alloc_coherent() and friends for NOMMU
In-Reply-To: <1481636704-18948-1-git-send-email-vladimir.murzin@arm.com>
References: <1481636704-18948-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20161213140711.GY14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2016 at 01:45:01PM +0000, Vladimir Murzin wrote:
> This patch set is trying to address the issue by providing region of
> memory suitable for consistent DMA operations. It is supposed that such
> region is marked by MPU as non-cacheable. Since we have MPU support in
> Linux for R-class only and M-class setting MPU in bootloader, proposed
> interface to advertise such memory is via "memdma=size at start" command
> line option, to avoid clashing with normal memory (which usually comes
> from dts) it'd be safer to use it together with "mem=" command line
> option. Meanwhile, I'm open to suggestions for the better way telling
> Linux of such memory.

For those nommu systems where the MPU is not used, how do they allocate
DMA memory without setting aside a chunk of memory?

>From what I understand of the current nommu code, it would just use
the normal page allocator for DMA memory allocation, so now requiring
everything to fit the "nommu has mpu" case seems like it's going to
break older nommu.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
