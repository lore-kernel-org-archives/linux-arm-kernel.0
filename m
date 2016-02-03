From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 3 Feb 2016 16:18:36 +0000
Subject: [PATCH v3] ARM64: kernel: implement ACPI parking protocol
In-Reply-To: <20160203112112.GA18387@red-moon>
References: <1453806638-23167-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20160202182657.GC15706@e104818-lin.cambridge.arm.com>
 <20160203112112.GA18387@red-moon>
Message-ID: <20160203161834.GB26487@MBP.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2016 at 11:21:12AM +0000, Lorenzo Pieralisi wrote:
> On Tue, Feb 02, 2016 at 06:26:58PM +0000, Catalin Marinas wrote:
> > On Tue, Jan 26, 2016 at 11:10:38AM +0000, Lorenzo Pieralisi wrote:
> > > The SBBR and ACPI specifications allow ACPI based systems that do not
> > > implement PSCI (eg systems with no EL3) to boot through the ACPI parking
> > > protocol specification[1].
> > > 
> > > This patch implements the ACPI parking protocol CPU operations, and adds
> > > code that eases parsing the parking protocol data structures to the
> > > ARM64 SMP initializion carried out at the same time as cpus enumeration.
> > > 
> > > To wake-up the CPUs from the parked state, this patch implements a
> > > wakeup IPI for ARM64 (ie arch_send_wakeup_ipi_mask()) that mirrors the
> > > ARM one, so that a specific IPI is sent for wake-up purpose in order
> > > to distinguish it from other IPI sources.
> > > 
> > > Given the current ACPI MADT parsing API, the patch implements a glue
> > > layer that helps passing MADT GICC data structure from SMP initialization
> > > code to the parking protocol implementation somewhat overriding the CPU
> > > operations interfaces. This to avoid creating a completely trasparent
> > > DT/ACPI CPU operations layer that would require creating opaque
> > > structure handling for CPUs data (DT represents CPU through DT nodes, ACPI
> > > through static MADT table entries), which seems overkill given that ACPI
> > > on ARM64 mandates only two booting protocols (PSCI and parking protocol),
> > > so there is no need for further protocol additions.
> > > 
> > > Based on the original work by Mark Salter <msalter@redhat.com>
> > > 
> > > [1] https://acpica.org/sites/acpica/files/MP%20Startup%20for%20ARM%20platforms.docx
> > > 
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Cc: Hanjun Guo <hanjun.guo@linaro.org>
> > > Cc: Loc Ho <lho@apm.com>
> > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Mark Salter <msalter@redhat.com>
> > > Cc: Al Stone <ahs3@redhat.com>
> > 
> > Applied, with a minor addition just to warn people from not using it in
> > other configurations (#ifdef still needed otherwise the
> > acpi_parking_protocol_valid symbol is not available; but I prefer uglier
> > code than people starting to use this IPI in their firmware):
> 
> It makes sense, we could include asm/acpi.h in smp.c (which is not
> included by linux/acpi.h if !CONFIG_ACPI) to pull in the symbol and
> remove the ifdef if you think it is cleaner.

I don't think it's worth.

BTW, the acpi_parking_protocol_valid() definition has an __init
annotation while the declaration does not. I removed the __init
altogether since I get a section mismatch warning when being called from
handle_IPI.

-- 
Catalin
