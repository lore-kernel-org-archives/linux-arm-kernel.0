From: keith.busch@intel.com (Keith Busch)
Date: Mon, 23 Feb 2015 16:01:23 +0000 (UTC)
Subject: [PATCH] NVMe: add explicit BLK_DEV_INTEGRITY dependency
In-Reply-To: <6241161.LKiT8yUlIj@wuerfel>
References: <6241161.LKiT8yUlIj@wuerfel>
Message-ID: <alpine.LNX.2.00.1502231559290.32385@localhost.lm.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 23 Feb 2015, Arnd Bergmann wrote:
> A patch that was added to 4.0-rc1 in the last minute caused a
> build break in the NVMe driver unless integrity support is
> also enabled:
>
> drivers/block/nvme-core.c: In function 'nvme_dif_remap':
> drivers/block/nvme-core.c:523:24: error: dereferencing pointer to incomplete type
>  pmap = kmap_atomic(bip->bip_vec->bv_page) + bip->bip_vec->bv_offset;
>                        ^
> drivers/block/nvme-core.c:523:49: error: dereferencing pointer to incomplete type
>  pmap = kmap_atomic(bip->bip_vec->bv_page) + bip->bip_vec->bv_offset;
>                                                 ^
>
> This changes the Kconfig entry for NVMe to depend on that
> support, to avoid the build error. Using 'select' would work
> as well, but might have unintended side-effects when users
> do not actually want the integerity support.

Thanks for the catch. We do want users to be able to use this with and
without blk-integrity, so I'll send a patch using conditional functions
between appropriate ifdef's like how scsi and block handle this.
