From: kmcmarti@redhat.com (Kyle McMartin)
Date: Fri, 27 Mar 2015 11:31:32 -0400
Subject: [RFC v2 0/5] arm64: kvm: reset hyp context for kexec
In-Reply-To: <1427358326-3708-1-git-send-email-takahiro.akashi@linaro.org>
References: <1427358326-3708-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20150327153131.GK12400@redacted.bos.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 05:25:21PM +0900, AKASHI Takahiro wrote:
> 1) Call kvm_cpu_reset() on non-boot cpus in reboot notifier
>    We don't have to do so in kexec-specific case. But the current code runs
>    the function on each cpu for safety since we use a general reboot hook.
> 2) Flush D$ in kvm_cpu_reset()
>    Currently doesn't do so because all the cpus are just going to shut down,
>    and we actually flush D$ on boot cpu in Geoff's cpu_reset().
> 3) Compatibility with arm implementation
>    Frediano[2] is no longer working on this issue on arm as he left his
>    company. But my approach here is based on a generic interface and can be
>    applied to arm in a similar way.
> 

i'm hitting this when rebooting with your patchset applied...

Rebooting.
[  236.260863] Kernel panic - not syncing: HYP panic:
[  236.260863] PS:600003c9 PC:000003ffffff0830 ESR:0000000096000006
[  236.260863] FAR:0000028001000018 HPFAR:          (null) PAR:          (null)
[  236.260863] VCPU:          (null)
[  236.260863]
[  236.284440] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W       4.0.0-0.rc5.git4.1.fc23.aarch64 #1
[  236.293734] Hardware name:  /Default string, BIOS ROD0074D 01/29/2015
[  236.300164] Call trace:
[  236.302610] [<fffffe0000097770>] dump_backtrace+0x0/0x150
[  236.307999] [<fffffe00000978e0>] show_stack+0x20/0x30
[  236.313044] [<fffffe0000771828>] dump_stack+0x78/0x94
[  236.318086] [<fffffe000076fdac>] panic+0xd8/0x234
[  236.322780] [<fffffe000076fcd0>] __do_kernel_fault.part.1+0x8c/0x90
[  236.329038] [<fffffe00000af94c>] kvm_cpu_reset+0x24/0x30
[  236.334342] [<fffffe00001362c8>] flush_smp_call_function_queue+0x88/0x178
[  236.341120] [<fffffe00001364dc>] generic_smp_call_function_single_interrupt+0x14/0x20
[  236.348939] [<fffffe000009db5c>] handle_IPI+0x1ac/0x220
[  236.354153] [<fffffe0000090460>] gic_handle_irq+0x88/0x90
[  236.359541] Exception stack(0xfffffe03db0f3e20 to 0xfffffe03db0f3f40)
[  236.365972] 3e20: 00000001 00000000 db0f0000 fffffe03 db0f3f60 fffffe03 000949c0 fffffe00
[  236.374138] 3e40: 000ff770 fffffe00 00000000 00000000 fe1b0b0c fffffe03 00000000 00000000
[  236.382304] 3e60: db158048 fffffe03 00000001 00000000 97c9abf3 000e5f34 ffffe700 00000000
[  236.390470] 3e80: db088f80 fffffe03 ffffe701 00000000 00000000 00000000 00000040 00000000
[  236.398636] 3ea0: 00448320 00000000 00000000 00000000 00000001 00000000 ffffffff ffffffff
[  236.406801] 3ec0: 000c5800 fffffe00 90086f40 000003ff 00000000 00000000 00000001 00000000
[  236.414967] 3ee0: db0f0000 fffffe03 00d406ec fffffe00 00d40650 fffffe00 00de4000 fffffe00
[  236.423133] 3f00: 007a9b70 fffffe00 00de33a4 fffffe00 009baf20 fffffe00 000906e0 fffffe00
[  236.431298] 3f20: 01000000 00000280 db0f3f60 fffffe03 000949bc fffffe00 db0f3f60 fffffe03
[  236.439464] [<fffffe00000934e4>] el1_irq+0x64/0xc0
[  236.444247] [<fffffe00000ff76c>] cpu_startup_entry+0x17c/0x1d0
[  236.450068] [<fffffe000009d58c>] secondary_start_kernel+0x104/0x118
[  236.456325] CPU0: stopping
[  236.459025] CPU: 0 PID: 978 Comm: reboot Tainted: G        W       4.0.0-0.rc5.git4.1.fc23.aarch64 #1
[  236.468232] Hardware name:  /Default string, BIOS ROD0074D 01/29/2015
[  236.474660] Call trace:
[  236.477099] [<fffffe0000097770>] dump_backtrace+0x0/0x150
[  236.482488] [<fffffe00000978e0>] show_stack+0x20/0x30
[  236.487529] [<fffffe0000771828>] dump_stack+0x78/0x94
[  236.492570] [<fffffe000009db90>] handle_IPI+0x1e0/0x220
[  236.497784] [<fffffe0000090460>] gic_handle_irq+0x88/0x90
[  236.503172] Exception stack(0xfffffe001869bac0 to 0xfffffe001869bbe0)
[  236.509602] bac0: 00d41788 fffffe00 fe1a4c40 fffffe03 1869bc00 fffffe00 00135e24 fffffe00
[  236.517768] bae0: 00000001 00000000 00000004 00000000 00000001 00000000 fe1c7678 fffffe03
[  236.525934] bb00: 00d42880 fffffe00 fe144680 fffffe03 0000000f 00000000 85ff2d66 feff02fe
[  236.534100] bb20: 00000000 00000000 86514a0f feff02fe ff7f7f7f 7f7f7fff 01010101 01010101
[  236.542265] bb40: 00000010 00000000 ffffffff ffffffff 00000000 ffffff00 ffffffff ffffffff
[  236.550431] bb60: 000e2b00 fffffe00 87355050 000003ff 00000000 00000000 00d41788 fffffe00
[  236.558597] bb80: fe1a4c40 fffffe03 00d42000 fffffe00 00cf4c00 fffffe00 000af928 fffffe00
[  236.566763] bba0: 00000000 00000000 00000001 00000000 00000004 00000000 00d41000 fffffe00
[  236.574928] bbc0: 18698000 fffffe00 1869bc00 fffffe00 00135dfc fffffe00 1869bc00 fffffe00
[  236.583094] [<fffffe00000934e4>] el1_irq+0x64/0xc0
[  236.587875] [<fffffe0000135f14>] on_each_cpu+0x3c/0x68
[  236.593003] [<fffffe00000af828>] kvm_reboot_notify+0x20/0x30
[  236.598655] [<fffffe00000e0b08>] notifier_call_chain+0x58/0xa0
[  236.604478] [<fffffe00000e0fe4>] __blocking_notifier_call_chain+0x54/0xa0
[  236.611255] [<fffffe00000e1068>] blocking_notifier_call_chain+0x38/0x50
[  236.617859] [<fffffe00000e27d0>] kernel_restart_prepare+0x28/0x50
[  236.623941] [<fffffe00000e28fc>] kernel_restart+0x1c/0x80
[  236.629329] [<fffffe00000e2c3c>] SyS_reboot+0x13c/0x238
[  237.542991] SMP: failed to stop secondary CPUs
[  237.547426] ---[ end Kernel panic - not syncing: HYP panic:
[  237.547426] PS:600003c9 PC:000003ffffff0830 ESR:0000000096000006
[  237.547426] FAR:0000028001000018 HPFAR:          (null) PAR:          (null)
[  237.547426] VCPU:          (null)
[  237.547426]
Boot firmware (version  built at 12:39:20 on Jan 29 2015)

regards, Kyle
