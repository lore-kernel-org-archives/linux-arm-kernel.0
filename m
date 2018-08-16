From: will.deacon@arm.com (Will Deacon)
Date: Thu, 16 Aug 2018 11:22:20 +0100
Subject: AArch64 boot failure on Hikey960 on latest master after "arm64:
 insn: Don't fallback on nosync path for general insn patching"
In-Reply-To: <462f8ae6-9948-a8e5-7504-623d40344336@iki.fi>
References: <462f8ae6-9948-a8e5-7504-623d40344336@iki.fi>
Message-ID: <20180816102219.GF31093@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tuomas, [+John]

On Thu, Aug 16, 2018 at 02:38:51AM +0300, Tuomas Tynkkynen wrote:
> Booting Linus's master of today with the usual arm64 defconfig fails for
> me on the Hikey960 board. I've bisected it down to:
> 
> commit 693350a7998018391852c48f68956cf0f855b2b9 (HEAD, refs/bisect/bad)
> Author: Will Deacon <will.deacon@arm.com>
> Date:   Tue Jun 19 17:55:28 2018 +0100
> 
>     arm64: insn: Don't fallback on nosync path for general insn patching
> 
> Here's the boot log with earlycon enabled after which the boot hangs:

Thanks for the boot log, that's really helpful. Please can you try the diff
below?

Out of interest -- do you know if Hikey960 is used by any boot-testing
farms? The patch above has been in linux-next for ages, but we didn't see
any complaints until it hit mainline :(

Cheers,

Will

--->8

diff --git a/arch/arm64/kernel/jump_label.c b/arch/arm64/kernel/jump_label.c
index c2dd1ad3e648..e0756416e567 100644
--- a/arch/arm64/kernel/jump_label.c
+++ b/arch/arm64/kernel/jump_label.c
@@ -36,7 +36,7 @@ void arch_jump_label_transform(struct jump_entry *entry,
 		insn = aarch64_insn_gen_nop();
 	}
 
-	aarch64_insn_patch_text(&addr, &insn, 1);
+	aarch64_insn_patch_text_nosync(addr, insn);
 }
 
 void arch_jump_label_transform_static(struct jump_entry *entry,
