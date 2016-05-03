From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 3 May 2016 16:35:49 +0100
Subject: [PATCH v2 47/54] KVM: arm/arm64: vgic-new: vgic_init: implement
 kvm_vgic_hyp_init
In-Reply-To: <1461861973-26464-48-git-send-email-andre.przywara@arm.com>
References: <1461861973-26464-1-git-send-email-andre.przywara@arm.com>
 <1461861973-26464-48-git-send-email-andre.przywara@arm.com>
Message-ID: <5728C555.3080008@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/04/16 17:46, Andre Przywara wrote:
> From: Eric Auger <eric.auger@linaro.org>
> 
> Implements kvm_vgic_hyp_init and vgic_probe function.
> 
> The vgic_global struct is enriched with new fields populated
> by those functions.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Changelog v1 .. v2:
> - rename vgic_init.c to vgic-init.c
> 
>  include/kvm/vgic/vgic.h       |   1 +
>  virt/kvm/arm/vgic/vgic-init.c | 122 ++++++++++++++++++++++++++++++++++++++++++
>  virt/kvm/arm/vgic/vgic-v2.c   |  90 +++++++++++++++++++++++++++++++
>  virt/kvm/arm/vgic/vgic-v3.c   |  74 +++++++++++++++++++++++++
>  virt/kvm/arm/vgic/vgic.h      |   6 +++
>  5 files changed, 293 insertions(+)
>  create mode 100644 virt/kvm/arm/vgic/vgic-init.c
> 
> diff --git a/include/kvm/vgic/vgic.h b/include/kvm/vgic/vgic.h
> index cfc3640..d144e3d 100644
> --- a/include/kvm/vgic/vgic.h
> +++ b/include/kvm/vgic/vgic.h
> @@ -202,6 +202,7 @@ struct vgic_cpu {
>  };
>  
>  int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write);
> +int kvm_vgic_hyp_init(void);
>  
>  int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int intid,
>  			bool level);
> diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
> new file mode 100644
> index 0000000..d7c50bb
> --- /dev/null
> +++ b/virt/kvm/arm/vgic/vgic-init.c
> @@ -0,0 +1,122 @@
> +/*
> + * Copyright (C) 2015, 2016 ARM Ltd.
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
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/uaccess.h>
> +#include <linux/interrupt.h>
> +#include <linux/cpu.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/kvm_host.h>
> +#include <kvm/vgic/vgic.h>

Same issue here as well.

	M.
-- 
Jazz is not dead. It just smells funny...
