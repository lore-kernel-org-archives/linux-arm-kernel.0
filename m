From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Wed, 27 Apr 2016 21:44:17 +0530
Subject: [PATCH] dmaengine: pl330: Fix race in pl330_get_desc()
In-Reply-To: <5720C301.1020707@arm.com>
References: <bc03a8073460ebac253b80466d11654ee81f540e.1461687536.git.robin.murphy@arm.com>
 <CABb+yY3JG=XyJekz==VYF+w7ptDBwgMyVJMHzO-uM_ynXKOcaA@mail.gmail.com>
 <5720C301.1020707@arm.com>
Message-ID: <CAJe_Zhc-ueMEi9mnW2VKQP8CD6LYXywbpQHP-Gv=aOV-ww=Syg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 April 2016 at 19:17, Robin Murphy <robin.murphy@arm.com> wrote:

>> Instead of churning the code, I would suggest either check in a loop
>> that we have a desc OR allocate 2 or NR_DEFAULT_DESC descriptors
>> there. Probably we get more descriptors at the same cost of memory.
>
>
> Having had a quick look into how beneficial that might be, I discover that
> what's provoking the add_desc() race is something else causing
> desc_pool->head to get wedged pointing at itself, so list_empty() forever
> returns true and we kick off a storm of allocations while desc_pool->tail
> fills up with unused descriptors. Looks like I'm going to have to set aside
> some time to properly debug and fix this driver if I want to use it for
> stress-testing IOMMU code...
>
OK, thanks.
And yes, we still need to fix that potential race in pl330_get_desc,
probably by retrying in a loop.

