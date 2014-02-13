From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Feb 2014 17:11:17 +0000
Subject: [PATCH] Fix uses of dma_max_pfn() when converting to a
 limiting address
In-Reply-To: <1392310690.2175.13.camel@dabdike.int.hansenpartnership.com>
References: <E1WDH7v-00038J-2k@rmk-PC.arm.linux.org.uk>
 <1392310690.2175.13.camel@dabdike.int.hansenpartnership.com>
Message-ID: <20140213171117.GA30257@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 13, 2014 at 08:58:10AM -0800, James Bottomley wrote:
> This doesn't really look like the right fix.  You replaced dev->dma_mask
> with a calculation on dev_max_pfn().  Since dev->dma_mask is always u64
> and dev_max_pfn is supposed to be returning the pfn of the dma_mask, it
> should unconditionally be 64 bits as well.  Either that or it should
> return dma_addr_t.

My reasoning is that PFNs in the system are always of type "unsigned long"
and therefore a function returning a pfn should have that type.  If we
overflow a PFN fitting in an unsigned long, we have lots of places which
need fixing.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
