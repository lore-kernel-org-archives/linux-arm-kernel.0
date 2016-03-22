From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 22 Mar 2016 16:08:24 +0100
Subject: [PATCH 2/2] arm*: efi: drop writable mapping of the UEFI System
 table
In-Reply-To: <20160226150156.GC7475@codeblueprint.co.uk>
References: <1456496435-12679-1-git-send-email-ard.biesheuvel@linaro.org>
 <1456496435-12679-2-git-send-email-ard.biesheuvel@linaro.org>
 <20160226150156.GC7475@codeblueprint.co.uk>
Message-ID: <CAKv+Gu8+pYR_jxjcVeXgekVqD_BugtRLgNNhOkvhuaEpddbHRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 February 2016 at 16:01, Matt Fleming <matt@codeblueprint.co.uk> wrote:
> On Fri, 26 Feb, at 03:20:35PM, Ard Biesheuvel wrote:
>> Commit 2eec5dedf770 ("efi/arm-init: Use read-only early mappings")
>> updated the early ARM UEFI init code to create the temporary, early
>> mapping of the UEFI System table using read-only attributes, as a
>> hardening measure against inadvertent modification.
>>
>> However, this still leaves the permanent, writable mapping of the UEFI
>> System table, which is only ever referenced during invocations of UEFI
>> Runtime Services, at which time the UEFI virtual mapping is available,
>> which also covers the system table. (This is guaranteed by the fact that
>> SetVirtualAddressMap(), which is a runtime service itself, converts
>> various entries in the table to their virtual equivalents, which implies
>> that the table must be covered by a RuntimeServicesData region that has
>> the EFI_MEMORY_RUNTIME attribute.)
>>
>> So instead of creating this permanent mapping, record the virtual address
>> of the system table inside the UEFI virtual mapping, and dereference that
>> when accessing the table. This protects the contents of the system table
>> from inadvertent (or deliberate) modification when no UEFI Runtime
>> Services calls are in progress.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  drivers/firmware/efi/arm-init.c    |  2 ++
>>  drivers/firmware/efi/arm-runtime.c | 27 ++++++++++++++++-----------
>>  2 files changed, 18 insertions(+), 11 deletions(-)
>
> Looks like a nice cleanup. Applied.

This patch causes a warning I hadn't spotted before sending it out.
Could you fold this in please?

diff --git a/drivers/firmware/efi/arm-runtime.c
b/drivers/firmware/efi/arm-runtime.c
index 6c97d4884fc7..fe749da9997e 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -72,8 +72,8 @@ static bool __init efi_virtmap_init(void)
                 */
                if (efi_system_table >= phys &&
                    efi_system_table < phys + (md->num_pages * EFI_PAGE_SIZE)) {
-                       efi.systab = (void *)(efi_system_table - phys +
-                                             md->virt_addr);
+                       efi.systab = (void *)(unsigned long)(efi_system_table -
+                                                         phys + md->virt_addr);
                        systab_found = true;
                }
        }

Thanks,
Ard.
