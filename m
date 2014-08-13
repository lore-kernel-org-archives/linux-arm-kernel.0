From: matt@console-pimps.org (Matt Fleming)
Date: Wed, 13 Aug 2014 15:27:48 +0100
Subject: [PATCH 4/5] efi x86: clear EFI_RUNTIME_SERVICES bit in case
 failures other than SetVirtualAddressMap
In-Reply-To: <1407823822-23829-4-git-send-email-dyoung@redhat.com>
References: <1407823822-23829-1-git-send-email-dyoung@redhat.com>
 <1407823822-23829-4-git-send-email-dyoung@redhat.com>
Message-ID: <20140813142748.GS15082@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Aug, at 02:10:21PM, Dave Young wrote:
> If enter virtual mode failed due to some reason other than the efi call
> the EFI_RUNTIME_SERVICES bit in efi.flags should be cleared thus users
> of efi runtime services can check the bit and handle the case instead of
> assume efi runtime is ok.
> 
> Per Matt, if efi call SetVirtualAddressMap fails we will be not sure it's safe
> to make any assumptions about the state of the system. so kernel panics instead
> of clears EFI_RUNTIME_SERVICES bit.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  arch/x86/platform/efi/efi.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

[...]

> @@ -882,8 +886,10 @@ static void __init __efi_enter_virtual_mode(void)
>  
>  void __init efi_enter_virtual_mode(void)
>  {
> -	if (efi_enabled(EFI_PARAVIRT))
> +	if (efi_enabled(EFI_PARAVIRT)) {
> +		clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
>  		return;
> +	}

The EFI_PARAVIRT folks purposely do not set this bit, so there should be
no reason to clear it here.

-- 
Matt Fleming, Intel Open Source Technology Center
