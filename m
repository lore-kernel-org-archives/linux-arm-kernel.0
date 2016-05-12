From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 12 May 2016 17:24:49 +0100
Subject: [PATCH v6 13/14] arm64, acpi, numa: NUMA support based on SRAT
 and SLIT
In-Reply-To: <5734A0CC.8010600@caviumnetworks.com>
References: <1461780436-27182-1-git-send-email-ddaney.cavm@gmail.com>
 <1461780436-27182-14-git-send-email-ddaney.cavm@gmail.com>
 <20160511103929.GC3051@e104818-lin.cambridge.arm.com>
 <5733C8F5.6090206@caviumnetworks.com>
 <20160512094915.GD11226@e104818-lin.cambridge.arm.com>
 <5734A0CC.8010600@caviumnetworks.com>
Message-ID: <20160512162449.GK11226@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 12, 2016 at 08:27:08AM -0700, David Daney wrote:
> On 05/12/2016 02:49 AM, Catalin Marinas wrote:
> >On Wed, May 11, 2016 at 05:06:13PM -0700, David Daney wrote:
> >>On 05/11/2016 03:39 AM, Catalin Marinas wrote:
> [...]
> >>>
> >>>I wonder whether you could replace the get_mpidr_in_madt() function with
> >>>something like acpi_get_phys_id(). It looks like get_mpidr_in_madt()
> >>>duplicates functionality already available elsewhere.
> >>
> >>I just tried that, and it doesn't work.
> >>
> >>The problem is that this code is being run very early in the boot, and
> >>kmalloc cannot be used.  acpi_get_phys_id() and its ilk can only be used
> >>once we have working kmalloc.  We need to extract the NUMA information early
> >>like this precisely because it is needed to initializing the slab system
> >>
> >>Notice that we are using early_acpi_os_unmap_memory() et al. in
> >>get_mpidr_in_madt() explicitly for this reason.
> >>
> >>In summary: I don't think we need another revision of this patch, it is like
> >>this for a good reason.
> >
> >Slightly confusing, in another reply you said you are going to address
> >my comment. So, is it doable?
> 
> I don't think so.
> 
> My previous reply, to the thread in 0/14, was prematurely made with the
> incorrect assumption that it was a simple change.  Now, after really digging
> in to the code, and attempting to do as you suggested, I have changed my
> mind.

Would the snippet below help with avoiding any kmalloc calls? At a quick
look, it seems that it's only map_mat_entry() that ends up using
kmalloc() calls. Alternatively, exporting map_madt_entry() may work as
well.

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 33a38d604630..77af0a7df914 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -152,6 +152,9 @@ static phys_cpuid_t map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
 	struct acpi_subtable_header *header;
 	phys_cpuid_t phys_id = PHYS_CPUID_INVALID;
 
+	if (!acpi_gbl_permanent_mmap)
+		return phys_id;
+
 	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_MAT", NULL, &buffer)))
 		goto exit;
 

-- 
Catalin
