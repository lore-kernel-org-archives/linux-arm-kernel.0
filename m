From: per.xx.fransson@stericsson.com (Per Fransson)
Date: Thu, 2 Sep 2010 15:30:01 +0200
Subject: [PATCH] ARM: Implement cpu_v7_reset.
In-Reply-To: <20100902103957.GR26319@n2100.arm.linux.org.uk>
References: <1283349719-21115-1-git-send-email-linus.walleij@stericsson.com>
	<20100901232307.GC25860@n2100.arm.linux.org.uk>
	<20100902083423.GI25559@gw.healthdatacare.com>
	<20100902084101.GA26319@n2100.arm.linux.org.uk>
	<20100902085341.GJ25559@gw.healthdatacare.com>
	<20100902103957.GR26319@n2100.arm.linux.org.uk>
Message-ID: <4C7FA6D9.6040307@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


I tested the v7 version below and it works fine.

Regards,
Per

On 09/02/2010 12:39 PM, Russell King - ARM Linux wrote:
> On Thu, Sep 02, 2010 at 11:53:41AM +0300, Mika Westerberg wrote:
>> On Thu, Sep 02, 2010 at 09:41:01AM +0100, Russell King - ARM Linux wrote:
>>> On Thu, Sep 02, 2010 at 11:34:23AM +0300, Mika Westerberg wrote:
>>>>
>>>> When the MMU is turned off, should we be running on 1:1 mappings?
>>>
>>> Mappings are setup, but not for this code.  This code relies upon the
>>> instruction which jumps to already be in the pipeline at the point when
>>> the MMU is turned off - and the destination for that jump to be a 1:1
>>> mapping.
>>
>> OK, thanks.
>>
>> Any Idea what might cause the hang on OMAP3? Only way I was able
>> to get it working when MMU is disabled was to run cpu_v7_reset()
>> also via 1:1 mapping.
>
> Well, as the current v6 and v7 cpu_reset() code is broken, it's hardly
> surprising that it doesn't work.  It needs to be something like this
> (I haven't tested it yet.)
>
> diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
> index 22aac85..6b873f9 100644
> --- a/arch/arm/mm/proc-v6.S
> +++ b/arch/arm/mm/proc-v6.S
> @@ -59,6 +59,16 @@ ENTRY(cpu_v6_proc_fin)
>    */
>   	.align	5
>   ENTRY(cpu_v6_reset)
> +	mov	ip, #0
> +	mcr	p15, 0, ip, c7, c7, 0		@ invalidate I,D caches
> +	mcr	p15, 0, ip, c7, c10, 4		@ drain WB
> +#ifdef CONFIG_MMU
> +	mcr	p15, 0, ip, c8, c7, 0		@ invalidate I&  D TLBs
> +#endif
> +	mrc	p15, 0, ip, c1, c0, 0		@ ctrl register
> +	bic	ip, ip, #0x000f			@ ............wcam
> +	bic	ip, ip, #0x1100			@ ...i...s........
> +	mcr	p15, 0, ip, c1, c0, 0		@ ctrl register
>   	mov	pc, r0
>
>   /*
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index 6a8506d..3542ee0 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -63,6 +63,16 @@ ENDPROC(cpu_v7_proc_fin)
>    */
>   	.align	5
>   ENTRY(cpu_v7_reset)
> +	mov	ip, #0
> +	mcr	p15, 0, ip, c7, c7, 0		@ invalidate I,D caches
> +	dsb
> +#ifdef CONFIG_MMU
> +	mcr	p15, 0, ip, c8, c7, 0		@ invalidate I&  D TLBs
> +#endif
> +	mrc	p15, 0, ip, c1, c0, 0		@ ctrl register
> +	bic	ip, ip, #0x000f			@ ............wcam
> +	bic	ip, ip, #0x1100			@ ...i...s........
> +	mcr	p15, 0, ip, c1, c0, 0		@ ctrl register
>   	mov	pc, r0
>   ENDPROC(cpu_v7_reset)
>
>
>
