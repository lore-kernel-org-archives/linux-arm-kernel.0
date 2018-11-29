From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Nov 2018 10:22:59 +0000
Subject: [PATCH v2] ARM: dma-mapping: fix potential uninitialized return
In-Reply-To: <7b054176-aaef-cbdd-b2df-82eda94180e8@arm.com>
References: <20181128173929.3050-1-nathanj439@gmail.com>
 <20181128185910.5778-1-nathanj439@gmail.com>
 <401b58b2-fb17-dc83-f898-c10cafdc5413@arm.com>
 <7b054176-aaef-cbdd-b2df-82eda94180e8@arm.com>
Message-ID: <20181129102259.GR30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 29, 2018 at 10:11:45AM +0000, Vladimir Murzin wrote:
> On 11/29/18 9:50 AM, Vladimir Murzin wrote:
> > On 11/28/18 6:59 PM, Nathan Jones wrote:
> >> If neither of the if() statements fire then the return value is
> >> uninitialized. In the worst case it returns 0 which means the caller
> >> will think the function succeeded.
> > 
> > "ret" is updated indirectly via:
> > 
> >         if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
> >                 return ret;
> 
> Ok. I've had a look how dma_mmap_from_dev_coherent() is implemented and it
> looks like "ret" is not updated if dev doesn't have reserved memory.
> It looks like arm64 also might be affected by this as well.
> 
> So, would it be better to update dma_mmap_from_dev_coherent() with

I don't think so - if we were to remove the call to
dma_mmap_from_dev_coherent(), it reintroduces the bug.

Quite why we have dma_mmap_from_dev_coherent() returning a 0/1 and
error code via pointer I'm really not sure.

	ret = dma_mmap_from_dev_coherent(...);
	if (ret)
		return ret > 0 ? 0 : ret;

and have dma_mmap_from_dev_coherent() return -ve for errnos, 1 if
mapped via the coherent pool mechanism, or 0 otherwise.

The down-side is that 'ret' would be zero for the follow-on code,
which would need explicit initialisation - but at least it's then
obvious what is going on.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
