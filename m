From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 16 Oct 2013 15:35:52 +0100
Subject: [PATCH v2] ARM: cci driver need big endian fixes in asm code
In-Reply-To: <1381899034-420-2-git-send-email-victor.kamensky@linaro.org>
References: <1381899034-420-1-git-send-email-victor.kamensky@linaro.org>
 <1381899034-420-2-git-send-email-victor.kamensky@linaro.org>
Message-ID: <525EA448.7040503@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/10/13 05:50, Victor Kamensky wrote:
> cci_enable_port_for_self written in asm and it works with h/w
> registers that are in little endian format. When run in big
> endian mode it needs byteswaped constants before/after it
> writes/reads to/from such registers
>
> Signed-off-by: Victor Kamensky<victor.kamensky@linaro.org>
> Signed-off-by: Ben Dooks<ben.dooks@codethink.co.uk>
> ---
>   drivers/bus/arm-cci.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> index 57b0bc6..4328c25 100644
> --- a/drivers/bus/arm-cci.c
> +++ b/drivers/bus/arm-cci.c
> @@ -872,7 +872,7 @@ asmlinkage void __naked cci_enable_port_for_self(void)
>
>   	/* Enable the CCI port */
>   "	ldr	r0, [r0, %[offsetof_port_phys]] \n"
> -"	mov	r3, #"__stringify(CCI_ENABLE_REQ)" \n"
> +"	mov	r3, %[cci_enable_req]\n"		
>   "	str	r3, [r0, #"__stringify(CCI_PORT_CTRL)"] \n"
>
>   	/* poll the status reg for completion */
> @@ -880,7 +880,7 @@ asmlinkage void __naked cci_enable_port_for_self(void)
>   "	ldr	r0, [r1] \n"
>   "	ldr	r0, [r0, r1]		@ cci_ctrl_base \n"
>   "4:	ldr	r1, [r0, #"__stringify(CCI_CTRL_STATUS)"] \n"
> -"	tst	r1, #1 \n"
> +"	tst	r1, %[cci_control_status_bits] \n"			
>   "	bne	4b \n"
>
>   "	mov	r0, #0 \n"
> @@ -893,6 +893,8 @@ asmlinkage void __naked cci_enable_port_for_self(void)
>   "7:	.word	cci_ctrl_phys - . \n"
>   	: :
>   	[sizeof_cpu_port] "i" (sizeof(cpu_port)),
> +	[cci_enable_req] "i" cpu_to_le32(CCI_ENABLE_REQ),
> +	[cci_control_status_bits] "i" cpu_to_le32(1),
>   #ifndef __ARMEB__
>   	[offsetof_cpu_port_mpidr_lsb] "i" (offsetof(struct cpu_port, mpidr)),
>   #else

Thanks

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
