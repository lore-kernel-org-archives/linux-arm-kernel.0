From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 28 Oct 2015 11:06:46 +0900
Subject: [PATCH] arm64: efi: make sure vmlinux load address aligned on
 2MBytes
In-Reply-To: <1445981041-8774-1-git-send-email-timur@codeaurora.org>
References: <1445981041-8774-1-git-send-email-timur@codeaurora.org>
Message-ID: <CAKv+Gu_ivkemFva-Fu0E24mQqE-m0jPWBzo5OZAr7cyM08hqug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 October 2015 at 06:24, Timur Tabi <timur@codeaurora.org> wrote:
> From: Shanker Donthineni <shankerd@codeaurora.org>
>
> The vmlinux image load address must be aligned to 2MB, as documented
> in Documentation/arm64/booting.txt. Otherwise, __create_page_tables
> in head.S will create incorrect page table entries.
>
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> ---
>  arch/arm64/kernel/efi-stub.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/kernel/efi-stub.c b/arch/arm64/kernel/efi-stub.c
> index 816120e..df1433d 100644
> --- a/arch/arm64/kernel/efi-stub.c
> +++ b/arch/arm64/kernel/efi-stub.c
> @@ -21,7 +21,7 @@ efi_status_t __init handle_kernel_image(efi_system_table_t *sys_table_arg,
>                                         unsigned long dram_base,
>                                         efi_loaded_image_t *image)
>  {
> -       efi_status_t status;
> +       efi_status_t status = EFI_LOAD_ERROR;
>         unsigned long kernel_size, kernel_memsize = 0;
>         unsigned long nr_pages;
>         void *old_image_addr = (void *)*image_addr;
> @@ -39,15 +39,18 @@ efi_status_t __init handle_kernel_image(efi_system_table_t *sys_table_arg,
>                  * value or a NULL pointer). It will also ensure that, on
>                  * platforms where the [dram_base, dram_base + TEXT_OFFSET)
>                  * interval is partially occupied by the firmware (like on APM
> -                * Mustang), we can still place the kernel at the address
> -                * 'dram_base + TEXT_OFFSET'.
> +                * Mustang) and dram_base is aligned on 2Mbytes, we can still
> +                * place the kernel at the address 'dram_base + TEXT_OFFSET'.
>                  */
> -               *image_addr = *reserve_addr = dram_base + TEXT_OFFSET;
> -               nr_pages = round_up(kernel_memsize, EFI_ALLOC_ALIGN) /
> +               if (IS_ALIGNED(dram_base, SZ_2M)) {
> +                       *image_addr = *reserve_addr = dram_base + TEXT_OFFSET;
> +                       nr_pages = round_up(kernel_memsize, EFI_ALLOC_ALIGN) /
>                            EFI_PAGE_SIZE;
> -               status = efi_call_early(allocate_pages, EFI_ALLOCATE_ADDRESS,
> +                       status = efi_call_early(allocate_pages,
> +                                       EFI_ALLOCATE_ADDRESS,
>                                         EFI_LOADER_DATA, nr_pages,
>                                         (efi_physical_addr_t *)reserve_addr);
> +               }
>                 if (status != EFI_SUCCESS) {
>                         kernel_memsize += TEXT_OFFSET;
>                         status = efi_low_alloc(sys_table_arg, kernel_memsize,

I agree we should fix this, but I would prefer a oneliner such as

diff --git a/arch/arm64/kernel/efi-stub.c b/arch/arm64/kernel/efi-stub.c
index 816120ece6bc..a60ce249cfc0 100644
--- a/arch/arm64/kernel/efi-stub.c
+++ b/arch/arm64/kernel/efi-stub.c
@@ -42,7 +42,8 @@
                 * Mustang), we can still place the kernel at the address
                 * 'dram_base + TEXT_OFFSET'.
                 */
-               *image_addr = *reserve_addr = dram_base + TEXT_OFFSET;
+               *image_addr = *reserve_addr = round_up(dram_base, SZ_2M) +
+                                                      TEXT_OFFSET);
                nr_pages = round_up(kernel_memsize, EFI_ALLOC_ALIGN) /
                           EFI_PAGE_SIZE;
                status = efi_call_early(allocate_pages, EFI_ALLOCATE_ADDRESS,
