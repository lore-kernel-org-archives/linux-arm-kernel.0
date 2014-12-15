From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Mon, 15 Dec 2014 10:16:28 -0800
Subject: [RFC PATCH v2 4/4] arm64:numa: adding numa support for arm64
 platforms.
In-Reply-To: <54883be3.8284440a.3154.ffffa34fSMTPIN_ADDED_BROKEN@mx.google.com>
References: <1416605010-10442-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <1416605010-10442-5-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <5482ce36.c9e2420a.5d40.71c7SMTPIN_ADDED_BROKEN@mx.google.com>
 <CAFpQJXU89uwAkHyi+dvHmbZOvadO_EyQbrG8jMo5G3tnWP5qcw@mail.gmail.com>
 <54883be3.8284440a.3154.ffffa34fSMTPIN_ADDED_BROKEN@mx.google.com>
Message-ID: <CAFpQJXU858fnJ-oWda=mTkVv1e+3goTxvZ8sfvty==2msFus_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roy/Leif

On Wed, Dec 10, 2014 at 4:26 AM, Ashok Kumar <ashoks@broadcom.com> wrote:
> On Sat, Dec 06, 2014 at 10:50:57AM -0800, Ganapatrao Kulkarni wrote:
>> On Sat, Dec 6, 2014 at 1:36 AM, Ashok Kumar <ashoks@broadcom.com> wrote:
>> > On Sat, Nov 22, 2014 at 02:53:30AM +0530, Ganapatrao Kulkarni wrote:
>> >> Adding numa support for arm64 based platforms.
>> >> creating numa mapping by parsing the dt node numa-map.
>> >>
>> >> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@caviumnetworks.com>
>> > Ganapat,
>> >
>> > Can we get a simple version of this patchset with just the associativity parameter for the cpu and memory nodes
>> > upstream? The initial patchset can be with the assumption of a simple full mesh topology for the distance.  The
>> > hierarchical complex topologies and the DT nodes and properties for that can be added in a later patch, once the
>> > standard for that is agreed upon.
>> > We are planning to support ACPI based NUMA for Broadcom Vulcan processors(http://www.broadcom.com/press/release.php?id=s797235).
>> > I am working on a patch to add support for the SRAT and SLIT ACPI tables based on your patch and I will post that
>> > patchset soon, so it will be helpful if the core changes are upstream.
>> >
>> to implement, ibm/ppc like implementation, we need efi-stub patch to
>> not remove the memory node from the dt.
>> current efi-stub parses dt file and removes memory nodes.
>> can i get the efi-stub patch to start with please?
>
> Ganapat,
>  I tried the below patch in qemu and it works. Would this be of help to you?
>
> Roy/Ard,
>  Is the below patch fine?
>
> From 27b4aecf09707e3d5bd4ff7bf765cd609772476f Mon Sep 17 00:00:00 2001
> From: Ashok Kumar <ashoks@broadcom.com>
> Date: Tue, 9 Dec 2014 17:23:11 +0530
> Subject: [PATCH] efi/arm64: Remove deleting memory nodes in efi-stub
>
> Dont delete memory nodes from DT as it will be
> used by NUMA configuration.
>
> Signed-off-by: Ashok Kumar <ashoks@broadcom.com>
> ---
>  arch/arm64/kernel/setup.c          | 12 +++++++++++-
>  drivers/firmware/efi/libstub/fdt.c | 24 +-----------------------
>  2 files changed, 12 insertions(+), 24 deletions(-)
>
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 27f65b0..ac6d34f 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -302,7 +302,7 @@ static void __init setup_processor(void)
>
>  static void __init setup_machine_fdt(phys_addr_t dt_phys)
>  {
> -       if (!dt_phys || !early_init_dt_scan(phys_to_virt(dt_phys))) {
> +       if (!dt_phys || !early_init_dt_verify(phys_to_virt(dt_phys))) {
>                 early_print("\n"
>                         "Error: invalid device tree blob at physical address 0x%p (virtual address 0x%p)\n"
>                         "The dtb must be 8-byte aligned and passed in the first 512MB of memory\n"
> @@ -313,6 +313,16 @@ static void __init setup_machine_fdt(phys_addr_t dt_phys)
>                         cpu_relax();
>         }
>
> +       /* Retrieve various information from the /chosen node */
> +       of_scan_flat_dt(early_init_dt_scan_chosen, boot_command_line);
> +
> +       /* Initialize {size,address}-cells info */
> +       of_scan_flat_dt(early_init_dt_scan_root, NULL);
> +
> +       /* Setup memory, calling early_init_dt_add_memory_arch */
> +       if (!IS_ENABLED(CONFIG_EFI))
> +               of_scan_flat_dt(early_init_dt_scan_memory, NULL);
> +
>         machine_name = of_flat_dt_get_machine_name();
>  }
>
> diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
> index c846a96..a02e56e 100644
> --- a/drivers/firmware/efi/libstub/fdt.c
> +++ b/drivers/firmware/efi/libstub/fdt.c
> @@ -22,7 +22,7 @@ efi_status_t update_fdt(efi_system_table_t *sys_table, void *orig_fdt,
>                         unsigned long map_size, unsigned long desc_size,
>                         u32 desc_ver)
>  {
> -       int node, prev, num_rsv;
> +       int node, num_rsv;
>         int status;
>         u32 fdt_val32;
>         u64 fdt_val64;
> @@ -52,28 +52,6 @@ efi_status_t update_fdt(efi_system_table_t *sys_table, void *orig_fdt,
>                 goto fdt_set_fail;
>
>         /*
> -        * Delete any memory nodes present. We must delete nodes which
> -        * early_init_dt_scan_memory may try to use.
> -        */
> -       prev = 0;
> -       for (;;) {
> -               const char *type;
> -               int len;
> -
> -               node = fdt_next_node(fdt, prev, NULL);
> -               if (node < 0)
> -                       break;
> -
> -               type = fdt_getprop(fdt, node, "device_type", &len);
> -               if (type && strncmp(type, "memory", len) == 0) {
> -                       fdt_del_node(fdt, node);
> -                       continue;
> -               }
> -
> -               prev = node;
> -       }
> -
> -       /*
>          * Delete all memory reserve map entries. When booting via UEFI,
>          * kernel will use the UEFI memory map to find reserved regions.
>          */
> --
> 1.9.1
>
>
what will happen, If we keep memory node in the DT and boot with UEFI,
will both efi-stub and dt try to add memblocks?
is kernel ignores second request to add memblock to the same address?


> Thanks,
> Ashok

thanks
Ganapat
