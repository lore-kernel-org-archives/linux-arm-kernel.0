From: al.stone@linaro.org (Al Stone)
Date: Mon, 06 Jan 2014 16:14:26 -0700
Subject: [PATCH v4 3/5] ACPI: HW reduced mode does not allow use of the
 FADT sci_interrupt field
In-Reply-To: <20131227045630.GA21429@srcf.ucam.org>
References: <1387239401-13918-1-git-send-email-al.stone@linaro.org>
 <1387239401-13918-4-git-send-email-al.stone@linaro.org>
 <20131227045630.GA21429@srcf.ucam.org>
Message-ID: <52CB38D2.30307@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/26/2013 09:56 PM, Matthew Garrett wrote:
> On Mon, Dec 16, 2013 at 05:16:39PM -0700, al.stone at linaro.org wrote:
>
>> +	if (!acpi_gbl_reduced_hardware) {
>
> I don't really understand this. You've explained that runtime hardware
> reduced mode switching isn't expected to work, but you're making this
> conditional on a runtime flag?
>

Correct.  My apologies if I've made this unclear.

Suppose I build a kernel with full ACPI support.  The kernel would
then include legacy and hardware-reduced support.  If I pass that
kernel ACPI tables specifying legacy mode, things work fine.  If I
pass that same kernel ACPI tables with the hardware-reduced flag
set in the FADT, that should also work -- iff the ACPI driver checks
the acpi_gbl_reduced_hardware flag at run-time.  This patch is adding
some of those checks that were missing so that at least the files in
drivers/acpi/*.[ch] are correct; I contend that there are still places
in the drivers/acpi/acpica/*.[ch] files where a Linux driver can call
code it should not be allowed to when in hardware-reduced (e.g., when
using the ACPI global lock [0]).  Patching the ACPICA code I'm viewing
as a separate issue yet to be done.

If I build a kernel with only hardware-reduced ACPI support, using
ACPI tables without the hardware-reduced flag set in the FADT will
clearly not work -- nor do I expect it to in this case since most of
the legacy code gets removed at compile time.  If the ACPI tables do
have hardware-reduced mode set in the FADT, I expect the kernel to
behave correctly.  It may turn out to be exactly the same patch for
ACPICA as mentioned above, but I contend that ACPICA does not
completely handle this case properly at runtime, either.

Does that make sense?



[0] No driver should be doing this but it cannot currently be precluded
     by the kernel.  You can call me paranoid but I think if it can be
     abused by a driver, it will be.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone at linaro.org
-----------------------------------
