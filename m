From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Tue, 15 Nov 2016 22:15:51 +0100
Subject: Default atomic_pool_size value & changing it
Message-ID: <CACna6ryHrkhxF-HKDB-+if=7XC9D=89oTEVyR9PJWpYAWnoVzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I've hit problem with allocating enough coherent DMA memory. Obviously
there is a limit of this memory as pointed by:
[ 0.283667] DMA: preallocated 256 KiB pool for atomic coherent allocations

In my case I was experimenting with a coherent memory used for DMA
descriptors. They are some small structs addressing SKBs and
controlling them:
struct bgmac_dma_desc {
        __le32 ctl0;
        __le32 ctl1;
        __le32 addr_low;
        __le32 addr_high;
} __packed;
Having 5-6 rings 512 entries each requires 48 KiB. There are devices
with 3 Ethernet bgmac devices and 2 wireless devices, 48 KiB * 5 gets
me dangerously close to the limit. I don't see this problem with
upstream default drivers yet, but it may become an issue at some
point.

Raspberry Pi was dealing a similar problem:
https://github.com/raspberrypi/linux/issues/170

Does it make any sense to increase default atomic_pool_size value?

I see there is init_dma_coherent_pool_size function but it seems to be
dead code (can we drop it?).
I can change that value using coherent_pool param, but is that sane to
put it in bootargs of upstream DTS files?
Any advise on this?

-- 
Rafa?
