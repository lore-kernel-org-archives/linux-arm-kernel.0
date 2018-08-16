From: valentin.schneider@arm.com (Valentin Schneider)
Date: Thu, 16 Aug 2018 14:58:59 +0100
Subject: AArch64 boot failure on Hikey960 on latest master after "arm64:
 insn: Don't fallback on nosync path for general insn patching"
In-Reply-To: <20180816102219.GF31093@arm.com>
References: <462f8ae6-9948-a8e5-7504-623d40344336@iki.fi>
 <20180816102219.GF31093@arm.com>
Message-ID: <6490931d-65b6-e524-f2d0-65cbac0a263b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 16/08/18 11:22, Will Deacon wrote:
> Hi Tuomas, [+John]
> 
> On Thu, Aug 16, 2018 at 02:38:51AM +0300, Tuomas Tynkkynen wrote:
>> Booting Linus's master of today with the usual arm64 defconfig fails for
>> me on the Hikey960 board. I've bisected it down to:
>>
>> commit 693350a7998018391852c48f68956cf0f855b2b9 (HEAD, refs/bisect/bad)
>> Author: Will Deacon <will.deacon@arm.com>
>> Date:   Tue Jun 19 17:55:28 2018 +0100
>>
>>     arm64: insn: Don't fallback on nosync path for general insn patching
>>
>> Here's the boot log with earlycon enabled after which the boot hangs:
> 
> Thanks for the boot log, that's really helpful. Please can you try the diff
> below?
> 

I get the same "BUG: scheduling while atomic" when running the current master
(f91e654474d413201ae578820fb63f8a811f6c4e), and confirmed that I don't get
it on my setup when checking out the direct parent of 693350a7998018391852c48f68956cf0f855b2b9.

Tried out the diff and the board doesn't seem to die anymore, so FWIW:

Tested-by: Valentin Schneider <valentin.schneider@arm.com>

> Out of interest -- do you know if Hikey960 is used by any boot-testing
> farms? The patch above has been in linux-next for ages, but we didn't see
> any complaints until it hit mainline :(
> 
> Cheers,
> 
> Will
> 
> --->8
> 
> diff --git a/arch/arm64/kernel/jump_label.c b/arch/arm64/kernel/jump_label.c
> index c2dd1ad3e648..e0756416e567 100644
> --- a/arch/arm64/kernel/jump_label.c
> +++ b/arch/arm64/kernel/jump_label.c
> @@ -36,7 +36,7 @@ void arch_jump_label_transform(struct jump_entry *entry,
>  		insn = aarch64_insn_gen_nop();
>  	}
>  
> -	aarch64_insn_patch_text(&addr, &insn, 1);
> +	aarch64_insn_patch_text_nosync(addr, insn);
>  }
>  
>  void arch_jump_label_transform_static(struct jump_entry *entry,
> 
