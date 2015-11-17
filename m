From: julien.grall@citrix.com (Julien Grall)
Date: Tue, 17 Nov 2015 12:02:31 +0000
Subject: [PATCH v3 51/62] arm/acpi: Prepare EFI system table for Dom0
In-Reply-To: <1447753261-7552-52-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-52-git-send-email-shannon.zhao@linaro.org>
Message-ID: <564B1757.5060008@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shannon,

On 17/11/15 09:40, shannon.zhao at linaro.org wrote:
> diff --git a/xen/common/efi/boot.c b/xen/common/efi/boot.c
> index 6a48624..75835ae 100644
> --- a/xen/common/efi/boot.c
> +++ b/xen/common/efi/boot.c
> @@ -1192,6 +1192,70 @@ int __init estimate_efi_size(int mem_nr_banks)
>  
>      return size;
>  }
> +
> +static uint32_t __init xz_crc32(uint8_t *buf, size_t size, uint32_t crc)
> +{
> +    uint32_t xz_crc32_table[256];
> +    const uint32_t poly = 0xEDB88320;
> +    uint32_t i;
> +    uint32_t j;
> +    uint32_t r;
> +
> +    for (i = 0; i < 256; ++i) {
> +        r = i;
> +        for (j = 0; j < 8; ++j)
> +            r = (r >> 1) ^ (poly & ~((r & 1) - 1));
> +
> +        xz_crc32_table[i] = r;
> +    }
> +
> +    crc = ~crc;
> +    while (size != 0) {
> +            crc = xz_crc32_table[*buf++ ^ (crc & 0xFF)] ^ (crc >> 8);
> +            --size;
> +    }
> +
> +    return ~crc;
> +}

I'm nearly sure I already said it, this code already exists in the tree.
Why do you need to implement a new version?

Regards,

-- 
Julien Grall
