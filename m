From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Mon, 24 Sep 2018 10:06:09 +0000
Subject: [PATCH v5] ARM: mvebu: use dt_fixup to provide fallback for
 enable-method
References: <20180726034856.20743-1-chris.packham@alliedtelesis.co.nz>
 <8736u3jhc3.fsf@bootlin.com> <20180924095332.lrfobc5dhxahm6g5@localhost>
Message-ID: <63e0f13b8081419a813fba4c4d6faa8b@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/09/18 21:54, Olof Johansson wrote:
> On Fri, Sep 21, 2018 at 12:05:48PM +0200, Gregory CLEMENT wrote:
>> Hi Chris,
>>   
>>   On jeu., juil. 26 2018, Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:
>>
>>> We need to maintain backwards compatibility with device trees that don't
>>> define an enable method. At the same time we want the device tree to be
>>> able to specify an enable-method and have it stick.
>>>
>>> Previously by having smp assigned in the DT_MACHINE definition this
>>> would be picked up by setup_arch() and override whatever
>>> arm_dt_init_cpu_maps() had configured. Now we move the initial
>>> assignment of default smp_ops to a dt_fixup and let
>>> arm_dt_init_cpu_maps() override that if the device tree defines an
>>> enable-method.
>>>
>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>>
>> I made several tests on an Armada XP based board: OpenBlock AX3: I
>> modify the enable-method in the decvice tree, and I confirm that without
>> your patch it is not taken into account whereas with this patch the
>> enable-method is applied form the device tree. I also didn't see any
>> regression with the original dtb.
>>
>> So I added my:
>> Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>>
>> and applied on mvebu/soc
> 
> Hi,
> 
> Looks like this broke non-SMP. Not a huge deal, but please apply this as
> closely as possible on top of the previous patch (or squash it in).
> 
> 
> - 8< - 8< - 8< - 8< - 8< - 8< - 8< - 8< - 8< - 8< - 8< - 8< - 8< - 8< -
> 
> 
> 
>  From 3190d9502607995c7aecce79beec36714574d494 Mon Sep 17 00:00:00 2001
> From: Olof Johansson <olof@lixom.net>
> Date: Mon, 24 Sep 2018 02:37:31 -0700
> Subject: [PATCH] ARM: mvebu: fix !SMP build
> 
> Wrap set_smp_ops() in CONFIG_SMP.
> 
> Fixes: d6ec59de9a0a8 ("ARM: mvebu: use dt_fixup to provide fallback for enable-method")
> Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>   arch/arm/mach-mvebu/board-v7.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
> index 5bbde5e..0b10acd 100644
> --- a/arch/arm/mach-mvebu/board-v7.c
> +++ b/arch/arm/mach-mvebu/board-v7.c
> @@ -147,7 +147,9 @@ static void __init mvebu_dt_init(void)
>   
>   static void __init armada_370_xp_dt_fixup(void)
>   {
> +#ifdef CONFIG_SMP
>   	smp_set_ops(smp_ops(armada_xp_smp_ops));
> +#endif
>   }
>   
>   static const char * const armada_370_xp_dt_compat[] __initconst = {
> 

Makes sense to me.

Gregory, do you want me to send a v6 or are you able to squash this in?
