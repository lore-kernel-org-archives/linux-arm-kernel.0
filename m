From: ian.campbell@citrix.com (Ian Campbell)
Date: Mon, 7 Dec 2015 10:38:30 +0000
Subject: [Xen-devel] [PATCH v3 07/62] arm/acpi: Add
 arch_acpi_os_map_memory helper function for ARM
In-Reply-To: <56656E5802000078000BC8C7@prv-mh.provo.novell.com>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-8-git-send-email-shannon.zhao@linaro.org>
 <alpine.DEB.2.02.1511231137000.1107@kaball.uk.xensource.com>
 <565C6198.3070805@citrix.com> <56654A36.6070708@huawei.com>
 <56656E5802000078000BC8C7@prv-mh.provo.novell.com>
Message-ID: <1449484710.29724.45.camel@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-12-07 at 03:32 -0700, Jan Beulich wrote:
> > > > On 07.12.15 at 09:58, <zhaoshenglong@huawei.com> wrote:
> > On 2015/11/30 22:47, Julien Grall wrote:
> > > On 23/11/15 11:37, Stefano Stabellini wrote:
> > > > > On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> > > > > > > From: Shannon Zhao <shannon.zhao@linaro.org>
> > > > > could you please add a couple of lines to the commit message
> > > > > mentioning
> > > > > why __va(phys) is an acceptable implementation of
> > > > > arch_acpi_os_map_memory?
> > > FWIW, I already asked this question multiple time on the previous
> > > series
> > > without clear answer.
> > > 
> > > __va should only be used when the memory is direct-mapped to Xen (i.e
> > > accessible directly). On ARM64, this is only the case for the RAM.
> > > Can
> > > someone confirm the ACPI will always reside to the RAM?
> > I checked this with the UEFI SPEC. It says in 2.3.6 AArch64 Platforms:
> > "If ACPI is supported :
> > ? ACPI Tables loaded at boot time can be contained in memory of type
> > EfiACPIReclaimMemory (recommended) or EfiACPIMemoryNVS."
> > 
> > So I think it means the ACPI tables will always reside in RAM.
> 
> I think NVS doesn't necessarily mean RAM.

That's what I thought/expected too (sounds like it could be flash, CMOS,
ROM etc), but looking at the ACPI 6.0 spec ("16.3.2 BIOS Initialization of
Memory") it says:

    Memory identified by the BIOS as being?    reserved by the BIOS for its use.
    OSPM is required to tag this memory as cacheable, and to save     and
    restore its image before entering an S4 state.

IOW, if I'm reading that correctly, it actually is "memory", and it is only
"NV" by virtue of requiring the OSPM to save/restore it over suspend (so
not at all "NV" in the usual sense).

Ian.
