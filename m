From: ynorov@caviumnetworks.com (Yury Norov)
Date: Sun, 29 Jan 2017 17:51:25 +0530
Subject: next-20170125 hangs on aarch64
In-Reply-To: <20170129101255.GA29415@yury-N73SV>
References: <20170129101255.GA29415@yury-N73SV>
Message-ID: <20170129122125.GA20269@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 29, 2017 at 03:42:55PM +0530, Yury Norov wrote:
> Hi all,
> 
> I pulled next-20170125 kernel, and found it hanged on boot. The exact reason is
> panic on dereferencing of the 0xffffffc8 address, which is most probably the
> attempt to dereference the ENOSYS error code as the address. next-20170124 works
> fine, at least it boots.
> 
> Does anyone have details on that?
> 
> Yury

UPD:

I run qemu for testing.

The true failure backtrace is like below. The bad dereference happens for me in
arm_smccc_hvc() function in macro SMCCC.

Yury

Backtrace:

#0  0xffff00000808f7a8 in arm_smccc_hvc () at
arch/arm64/kernel/smccc-call.S:50
#1  0xffff000008745ea0 in __invoke_psci_fn_hvc (function_id=<optimized out>, arg0=<optimized out>,
    arg1=<optimized out>, arg2=<optimized out>) at drivers/firmware/psci.c:119
#2  0xffff000008745d18 in psci_migrate_info_type () at drivers/firmware/psci.c:204
#3  0xffff000008ca150c in psci_init_migrate () at drivers/firmware/psci.c:465
#4  psci_probe () at drivers/firmware/psci.c:539
#5  0xffff000008ca1684 in psci_0_2_init (np=<optimized out>) at drivers/firmware/psci.c:571
#6  0xffff000008ca16d8 in psci_dt_init () at drivers/firmware/psci.c:637
#7  0xffff000008c62914 in setup_arch (cmdline_p=<optimized out>) at arch/arm64/kernel/setup.c:287
#8  0xffff000008c6082c in start_kernel () at init/main.c:509
#9  0xffff000008c601e0 in __primary_switched () at arch/arm64/kernel/head.S:452

Listing:

 ?0xffff00000808f790 <arm_smccc_hvc>        hvc    #0x0
 ?0xffff00000808f794 <arm_smccc_hvc+4>      ldr    x4, [sp]
 ?0xffff00000808f798 <arm_smccc_hvc+8>      stp    x0, x1, [x4]          
 ?0xffff00000808f79c <arm_smccc_hvc+12>     stp x2, x3, [x4,#16]
 ?0xffff00000808f7a0 <arm_smccc_hvc+16>     ldr x4, [sp,#8] 
 ?0xffff00000808f7a4 <arm_smccc_hvc+20>     cbz x4, 0xffff00000808f7b8 <arm_smccc_hvc+40>
>?0xffff00000808f7a8 <arm_smccc_hvc+24      ldr    x9, [x4]
 ?0xffff00000808f7ac <arm_smccc_hvc+28>     cmp    x9, #0x1
 ?0xffff00000808f7b0 <arm_smccc_hvc+32>     b.ne   0xffff00000808f7b8 <arm_smccc_hvc+40>
 ?0xffff00000808f7b4 <arm_smccc_hvc+36>     str    x6, [x4,#8]
 ?0xffff00000808f7b8 <arm_smccc_hvc+40>     ret
