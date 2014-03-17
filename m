From: sebastian.capella@linaro.org (Sebastian Capella)
Date: Mon, 17 Mar 2014 15:07:51 -0700
Subject: [PATCH v7 2/2] ARM hibernation / suspend-to-disk
In-Reply-To: <20140316094650.GV21483@n2100.arm.linux.org.uk>
References: <1394016605-24120-1-git-send-email-sebastian.capella@linaro.org>
 <1394016605-24120-3-git-send-email-sebastian.capella@linaro.org>
 <20140307044251.GD9985@codeaurora.org>
 <CADHgK6s4K+K+OZuUZVbHKNzbFiHzm82Ss0WpSfkUdQgP+E3j=w@mail.gmail.com>
 <20140316094650.GV21483@n2100.arm.linux.org.uk>
Message-ID: <CADHgK6u7caDEZbt6Kj6VpzwADKytpk1068u_wQFFMvd3r1v1gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Russell!

On 16 March 2014 02:46, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Mon, Mar 10, 2014 at 11:32:17AM -0700, Sebastian Capella wrote:
...
> Let's look at the implementations...
>
> #define __pa(x)                 __virt_to_phys((unsigned long)(x))
> static inline phys_addr_t __virt_to_phys(unsigned long x)
> {
>         return (phys_addr_t)x - PAGE_OFFSET + PHYS_OFFSET;
> }
>
> So, __pa() returns a phys_addr_t (which may be either 32-bit or 64-bit).
>
> #define virt_to_pfn(kaddr)  (__pa(kaddr) >> PAGE_SHIFT)
>
> And that will do an appropriate shift to convert the phys_addr_t to a PFN,
> which will be fine to assign to an unsigned long variable.
>
> #define __phys_to_pfn(paddr)    ((unsigned long)((paddr) >> PAGE_SHIFT))
>
> This does the same thing, but has an explicit cast.
>
> So, the only difference between the two suggestions is that additional
> cast, which has no effect here.

Sounds good, thanks!

I was a little unsure about the page sizes that could affect all of
the implementations.

I'll make this change and repost, basically using virt_to_pfn in place
of the previous __pa_symbol, and remove unused declarations.

Thanks again!

Sebastian
