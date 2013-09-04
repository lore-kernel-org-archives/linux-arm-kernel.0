From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Wed, 4 Sep 2013 10:10:29 +0200
Subject: [PATCH v3 1/2] ARM: OMAP: Add secure function omap_smc3() which
 calling instruction smc #1
In-Reply-To: <2121638991.49538.1376246200421.JavaMail.apache@mail81.abv.bg>
References: <2121638991.49538.1376246200421.JavaMail.apache@mail81.abv.bg>
Message-ID: <201309041010.30090@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 11 August 2013 20:36:40 ?????? ???????? wrote:
>   >-------- ?????????? ????? --------
>  >
>  >??:  Dave Martin
>  >???????: Re: [PATCH v3 1/2] ARM: OMAP: Add secure function
>  >omap_smc3() which
> 
>  calling instruction smc #1
> 
>  >??: Pali Roh?r
>  >????????? ??: ??????????, 2013, ?????? 5 16:29:44 EEST
>  >
>  >On Sun, Aug 04, 2013 at 10:45:00AM +0200, Pali Roh?r wrote:
>  >> Here is new version (v3) of omap secure part patch:
>  >> 
>  >> Other secure functions omap_smc1() and omap_smc2() calling
>  >> instruction smc #0 but Nokia RX-51 board needs to call
>  >> smc #1 for PPA access.
>  >> 
>  >> Signed-off-by: Ivaylo Dimitrov
>  >> Signed-off-by: Pali Roh?r
>  >> ---
>  >> diff --git a/arch/arm/mach-omap2/omap-secure.h
>  >> b/arch/arm/mach-omap2/omap-secure.h index
>  >> 0e72917..c4586f4 100644
>  >> --- a/arch/arm/mach-omap2/omap-secure.h
>  >> +++ b/arch/arm/mach-omap2/omap-secure.h
>  >> @@ -51,6 +51,7 @@
>  >> 
>  >>  extern u32 omap_secure_dispatcher(u32 idx, u32 flag, u32
>  >>  nargs,
>  >>  
>  >>  				u32 arg1, u32 arg2, u32 arg3, u32 arg4);
>  >>  
>  >>  extern u32 omap_smc2(u32 id, u32 falg, u32 pargs);
>  >> 
>  >> +extern u32 omap_smc3(u32 id, u32 process, u32 flag, u32
>  >> pargs);
>  >> 
>  >>  extern phys_addr_t omap_secure_ram_mempool_base(void);
>  >>  extern int omap_secure_ram_reserve_memblock(void);
>  >> 
>  >> diff --git a/arch/arm/mach-omap2/omap-smc.S
>  >> b/arch/arm/mach-omap2/omap-smc.S index f6441c1..7bbc043
>  >> 100644
>  >> --- a/arch/arm/mach-omap2/omap-smc.S
>  >> +++ b/arch/arm/mach-omap2/omap-smc.S
>  >> @@ -1,9 +1,11 @@
>  >> 
>  >>  /*
>  >> 
>  >> - * OMAP44xx secure APIs file.
>  >> + * OMAP34xx and OMAP44xx secure APIs file.
>  >> 
>  >>   *
>  >>   * Copyright (C) 2010 Texas Instruments, Inc.
>  >>   * Written by Santosh Shilimkar
>  >>   *
>  >> 
>  >> + * Copyright (C) 2012 Ivaylo Dimitrov
>  >> + * Copyright (C) 2013 Pali Roh?r
>  >> 
>  >>   *
>  >>   * This program is free software,you can redistribute it
>  >>   and/or modify * it under the terms of the GNU General
>  >>   Public License version 2 as
>  >> 
>  >> @@ -54,6 +56,23 @@ ENTRY(omap_smc2)
>  >> 
>  >>  	ldmfd   sp!, {r4-r12, pc}
>  >>  
>  >>  ENDPROC(omap_smc2)
>  >> 
>  >> +/**
>  >> + * u32 omap_smc3(u32 service_id, u32 process_id, u32
>  >> flag, u32 pargs) + * Low level common routine for secure
>  >> HAL and PPA APIs via smc #1 + * r0 - @service_id: Secure
>  >> Service ID
>  >> + * r1 - @process_id: Process ID
>  >> + * r2 - @flag: Flag to indicate the criticality of
>  >> operation + * r3 - @pargs: Physical address of parameter
>  >> list + */
>  >> +ENTRY(omap_smc3)
>  >> +	stmfd	sp!, {r4-r11, lr}
>  >> +	mov	r12, r0		@ Copy the secure service ID
>  >> +	mov	r6, #0xff	@ Indicate new Task call
>  >> +	dsb			@ Memory Barrier
>  >
>  >Can you explain _why_ the barrier is there?  The reader
>  >doesn't need to be told that a barrier instruction is a
>  >barrier instruction.
>  >
>  >Cheers
>  >---Dave
> 
> Hi Dave,
> 
> Would quoting Santosh's explanation "DSBs were needed on OMAP
> for power sequencing." do the job? Something like "@ Needed
> on OMAP for power sequencing" instead of "@ Memory Barrier".
> 
> I want to be sure I correctly understand your requirement.
> 
> Regards,
> Ivo

Hello,

I'd like to know what happened with this patch? What is needed 
for including it into mainline? Note that without with this patch 
series Thumb-2 user space binaries crashing.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130904/79378b50/attachment-0001.sig>
