From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 27 Apr 2011 23:45:22 +0800
Subject: [alsa-devel] [PATCH] ASoC: prevent compilers from optimising pll
	calculation into __aeabi__uldivmod
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0497F1AA8C@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0497F1AA8C@HQMAIL01.nvidia.com>
Message-ID: <BANLkTima_RChkz07Vdno8vMt-J=KOen6rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/27 Stephen Warren <swarren@nvidia.com>:
> Barry Song wrote at Wednesday, April 27, 2011 1:28 AM:
>> The newest compiliers can optimize pll calculation in several codecs into
>> __aeabi__uldivmod which doesn't exist in kernel.
>> Then the link will fail:
>> ERROR: "__aeabi_uldivmod" [sound/soc/codecs/snd-soc-wm8974.ko] undefined!
>> ERROR: "__aeabi_uldivmod" [sound/soc/codecs/snd-soc-wm8940.ko] undefined!
>> ERROR: "__aeabi_uldivmod" [sound/soc/codecs/snd-soc-wm8510.ko] undefined!
>> This patch prevent the optimizaton by insert ASM.
>
> Aren't there compiler flags that tell gcc it isn't operating in a hosted(?)
> environment, and hence not to emit calls to these functions? If so, I
> imagine they should be added to the kernel's core (or ARM arch ) makefiles.
>
> I doubt __aeabi_uldivmod is the only function of this type. How was this
> solved for other such functions; does the kernel implement the AEABI
> functions, and this implementation is simply missing?

__aeabi_uldivmod is not implemented by kernel, others are implemented
in arch/arm/lib/lib1funcs.S:
extern void __aeabi_idiv(void);
extern void __aeabi_idivmod(void);
extern void __aeabi_lasr(void);
extern void __aeabi_llsl(void);
extern void __aeabi_llsr(void);
extern void __aeabi_lmul(void);
extern void __aeabi_uidiv(void);
extern void __aeabi_uidivmod(void);
extern void __aeabi_ulcmp(void);

>
> But yes either way, ask on the main kernel or ARM kernel mailing list
> (ARM now CC'd)
>
> diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
> index db0dced..a636b15 100644
> --- a/sound/soc/codecs/wm8510.c
> +++ b/sound/soc/codecs/wm8510.c
> @@ -258,6 +258,12 @@ static void pll_factors(unsigned int target, unsigned int source)
> ? ? ? ?Nmod = target % source;
> ? ? ? ?Kpart = FIXED_PLL_SIZE * (long long)Nmod;
>
> + ? ? ? /*
> + ? ? ? ?* The following asm() prevents the compiler from optimising
> + ? ? ? ?* into a standard EABI function __aeabi__uldivmod()
> + ? ? ? ?*/
> + ? ? ? asm("" : "+r"(source));
> +
> ? ? ? ?do_div(Kpart, source);
>
> ? ? ? ?K = Kpart & 0xFFFFFFFF;
>
> --
> nvpublic
>
>
