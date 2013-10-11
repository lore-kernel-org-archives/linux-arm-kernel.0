From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Oct 2013 15:50:47 +0100
Subject: [PATCH 2/7] kvmtool: virt_queue: handle guest endianness
In-Reply-To: <1381502195-8263-3-git-send-email-marc.zyngier@arm.com>
References: <1381502195-8263-1-git-send-email-marc.zyngier@arm.com>
 <1381502195-8263-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20131011145047.GO14732@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 11, 2013 at 03:36:30PM +0100, Marc Zyngier wrote:
> Wrap all accesses to virt_queue data structures shared between
> host and guest with byte swapping helpers.
> 
> Should the architecture only support one endianness, these helpers
> are reduced to the identity function.
> 
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  tools/kvm/include/kvm/virtio.h | 189 ++++++++++++++++++++++++++++++++++++++++-
>  tools/kvm/virtio/core.c        |  59 +++++++------
>  2 files changed, 219 insertions(+), 29 deletions(-)
> 
> diff --git a/tools/kvm/include/kvm/virtio.h b/tools/kvm/include/kvm/virtio.h
> index d6b0f47..04ec137 100644
> --- a/tools/kvm/include/kvm/virtio.h
> +++ b/tools/kvm/include/kvm/virtio.h
> @@ -1,6 +1,8 @@
>  #ifndef KVM__VIRTIO_H
>  #define KVM__VIRTIO_H
>  
> +#include <endian.h>
> +
>  #include <linux/virtio_ring.h>
>  #include <linux/virtio_pci.h>
>  
> @@ -29,15 +31,194 @@ struct virt_queue {
>  	u16		endian;
>  };
>  
> +/*
> + * The default policy is not to cope with the guest endianness.
> + * It also helps not breaking archs that do not care about supporting
> + * such a configuration.
> + */

Jesus Marc, are you *trying* to crash my preprocessor? Seriously though,
maybe this is better done as a block:

#if __BYTE_ORDER == __BIG_ENDIAN
#define	virtio_le16toh(x)	le16toh(x)
#define virtio_be16toh(x)
[...]

> +#ifndef VIRTIO_RING_ENDIAN
> +#define VIRTIO_RING_ENDIAN 0
> +#endif
> +
> +#if (VIRTIO_RING_ENDIAN & ((1UL << VIRTIO_RING_F_GUEST_LE) | (1UL << VIRTIO_RING_F_GUEST_BE)))
> +
> +#ifndef __BYTE_ORDER
> +#error "No byteorder? Giving up..."
> +#endif
> +
> +
> +static inline __u16 __virtio_guest_to_host_u16(u16 endian, __u16 val)
> +{
> +#if __BYTE_ORDER == __BIG_ENDIAN
> +	if (endian == VIRTIO_ENDIAN_LE)
> +		return le16toh(val);
> +#else
> +	if (endian == VIRTIO_ENDIAN_BE)
> +		return be16toh(val);
> +#endif

Then you can just use the endian parameter to do the right thing.

Will
