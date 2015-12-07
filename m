From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 7 Dec 2015 06:05:47 +0000
Subject: Touching the initrd before paging_init
In-Reply-To: <566D3090.9090509@redhat.com>
References: <566D3090.9090509@redhat.com>
Message-ID: <20151207060546.GA27677@svinekod>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Dec 13, 2015 at 03:47:12AM -0500, Jon Masters wrote:
> Hi Folks,
> 
> Just a few notes that might be useful to someone else.
> 
> I mentioned before that we'll want to see ACPI_INITRD_TABLE_OVERRIDE
> support on arm64 in due course for use during bringup of new systems. It
> is commonly used on x86 to provide handy updated ACPI tables via a
> prepended initrd cpio that is attached to the regular initrd image,
> which is infinitely better than respinning firmware each time you want
> to provide updated tables (yes yes, we all know the "devicetree"
> directive in GRUB does this with DT and that's great and wonderful). I
> know that someone is working on it, but I had a need for an interim
> solution over the weekend for some hardware I am bringing up here.

Which table(s) are you trying to override?

It might be possible to have an EFI application prior to the kernel which
override the relevant table, or you may be able to override the tables in the
EFI stub. From the PoV of Linux proper, things would then be the same as a
normal boot -- nothing special to be done.

If you're able to do this in a separate application prior to the stub (or even
prior to the main bootloader), that same override should work for any OS.

> The problem is that there's no mapping for the pages containing the
> ramdisk data prior to paging_init.Can we not move paging_init earlier?

Why can't we move paging_init earlier? Which information do we need prior to
paging_init?

The only thing I can think of are the SLIT and SRAT. Are you trying to override
those?

> x86 does a bit of hoop jumping (and I think they have certain assumptions
> about linear mapping too) and splits the initrd setup into a couple of
> different phases, which we may well need to do also if we want to be able to
> call something like:
>
> #if defined(CONFIG_ACPI) && defined(CONFIG_BLK_DEV_INITRD)
>         acpi_initrd_override((void *)initrd_start, initrd_end -
> initrd_start);
> #endif
> 
> prior to acpi_boot_table_init in arch/arm64/kernel/setup.c. That routine
> will correctly map memory for data it copies out of the cpio, but it
> assumes that the initrd is already mapped. For the very nasty hack I
> want over the weekend, I added some extra fixmaps and then do an
> early_memremap on the physical address of first page of the initrd (the
> cpio is tiny, and is always prepended and this is very nasty). Viz:
> 
> [    0.000000] JCM: using fixmap for first page of ramdisk...
> [    0.000000] JCM: first physical page of ramdisk: [mem REDACTED]
> [    0.000000] JCM: first virtual page of ramdisk: [mem REDACTED]
> [    0.000000] XXXX ACPI table found in initrd
> [kernel/firmware/acpi/xxxx.aml][0xxxx]
> [    0.000000] XXXX ACPI table found in initrd
> [kernel/firmware/acpi/xxxx.aml][0xxx]
> [    0.000000] XXXX ACPI table found in initrd
> [kernel/firmware/acpi/xxxx.aml][0xxxx]
> 
> So maybe I'll get what I want working, but a head's up to whoever from
> Linaro ends up looking into the broader implementation that I think
> you'll need to rework initrd mapping as part of that. Unless of course
> I'm missing something. Which is more than possible.

If we really need to map the initrd this early, one option would be to make it
possible to perform arbitrarily large memremaps early on, following the
approach I posted for the linear mapping [1]. That would require some more
invasive rework, but we'd be able to reuse the logic for other things we want
to map early on.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/392292.html
