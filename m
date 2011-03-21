From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 21 Mar 2011 18:49:53 -0400 (EDT)
Subject: [PATCH v2] ARM:boot:device tree: Allow the device tree binary to
	be appended to zImage
In-Reply-To: <20110321221930.19756.36549.stgit@riker>
References: <20110321221930.19756.36549.stgit@riker>
Message-ID: <alpine.LFD.2.00.1103211844500.11889@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Mar 2011, John Bonesio wrote:

> This patch provides the ability to boot using a device tree that is appended
> to the raw binary zImage (e.g. cat zImage <filename>.dtb > zImage_w_dtb).
> 
> Signed-off-by: John Bonesio <bones@secretlab.ca>

One minor glitch still...  ;-)

> @@ -288,12 +344,28 @@ wont_overwrite:
>  
>  		/*
>  		 * Relocate all entries in the GOT table.
> +		 * Bump bss entries to _edata + dtb size
>  		 */
>  1:		ldr	r1, [r11, #0]		@ relocate entries in the GOT
> -		add	r1, r1, r0		@ table.  This fixes up the
> -		str	r1, [r11], #4		@ C references.
> +		add	r1, r1, r0		@ This fixes up C references
> +		cmp	r1, r2			@ if entry >= bss_start &&
> +		cmphs	r3, r1			@       bss_end > entry
> +		addhi	r1, lr			@    entry += dtb size

Some toolchains won't accept this shortened version unless you compile 
for Thumb.  You should instead use:

		addhi	r1, r1, lr

Otherwise...

Reviewed-by: Nicolas Pitre <nicolas.pitre@linaro.org>


Nicolas
