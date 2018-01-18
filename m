From: will.deacon@arm.com (Will Deacon)
Date: Thu, 18 Jan 2018 13:53:55 +0000
Subject: [PATCH v2] arm64: Branch predictor hardening for Cavium ThunderX2
In-Reply-To: <20180116234554.GA38392@jc-sabre>
References: <20180108164651.GQ25869@arm.com>
 <1515502022-7376-1-git-send-email-jnair@caviumnetworks.com>
 <e9a192da-f603-6523-6d2e-858eb9c7d1b2@jonmasters.org>
 <20180116234554.GA38392@jc-sabre>
Message-ID: <20180118135354.GB20783@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi JC,

On Tue, Jan 16, 2018 at 03:45:54PM -0800, Jayachandran C wrote:
> On Tue, Jan 16, 2018 at 04:52:53PM -0500, Jon Masters wrote:
> > On 01/09/2018 07:47 AM, Jayachandran C wrote:
> > 
> > > Use PSCI based mitigation for speculative execution attacks targeting
> > > the branch predictor. The approach is similar to the one used for
> > > Cortex-A CPUs, but in case of ThunderX2 we add another SMC call to
> > > test if the firmware supports the capability.
> > > 
> > > If the secure firmware has been updated with the mitigation code to
> > > invalidate the branch target buffer, we use the PSCI version call to
> > > invoke it.
> > 
> > What's the status of this patch currently? Previously you had suggested
> > to hold while the SMC got standardized, but then you seemed happy with
> > pulling in. What's the latest?
> 
> My understanding is that the SMC standardization is being worked on
> but will take more time, and the KPTI current patchset will go to
> mainline before that.
> 
> Given that, I would expect arm64 maintainers to pick up this patch for
> ThunderX2, but I have not seen any comments so far.
> 
> Will/Marc, please let me know if you are planning to pick this patch
> into the KPTI tree.

Are you really sure you want us to apply this? If we do, then you can't run
KVM guests anymore because your IMPDEF SMC results in an UNDEF being
injected (crash below).

I really think that you should just hook up the enable_psci_bp_hardening
callback like we've done for the Cortex CPUs. We can optimise this later
once the SMC standarisation work has been completed (which is nearly final
now and works in a backwards-compatible manner).

Will

--->8