>>>
>>> I'm also seeing what looks like another occasional race under the same
>>> conditions where pl330_tx_submit() blows up from dma_cookie_assign()
>>> dereferencing a bogus tx->chan, but I think that's beyond my ability to
>>> figure out right now. Similarly the storm of WARNs from
>>> pl330_issue_pending()
>>> when using a large number of small buffers and dmatest.noverify=1. This
>>> one was some obvious low-hanging fruit.
>>>
>> Sorry, that part of code has changed a lot since I wrote the driver,
>> so more details will help me.
>
>
> Here's the actual splat:
>
> [  220.649267] Unable to handle kernel paging request at virtual address
> 100341338
> [  220.666576] pgd = ffffff8008dcb000
> [  220.679805] [100341338] *pgd=0000000000000000, *pud=0000000000000000
> [  220.696116] Internal error: Oops: 96000005 [#1] PREEMPT SMP
> [  220.711579] Modules linked in:
> [  220.724459] CPU: 3 PID: 1249 Comm: dma0chan5-copy0 Not tainted 4.6.0-rc4+
> #527
> [  220.741652] Hardware name: ARM Juno development board (r1) (DT)
> [  220.757512] task: ffffffc976255400 ti: ffffffc975aa4000 task.ti:
> ffffffc975aa4000
> [  220.774979] PC is at pl330_tx_submit+0x68/0x108
> [  220.789412] LR is at pl330_tx_submit+0x2c/0x108
> [  220.803704] pc : [<ffffff80083dae08>] lr : [<ffffff80083dadcc>] pstate:
> 800001c5
> [  220.821078] sp : ffffffc975aa7c90
> [  220.834236] x29: ffffffc975aa7c90 x28: ffffffc975e81800
> [  220.849303] x27: ffffffc97626c018 x26: ffffff8008cd9000
> [  220.864314] x25: 0000000000000000 x24: 0000000000000000
> [  220.879300] x23: ffffff8008d8d410 x22: ffffff8008ce52f0
> [  220.894266] x21: ffffffc976220d18 x20: ffffffc079138610
> [  220.909139] x19: ffffffc976220c60 x18: 0000000000000010
> [  220.923857] x17: 0000000000000007 x16: 0000000000000001
> [  220.938418] x15: 0000000000000001 x14: 0001020304050607
> [  220.952886] x13: 08090a0b0c0d0e0f x12: 1011121314151617
> [  220.967305] x11: 18191a1b1c1d1e1f x10: 0001020304050607
> [  220.981603] x9 : 0000000000000000 x8 : 0000000000000010
> [  220.995783] x7 : 0000000000000001 x6 : ffffffc976220ce0
> [  221.009899] x5 : 0000000100341330 x4 : ffffffc079138600
> [  221.023775] x3 : 0000000000000000 x2 : ffffffc97626c158
> [  221.037417] x1 : ffffffc97636a790 x0 : 0000000000000140
> [  221.050845]
> [  221.060126] Process dma0chan5-copy0 (pid: 1249, stack limit =
> 0xffffffc975aa4020)
> [  221.075704] Stack: (0xffffffc975aa7c90 to 0xffffffc975aa8000)
> [  221.089574] 7c80:                                   ffffffc975aa7cd0
> ffffff80083d9e60
> [  221.105653] 7ca0: ffffffc9758b88c0 0000000000002b12 00000000000020b8
> ffffff8008ce52f0
> [  221.121765] 7cc0: 00000000f9f82b12 ffffffc0790e5b00 ffffffc975aa7e30
> ffffff80080d7138
> [  221.137833] 7ce0: ffffffc975e81780 ffffff8008d90b00 ffffff8008af0d40
> ffffffc975e81800
> [  221.153811] 7d00: ffffff80083d91c0 0000000000000000 0000000000000000
> 0000000000000000
> [  221.169777] 7d20: 0000000000000000 0000000000000000 ffffff8008ca7000
> 000000323ef9fd9c
> [  221.185714] 7d40: 0000000000000008 ffffffc975aa7e20 ffffff8008b265d8
> 0000000000000000
> [  221.201753] 7d60: 0000000000000010 0000000000000000 0000000175aa7dc0
> 0000000000000000
> [  221.217898] 7d80: 0000000000000259 0000000000000001 ffffff8008b265f0
> ffffffc9758b88e8
> [  221.234155] 7da0: ffffff8000002b12 ffffffc975aa7cd0 ffffffc976220c88
> 00000000005d99c3
> [  221.250577] 7dc0: 0000000000000001 000002f400000259 ffffff8008d12be0
> ffffffc975aa7cc0
> [  221.267166] 7de0: 0000000000000000 ffffffc975aa7df0 ffffff800bcc0bcc
> ffffffc975aa7df8
> [  221.283840] 7e00: ffffffc975aa7df8 c5b6eabfb5a2c4b8 ffffffc900000000
> ffffff80080f2048
> [  221.300672] 7e20: ffffffc975aa7e20 ffffffc975aa7e20 0000000000000000
> ffffff8008085e10
> [  221.317405] 7e40: ffffff80080d7068 ffffffc975e81780 0000000000000000
> 0000000000000000
> [  221.334211] 7e60: 0000000000000000 ffffff80080df900 ffffff80080d7068
> 0000000000000000
> [  221.351119] 7e80: 0000000000000000 ffffffc975e81800 0000000000000000
> 0000000000000000
> [  221.368086] 7ea0: ffffffc975aa7ea0 ffffffc975aa7ea0 0000000000000000
> ffffff8000000000
> [  221.385128] 7ec0: ffffffc975aa7ec0 ffffffc975aa7ec0 0000000000000000
> 0000000000000000
> [  221.402194] 7ee0: 0000000000000000 0000000000000000 0000000000000000
> 0000000000000000
> [  221.419345] 7f00: 0000000000000000 0000000000000000 0000000000000000
> 0000000000000000
> [  221.436492] 7f20: 0000000000000000 0000000000000000 0000000000000000
> 0000000000000000
> [  221.453629] 7f40: 0000000000000000 0000000000000000 0000000000000000
> 0000000000000000
> [  221.470764] 7f60: 0000000000000000 0000000000000000 0000000000000000
> 0000000000000000
> [  221.487893] 7f80: 0000000000000000 0000000000000000 0000000000000000
> 0000000000000000
> [  221.505008] 7fa0: 0000000000000000 0000000000000000 0000000000000000
> 0000000000000000
> [  221.522116] 7fc0: 0000000000000000 0000000000000000 0000000000000000
> 0000000000000005
> [  221.539221] 7fe0: 0000000000000000 0000000000000000 88898a8b8c8d8e8f
> 8081828384858687
> [  221.556415] Call trace:
> [  221.568286] Exception stack(0xffffffc975aa7ad0 to 0xffffffc975aa7bf0)
> [  221.584423] 7ac0:                                   ffffffc976220c60
> ffffffc079138610
> [  221.602172] 7ae0: ffffffc975aa7c90 ffffff80083dae08 ffffffc976812d00
> ffffffc976aa2600
> [  221.620055] 7b00: ffffffc975aa7b30 ffffff80080ebfa0 ffffffc975aa7b30
> ffffff80080ec050
> [  221.638012] 7b20: 00000000ffffb237 ffffffc976255400 ffffffc975aa7bd0
> ffffff8008881408
> [  221.656053] 7b40: ffffff8008ca7000 ffffff8008cd9000 ffffffc97feef380
> ffffffc976255400
> [  221.674207] 7b60: ffffffc975aa7b90 ffffff80080e6fb8 0000000000000140
> ffffffc97636a790
> [  221.692454] 7b80: ffffffc97626c158 0000000000000000 ffffffc079138600
> 0000000100341330
> [  221.710838] 7ba0: ffffffc976220ce0 0000000000000001 0000000000000010
> 0000000000000000
> [  221.729306] 7bc0: 0001020304050607 18191a1b1c1d1e1f 1011121314151617
> 08090a0b0c0d0e0f
> [  221.747943] 7be0: 0001020304050607 0000000000000001
> [  221.763694] [<ffffff80083dae08>] pl330_tx_submit+0x68/0x108
> [  221.780284] [<ffffff80083d9e60>] dmatest_func+0xca0/0x1248
> [  221.796853] [<ffffff80080d7138>] kthread+0xd0/0xe8
> [  221.812785] [<ffffff8008085e10>] ret_from_fork+0x10/0x40
> [  221.829336] Code: f9402083 f9002043 f9401045 3902205f (b94008a3)
> [  221.846910] ---[ end trace a413951a16f706c7 ]---
>
> The faulting instruction is the initial access to chan->cookie in
> dma_cookie_assign(), and tx->chan (x5 here) seems to always be 0x100341330,
> implying that tx is pointing somewhere near a struct pl330_config because
> that 'address' is clearly the first two words of one of those (.periph_id,
> .mode). I'm going to have to put this to one side for now and maybe come
> back to it later, but I thought it was worth mentioning just in case it
> looked familiar to anyone. I can usually hit it within a couple of runs of
> dmatest with 8 channels, threads_per_chan=6, test_buf_size=16384 and
> iterations=5000 (the point of which, if anyone's wondering, is to batter the
> TLBs of the downstream SMMU with recycled addresses as much as possible).
>
I have had it tested just as well on some old platform and I didn't
hit the issue.
Let me try if I can guess where the problem is, which might
'disappear' when we fix the real problem that this patch intended to
fix.

Thanks.
