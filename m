From: JBeulich@suse.com (Jan Beulich)
Date: Tue, 17 Nov 2015 04:04:58 -0700
Subject: [PATCH v3 59/62] xen/arm: Add a hypercall for device mmio mapping
In-Reply-To: <1447753261-7552-60-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-60-git-send-email-shannon.zhao@linaro.org>
Message-ID: <564B17EA02000078000B5D34@prv-mh.provo.novell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> On 17.11.15 at 10:40, <shannon.zhao@linaro.org> wrote:
> --- a/xen/arch/arm/mm.c
> +++ b/xen/arch/arm/mm.c
> @@ -1138,6 +1138,10 @@ int xenmem_add_to_physmap_one(
>          rcu_unlock_domain(od);
>          break;
>      }
> +    case XENMAPSPACE_dev_mmio:
> +        rc = map_dev_mmio_region(d, gpfn, 1, idx);
> +        return rc;
> +        break;

Blindly for any kind of domain? The XSM check in the
XENMEM_add_to_physmap_batch handler (in common code) doesn't
even know which map space is to be used...

Jan
