From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Fri, 26 Feb 2016 15:01:56 +0000
Subject: [PATCH 2/2] arm*: efi: drop writable mapping of the UEFI System
 table
In-Reply-To: <1456496435-12679-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1456496435-12679-1-git-send-email-ard.biesheuvel@linaro.org>
 <1456496435-12679-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160226150156.GC7475@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Feb, at 03:20:35PM, Ard Biesheuvel wrote:
> Commit 2eec5dedf770 ("efi/arm-init: Use read-only early mappings")
> updated the early ARM UEFI init code to create the temporary, early
> mapping of the UEFI System table using read-only attributes, as a
> hardening measure against inadvertent modification.
> 
> However, this still leaves the permanent, writable mapping of the UEFI
> System table, which is only ever referenced during invocations of UEFI
> Runtime Services, at which time the UEFI virtual mapping is available,
> which also covers the system table. (This is guaranteed by the fact that
> SetVirtualAddressMap(), which is a runtime service itself, converts
> various entries in the table to their virtual equivalents, which implies
> that the table must be covered by a RuntimeServicesData region that has
> the EFI_MEMORY_RUNTIME attribute.)
> 
> So instead of creating this permanent mapping, record the virtual address
> of the system table inside the UEFI virtual mapping, and dereference that
> when accessing the table. This protects the contents of the system table
> from inadvertent (or deliberate) modification when no UEFI Runtime
> Services calls are in progress.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/firmware/efi/arm-init.c    |  2 ++
>  drivers/firmware/efi/arm-runtime.c | 27 ++++++++++++++++-----------
>  2 files changed, 18 insertions(+), 11 deletions(-)

Looks like a nice cleanup. Applied.
