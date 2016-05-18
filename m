From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 18 May 2016 15:18:13 +0100
Subject: [PATCH v3 10/55] KVM: arm/arm64: Export mmio_read/write_bus
In-Reply-To: <1462531568-9799-11-git-send-email-andre.przywara@arm.com>
References: <1462531568-9799-1-git-send-email-andre.przywara@arm.com>
 <1462531568-9799-11-git-send-email-andre.przywara@arm.com>
Message-ID: <573C79A5.6080008@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/16 11:45, Andre Przywara wrote:
> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> Rename mmio_{read,write}_bus to kvm_mmio_{read,write}_bus and export
> them out of mmio.c.
> This will be needed later for the new VGIC implementation.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks,
Andre.

> ---
>  arch/arm/include/asm/kvm_mmio.h   |  3 +++
>  arch/arm/kvm/mmio.c               | 10 +++++-----
>  arch/arm64/include/asm/kvm_mmio.h |  3 +++
>  3 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_mmio.h b/arch/arm/include/asm/kvm_mmio.h
> index d8e90c8..f3a7de7 100644
> --- a/arch/arm/include/asm/kvm_mmio.h
> +++ b/arch/arm/include/asm/kvm_mmio.h
> @@ -28,6 +28,9 @@ struct kvm_decode {
>  	bool sign_extend;
>  };
>  
> +void kvm_mmio_write_buf(void *buf, unsigned int len, unsigned long data);
> +unsigned long kvm_mmio_read_buf(const void *buf, unsigned int len);
> +
>  int kvm_handle_mmio_return(struct kvm_vcpu *vcpu, struct kvm_run *run);
>  int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  		 phys_addr_t fault_ipa);
> diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
> index 0158e9e..10f80a6 100644
> --- a/arch/arm/kvm/mmio.c
> +++ b/arch/arm/kvm/mmio.c
> @@ -23,7 +23,7 @@
>  
>  #include "trace.h"
>  
> -static void mmio_write_buf(char *buf, unsigned int len, unsigned long data)
> +void kvm_mmio_write_buf(void *buf, unsigned int len, unsigned long data)
>  {
>  	void *datap = NULL;
>  	union {
> @@ -55,7 +55,7 @@ static void mmio_write_buf(char *buf, unsigned int len, unsigned long data)
>  	memcpy(buf, datap, len);
>  }
>  
> -static unsigned long mmio_read_buf(char *buf, unsigned int len)
> +unsigned long kvm_mmio_read_buf(const void *buf, unsigned int len)
>  {
>  	unsigned long data = 0;
>  	union {
> @@ -66,7 +66,7 @@ static unsigned long mmio_read_buf(char *buf, unsigned int len)
>  
>  	switch (len) {
>  	case 1:
> -		data = buf[0];
> +		data = *(u8 *)buf;
>  		break;
>  	case 2:
>  		memcpy(&tmp.hword, buf, len);
> @@ -103,7 +103,7 @@ int kvm_handle_mmio_return(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  		if (len > sizeof(unsigned long))
>  			return -EINVAL;
>  
> -		data = mmio_read_buf(run->mmio.data, len);
> +		data = kvm_mmio_read_buf(run->mmio.data, len);
>  
>  		if (vcpu->arch.mmio_decode.sign_extend &&
>  		    len < sizeof(unsigned long)) {
> @@ -189,7 +189,7 @@ int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  					       len);
>  
>  		trace_kvm_mmio(KVM_TRACE_MMIO_WRITE, len, fault_ipa, data);
> -		mmio_write_buf(data_buf, len, data);
> +		kvm_mmio_write_buf(data_buf, len, data);
>  
>  		ret = kvm_io_bus_write(vcpu, KVM_MMIO_BUS, fault_ipa, len,
>  				       data_buf);
> diff --git a/arch/arm64/include/asm/kvm_mmio.h b/arch/arm64/include/asm/kvm_mmio.h
> index fe612a9..75ea420 100644
> --- a/arch/arm64/include/asm/kvm_mmio.h
> +++ b/arch/arm64/include/asm/kvm_mmio.h
> @@ -30,6 +30,9 @@ struct kvm_decode {
>  	bool sign_extend;
>  };
>  
> +void kvm_mmio_write_buf(void *buf, unsigned int len, unsigned long data);
> +unsigned long kvm_mmio_read_buf(const void *buf, unsigned int len);
> +
>  int kvm_handle_mmio_return(struct kvm_vcpu *vcpu, struct kvm_run *run);
>  int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  		 phys_addr_t fault_ipa);
> 
