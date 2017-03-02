From: jonathanh@nvidia.com (Jon Hunter)
Date: Thu, 2 Mar 2017 15:30:26 +0000
Subject: [PATCH] arm64: restore get_current() optimisation
In-Reply-To: <20170302123507.GD19632@leverpostej>
References: <1483468021-8237-1-git-send-email-mark.rutland@arm.com>
 <ee26a4f0-e3e9-fb44-fe7c-c40a15c33b38@nvidia.com>
 <20170302123507.GD19632@leverpostej>
Message-ID: <086dff0b-126d-b5b7-e877-d3d46efce618@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 02/03/17 12:35, Mark Rutland wrote:
> On Thu, Mar 02, 2017 at 11:35:06AM +0000, Jon Hunter wrote:
>> Hi Mark,
> 
> Hi Jon,
> 
>> On 03/01/17 18:27, Mark Rutland wrote:
>>> Commit c02433dd6de32f04 ("arm64: split thread_info from task stack")
>>> inverted the relationship between get_current() and
>>> current_thread_info(), with sp_el0 now holding the current task_struct
>>> rather than the current thead_info. The new implementation of
>>> get_current() prevents the compiler from being able to optimize repeated
>>> calls to either, resulting in a noticeable penalty in some
>>> microbenchmarks.
>>>
>>> This patch restores the previous optimisation by implementing
>>> get_current() in the same way as our old current_thread_info(), using a
>>> non-volatile asm statement.
> 
>>> +/*
>>> + * We don't use read_sysreg() as we want the compiler to cache the value where
>>> + * possible.
>>> + */
>>>  static __always_inline struct task_struct *get_current(void)
>>>  {
>>> -	return (struct task_struct *)read_sysreg(sp_el0);
>>> +	unsigned long sp_el0;
>>> +
>>> +	asm ("mrs %0, sp_el0" : "=r" (sp_el0));
>>> +
>>> +	return (struct task_struct *)sp_el0;
>>>  }
>>>  
>>>  #define current get_current()
> 
>> I noticed that with v4.10 I am seeing the following panic ...
> 
> Ouch. :(
> 
> For reference, which toolchain are you using? This kind of code tends to be
> toolchain-sensitive.

This is with Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4. I have also tried ...

gcc version 5.3.1 20160412 (Linaro GCC 5.3-2016.05) 
gcc version 6.2.1 20161016 (Linaro GCC 6.2-2016.11)

... and see the same panic.
 
>> [  184.523390] Unable to handle kernel paging request at virtual address ffff8001bb7a2800
>> [  184.531316] pgd = ffff8000b96b1000
>> [  184.534711] [ffff8001bb7a2800] *pgd=0000000000000000
>> [  184.539670] Internal error: Oops: 96000005 [#1] PREEMPT SMP
> 
> That ESR_EL1 value decodes as a "Data Abort taken without a change in Exception
> level", the DFSC decodes as "Translation fault, level 1", and WnR is clear.
> 
> So we're blowing up on a read of a bogus address.
> 
>> [  184.566458] PC is at regcache_flat_read+0x14/0x20
>> [  184.571155] LR is at regcache_read+0x50/0x78
>> [  184.575417] pc : [<ffff0000085d0c6c>] lr : [<ffff0000085cefa8>] pstate: 400001c5
> 
> Judging by the PC, that read could be any of:
> 
> * the read of map->cache at the start of regcache_flat_read()
> 
> * an inlined regcache_get_index_by_order()'s read of map->reg_stride_order
> 
> * the read of cache[regcache_flat_get_index(map, reg)]
> 
> ... so it seems either map or map->cache is dodgy.
> 
> If you're can addr2line that PC, that should tell us which access is
> blowing up, and therefore which pointer is dodgy.
> 
> We'll want the full output considering inlined functions, i.e.
> 
> ${CROSS_COMPILE}addr2line -ife vmlinux 0xffff0000085d0c6c

This shows ...

regcache_flat_read
/home/jonathanh/workdir/tegra/korg-linux.git/drivers/base/regmap/regcache-flat.c:60
 
>> [  184.582802] sp : ffff8000b964b970
>> [  184.586108] x29: ffff8000b964b970 x28: ffff8000b9584800 
>> [  184.591412] x27: ffff8000b964bcc8 x26: ffff8000b9461000 
>> [  184.596716] x25: 0000000000000000 x24: 0000000000000000 
>> [  184.602019] x23: 00000000ffff8000 x22: ffff8000b964ba1c 
>> [  184.607322] x21: ffff8000b964ba1c x20: 00000000ffff8000 
>> [  184.612626] x19: ffff8000bb7dc400 x18: 0000000000000000 
>> [  184.617928] x17: 0000000000000001 x16: ffff0000081f79e8 
>> [  184.623230] x15: 0000000000497000 x14: 0000000000000000 
>> [  184.628532] x13: 0000000000000001 x12: 0000000005cc6000 
>> [  184.633835] x11: 0000000000000000 x10: ffff8000bc16bf00 
>> [  184.639138] x9 : 0000000000000000 x8 : 0000000000000000 
>> [  184.644441] x7 : ffff8000bff68908 x6 : 0000000000000000 
>> [  184.649742] x5 : ffff000008fc9f00 x4 : ffff8000bb7aa800 
>> [  184.655044] x3 : 0000000000000002 x2 : ffff8000b964ba1c 
>> [  184.660347] x1 : 000000003fffe000 x0 : 0000000000000000 
> 
>> [  185.178203] [<ffff0000085d0c6c>] regcache_flat_read+0x14/0x20
>> [  185.183939] [<ffff0000085cce60>] _regmap_read+0x98/0xe8
>> [  185.189155] [<ffff0000085cd218>] _regmap_update_bits+0xa0/0xf0
>> [  185.194978] [<ffff0000085ce1d8>] regmap_update_bits_base+0x60/0x90
>> [  185.201152] [<ffff000008856c44>] snd_soc_component_update_bits+0x24/0x40
> 
> AFAICT, these don't implicitly access current as part of generating the
> map pointer, so the dodgy pointer must have been generated above this
> level.
> 
> At this level I can't see why current would be involved at all. Beyond this
> point it's rather painful to follow the backtrace due to inlining.
> 
>> [  185.207843] [<ffff00000884e7f4>] dapm_power_widgets+0x474/0x730
>> [  185.213751] [<ffff00000884eb2c>] soc_dapm_mux_update_power.isra.29+0x7c/0xa0
>> [  185.220787] [<ffff00000884eb9c>] snd_soc_dapm_mux_update_power+0x4c/0x88
>> [  185.227479] [<ffff00000886bd04>] tegra210_xbar_put_value_enum+0x1b4/0x228
>> [  185.234256] [<ffff000008830110>] snd_ctl_elem_write+0x110/0x188
>> [  185.240165] [<ffff000008830610>] snd_ctl_ioctl+0xd0/0x798
>> [  185.245557] [<ffff0000081f7354>] do_vfs_ioctl+0xa4/0x738
>> [  185.250859] [<ffff0000081f7a74>] SyS_ioctl+0x8c/0xa0
>> [  185.255818] [<ffff000008082f30>] el0_svc_naked+0x24/0x28
>> [  185.261121] Code: 52800000 b941c883 f9410084 1ac32421 (b8615881) 
>> [  185.267223] ---[ end trace 5f6a6332822eca30 ]---
>>
>> Bisecting the panic ends up at this patch and reverting it on top of v4.10 prevents this from
>> occurring. 
>>
>> The occurs when I start playing audio on Tegra210 using tinymix. I do have some out-of-tree
>> patches for Tegra audio that I am using when seeing this but I have been using those for
>> probably a year or so, as I am gradually upstreaming bits.
>>
>> I am a bit flummoxed by the above, any thoughts?
> 
> Likewise. :/
> 
> It could just be that this happens to change the alignment/size of things, and
> unmasks a latent bug. Possibly, the removal of volatile has allowed some code
> to be reordered, highlighting missing barriers/synchronisation.
> 
> Maybe we are generating current wrong in some case, though I can't see how, and
> this is the only such report I've seen.
> 
> If the commit in question is resulting in get_current() behaving differently,
> it *might* be possible to detect with the hack below. I haven't seen it blow up
> on my test systems.

Unfortunately, that did not catch it :-(
 
> Otherwise, it might be worth giving KASAN a go; that might detect data
> corruption. If you have a recent enough toolchain, you only need enable
> CONFIG_KASAN. This will make your kernel Image a fair amount larger.

I enabled this with gcc 6.2.1 but now the PC is at __asan_load4 ...

[   19.516956] Unable to handle kernel paging request at virtual address ffff100033fcc660
[   19.524940] pgd = ffff80009c4c8000
[   19.528365] [ffff100033fcc660] *pgd=0000000000000000
[   19.533357] Internal error: Oops: 96000006 [#1] PREEMPT SMP
[   19.538949] Modules linked in:
[   19.542033] CPU: 1 PID: 1465 Comm: tinymix Not tainted 4.10.0-00018-g0db5ca31acab #3
[   19.549822] Hardware name: Google Pixel C (DT)
[   19.554289] task: ffff8000a47e0d00 task.stack: ffff8000a3818000
[   19.560239] PC is at __asan_load4+0x24/0xa0
[   19.564450] LR is at regcache_flat_read+0x40/0x68
[   19.569176] pc : [<ffff200008269f94>] lr : [<ffff200008889ec8>] pstate: 200001c5
[   19.576616] sp : ffff8000a381b5a0
[   19.579951] x29: ffff8000a381b5a0 x28: ffff2000092a4240 
[   19.585288] x27: 0000000000000000 x26: 00000000a4c19f80 
[   19.590624] x25: 0000000000000000 x24: 00000000ffff8000 
[   19.595960] x23: ffff8000a381b6c0 x22: ffff80009fe6b300 
[   19.601295] x21: ffff8000a381b6c0 x20: ffff80009f821b00 
[   19.606632] x19: 000000003fffe000 x18: 0000000000000000 
[   19.611967] x17: 0000000000000001 x16: ffff2000082ac7d0 
[   19.617302] x15: 0000000000497000 x14: ffff200008c4f2f0 
[   19.622637] x13: ffff200008c4f264 x12: ffffffffffffffff 
[   19.627972] x11: 0000000000000040 x10: 0000000000000870 
[   19.633307] x9 : ffff8000a381b5a0 x8 : 00000000f4f4f404 
[   19.638642] x7 : ffff1000147036d4 x6 : 00000000f3f3f3f3 
[   19.643976] x5 : 0000000000000000 x4 : ffff80019fe63300 
[   19.649312] x3 : ffff200008889e88 x2 : 0000000000000000 
[   19.654646] x1 : 1ffff00033fcc660 x0 : dfff200000000000 
[   19.659979] 
[   19.661494] Process tinymix (pid: 1465, stack limit = 0xffff8000a3818000)
[   19.668304] Stack: (0xffff8000a381b5a0 to 0xffff8000a381c000)
[   19.674077] b5a0: ffff8000a381b5b0 ffff200008889ec8 ffff8000a381b5e0 ffff200008886ed4
[   19.681955] b5c0: ffff80009f821b00 ffff200009b08580 00000000ffff8000 ffff8000a381b6c0
[   19.689834] b5e0: ffff8000a381b610 ffff200008883908 ffff80009f821b00 ffff80009f821b00
[   19.697711] b600: 00000000ffff8000 ffff80009f821ced ffff8000a381b650 ffff200008883fb8
[   19.705590] b620: 1ffff000147036d4 ffff8000a381b7c0 ffff80009f821b00 0000000000000000
[   19.713467] b640: 00000000ffff8000 ffff200008883f14 ffff8000a381b700 ffff2000088859cc
[   19.721344] b660: ffff80009f821b00 ffff80009f821b30 ffff80009f821bb0 0000000000000000
[   19.729222] b680: 00000000ffff8000 00000000a4c19f80 00000000ffff8000 ffff8000a381b7c0
[   19.737100] b6a0: 0000000041b58ab3 ffff2000094ee250 ffff200008883e88 ffff80009f821b30
[   19.744979] b6c0: ffff200008880c50 0000000000000000 ffff8000a381b6e0 ffff200008880c70
[   19.752856] b6e0: ffff8000a381b700 ffff2000088859a0 ffff8000a381b700 ffff2000088859ac
[   19.760733] b700: ffff8000a381b760 ffff200008c5cad4 1ffff000147036f4 ffff80009ffe5bc0
[   19.768610] b720: 00000000ffff8000 00000000a4c19f80 00000000ffff8000 ffff80009ec442a8
[   19.776489] b740: ffff8000a381bae0 ffff200009c69f80 0000000000000000 ffff200008c5cab0
[   19.784366] b760: ffff8000a381b800 ffff200008c4ed24 ffff80009ee6de00 ffff80009ec44280
[   19.792243] b780: ffff200009c6a168 ffff200009c6a228 ffff200009c6a198 ffff8000a381b8f0
[   19.800120] b7a0: 0000000041b58ab3 ffff20000953f560 ffff200008c5ca38 ffff200008c4c2f0
[   19.807997] b7c0: ffff8000a381b700 ffff8000a381b7c0 ffff200009c6a198 ffff80009f29d500
[   19.815875] b7e0: ffff200009c6a148 ffff200009c69f80 ffff8000a381b800 ffff200008c4ed0c
[   19.823754] b800: ffff8000a381b970 ffff200008c4f264 ffff80009ee6dcc8 ffff20000931e4a0
[   19.831630] b820: 0000000000000008 ffff200009c5c990 ffff80009ee8de00 ffff200009c69f80
[   19.839507] b840: ffff2000092f0d60 0000000000000002 ffff80009ee8de00 0000000000000028
[   19.847384] b860: 1ffff00014703712 ffff2000ffff8000 ffff8000a4c19f80 ffff80009ffe5bc0
[   19.855261] b880: ffff2000092a3000 0000000009b08580 0000000041b58ab3 ffff20000953f2c0
[   19.863138] b8a0: ffff200008c4e480 ffff200008883908 ffff80009ed9c110 ffff80009ed9c110
[   19.871015] b8c0: ffff8000a381b8f0 ffff200008880ca4 ffff80009f821b00 0000000000000000
[   19.878892] b8e0: ffff80009f821b30 ffff200008880c98 ffff8000a381b8f0 ffff8000a381b8f0
[   19.886769] b900: ffff8000a381b930 ffff200008c4be90 ffff80009ecabc00 ffff80009ec443a0
[   19.894647] b920: ffff80009ec44280 ffff200008c4be64 ffff8000a381b930 ffff8000a381b930
[   19.902524] b940: ffff80009ecabc00 ffff20000931e4a0 0000000000000008 ffff200009c5c990
[   19.910403] b960: ffff8000a381b970 ffff200008c4f240 ffff8000a381b9c0 ffff200008c4f2f0
[   19.918281] b980: ffff200009c69f80 ffff8000a381bae0 ffff200009c69fd0 ffff200009c6a210
[   19.926158] b9a0: ffff80009ee8de00 0000000000000001 ffff200009c5c980 ffff200008c4f2d8
[   19.934036] b9c0: ffff8000a381ba10 ffff200008c7bda0 ffff8000a381bb58 ffff2000092f0bf4
[   19.941912] b9e0: ffff8000a381bb08 00000000ff1cf313 0000000000000002 ffff200009c5c980
[   19.949790] ba00: 0000000000000001 ffff200008c7bd80 ffff8000a381bb80 ffff200008c1e9b4
[   19.957667] ba20: ffff8000a3e71100 ffff80009ee8de00 1ffff0001470377c 0000000000000055
[   19.965546] ba40: ffff80009ee8de00 ffff80009f29d500 ffff80009f29d9a0 ffff8000a441f200
[   19.973423] ba60: 0000000000000000 ffff8000a47e0d00 1ffff00014703760 0000000000000050
[   19.981301] ba80: 0000000000000001 0000000000000000 1ffff00014703758 ffff8000a3e71100
[   19.989178] baa0: ffff8000a3e71148 ffff80009ffe5ca0 ffff80009ffe5b80 0000000300000000
[   19.997056] bac0: 0000000041b58ab3 ffff2000095421a0 ffff200008c7bb40 ffff8000a441f210
[   20.004933] bae0: ffff80009ee8de00 3f30031f00000240 ffff800000000000 ffff8000a4c19f80
[   20.012810] bb00: 0000000041b58ab3 ffff20000953e4f0 ff1cf31300000440 ffff200000000000
[   20.020688] bb20: ffff8000a381bb80 ffff200008c1e86c ffff8000a3e71100 0f1f03ff00000040
[   20.028564] bb40: 1ffff00000000001 0000000000000000 0000ffffcc230cc8 ffff80009f29d500
[   20.036443] bb60: ffff80009f29d9a0 ffff8000a441f200 ffff8000a381bb80 ffff200008c1e98c
[   20.044321] bb80: ffff8000a381bc60 ffff200008c1f190 1ffff00014703798 ffff8000a3e71100
[   20.052197] bba0: ffff8000a441f200 0000000000000000 0000ffffcc230cc8 ffff80009f29d500
[   20.060076] bbc0: ffff80009f29dd70 000000000000001d ffff200008e14000 ffff200008213d04
[   20.067953] bbe0: 0000000041b58ab3 ffff20000953e4c0 ffff200008c1e7e8 0000ffffcc230cc8
[   20.075830] bc00: 0000ffffcc230cc8 ffff80009ef4aec0 ffff80009f29d500 000000000000001d
[   20.083707] bc20: ffff8000a381bc30 ffff200008213d2c ffff8000a381bc60 ffff200008c1f148
[   20.091583] bc40: 1ffff00014703798 00000000c4c85513 ffff8000a381bc60 ffff200008c1f16c
[   20.099461] bc60: ffff8000a381bd40 ffff2000082abebc 1ffff000147037b4 00000000c4c85513
[   20.107339] bc80: ffff80009cdbfb80 0000ffffcc230cc8 ffff20000929b0a0 ffff80009ef4aec0
[   20.115216] bca0: 0000000000000123 000000000000001d ffff200008e14000 014000c000000055
[   20.123094] bcc0: 0000000041b58ab3 ffff20000953e4c0 ffff200008c1f058 0000000000000000
[   20.130970] bce0: 0000000000000000 0000000000000000 0000000000000000 ffff80009c455a40
[   20.138847] bd00: ffff7e0002711570 0000000000000000 ffff8000a47e0d00 ffff8000a381bec0
[   20.146725] bd20: ffff8000a381bd30 ffff20000809f5d8 ffff8000a381bd40 ffff2000082abea4
[   20.154602] bd40: ffff8000a381be80 ffff2000082ac85c 0000000000000000 ffff80009cdbfb80
[   20.162479] bd60: ffff80009cdbfb80 0000000000000003 00000000c4c85513 0000ffffcc230cc8
[   20.170355] bd80: 0000000000000123 000000000000001d ffff200008e14000 ffff8000a47e0d00
[   20.178232] bda0: 0000000041b58ab3 ffff2000094dd808 ffff2000082abd88 ffff20000808336c
[   20.186109] bdc0: 0000000000000000 00006000b6877000 ffffffffffffffff 0000000000415230
[   20.193986] bde0: 0000000060000000 0000000000000024 0000000092000047 000000000a148018
[   20.201863] be00: 0000000041b58ab3 ffff2000094cc5c8 ffff200008081360 ffff2000094da138
[   20.209741] be20: ffff200008239b00 ffff80009e48b0f0 ffff8000a381be40 ffff2000082bd2d4
[   20.217617] be40: ffff8000a381be80 ffff2000082ac810 0000000000000000 ffff80009cdbfb80
[   20.225494] be60: ffff80009cdbfb80 0000000000000003 00000000c4c85513 ffff2000082ac7f4
[   20.233370] be80: 0000000000000000 ffff200008083730 0000000000000000 00006000b6877000
[   20.241247] bea0: ffffffffffffffff 000000000041c51c 0000000080000000 0000000000000015
[   20.249125] bec0: 0000000000000003 00000000c4c85513 0000ffffcc230cc8 0000000000000010
[   20.257002] bee0: fffffffffffffff0 0000000000000040 000000000000003f 0000000000000000
[   20.264879] bf00: 000000000000001d 0000000000000004 0101010101010101 0000000000000005
[   20.272756] bf20: ffffffffffffffff 0000000000499000 0000000000499000 0000000000497000
[   20.280634] bf40: 0000ffffcc231528 0000000000000001 0000000000000000 00000000004001a0
[   20.288510] bf60: 0000000000000000 00000000004001a0 0000000000000000 0000000000000000
[   20.296386] bf80: 000000000040559c 00000000004054e4 0000000000000000 0000000000000000
[   20.304263] bfa0: 0000000000000000 0000ffffcc230ca0 0000000000402998 0000ffffcc230ca0
[   20.312139] bfc0: 000000000041c51c 0000000080000000 0000000000000003 000000000000001d
[   20.320016] bfe0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[   20.327888] Call trace:
[   20.330358] Exception stack(0xffff8000a381b370 to 0xffff8000a381b4a0)
[   20.336821] b360:                                   000000003fffe000 0001000000000000
[   20.344698] b380: ffff8000a381b5a0 ffff200008269f94 00000000200001c5 0000000000000025
[   20.352575] b3a0: 0000000000000000 00000000a4c19f80 0000000041b58ab3 ffff2000094cc5c8
[   20.360452] b3c0: ffff200008081360 0000000000000003 ffff200009729b74 0000000000000008
[   20.368330] b3e0: ffff200008e2fec0 ffff200008e37000 ffff8000a381b400 ffff200008549b64
[   20.376208] b400: ffff8000a381b410 ffff20000811a1ec ffff8000a381b440 ffff20000811a860
[   20.384085] b420: ffff8000a381b430 ffff20000811a2cc ffff8000a381b470 ffff20000811aa60
[   20.391961] b440: 0000000000000002 ffff8000a375ef80 ffff8000bff628e0 0000000000000001
[   20.399838] b460: ffff8000a381b470 ffff20000811a988 dfff200000000000 1ffff00033fcc660
[   20.407715] b480: 0000000000000000 ffff200008889e88 ffff80019fe63300 0000000000000000
[   20.415595] [<ffff200008269f94>] __asan_load4+0x24/0xa0
[   20.420845] [<ffff200008889ec8>] regcache_flat_read+0x40/0x68
[   20.426618] [<ffff200008886ed4>] regcache_read+0x7c/0xa8
[   20.431955] [<ffff200008883908>] _regmap_read+0xd0/0x130
[   20.437292] [<ffff200008883fb8>] _regmap_update_bits+0x130/0x178
[   20.443322] [<ffff2000088859cc>] regmap_update_bits_base+0x84/0xd0
[   20.449532] [<ffff200008c5cad4>] snd_soc_component_update_bits+0x9c/0xf0
[   20.456256] [<ffff200008c4ed24>] dapm_power_widgets+0x8a4/0xd28
[   20.462199] [<ffff200008c4f264>] soc_dapm_mux_update_power.isra.29+0xbc/0xe0
[   20.469270] [<ffff200008c4f2f0>] snd_soc_dapm_mux_update_power+0x68/0xb0
[   20.475996] [<ffff200008c7bda0>] tegra210_xbar_put_value_enum+0x260/0x348
[   20.482809] [<ffff200008c1e9b4>] snd_ctl_elem_write+0x1cc/0x250
[   20.488751] [<ffff200008c1f190>] snd_ctl_ioctl+0x138/0x998
[   20.494263] [<ffff2000082abebc>] do_vfs_ioctl+0x134/0xa48
[   20.499684] [<ffff2000082ac85c>] SyS_ioctl+0x8c/0xa0
[   20.504675] [<ffff200008083730>] el0_svc_naked+0x24/0x28
[   20.510013] Code: d343fc01 aa0003e4 d2c40000 f2fbffe0 (78606822) 
[   20.516180] ---[ end trace 97433b67122c9a34 ]---

Cheers
Jon

-- 
nvpublic
