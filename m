From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Mar 2014 23:31:35 +0000
Subject: [PATCH v6 1/3] Fix ioport_map() for !CONFIG_GENERIC_IOMAP cases.
In-Reply-To: <1394020150-1875-2-git-send-email-Liviu.Dudau@arm.com>
References: <1394020150-1875-1-git-send-email-Liviu.Dudau@arm.com>
 <1394020150-1875-2-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <20140305233135.GZ21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 05, 2014 at 11:49:08AM +0000, Liviu Dudau wrote:
> The inline version of ioport_map() that gets used when !CONFIG_GENERIC_IOMAP
> is wrong. It returns a mapped (i.e. virtual) address that can start from
> zero and completely ignores the PCI_IOBASE and IO_SPACE_LIMIT that most
> architectures that use !CONFIG_GENERIC_MAP define.

What value does PCI_IOBASE and IO_SPACE_LIMIT have on other architectures
who make use of asm-generic/io.h ?

$ git grep asm-generic/io.h arch/
arch/arc/include/asm/io.h:#include <asm-generic/io.h>
arch/blackfin/include/asm/io.h:#include <asm-generic/io.h>
arch/metag/include/asm/io.h:#include <asm-generic/io.h>
arch/microblaze/include/asm/io.h:/* from asm-generic/io.h */
arch/openrisc/include/asm/io.h:#include <asm-generic/io.h>
arch/s390/include/asm/io.h:#include <asm-generic/io.h>
arch/score/include/asm/io.h:#include <asm-generic/io.h>
arch/unicore32/include/asm/io.h:#include <asm-generic/io.h>
arch/xtensa/include/asm/io.h:#include <asm-generic/io.h>
$ arch/arc/include/asm/io.h:#define PCI_IOBASE ((void __iomem *)0)
arch/arm64/include/asm/io.h:#define PCI_IOBASE          ((void __iomem *)(MODULES_VADDR - SZ_2M))
arch/arm64/include/asm/io.h:    return readb(addr + PCI_IOBASE);
arch/arm64/include/asm/io.h:    return readw(addr + PCI_IOBASE);
arch/arm64/include/asm/io.h:    return readl(addr + PCI_IOBASE);
arch/arm64/include/asm/io.h:    writeb(b, addr + PCI_IOBASE);
arch/arm64/include/asm/io.h:    writew(b, addr + PCI_IOBASE);
arch/arm64/include/asm/io.h:    writel(b, addr + PCI_IOBASE);
arch/arm64/include/asm/io.h:            *buf++ = __raw_readb(addr + PCI_IOBASE);arch/arm64/include/asm/io.h:            *buf++ = __raw_readw(addr + PCI_IOBASE);arch/arm64/include/asm/io.h:            *buf++ = __raw_readl(addr + PCI_IOBASE);arch/arm64/include/asm/io.h:            __raw_writeb(*buf++, addr + PCI_IOBASE);arch/arm64/include/asm/io.h:            __raw_writew(*buf++, addr + PCI_IOBASE);arch/arm64/include/asm/io.h:            __raw_writel(*buf++, addr + PCI_IOBASE);arch/unicore32/include/asm/io.h:#define PCI_IOBASE      PKUNITY_PCILIO_BASE
arch/unicore32/include/asm/io.h:#define PIO_OFFSET              (unsigned int)(PCI_IOBASE)


-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