[    0.319123] Code: 2a080042 b8236885 29008829 17ffffc0 (d4000003) 
[    0.319125] Code: 2a080042 b8236885 29008829 17ffffc0 (d4000003) 
[    0.319147] Modules linked in:
[    0.319152] CPU: 2 PID: 19 Comm: migration/2 Not tainted 4.15.0-rc8-00103-g9409c1e175be-dirty #1
[    0.319154] Hardware name: linux,dummy-virt (DT)
[    0.319156] pstate: 00000085 (nzcv daIf -PAN -UAO)
[    0.319163] pc : __arm_smccc_smc+0x0/0x2c
[    0.319166] lr : enable_tx2_psci_bp_hardening+0x6c/0x108
[    0.319167] sp : ffff000009dcbd30
[    0.319168] x29: ffff000009dcbd40 x28: 0000000000000000 
[    0.319171] x27: ffff00000803bc88 x26: 0000000000000001 
[    0.319174] x25: ffff000008d13980 x24: ffff00000907b575 
[    0.319176] x23: 0000000000000001 x22: 0000000000000000 
[    0.319179] x21: ffff00000803bd3c x20: ffff00000803bd18 
[    0.319181] x19: ffff0000089f2438 x18: 0000000000000030 
[    0.319183] x17: 0000000000000000 x16: 0000000000000000 
[    0.319185] x15: 0000000000000000 x14: 0000000000000400 
[    0.319187] x13: 0000000000000400 x12: 0000000000000000 
[    0.319189] x11: 0000000000000000 x10: 0000000000000a00 
[    0.319192] x9 : ffff000009dcbd80 x8 : ffff8001f691b460 
[    0.319194] x7 : 0000000000000000 x6 : 0000000000000000 
[    0.319196] x5 : 0000000000000000 x4 : 0000000000000000 
[    0.319198] x3 : 0000000000000000 x2 : 0000000000000000 
[    0.319200] x1 : 000000000000b0a0 x0 : 00000000c200ff00 
[    0.319203] Process migration/2 (pid: 19, stack limit = 0x000000004aa336a5)
[    0.319204] Call trace:
[    0.319207]  __arm_smccc_smc+0x0/0x2c
[    0.319211]  multi_cpu_stop+0x8c/0x110
[    0.319213]  cpu_stopper_thread+0xac/0x120
[    0.319219]  smpboot_thread_fn+0x158/0x240
[    0.319220]  kthread+0x128/0x130
[    0.319223]  ret_from_fork+0x10/0x18
[    0.319226] Code: 2a080042 b8236885 29008829 17ffffc0 (d4000003) 
[    0.319230] ---[ end trace 169f08213b3163bb ]---
[    0.319234] Internal error: undefined instruction: 0 [#2] PREEMPT SMP
[    0.319259] note: migration/2[19] exited with preempt_count 1
[    0.319284] Modules linked in:
[    0.319288] CPU: 3 PID: 24 Comm: migration/3 Tainted: G      D          4.15.0-rc8-00103-g9409c1e175be-dirty #1
[    0.319289] Hardware name: linux,dummy-virt (DT)
[    0.319291] pstate: 00000085 (nzcv daIf -PAN -UAO)
[    0.319295] pc : __arm_smccc_smc+0x0/0x2c
[    0.319298] lr : enable_tx2_psci_bp_hardening+0x6c/0x108
[    0.319298] sp : ffff000009df3d30
[    0.319300] x29: ffff000009df3d40 x28: 0000000000000000 
[    0.319303] x27: ffff00000803bc88 x26: 0000000000000001 
[    0.319305] x25: ffff000008d13980 x24: ffff00000907b575 
[    0.319307] x23: 0000000000000001 x22: 0000000000000000 
[    0.319310] x21: ffff00000803bd3c x20: ffff00000803bd18 
[    0.319312] x19: ffff0000089f2438 x18: 0000000000000030 
[    0.319314] x17: 0000000000000000 x16: 0000000000000000 
[    0.319316] x15: 0000000000000000 x14: 0000000000000400 
[    0.319318] x13: 0000000000000400 x12: 0000000000000001 
[    0.319321] x11: 000000009ad0065e x10: 0000000000000a00 
[    0.319323] x9 : ffff000009df3d80 x8 : ffff8001f691fa60 
[    0.319325] x7 : 0000000000000000 x6 : 0000000000000000 
[    0.319327] x5 : 0000000000000000 x4 : 0000000000000000 
[    0.319329] x3 : 0000000000000000 x2 : 0000000000000000 
[    0.319331] x1 : 000000000000b0a0 x0 : 00000000c200ff00 
[    0.319334] Process migration/3 (pid: 24, stack limit = 0x00000000be13f0f9)
[    0.319335] Call trace:
[    0.319338]  __arm_smccc_smc+0x0/0x2c
[    0.319340]  multi_cpu_stop+0x8c/0x110
[    0.319342]  cpu_stopper_thread+0xac/0x120
[    0.319345]  smpboot_thread_fn+0x158/0x240
[    0.319346]  kthread+0x128/0x130
[    0.319348]  ret_from_fork+0x10/0x18
[    0.319351] Code: 2a080042 b8236885 29008829 17ffffc0 (d4000003) 
[    0.319352] ---[ end trace 169f08213b3163bc ]---
[    0.319355] note: migration/3[24] exited with preempt_count 1
[    0.319371] Internal error: undefined instruction: 0 [#3] PREEMPT SMP
[    0.319373] Modules linked in:
[    0.319376] CPU: 1 PID: 14 Comm: migration/1 Tainted: G      D          4.15.0-rc8-00103-g9409c1e175be-dirty #1
[    0.319377] Hardware name: linux,dummy-virt (DT)
[    0.319379] pstate: 00000085 (nzcv daIf -PAN -UAO)
[    0.319383] pc : __arm_smccc_smc+0x0/0x2c
[    0.319385] lr : enable_tx2_psci_bp_hardening+0x6c/0x108
[    0.319386] sp : ffff000009da3d30
[    0.319387] x29: ffff000009da3d40 x28: 0000000000000000 
[    0.319390] x27: ffff00000803bc88 x26: 0000000000000001 
[    0.319393] x25: ffff000008d13980 x24: ffff00000907b575 
[    0.319395] x23: 0000000000000001 x22: 0000000000000000 
[    0.319397] x21: ffff00000803bd3c x20: ffff00000803bd18 
[    0.319399] x19: ffff0000089f2438 x18: 0000000000000030 
[    0.319402] x17: 0000000000000000 x16: 0000000000000000 
[    0.319404] x15: 0000000000000000 x14: 0000000000000400 
[    0.319406] x13: 0000000000000400 x12: 0000000000000000 
[    0.319408] x11: 0000000000000000 x10: 0000000000000a00 
[    0.319410] x9 : ffff000009da3d80 x8 : ffff8001f68e6c60 
[    0.319412] x7 : 0000000000000000 x6 : 0000000000000000 
[    0.319414] x5 : 0000000000000000 x4 : 0000000000000000 
[    0.319416] x3 : 0000000000000000 x2 : 0000000000000000 
[    0.319418] x1 : 000000000000b0a0 x0 : 00000000c200ff00 
[    0.319422] Process migration/1 (pid: 14, stack limit = 0x00000000596b9e92)
[    0.319423] Call trace:
[    0.319425]  __arm_smccc_smc+0x0/0x2c
[    0.319427]  multi_cpu_stop+0x8c/0x110
[    0.319429]  cpu_stopper_thread+0xac/0x120
[    0.319431]  smpboot_thread_fn+0x158/0x240
[    0.319433]  kthread+0x128/0x130
[    0.319435]  ret_from_fork+0x10/0x18
[    0.319437] Code: 2a080042 b8236885 29008829 17ffffc0 (d4000003) 
[    0.319439] ---[ end trace 169f08213b3163bd ]---
[    0.319441] note: migration/1[14] exited with preempt_count 1
[    0.857389] Code: 2a080042 b8236885 29008829 17ffffc0 (d4000003) 
[    0.863472] Internal error: undefined instruction: 0 [#4] PREEMPT SMP
[    0.869937] Modules linked in:
[    0.872969] CPU: 0 PID: 11 Comm: migration/0 Tainted: G      D          4.15.0-rc8-00103-g9409c1e175be-dirty #1
[    0.883064] Hardware name: linux,dummy-virt (DT)
[    0.887680] pstate: 00000085 (nzcv daIf -PAN -UAO)
[    0.892453] pc : __arm_smccc_smc+0x0/0x2c
[    0.896466] lr : enable_tx2_psci_bp_hardening+0x6c/0x108
[    0.901767] sp : ffff000009d73d30
[    0.905078] x29: ffff000009d73d40 x28: 0000000000000000 
[    0.910404] x27: ffff00000803bc88 x26: 0000000000000001 
[    0.915706] x25: ffff000008d13980 x24: ffff00000907b575 
[    0.921040] x23: 0000000000000001 x22: 0000000000000000 
[    0.926357] x21: ffff00000803bd3c x20: ffff00000803bd18 
[    0.931660] x19: ffff0000089f2438 x18: 0000000000000010 
[    0.936954] x17: 00000000ffffff80 x16: 00000000bad0c696 
[    0.942280] x15: 0000000000000000 x14: 0000000000000400 
[    0.947567] x13: 0000000000000400 x12: 0000000000000001 
[    0.952861] x11: 0000000002014024 x10: 0000000000000a00 
[    0.958179] x9 : ffff000009d73d80 x8 : ffff8001f68e1860 
[    0.963460] x7 : 0000000000000000 x6 : 0000000000000000 
[    0.968761] x5 : 0000000000000000 x4 : 0000000000000000 
[    0.974071] x3 : 0000000000000000 x2 : 0000000000000000 
[    0.979341] x1 : 000000000000b0a0 x0 : 00000000c200ff00 
[    0.984676] Process migration/0 (pid: 11, stack limit = 0x0000000054c91580)
[    0.991623] Call trace:
[    0.994062]  __arm_smccc_smc+0x0/0x2c
[    0.997749]  multi_cpu_stop+0x8c/0x110
[    1.001495]  cpu_stopper_thread+0xac/0x120
[    1.005567]  smpboot_thread_fn+0x158/0x240
[    1.009665]  kthread+0x128/0x130
[    1.012881]  ret_from_fork+0x10/0x18
[    1.016435] Code: 2a080042 b8236885 29008829 17ffffc0 (d4000003) 
[    1.022526] ---[ end trace 169f08213b3163be ]---
[    1.027146] note: migration/0[11] exited with preempt_count 1
