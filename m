From: msalter@redhat.com (Mark Salter)
Date: Mon, 18 May 2015 09:58:45 -0400
Subject: [PATCH] arm64: support ACPI tables outside of kernel RAM
In-Reply-To: <20150518111143.GC21251@e104818-lin.cambridge.arm.com>
References: <1431613373-10928-1-git-send-email-msalter@redhat.com>
 <20150518111143.GC21251@e104818-lin.cambridge.arm.com>
Message-ID: <1431957525.9933.4.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-05-18 at 12:11 +0100, Catalin Marinas wrote:
> On Thu, May 14, 2015 at 10:22:53AM -0400, Mark Salter wrote:
> > There is no guarantee that ACPI tables will be located in RAM linearly
> > mapped by the kernel. This could be because UEFI placed them below the
> > kernel image or because mem= places them beyond the reach of the linear
> > kernel mapping. Even though these tables are outside the linear mapped
> > RAM, they still need to be accessed as normal memory in order to support
> > unaligned accesses from ACPI code. In this case, the page_is_ram() test
> > in acpi_os_ioremap() is not sufficient.
> 
> And can we not simply add the rest of the RAM to the resource list as
> "System RAM" without being part of memblock?

If it is in "System RAM", then it needs a valid pfn and struct page.
Parts of the kernel expect that (page_is_ram(), memory hotplug, etc).

> 
> > Additionally, if the table spans multiple pages, it may fall partially
> > within the linear map and partially without. If the table overlaps the
> > end of the linear map, the test for whether or not to use the existing
> > mapping in ioremap_cache() could lead to a panic when ACPI code tries
> > to access the part beyond the end of the linear map. This patch
> > attempts to address these problems.
> 
> That's a problem with ioremap_cache() that should be fixed independently.

I can submit that separately if you prefer.

> 
> Ideally, I'd like to see the ACPI code use different APIs to distinguish
> between table access in RAM and device access, so that we don't have to
> guess whether the page is RAM or not.
> 

I don't think the ACPI code has enough info to make that decision, but
I'm not sure honestly.
