From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Mon, 30 Nov 2015 14:13:26 -0500
Subject: [PATCH] evm: EVM_LOAD_X509 depends on EVM
In-Reply-To: <6677122.Oqut6OGZ1C@wuerfel>
References: <6677122.Oqut6OGZ1C@wuerfel>
Message-ID: <1448910806.12924.17.camel@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-11-27 at 14:52 +0100, Arnd Bergmann wrote:
> The newly added EVM_LOAD_X509 code can be configured even if
> CONFIG_EVM is disabled, but that causes a link error:
> 
> security/built-in.o: In function `integrity_load_keys':
> digsig_asymmetric.c:(.init.text+0x400): undefined reference to `evm_load_x509'
> 
> This adds a Kconfig dependency to ensure it is only enabled when
> CONFIG_EVM is set as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 7f753c992343 ("evm: load x509 certificate from the kernel")

Thanks for the patch!

Mimi

> ---
> Found on yesterday's linux-next with ARM randconfig builds
> 
> diff --git a/security/integrity/evm/Kconfig b/security/integrity/evm/Kconfig
> index b1433e9cd8cb..87e83adf4c6e 100644
> --- a/security/integrity/evm/Kconfig
> +++ b/security/integrity/evm/Kconfig
> @@ -44,7 +44,7 @@ config EVM_EXTRA_SMACK_XATTRS
> 
>  config EVM_LOAD_X509
>  	bool "Load X509 certificate to the '.evm' trusted keyring"
> -	depends on INTEGRITY_TRUSTED_KEYRING
> +	depends on EVM && INTEGRITY_TRUSTED_KEYRING
>  	default n
>  	help
>  	   Load X509 certificate to the '.evm' trusted keyring.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
