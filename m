From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 2 Jul 2015 18:03:26 +0100
Subject: [PATCH 2/7] KVM: kvm_host: add kvm_extended_msi
In-Reply-To: <1435592237-17924-3-git-send-email-eric.auger@linaro.org>
References: <1435592237-17924-1-git-send-email-eric.auger@linaro.org>
 <1435592237-17924-3-git-send-email-eric.auger@linaro.org>
Message-ID: <55956EDE.6030300@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

just played a bit with the code and I could make things easier by the
following change:

On 29/06/15 16:37, Eric Auger wrote:
> Add a new kvm_extended_msi struct to store the additional device ID
> specific to ARM. kvm_kernel_irq_routing_entry union now encompasses
> this new struct.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> 
> ---
> 
> RFC -> PATCH:
> - reword the commit message after change in first patch (uapi)
> ---
>  include/linux/kvm_host.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index ad45054..e1c1c0d 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -304,6 +304,13 @@ struct kvm_s390_adapter_int {
>  	u32 adapter_id;
>  };
>  
> +struct kvm_extended_msi {
> +	u32     address_lo;     /* low 32 bits of msi message address */
> +	u32     address_hi;     /* high 32 bits of msi message address */
> +	u32     data;           /* 16 bits of msi message data */
> +	u32	devid;		/* out-of-band device ID */
> +};
> +

I got rid of this structure at all, instead using:

 @@ -317,6 +324,7 @@ struct kvm_kernel_irq_routing_entry {
  		} irqchip;
-		struct msi_msg msi;
+		struct {
+			struct msi_msg msi;
+			u32 devid;
+		};
  		struct kvm_s390_adapter_int adapter;
  	};
  	struct hlist_node link;
  };

This re-uses the existing MSI fields in struct msi_msg, so all the extra
code you added in the next patches to set address and data could be
skipped. If needed we can add a flags field here as well to avoid that
extra type.
That simplified a lot for me.

Cheers,
Andr?
