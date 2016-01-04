From: dcb314@hotmail.com (David Binderman)
Date: Mon, 4 Jan 2016 15:14:29 +0000
Subject: linux-4.4-rc8/arch/arm64/kernel/module.c:78: 32/64 bit problem ?
In-Reply-To: <20160104141657.GC1616@arm.com>
References: <DUB128-W158A3195DB26F149DD52E59CF20@phx.gbl>,
 <20160104141657.GC1616@arm.com>
Message-ID: <DUB128-W50B7B3ECEE2D2A6598224B9CF20@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello there Will,

----------------------------------------
> Curious, but how are you seeing this warning? GCC is silent for me...

Static analyser called cppcheck, available from sourceforge.

GCC will be silent for all sorts of dodgy code. clang produces more warnings, 
but I am not sure how much of the linux kernel it can compile. 
Hence use of cppcheck.


Regards

David Binderman

>
>> Source code is
>>
>>     u64 imm_mask = (1 << len) - 1;
>>     s64 sval = do_reloc(op, place, val);
>>
>>     switch (len) {
>>     case 16:
>>         *(s16 *)place = sval;
>>         break;
>>     case 32:
>>         *(s32 *)place = sval;
>>         break;
>>     case 64:
>>
>> So it seems that len can be 64. Suggest new code
>>
>>     u64 imm_mask = (1UL << len) - 1;
>
> That still ends up shifting by the width of the type when len == 64,
> which is potentially still broken. We're better off using GENMASK.
>
> Will
>
> --->8
>
> diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
> index f4bc779e62e8..266e7490e85c 100644
> --- a/arch/arm64/kernel/module.c
> +++ b/arch/arm64/kernel/module.c
> @@ -75,7 +75,7 @@ static u64 do_reloc(enum aarch64_reloc_op reloc_op, void *place, u64 val)
>
> static int reloc_data(enum aarch64_reloc_op op, void *place, u64 val, int len)
> {
> - u64 imm_mask = (1 << len) - 1;
> + u64 imm_mask = GENMASK(len - 1, 0);
> s64 sval = do_reloc(op, place, val);
>
> switch (len) {
 		 	   		  
