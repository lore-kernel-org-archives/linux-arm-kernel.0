From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Sep 2014 12:42:39 +0100
Subject: [PATCH v6 7/8] ARM: mm: allow non-text sections to be
 non-executable
In-Reply-To: <1411067949-10913-8-git-send-email-keescook@chromium.org>
References: <1411067949-10913-1-git-send-email-keescook@chromium.org>
 <1411067949-10913-8-git-send-email-keescook@chromium.org>
Message-ID: <20140926114239.GM5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 18, 2014 at 12:19:08PM -0700, Kees Cook wrote:
> @@ -1373,13 +1373,24 @@ static void __init map_lowmem(void)
>  		if (start >= end)
>  			break;
>  
> -		if (end < kernel_x_start || start >= kernel_x_end) {
> +		if (end < kernel_x_start) {
>  			map.pfn = __phys_to_pfn(start);
>  			map.virtual = __phys_to_virt(start);
>  			map.length = end - start;
>  			map.type = MT_MEMORY_RWX;
>  
>  			create_mapping(&map);
> +		} else if (start >= kernel_x_end) {
> +			map.pfn = __phys_to_pfn(start);
> +			map.virtual = __phys_to_virt(start);
> +			map.length = end - start;
> +#ifdef CONFIG_ARM_KERNMEM_PERMS
> +			map.type = MT_MEMORY_RW;
> +#else
> +			map.type = MT_MEMORY_RWX;
> +#endif
> +
> +			create_mapping(&map);


I'm looking at this, and wondering two things.  Firstly, why isn't it
MT_MEMORY_RW in the first place.  Secondly, why do you need to make
this depend on CONFIG_ARM_KERNMEM_PERMS at all?

I think the first is an oversight by me (and is a case which never came
up in my testing, because most of my platforms don't have segmented
memory layouts.)

The second I think is not necessary - the memory region being considered
is not part of the kernel at all, and so should not be executable in any
shape or form.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
