From: matt@console-pimps.org (Matt Fleming)
Date: Tue, 6 Aug 2013 14:53:27 +0100
Subject: [PATCH 2/7] Move common EFI stub code from x86 arch code to
 common location
In-Reply-To: <1375478948-22562-3-git-send-email-roy.franz@linaro.org>
References: <1375478948-22562-1-git-send-email-roy.franz@linaro.org>
 <1375478948-22562-3-git-send-email-roy.franz@linaro.org>
Message-ID: <20130806135327.GY2515@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 02 Aug, at 02:29:03PM, Roy Franz wrote:
> No code changes made, just moving functions from x86 arch directory
> to common location.
> Code is shared using #include, similar to how decompression code
> is shared among architectures.
> 
> Signed-off-by: Roy Franz <roy.franz@linaro.org>
> ---
>  arch/x86/boot/compressed/eboot.c       |  442 +-----------------------------
>  arch/x86/boot/compressed/eboot.h       |    6 -
>  drivers/firmware/efi/efi-stub-helper.c |  463 ++++++++++++++++++++++++++++++++
>  include/linux/efi.h                    |    8 +
>  4 files changed, 472 insertions(+), 447 deletions(-)
>  create mode 100644 drivers/firmware/efi/efi-stub-helper.c

[...]

> diff --git a/drivers/firmware/efi/efi-stub-helper.c b/drivers/firmware/efi/efi-stub-helper.c
> new file mode 100644
> index 0000000..47891bd
> --- /dev/null
> +++ b/drivers/firmware/efi/efi-stub-helper.c
> @@ -0,0 +1,463 @@
> +/*
> + * Helper functions used by the EFI stub on multiple
> + * architectures. This should be #included by the EFI stub
> + * implementation files.
> + *
> + * Copyright 2011 Intel Corporation; author Matt Fleming
> + *
> + * This file is part of the Linux kernel, and is made available
> + * under the terms of the GNU General Public License version 2.
> + *
> + */
> +
> +
> +struct initrd {
> +	efi_file_handle_t *handle;
> +	u64 size;
> +};

This should really be renamed in a later patch, like 'struct efi_file'
or similar because the dtb case has nothing to do with initrds.

> +/*
> + * Check the cmdline for a LILO-style initrd= arguments.
> + *
> + * We only support loading an initrd from the same filesystem as the
> + * kernel image.
> + */
> +static efi_status_t handle_ramdisks(efi_loaded_image_t *image,
> +				    struct setup_header *hdr)
> +{
> +	struct initrd *initrds;

[...]

> +free_initrds:
> +	efi_call_phys1(sys_table->boottime->free_pool, initrds);
> +fail:
> +	hdr->ramdisk_image = 0;
> +	hdr->ramdisk_size = 0;
> +
> +	return status;
> +}

Likewise, this function would benefit from getting rid of the references
to initrd in a later patch.

-- 
Matt Fleming, Intel Open Source Technology Center
