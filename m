From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Tue, 15 Dec 2015 10:14:55 +0000
Subject: [Linaro-acpi] Touching the initrd before paging_init
In-Reply-To: <566F9C3D.4090306@redhat.com>
References: <566D3090.9090509@redhat.com>
 <20151213165942.GN25034@bivouac.eciton.net>
 <23071B8C-D1F9-47A6-9DB4-B26842150B76@redhat.com>
 <566DEB04.2030806@redhat.com> <566DEDFC.909@redhat.com>
 <566F9C3D.4090306@redhat.com>
Message-ID: <20151215101455.GX25034@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 11:51:09PM -0500, Jon Masters wrote:
> Addendum. I was able to get the initrd based ACPI table override
> working...HOWEVER...
> 
> *** I had to implement a custom memcpy routine to do so ***
> 
> Per some internal suggestions, I tried moving map_mem earlier (prior to
> doing boot time ACPI table parsing, in order to avoid needing to abuse
> fixmaps to touch the initrd contents), which works. For reading the
> ramdisk cpio content (the kernel code still uses a fixmap in the initrd
> override driver code to map the newly created tables in memory).
> 
> But the reading of that cpio content into the new table locations is
> done using the kernel memcpy routine to early_ioremap'd memory (Device
> memory), which is architecturally sensitive to missaligned accesses.

Why is it mapped as device memory?

If that is a legal thing, shouldn't drivers/acpi/osl.c be using
memcpy_fromio(), which (on ARM*) does the alignment fixups if
required, without going full-bytewise?

/
    Leif
