From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 16 Mar 2014 09:46:50 +0000
Subject: [PATCH v7 2/2] ARM hibernation / suspend-to-disk
In-Reply-To: <CADHgK6s4K+K+OZuUZVbHKNzbFiHzm82Ss0WpSfkUdQgP+E3j=w@mail.gmail.com>
References: <1394016605-24120-1-git-send-email-sebastian.capella@linaro.org>
 <1394016605-24120-3-git-send-email-sebastian.capella@linaro.org>
 <20140307044251.GD9985@codeaurora.org>
 <CADHgK6s4K+K+OZuUZVbHKNzbFiHzm82Ss0WpSfkUdQgP+E3j=w@mail.gmail.com>
Message-ID: <20140316094650.GV21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 10, 2014 at 11:32:17AM -0700, Sebastian Capella wrote:
> I've moved to this second implementation.  I don't think I understand
> the ramifications enough to add the virt_to_pfn call for arm.

Let's look at the implementations...

#define __pa(x)                 __virt_to_phys((unsigned long)(x))
static inline phys_addr_t __virt_to_phys(unsigned long x)
{
        return (phys_addr_t)x - PAGE_OFFSET + PHYS_OFFSET;
}

So, __pa() returns a phys_addr_t (which may be either 32-bit or 64-bit).

#define virt_to_pfn(kaddr)  (__pa(kaddr) >> PAGE_SHIFT)

And that will do an appropriate shift to convert the phys_addr_t to a PFN,
which will be fine to assign to an unsigned long variable.

#define __phys_to_pfn(paddr)    ((unsigned long)((paddr) >> PAGE_SHIFT))

This does the same thing, but has an explicit cast.

So, the only difference between the two suggestions is that additional
cast, which has no effect here.

> I've changed one thing.  __nosave_end is pointing at the first byte
> not included in the nosave region.  I subtracted one from it so that
> we make sure we're referring to the last pfn, and left the pfn
> comparison as you'd suggested.

Yes, that should be safer.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
