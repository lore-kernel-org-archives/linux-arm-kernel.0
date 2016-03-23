From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 23 Mar 2016 21:41:28 +0100
Subject: [PATCH] arm64: handle unmapped pages in initrd relocation
In-Reply-To: <1458762438.23434.120.camel@redhat.com>
References: <1454373031-24218-1-git-send-email-msalter@redhat.com>
 <1458762438.23434.120.camel@redhat.com>
Message-ID: <CAKv+Gu84fSQphaCiKbE6E7Ute7Acsqf7q8ST15Qheh9bvvB_uQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 March 2016 at 20:47, Mark Salter <msalter@redhat.com> wrote:
> On Mon, 2016-02-01 at 19:30 -0500, Mark Salter wrote:
>> Commit 4dffbfc48d65 ("arm64/efi: mark UEFI reserved regions as
>> MEMBLOCK_NOMAP") causes a potential problem in arm64 initrd relocation
>> code. If the kernel uses a pagesize greater than the 4k pagesize used
>> by UEFI, pagesize rounding may lead to one or both ends of the initrd
>> image to be marked unmapped. This leads to a panic when the kernel goes
>> to unpack it. This patch looks for unmapped pages at beginning and end
>> of the initrd image and if seen, relocated the initrd to a new area
>> completely covered by the kernel linear map.
>>
>> Signed-off-by: Mark Salter <msalter@redhat.com>
>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>
> The Fedora folks have run into this problem with a certain kernel build. What ever
> happened to Ard's suggested fix. The MEMBLOCK_NOMAP patch caused a regression which
> should be fixed. Whether this patch, Ard's patch, or something else.
>
> https://bugzilla.redhat.com/show_bug.cgi?id=1309147
>

As I mentioned before, reverting the MEMBLOCK_NOMAP patch will break
ARM. However, I have some patches in flight [1] that I expect Russell
to pick up for v4.7, which will make memremap() work as expected on
ARM. So for the v4.7 timeframe, we can fix it properly, by switching
to the now fully functional memremap() for mapping the UEFI memory
map, which means we can revert the MEMBLOCK_NOMAP change since
memremap() doesn't care about that (unlike ioremap_cache(), which
disallows mapping normal memory on ARM)

That does not fix the breakage, though. Since the issue only occurs on
64k pages kernels, which implies arm64, we can perhaps apply the patch
below, and revert to using memblock_reserve() in all cases once [1] is
merged.

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/484005

-------8<----------
diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
index 7c5a38c60037..95303d19fff5 100644
--- a/drivers/firmware/efi/arm-init.c
+++ b/drivers/firmware/efi/arm-init.c
@@ -240,9 +240,25 @@ void __init efi_init(void)

        reserve_regions();
        early_memunmap(memmap.map, params.mmap_size);
-       memblock_mark_nomap(params.mmap & PAGE_MASK,
-                           PAGE_ALIGN(params.mmap_size +
-                                      (params.mmap & ~PAGE_MASK)));
+
+       /*
+        * On 64k pages kernels, marking the memory map as MEMBLOCK_NOMAP may
+        * cause adjacent allocations sharing the same 64k page frame to be
+        * removed from the linear mapping as well. If this happens to cover
+        * the initrd allocation performed by GRUB (which, unlike the stub, does
+        * not align its EFI_LOADER_DATA allocations to 64k), we will run into
+        * trouble later on, since the generic initrd code expects the initrd
+        * to be covered by the linear mapping.
+        */
+       if (PAGE_SIZE > SZ_4K) {
+               memblock_reserve(params.mmap & PAGE_MASK,
+                                PAGE_ALIGN(params.mmap_size +
+                                           (params.mmap & ~PAGE_MASK)));
+       } else {
+               memblock_mark_nomap(params.mmap & PAGE_MASK,
+                                   PAGE_ALIGN(params.mmap_size +
+                                              (params.mmap & ~PAGE_MASK)));
+       }

        init_screen_info();
 }
