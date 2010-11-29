From: paulius.zaleckas@gmail.com (Paulius Zaleckas)
Date: Mon, 29 Nov 2010 21:57:23 +0200
Subject: [PATCH] ARM: Gemini: Add support for PCI BUS
In-Reply-To: <20101129193246.GB20761@n2100.arm.linux.org.uk>
References: <1290860675-15453-1-git-send-email-ulli.kroll@googlemail.com>
	<201011282056.17389.arnd@arndb.de> <4CF3CF33.20407@gmail.com>
	<20101129193246.GB20761@n2100.arm.linux.org.uk>
Message-ID: <4CF405A3.9030205@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/2010 09:32 PM, Russell King - ARM Linux wrote:
> On Mon, Nov 29, 2010 at 06:05:07PM +0200, Paulius Zaleckas wrote:
>> No he really should NOT use readl/writel. The ONLY difference
>> between readl/writel and __raw_readl/__raw_writel is endianess
>> conversion. __raw_*l is not doing it. Which to use depend only
>> on HW.
>
> Wrong.  readl/writel have barriers too to guarantee ordering between
> device accesses and memory accesses.  (device accesses are already
> ordered with respect to themselves.)  __raw variants do not
> guarantee the relative ordering between memory accesses and device
> accesses.

#ifdef CONFIG_ARM_DMA_MEM_BUFFERABLE
#define __iormb()		rmb()
#define __iowmb()		wmb()
#else
#define __iormb()		do { } while (0)
#define __iowmb()		do { } while (0)
#endif

CONFIG_ARM_DMA_MEM_BUFFERABLE is NOT defined in this case.
I don't see any other barriers.
readl does endianess conversion. What to do if you don't need it?
Do it one more time?
