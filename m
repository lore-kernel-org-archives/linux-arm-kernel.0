From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Wed, 18 Sep 2013 10:33:24 +0200
Subject: [PATCH v2 2/2] RX-51: ARM errata 430973 workaround
In-Reply-To: <20130917232417.GK9994@atomide.com>
References: <1362044548-5398-1-git-send-email-pali.rohar@gmail.com>
 <1373461145-9812-3-git-send-email-pali.rohar@gmail.com>
 <20130917232417.GK9994@atomide.com>
Message-ID: <201309181033.24965@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 September 2013 01:24:17 Tony Lindgren wrote:
> * Pali Roh?r <pali.rohar@gmail.com> [130710 06:06]:
> > --- a/arch/arm/mach-omap2/board-rx51.c
> > +++ b/arch/arm/mach-omap2/board-rx51.c
> 
> This file will be gone as soon as we're moving to device
> tree based booting. So let's do this in more future proof
> way.
> 
> > +/**
> > + * rx51_secure_dispatcher: Routine to dispatch secure PPA
> > API calls + * @idx: The PPA API index
> > + * @process: Process ID
> > + * @flag: The flag indicating criticality of operation
> > + * @nargs: Number of valid arguments out of four.
> > + * @arg1, arg2, arg3 args4: Parameters passed to secure API
> > + *
> > + * Return the non-zero error value on failure.
> > + */
> > +static u32 rx51_secure_dispatcher(u32 idx, u32 process, u32
> > flag, u32 nargs, +			   u32 arg1, u32 arg2, u32 arg3, u32
> > arg4)
> > +{
> > +	u32 ret;
> > +	u32 param[5];
> > +
> > +	param[0] = nargs+1; /* RX-51 needs number of arguments + 
1
> > */ +	param[1] = arg1;
> > +	param[2] = arg2;
> > +	param[3] = arg3;
> > +	param[4] = arg4;
> > +
> > +	/*
> > +	 * Secure API needs physical address
> > +	 * pointer for the parameters
> > +	 */
> > +	local_irq_disable();
> > +	local_fiq_disable();
> > +	flush_cache_all();
> > +	outer_clean_range(__pa(param), __pa(param + 5));
> > +	ret = omap_smc3(idx, process, flag, __pa(param));
> > +	flush_cache_all();
> > +	local_fiq_enable();
> > +	local_irq_enable();
> > +
> > +	return ret;
> > +}
> 
> I think this used to be in omap-secure.c, and then made rx51
> specific.. But since board-rx51.c is going away, let's move
> this function to omap-secure.c.
> 
> > + * rx51_secure_update_aux_cr: Routine to modify the
> > contents of Auxiliary Control Register + *  @set_bits: bits
> > to set in ACR
> > + *  @clr_bits: bits to clear in ACR
> > + *
> > + * Return the non-zero error value on failure.
> > +*/
> > +static u32 rx51_secure_update_aux_cr(u32 set_bits, u32
> > clear_bits) +{
> > +	u32 acr;
> > +
> > +	/* Read ACR */
> > +	asm volatile ("mrc p15, 0, %0, c1, c0, 1" : "=r" (acr));
> > +	acr &= ~clear_bits;
> > +	acr |= set_bits;
> > +
> > +	return rx51_secure_dispatcher(RX51_PPA_WRITE_ACR,
> > +				      0,
> > +				      FLAG_START_CRITICAL,
> > +				      1, acr, 0, 0, 0);
> > +}
> 
> This too.
> 
> >  static void __init rx51_init(void)
> >  {
> >  
> >  	struct omap_sdrc_params *sdrc_params;
> > 
> > @@ -105,6 +175,14 @@ static void __init rx51_init(void)
> > 
> >  	rx51_peripherals_init();
> >  	rx51_camera_init();
> > 
> > +	if (omap_type() == OMAP2_DEVICE_TYPE_SEC) {
> > +#ifdef CONFIG_ARM_ERRATA_430973
> > +		pr_info("RX-51: Enabling ARM errata 430973
> > workaround\n"); +		/* set IBE to 1 */
> > +		rx51_secure_update_aux_cr(BIT(6), 0);
> > +#endif
> > +	}
> > +
> > 
> >  	/* Ensure SDRC pins are mux'd for self-refresh */
> >  	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
> >  	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
> 
> Then this can be called both from board-generic.c based on the
> compatible flag, and board-rx51.c for now.
> 
> Regards,
> 
> Tony

Hi Tony,

I'm not very happy. I sent this patch 6 months ago and only now 
you commented that needs rework again. This patch is needed 
because all thumb-2 userspace binaries crashing. I want to have
working support for Nokia N900 and not always rebasing and 
changing patches. Also DT still not working on N900 (file contains 
only small subset of devices as in board files plus it is not in 
stable kernel) so I do not want to switch to DT. I need something 
which is working and not something new non-working. I belive that 
you and other kernel guys do not remove all n900 board files until 
every one line will be rewritten to DT and tested that everything 
working. And from this and other conversation it looks for me 
that you are going to do that. So please clarify what you want to 
do (and when) with board-rx51-* files. Aftethat I can decide what 
to do in future.

For now I see this situation something like: I wrote patches, 
send them to ML and after half of year maintainer politely 
rejected them becuase my patches not using new uber cool 
technology with still not working and also was not available half 
year ago. What happen if I find another time to rework this patch 
and send it again in next 2 or 5 months?

Tony, if you did not have time for review this patch months ago 
or you found it only today - no problem, I understand it. But 
what I need to know is what will happen with board-rx51-* files 
(and when?) You can see that DT does not have definitions of all 
n900 hw parts (plus it is not in last 3.11 kernel!) which means 
that DT is not usable for me and other n900 people. This also 
means that I cannot rewrite my patches for DT and test if they 
working.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130918/573a27bd/attachment-0001.sig>
