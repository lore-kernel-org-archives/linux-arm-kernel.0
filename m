From: mgherzan@gmail.com (Mircea Gherzan)
Date: Wed, 21 Dec 2011 16:59:13 +0200
Subject: [PATCH v2] ARM: net: JIT compiler for packet filters
In-Reply-To: <20111219182908.GA2027@linaro.org>
References: <1324284030-25540-1-git-send-email-mgherzan@gmail.com>
 <20111219125021.GA2031@linaro.org>
 <20111219164513.GA25105@swarm.cs.pub.ro>
 <20111219181839.GH2031@linaro.org>
 <20111219182908.GA2027@linaro.org>
Message-ID: <20111221145913.GC3229@swarm.cs.pub.ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 06:29:08PM +0000, Dave Martin wrote:
> On Mon, Dec 19, 2011 at 06:18:39PM +0000, Dave Martin wrote:
> > On Mon, Dec 19, 2011 at 06:45:13PM +0200, Mircea Gherzan wrote:
> 
> [...]
> 
> > > The JITed code calls back to the kernel for the load helpers. So setting
> > > bit 0 is required.
> > 
> > When you take the address of a link-time external function symbol,
> > bit[0] in the address will automatically be set appropriately by the
> > linker to indicate the target instruction set -- you already use BX/BLX
> > to jump to such symbols, so you should switch correctly when calling
> > _to_ the kernel.
> > 
> > Returns should also work, except for old-style "mov pc,lr" returns made
> > in Thumb code (from ARM code, this magically works for >= v7).  Such returns
> > only happen in hand-written assembler: for C code, the compiler always
> > generates proper AEABI-compliant return sequences.
> > 
> > So, for calling load_func[], jit_get_skb_b etc. (which are C functions),
> > there should be no problem.
> > 
> > I think the only code which you call from the JIT output but which does
> > not return compliantly is __aeabi_uidiv() in arch/arm/lib/lib1funcs.S.
> > 
> > 
> > I have a quick hacked-up patch (below) which attempts to fix this;
> > I'd be interested if this works for you  -- but finalising your ARM-only
> > version of the patch should still be the priority.
> > 
> > If this fix does work, I'll turn it into a proper patch, as we can maybe
> > use it more widely.
> 
> Oops, I forgot to paste in my patch ... here it is.
> 
> Cheers
> ---Dave
> 
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index b6e65de..013bfaf 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -313,4 +313,39 @@
>  	.size \name , . - \name
>  	.endm
>  
> +/*
> + * Helper macro to abstract a function return, where the return address is
> + * held in a register:
> + */
> +.macro __def_bret cc
> +	.macro bret\cc Rm:req
> +#if __LINUX_ARM_ARCH__ < 7
> +		mov\cc	pc, \Rm
> +#else
> +		bx\cc	\Rm
> +#endif

This patch worked for me, because I'm using ARMv7 exclusively. But I'm
inclined to think that your patch will fail on ARMv6T (for example) with
a Thumb2 kernel, because the "mov pc, Rm" is a simple branch on pre-v7
cores.

Note however that v3 of my patch no longer requires any changes to the
assembly code: the C trampoline/wrapper for integer division ensures a
proper return. And this one is used only for the DIV_X BPF opcode, which
appears also quite rarely.

[...]

Cheers,
Mircea
