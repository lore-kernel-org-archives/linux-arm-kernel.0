From: msalter@redhat.com (Mark Salter)
Date: Thu, 05 Feb 2015 08:54:07 -0500
Subject: [PATCH v8 02/21] acpi: fix acpi_os_ioremap for arm64
In-Reply-To: <20150205104149.GA18158@e104818-lin.cambridge.arm.com>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-3-git-send-email-hanjun.guo@linaro.org>
 <2422968.Es7R0p3loO@vostro.rjw.lan>
 <1422984576.18187.82.camel@deneb.redhat.com>
 <20150204112508.GB26006@e104818-lin.cambridge.arm.com>
 <1423066107.18187.99.camel@deneb.redhat.com>
 <20150204175734.GI26006@e104818-lin.cambridge.arm.com>
 <1423076294.18187.103.camel@deneb.redhat.com>
 <20150205104149.GA18158@e104818-lin.cambridge.arm.com>
Message-ID: <1423144447.18187.110.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-02-05 at 10:41 +0000, Catalin Marinas wrote:
> On Wed, Feb 04, 2015 at 06:58:14PM +0000, Mark Salter wrote:
> > On Wed, 2015-02-04 at 17:57 +0000, Catalin Marinas wrote:
> > > On Wed, Feb 04, 2015 at 04:08:27PM +0000, Mark Salter wrote:
> > > > acpi_os_remap() is used to map ACPI tables. These tables may be in ram
> > > > which are already included in the kernel's linear RAM mapping. So we
> > > > need ioremap_cache to avoid two mappings to the same physical page
> > > > having different caching attributes.
> > > 
> > > What's the call path to acpi_os_ioremap() on such tables already in the
> > > linear mapping? I can see an acpi_map() function which already takes
> > > care of the RAM mapping case but there are other cases where
> > > acpi_os_ioremap() is called directly. For example,
> > > acpi_os_read_memory(), can it be called on both RAM and I/O?
> > 
> > acpi_map() is the one I've seen.
> 
> By default, if should_use_kmap() is not patched for arm64, it translates
> to page_is_ram(); acpi_map() would simply use a kmap() which returns the
> current kernel linear mapping on arm64.

The problem with kmap() is that it only maps a single page. I've seen
tables over 4k which is why I patched acpi_map() not to use kmap() on
arm64.

> 
> > I'm not sure about others.
> 
> Question for the ARM ACPI guys: what happens if you implement
> acpi_os_ioremap() on arm64 as just ioremap()? Do you get any WARN_ON()
> (__ioremap_caller() checks whether the memory is RAM)?
> 
