From: eric.auger@redhat.com (Auger Eric)
Date: Wed, 6 Sep 2017 09:22:41 +0200
Subject: [PATCH] KVM: arm64: vgic-its: Fix wrong return value check in
 vgic_its_restore_device_tables
In-Reply-To: <1504675565-13641-1-git-send-email-vkilari@codeaurora.org>
References: <1504675565-13641-1-git-send-email-vkilari@codeaurora.org>
Message-ID: <65a66715-4f22-07d4-879a-1181c8dad889@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vijaya,

On 06/09/2017 07:26, Vijaya Kumar K wrote:
> scan_its_table() return 1 on success.

As mentioned in the kernel-doc comment of scan_its_table, this latter
returns 1 if the last element is not found. Than can happen while
scanning an L2 table but shouldn't happen if we scan an L1 table.

 * Return: < 0 on error, 0 if last element was identified, 1 otherwise
 * (the last element may not be found on second level tables)


 In the function vgic_its_restore_device_tables()
> the return value of scan_its_table() is checked against success value
> and returns -EINVAL. Hence migration fails for VM with ITS.
> 
> With this patch the failure return value is checked while returning
> -EINVAL.
> 
> Signed-off-by: Vijaya Kumar K <vkilari@codeaurora.org>
> 
> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
> index aa6b68d..63f8ac3 100644
> --- a/virt/kvm/arm/vgic/vgic-its.c
> +++ b/virt/kvm/arm/vgic/vgic-its.c
> @@ -2142,7 +2142,7 @@ static int vgic_its_restore_device_tables(struct vgic_its *its)
>  				     vgic_its_restore_dte, NULL);
>  	}
>  
> -	if (ret > 0)
> +	if (ret <= 0)
>  		ret = -EINVAL;
your modification would return -EINVAL for whatever error encountered
during the scan table or if last element is found. I don't think this is
what we want.

Thanks

Eric
>  
>  	return ret;
> 
