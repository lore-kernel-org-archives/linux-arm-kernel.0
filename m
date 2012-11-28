From: will.deacon@arm.com (Will Deacon)
Date: Wed, 28 Nov 2012 13:09:34 +0000
Subject: [PATCH v4 04/13] ARM: KVM: Initial VGIC MMIO support code
In-Reply-To: <20121110154444.3061.22464.stgit@chazy-air>
References: <20121110154358.3061.16338.stgit@chazy-air>
 <20121110154444.3061.22464.stgit@chazy-air>
Message-ID: <20121128130934.GF21671@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 10, 2012 at 03:44:44PM +0000, Christoffer Dall wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> Wire the initial in-kernel MMIO support code for the VGIC, used
> for the distributor emulation.

[...]

> diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
> new file mode 100644
> index 0000000..26ada3b
> --- /dev/null
> +++ b/arch/arm/kvm/vgic.c
> @@ -0,0 +1,138 @@
> +/*
> + * Copyright (C) 2012 ARM Ltd.
> + * Author: Marc Zyngier <marc.zyngier@arm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> + */
> +
> +#include <linux/kvm.h>
> +#include <linux/kvm_host.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <asm/kvm_emulate.h>
> +
> +#define ACCESS_READ_VALUE	(1 << 0)
> +#define ACCESS_READ_RAZ		(0 << 0)
> +#define ACCESS_READ_MASK(x)	((x) & (1 << 0))
> +#define ACCESS_WRITE_IGNORED	(0 << 1)
> +#define ACCESS_WRITE_SETBIT	(1 << 1)
> +#define ACCESS_WRITE_CLEARBIT	(2 << 1)
> +#define ACCESS_WRITE_VALUE	(3 << 1)
> +#define ACCESS_WRITE_MASK(x)	((x) & (3 << 1))
> +
> +/**
> + * vgic_reg_access - access vgic register
> + * @mmio:   pointer to the data describing the mmio access
> + * @reg:    pointer to the virtual backing of the vgic distributor struct
> + * @offset: least significant 2 bits used for word offset
> + * @mode:   ACCESS_ mode (see defines above)
> + *
> + * Helper to make vgic register access easier using one of the access
> + * modes defined for vgic register access
> + * (read,raz,write-ignored,setbit,clearbit,write)
> + */
> +static void vgic_reg_access(struct kvm_exit_mmio *mmio, u32 *reg,
> +			    u32 offset, int mode)
> +{
> +	int word_offset = offset & 3;

You can get rid of this variable.

> +	int shift = word_offset * 8;

shift = (offset & 3) << 3;

> +	u32 mask;
> +	u32 regval;
> +
> +	/*
> +	 * Any alignment fault should have been delivered to the guest
> +	 * directly (ARM ARM B3.12.7 "Prioritization of aborts").
> +	 */
> +
> +	mask = (~0U) >> (word_offset * 8);

then use shift here.

> +	if (reg)
> +		regval = *reg;
> +	else {

Use braces for the if clause.

> +		BUG_ON(mode != (ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED));
> +		regval = 0;
> +	}
> +
> +	if (mmio->is_write) {
> +		u32 data = (*((u32 *)mmio->data) & mask) << shift;
> +		switch (ACCESS_WRITE_MASK(mode)) {
> +		case ACCESS_WRITE_IGNORED:
> +			return;
> +
> +		case ACCESS_WRITE_SETBIT:
> +			regval |= data;
> +			break;
> +
> +		case ACCESS_WRITE_CLEARBIT:
> +			regval &= ~data;
> +			break;
> +
> +		case ACCESS_WRITE_VALUE:
> +			regval = (regval & ~(mask << shift)) | data;
> +			break;
> +		}
> +		*reg = regval;
> +	} else {
> +		switch (ACCESS_READ_MASK(mode)) {
> +		case ACCESS_READ_RAZ:
> +			regval = 0;
> +			/* fall through */
> +
> +		case ACCESS_READ_VALUE:
> +			*((u32 *)mmio->data) = (regval >> shift) & mask;
> +		}
> +	}
> +}

It might be a good idea to have some port accessors for mmio->data otherwise
you'll likely get endianness issues creeping in.

> +/* All this should be handled by kvm_bus_io_*()... FIXME!!! */

I don't follow this comment :) Can you either make it clearer (and less
alarming!) or just drop it please?

> +struct mmio_range {
> +	unsigned long base;
> +	unsigned long len;
> +	bool (*handle_mmio)(struct kvm_vcpu *vcpu, struct kvm_exit_mmio *mmio,
> +			    u32 offset);
> +};

Why not make offset a phys_addr_t?

> +static const struct mmio_range vgic_ranges[] = {
> +	{}
> +};
> +
> +static const
> +struct mmio_range *find_matching_range(const struct mmio_range *ranges,
> +				       struct kvm_exit_mmio *mmio,
> +				       unsigned long base)
> +{
> +	const struct mmio_range *r = ranges;
> +	unsigned long addr = mmio->phys_addr - base;

Same here, I don't think we want to truncate everything to unsigned long.

> +	while (r->len) {
> +		if (addr >= r->base &&
> +		    (addr + mmio->len) <= (r->base + r->len))
> +			return r;
> +		r++;
> +	}

Hmm, does this work correctly for adjacent mmio devices where addr sits
on the boundary (i.e. the first address of the second device)?

Will
