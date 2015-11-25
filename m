From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed, 25 Nov 2015 16:58:52 -0600
Subject: [PATCH] arm64: mm: Prevent the initial page table setup from
 creating larger blocks
In-Reply-To: <1448387338-27851-1-git-send-email-catalin.marinas@arm.com>
References: <1448387338-27851-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <56563D2C.7050807@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/24/2015 11:48 AM, Catalin Marinas wrote:
> This patch prevents the larger block mappings at all levels _if_ the
> existing pud/pmd entry is present _and_ not already a block mapping.
> Contiguous ptes are rejected if any of the entries in the range are
> non-empty and non-contiguous.
>
> In addition, TLB flushing is added for the cases where an existing block
> entry is changed.

Ok, it seems to boot fairly reliably on the m400/ACPI, over a few dozen 
reboots yesterday and today. So, for that:

Tested-by: Jeremy Linton <jeremy.linton@arm.com>

That said, it basically disables the CONT ranges for the main kernel 
text section.

With this patch:

0xfffffe0000000000-0xfffffe0000090000 (paddr=0x4000000000)        576K 
    RW NX SHD AF            UXN MEM/NORMAL
0xfffffe0000090000-0xfffffe0000c50000 (paddr=0x4000090000)      12032K 
    ro x  SHD AF            UXN MEM/NORMAL
0xfffffe0000c50000-0xfffffe0001600000 (paddr=0x4000c50000)       9920K 
    RW NX SHD AF            UXN MEM/NORMAL
0xfffffe0001600000-0xfffffe0020000000 (paddr=0x4001600000)        490M 
    RW NX SHD AF    CON     UXN MEM/NORMAL
0xfffffe0020000000-0xfffffe1000000000 (paddr=0x4020000000)      65024M 
    RW NX SHD AF        BLK UXN MEM/NORMAL

without:

0xfffffe0000000000-0xfffffe0000090000 (paddr=0x4000000000)        576K 
    RW NX SHD AF            UXN MEM/NORMAL
0xfffffe0000090000-0xfffffe0000200000 (paddr=0x4000090000)       1472K 
    ro x  SHD AF            UXN MEM/NORMAL
0xfffffe0000200000-0xfffffe0000c00000 (paddr=0x4000200000)         10M 
    ro x  SHD AF    CON     UXN MEM/NORMAL
0xfffffe0000c00000-0xfffffe0000c50000 (paddr=0x4000c00000)        320K 
    ro x  SHD AF            UXN MEM/NORMAL
0xfffffe0000c50000-0xfffffe0000e00000 (paddr=0x4000c50000)       1728K 
    RW NX SHD AF            UXN MEM/NORMAL
0xfffffe0000e00000-0xfffffe0020000000 (paddr=0x4000e00000)        498M 
    RW NX SHD AF    CON     UXN MEM/NORMAL
0xfffffe0020000000-0xfffffe1000000000 (paddr=0x4020000000)      65024M 
    RW NX SHD AF        BLK UXN MEM/NORMAL
