From: leo.yan@linaro.org (leo.yan at linaro.org)
Date: Thu, 16 Aug 2018 10:25:06 +0800
Subject: AArch64 boot failure on Hikey960 on latest master after "arm64:
 insn: Don't fallback on nosync path for general insn patching"
In-Reply-To: <462f8ae6-9948-a8e5-7504-623d40344336@iki.fi>
References: <462f8ae6-9948-a8e5-7504-623d40344336@iki.fi>
Message-ID: <20180816022506.GB13920@leoy-ThinkPad-X240s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2018 at 02:38:51AM +0300, Tuomas Tynkkynen wrote:
> Hello,
> 
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

[...]

> [    0.207583] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64MMFR0_EL1. Boot CPU: 0x00000000001122, CPU4: 0x00000000101122
> [    0.207614] CPU features: Unsupported CPU feature variation detected.
> [    0.207643] BUG: scheduling while atomic: swapper/4/0/0x00000002
> [    0.207645] Modules linked in:
> [    0.207652] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G S                4.18.0-rc3-00017-g693350a79980 #17
> [    0.207654] Hardware name: HiKey960 (DT)
> [    0.207656] Call trace:
> [    0.207670]  dump_backtrace+0x0/0x150
> [    0.207674]  show_stack+0x14/0x20
> [    0.207680]  dump_stack+0x90/0xbc
> [    0.207685]  __schedule_bug+0x58/0x70
> [    0.207690]  __schedule+0x51c/0x5b0
> [    0.207693]  schedule+0x38/0xa0
> [    0.207694]  schedule_timeout+0x23c/0x340
> [    0.207698]  wait_for_common+0x140/0x170
> [    0.207701]  wait_for_completion+0x14/0x20
> [    0.207704]  __stop_cpus+0x68/0xa0
> [    0.207706]  stop_cpus+0x40/0x60
> [    0.207708]  stop_machine_cpuslocked+0xd4/0xf0
> [    0.207711]  aarch64_insn_patch_text+0x48/0x70
> [    0.207715]  arch_jump_label_transform+0x48/0x80
> [    0.207718]  __jump_label_update+0xa4/0xf0
> [    0.207721]  jump_label_update+0xe8/0x120
> [    0.207724]  static_key_enable_cpuslocked+0x7c/0xc0
> [    0.207730]  arch_timer_check_ool_workaround+0x190/0x1f0
> [    0.207732]  arch_timer_starting_cpu+0xd8/0x290
> [    0.207737]  cpuhp_invoke_callback+0x90/0x220
> [    0.207739]  notify_cpu_starting+0x68/0xa0
> [    0.207742]  secondary_start_kernel+0xe8/0x160

>From this part log, it's quite likely related with CPU4 (CA73) with
arch timer workaround ERRATUM_858921, before I reported another
similiar lockup issue: https://lkml.org/lkml/2017/7/24/346.

Thanks,
Leo Yan
