From: dave.hansen@intel.com (Dave Hansen)
Date: Thu, 11 Oct 2018 16:47:29 -0700
Subject: [PATCH v2 4/7] arm64/modules: Add rlimit checking for arm64
 modules
In-Reply-To: <20181011233117.7883-5-rick.p.edgecombe@intel.com>
References: <20181011233117.7883-1-rick.p.edgecombe@intel.com>
 <20181011233117.7883-5-rick.p.edgecombe@intel.com>
Message-ID: <25951d99-8ba7-5c9e-938e-baf92395f9e0@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/2018 04:31 PM, Rick Edgecombe wrote:
> +	if (check_inc_mod_rlimit(size))
> +		return NULL;
> +
>  	p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
>  				module_alloc_base + MODULES_VSIZE,
>  				gfp_mask, PAGE_KERNEL_EXEC, 0,
> @@ -65,6 +68,8 @@ void *module_alloc(unsigned long size)
>  		return NULL;
>  	}
>  
> +	update_mod_rlimit(p, size);

Is there a reason we couldn't just rename all of the existing per-arch
module_alloc() calls to be called, say, "arch_module_alloc()", then put
this new rlimit code in a generic helper that does:


	if (check_inc_mod_rlimit(size))
		return NULL;

	p = arch_module_alloc(...);

	...

	update_mod_rlimit(p, size);
