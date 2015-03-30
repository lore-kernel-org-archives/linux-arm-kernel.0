From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 30 Mar 2015 14:58:10 +0100
Subject: [patch v11 13/23] ACPI / processor: Introduce phys_cpuid_t for
 CPU hardware ID
In-Reply-To: <55155DCA.3060006@linaro.org>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
 <1427205776-5060-14-git-send-email-hanjun.guo@linaro.org>
 <20150325172109.GJ14585@localhost> <551381CD.5010804@huawei.com>
 <55155DCA.3060006@linaro.org>
Message-ID: <20150330135810.GC5964@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 27, 2015 at 09:40:26PM +0800, Hanjun Guo wrote:
> On 2015?03?26? 11:49, Hanjun Guo wrote:
> >On 2015/3/26 1:21, Catalin Marinas wrote:
> >>On Tue, Mar 24, 2015 at 10:02:46PM +0800, Hanjun Guo wrote:
> >>>--- a/drivers/acpi/acpi_processor.c
> >>>+++ b/drivers/acpi/acpi_processor.c
> >>>@@ -170,7 +170,7 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
> >>>  	acpi_status status;
> >>>  	int ret;
> >>>
> >>>-	if (pr->phys_id == -1)
> >>>+	if (pr->phys_id == PHYS_CPUID_INVALID)
> >>>  		return -ENODEV;
> >>If PHYS_CPUID_INVALID is the same as INVALID_HWID, we should get rid of
> >>the latter in the arm64 code (as a subsequent clean-up patch).
> >
> >OK, I'm preparing a patch set to introduce invalid_phys_cpuid() and invalid_logical_cpuid()
> >to remove the direct comparison of PHYS_CPUID_INVALID and -1 in ACPI processor drivers,
> >which is suggested by Rafael, I will cleanup PHYS_CPUID_INVALID in this patch set.
> 
> I met difficulty to do so, because we use
> 
> +#ifndef PHYS_CPUID_INVALID
> +typedef u32 phys_cpuid_t;
> +#define PHYS_CPUID_INVALID (phys_cpuid_t)(-1)
> +#endif
> 
> in the common head file linux/acpi.h, we need macro
> PHYS_CPUID_INVALID to identify if phys_cpuid_t is typedefed
> for different arch, so if we want remove PHYS_CPUID_INVALID
> for ARM64, we need to got back to typedef phys_cpuid_t for
> each arch using ACPI. which means that

What I meant was removing INVALID_HWID from arm64 and always use the
PHYS_CPUID_INVALID but I think we should leave them as they are for now
since PHYS_CPUID_INVALID is defined in the asm/acpi.h file.

-- 
Catalin
