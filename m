From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 6 Jul 2018 09:42:28 +0900
Subject: [PATCH v2 3/4] efi/arm: map UEFI memory map earlier on boot
In-Reply-To: <CAKv+Gu-c0wcscUZzRqOTAHg-L70jFf80T=7x6pVPe7iK8-wykw@mail.gmail.com>
References: <20180619064424.6642-1-takahiro.akashi@linaro.org>
 <20180619064424.6642-4-takahiro.akashi@linaro.org>
 <20180704170655.GD8370@arm.com>
 <CAKv+Gu9_rYYyQ+t89otz46DR0D4GDj-cCjhx9q=p+D8LWFRkgQ@mail.gmail.com>
 <20180705094313.GL28220@linaro.org>
 <ec1a5f0f-99e3-fda1-9a64-5c2539817190@arm.com>
 <20180705164824.GA7445@arm.com>
 <CAKv+Gu-c0wcscUZzRqOTAHg-L70jFf80T=7x6pVPe7iK8-wykw@mail.gmail.com>
Message-ID: <20180706004226.GO28220@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2018 at 12:31:49AM +0200, Ard Biesheuvel wrote:
> On 5 July 2018 at 18:48, Will Deacon <will.deacon@arm.com> wrote:
> > On Thu, Jul 05, 2018 at 12:02:15PM +0100, James Morse wrote:
> >> On 05/07/18 10:43, AKASHI Takahiro wrote:
> >> > On Wed, Jul 04, 2018 at 08:49:32PM +0200, Ard Biesheuvel wrote:
> >> >> On 4 July 2018 at 19:06, Will Deacon <will.deacon@arm.com> wrote:
> >> >>> On Tue, Jun 19, 2018 at 03:44:23PM +0900, AKASHI Takahiro wrote:
> >> >>>> Since arm_enter_runtime_services() was modified to always create a virtual
> >> >>>> mapping of UEFI memory map in the previous patch, it is now renamed to
> >> >>>> efi_enter_virtual_mode() and called earlier before acpi_load_tables()
> >> >>>> in acpi_early_init().
> >> >>>>
> >> >>>> This will allow us to use UEFI memory map in acpi_os_ioremap() to create
> >> >>>> mappings of ACPI tables using memory attributes described in UEFI memory
> >> >>>> map.
> >>
> >> >>> Hmm, this is ugly as hell. Is there nothing else we can piggy-back off?
> >> >>> It's also fairly jarring that, on x86, efi_enter_virtual_mode() is called
> >> >>> a few lines later, *after* acpi_early_init() has been called.
> >>
> >> >> Currently, there is a gap where we have already torn down the early
> >> >> mapping and haven't created the definitive mapping of the UEFI memory
> >> >> map. There are other reasons why this is an issue, and I recently
> >> >> proposed [0] myself to address one of them
> >>
> >> >> Akashi-san, could you please confirm whether the patch below would be
> >> >> sufficient for you? Apologies for going back and forth on this, but I
> >> >> agree with Will that we should try to avoid warts like the one above
> >> >> in generic code.
> >> >>
> >> >> [0] https://marc.info/?l=linux-efi&m=152930773507524&w=2
> >> >
> >> > I think that this patch will also work.
> >> > Please drop my patch#2 and #3 if you want to pick up my patchset, Will.
> >>
> >> Patch 2 is what changes arm_enable_runtime_services() to map the efi memory map
> >> before bailing out due to efi=noruntime.
> >>
> >> Without it, 'efi=noruntime' means no-acpi-tables.
> >
> > So it sounds like we want patch 2. Akashi, given that this series is only
> > four patches, please can you send out a v3 with the stuff that should be
> > reviewed and merged? Otherwise, there's a real risk we end up with breakage
> > that goes unnoticed initially.
> >
> 
> Yes, we want patches #1, #2 and #4, and this one can be replaced with
> my patch above. Everything can be taken via the arm64 tree as far as I
> am concerned.

I almost believed that my patch#2 was just a preparatory one for patch#3
where arm_enable_runtime_services() is moved aggressively forward.
But acpi_os_ioremap() is not a __init function and I can now agree to
keeping patch#2.

Meanwhile, the consequent code with Ard's patch would look like:
---8<---
static int __init arm_enable_runtime_services(void)
{
        ...
        efi_memmap_unmap();

        mapsize = efi.memmap.desc_size * efi.memmap.nr_map;

        if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
                pr_err("Failed to remap EFI memory map\n");
                return 0;
        }
        ...
}
--->8---
It seems to me that it makes no sense.
Is it okay to take them out?

-Takahiro AKASHI
