From: rafael@kernel.org (Rafael J. Wysocki)
Date: Fri, 24 Nov 2017 15:39:23 +0100
Subject: [PATCH v2 2/5] mm: memory_hotplug: Remove assumption on memory
 state before hotremove
In-Reply-To: <4e21a27570f665793debf167c8567c6752116d0a.1511433386.git.ar@linux.vnet.ibm.com>
References: <cover.1511433386.git.ar@linux.vnet.ibm.com>
 <4e21a27570f665793debf167c8567c6752116d0a.1511433386.git.ar@linux.vnet.ibm.com>
Message-ID: <CAJZ5v0i7vOxwhgA1LWYDqxCKkHaYikCf_HZZQCbgApLpoyV2JA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 24, 2017 at 11:22 AM, Andrea Reale <ar@linux.vnet.ibm.com> wrote:
> Resending the patch adding linux-acpi in CC, as suggested by Rafael.
> Everyone else: apologies for the noise.
>
> Commit 242831eb15a0 ("Memory hotplug / ACPI: Simplify memory removal")
> introduced an assumption whereas when control
> reaches remove_memory the corresponding memory has been already
> offlined. In that case, the acpi_memhotplug was making sure that
> the assumption held.
> This assumption, however, is not necessarily true if offlining
> and removal are not done by the same "controller" (for example,
> when first offlining via sysfs).
>
> Removing this assumption for the generic remove_memory code
> and moving it in the specific acpi_memhotplug code. This is
> a dependency for the software-aided arm64 offlining and removal
> process.
>
> Signed-off-by: Andrea Reale <ar@linux.vnet.ibm.com>
> Signed-off-by: Maciej Bielski <m.bielski@linux.vnet.ibm.com>
> ---
>  drivers/acpi/acpi_memhotplug.c |  2 +-
>  include/linux/memory_hotplug.h |  9 ++++++---
>  mm/memory_hotplug.c            | 13 +++++++++----
>  3 files changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> index 6b0d3ef..b0126a0 100644
> --- a/drivers/acpi/acpi_memhotplug.c
> +++ b/drivers/acpi/acpi_memhotplug.c
> @@ -282,7 +282,7 @@ static void acpi_memory_remove_memory(struct acpi_memory_device *mem_device)
>                         nid = memory_add_physaddr_to_nid(info->start_addr);
>
>                 acpi_unbind_memory_blocks(info);
> -               remove_memory(nid, info->start_addr, info->length);
> +               BUG_ON(remove_memory(nid, info->start_addr, info->length));

Why does this have to be BUG_ON()?  Is it really necessary to kill the
system here?

If it is, please add a comment describing why continuing is not an option here.

>                 list_del(&info->list);
>                 kfree(info);
>         }

Thanks,
Rafael
