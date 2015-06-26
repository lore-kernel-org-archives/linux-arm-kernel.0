From: dirk@dmllr.de (=?UTF-8?B?RGlyayBNw7xsbGVy?=)
Date: Fri, 26 Jun 2015 23:16:00 +0200
Subject: Regular oops on shutdown of KVM/ARM64 machines with VGA device
Message-ID: <CAL5wTH4MtybHBk22r593HmVX+2jqCDm4fb2MyT2L0TMkHrD7pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

with 4.1.0 I'm hitting a frequent memory corruption. with DEBUG_VM I
was able to trace it down to this BUG().

I'm not sure how atomic_dec_and_test() can pass twice from two
different CPUs. any idea?

Thanks,
Dirk


[ 1994.829596] page dumped because: VM_BUG_ON_PAGE((*({
__attribute__((unused)) typeof((&page->_
count)->counter) __var = ( typeof((&page->_count)->counter)) 0;
(volatile typeof((&page->_count)
->counter) *)&((&page->_count)->counter); })) == 0)
[ 1994.853654] BUG: failure at ../include/linux/mm.h:364/put_page_testzero()!
[ 1994.863295] Kernel panic - not syncing: BUG!
[ 1994.914504] CPU: 4 PID: 16525 Comm: qemu-system-aar Tainted: G
  W       4.1.0-0.g5faf79
9-default #1
[ 1994.924059] Hardware name: Default string Default string/Default
string, BIOS ROD0074E 04/02/
2015
[ 1994.932919] Call trace:
[ 1994.935364] [<fffffe0000098608>] dump_backtrace+0x0/0x150
[ 1994.940754] [<fffffe0000098778>] show_stack+0x20/0x30
[ 1994.945799] [<fffffe00006b3878>] dump_stack+0x7c/0x98
[ 1994.950840] [<fffffe00006b1b84>] panic+0xdc/0x220
[ 1994.955538] [<fffffe00001c4e64>] __free_pages+0xb4/0xb8
[ 1994.960751] [<fffffe00001c5000>] free_pages+0x78/0xc0
[ 1994.965792] [<fffffe00001c5148>] free_pages_exact+0x40/0x58
[ 1994.971355] [<fffffe00000b5fd0>] kvm_free_stage2_pgd+0x38/0x50
[ 1994.977178] [<fffffe00000b3540>] kvm_arch_destroy_vm+0x28/0x68
[ 1994.983000] [<fffffe00000ac7ec>] kvm_put_kvm+0x11c/0x208
[ 1994.988301] [<fffffe00000ac8f8>] kvm_device_release+0x20/0x38
[ 1994.994038] [<fffffe00002305a4>] __fput+0x8c/0x1c8
[ 1994.998818] [<fffffe000023074c>] ____fput+0x1c/0x30
[ 1995.003686] [<fffffe00000e4d50>] task_work_run+0xb8/0xf8
[ 1995.008989] [<fffffe00000c9f00>] do_exit+0x2d8/0xa08
[ 1995.013942] [<fffffe00000ca6c0>] do_group_exit+0x40/0xe8
[ 1995.019244] [<fffffe00000d688c>] get_signal+0x3cc/0x568
[ 1995.024458] [<fffffe0000097a10>] do_signal+0x78/0x528
[ 1995.029499] [<fffffe000009810c>] do_notify_resume+0x6c/0x78
[ 1995.035065] CPU3: stopping
[ 1995.037773] CPU: 3 PID: 16099 Comm: qemu-system-aar Tainted: G
  W       4.1.0-0.g5faf79
9-default #1
[ 1995.047328] Hardware name: Default string Default string/Default
string, BIOS ROD0074E 04/02/
2015
[ 1995.056187] Call trace:
[ 1995.058629] [<fffffe0000098608>] dump_backtrace+0x0/0x150
[ 1995.064019] [<fffffe0000098778>] show_stack+0x20/0x30
[ 1995.069060] [<fffffe00006b3878>] dump_stack+0x7c/0x98
[ 1995.074102] [<fffffe00000a0368>] handle_IPI+0x1f0/0x208
[ 1995.079317] [<fffffe00000904d0>] gic_handle_irq+0x88/0x90
[ 1995.084705] Exception stack(0xfffffe03c4e5f940 to 0xfffffe03c4e5fa60)
[ 1995.091136] f940: 8a8807ff 00000082 00000000 00000001 c4e5fa80
fffffe03 000a57ac fffffe00
[ 1995.099302] f960: 89884d40 fffffe02 89890000 fffffe02 00000040
00000000 0000003f 00000000
[ 1995.107468] f980: 00810000 00000000 1e880000 00000001 8a8807ff
00000082 ffffffff 00000000
[ 1995.115635] f9a0: 00000000 00000000 00000000 00000000 00f15c00
fffffdff 00b8b7e0 fffffe00
[ 1995.123800] f9c0: 00000001 00000000 ffffffff 00000000 00000000
00000000 c4e60000 fffffe03
[ 1995.131966] f9e0: 00000005 00000000 00000001 00000000 00000007
00000000 8a8807ff 00000082
[ 1995.140132] fa00: 00000000 00000001 00000000 00000100 c3122000
fffffe03 00ae0000 fffffe00
[ 1995.148298] fa20: 00000000 00000200 20000000 00000000 ffffffff
000000ff 20000000 00000001
[ 1995.156463] fa40: c4e4f440 fffffe03 c4e5fa80 fffffe03 000b49c0
fffffe00 c4e5fa80 fffffe03
[ 1995.164629] [<fffffe00000935a4>] el1_irq+0x64/0xc0
[ 1995.169411] [<fffffe00000b4d2c>] unmap_range+0x154/0x2f0
[ 1995.174711] [<fffffe00000b5fc4>] kvm_free_stage2_pgd+0x2c/0x50
[ 1995.180533] [<fffffe00000b3540>] kvm_arch_destroy_vm+0x28/0x68
[ 1995.186355] [<fffffe00000ac7ec>] kvm_put_kvm+0x11c/0x208
[ 1995.191656] [<fffffe00000ac8f8>] kvm_device_release+0x20/0x38
[ 1995.197392] [<fffffe00002305a4>] __fput+0x8c/0x1c8
[ 1995.202172] [<fffffe000023074c>] ____fput+0x1c/0x30
[ 1995.207039] [<fffffe00000e4d50>] task_work_run+0xb8/0xf8
[ 1995.212341] [<fffffe00000c9f00>] do_exit+0x2d8/0xa08
[ 1995.217294] [<fffffe00000ca6c0>] do_group_exit+0x40/0xe8
[ 1995.222596] [<fffffe00000d688c>] get_signal+0x3cc/0x568
[ 1995.227810] [<fffffe0000097a10>] do_signal+0x78/0x528
[ 1995.232851] [<fffffe000009810c>] do_notify_resume+0x6c/0x78
PU5: stopping
[ 1995.241112] CPU: 5 PID: 0 Comm: swapper/5 Tainted: G        W
4.1.0-0.g5faf799-default #1
[ 1995.249798] Hardware name: Default string Default string/Default
string, BIOS ROD0074E 04/02/2015
[ 1995.258656] Call trace:
[ 1995.261095] [<fffffe0000098608>] dump_backtrace+0x0/0x150
[ 1995.266483] [<fffffe0000098778>] show_stack+0x20/0x30
[ 1995.271524] [<fffffe00006b3878>] dump_stack+0x7c/0x98
[ 1995.276566] [<fffffe00000a0368>] handle_IPI+0x1f0/0x208
[ 1995.281780] [<fffffe00000904d0>] gic_handle_irq+0x88/0x90
[ 1995.287167] Exception stack(0xfffffe03bf39fe10 to 0xfffffe03bf39ff30)
[ 1995.293597] fe00:                                     bf39c000
fffffe03 00ae0000 fffffe00
[ 1995.301763] fe20: bf39ff50 fffffe03 00094968 fffffe00 00108880
fffffe00 00000000 00000000
[ 1995.309929] fe40: 00000000 00000000 fe1e0b84 fffffe03 30000000
00000000 00000020 00000000
[ 1995.318095] fe60: 6080e9a5 001226ea 00018000 00000000 bf2ec240
fffffe03 000295f0 00000001
[ 1995.326260] fe80: 000fa800 00000000 00005800 00000000 00000028
00000000 c98675e8 000003ff
[ 1995.334426] fea0: c98674c0 000003ff c98675e8 000003ff 0022f6a0
fffffe00 b685c650 000003ff
[ 1995.342592] fec0: b6940150 000003ff bf39c000 fffffe03 00ae0000
fffffe00 00ae06a8 fffffe00
[ 1995.350757] fee0: 00b92000 fffffe00 00000000 00000000 bf39ff60
fffffe03 00000000 00000000
[ 1995.358922] ff00: 00a95700 fffffe00 00a80b40 fffffe00 006ea000
fffffe00 bf39ff50 fffffe03
[ 1995.367086] ff20: 00094964 fffffe00 bf39ff50 fffffe03
[ 1995.372127] [<fffffe00000935a4>] el1_irq+0x64/0xc0
[ 1995.376910] [<fffffe000010887c>] cpu_startup_entry+0x2a4/0x300
[ 1995.382732] [<fffffe000009fd48>] secondary_start_kernel+0x118/0x140
[ 1995.388988] CPU2: stopping
[ 1995.391688] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G        W
4.1.0-0.g5faf799-default #1
[ 1995.400375] Hardware name: Default string Default string/Default
string, BIOS ROD0074E 04/02/2015
[ 1995.409233] Call trace:
[ 1995.411672] [<fffffe0000098608>] dump_backtrace+0x0/0x150
[ 1995.417061] [<fffffe0000098778>] show_stack+0x20/0x30
[ 1995.422102] [<fffffe00006b3878>] dump_stack+0x7c/0x98
[ 1995.427142] [<fffffe00000a0368>] handle_IPI+0x1f0/0x208
[ 1995.432357] [<fffffe00000904d0>] gic_handle_irq+0x88/0x90
[ 1995.437744] Exception stack(0xfffffe03bf38be10 to 0xfffffe03bf38bf30)
[ 1995.444174] be00:                                     bf388000
fffffe03 00ae0000 fffffe00
[ 1995.452341] be20: bf38bf50 fffffe03 00094968 fffffe00 00108880
fffffe00 00000000 00000000
[ 1995.460507] be40: 00000000 00000000 fe150b84 fffffe03 7ce1d400
000001d0 c4f8fe30 fffffe03
[ 1995.468673] be60: a674abb5 0013f0a9 fe151c38 fffffe03 00000016
00000000 01000296 00000000
[ 1995.476839] be80: 00000000 00000000 00000040 00000000 00000002
00000000 3e018480 00000000
[ 1995.485005] bea0: 00000000 00000000 020c516f 001480ab 0022f6a0
fffffe00 82c0fa70 000003ff
[ 1995.493170] bec0: 82c00d88 000003ff bf388000 fffffe03 00ae0000
fffffe00 00ae06a8 fffffe00
[ 1995.501336] bee0: 00b92000 fffffe00 00000000 00000000 bf38bf60
fffffe03 00000000 00000000
[ 1995.509502] bf00: 00a95700 fffffe00 00a80b40 fffffe00 006ea000
fffffe00 bf38bf50 fffffe03
[ 1995.517666] bf20: 00094964 fffffe00 bf38bf50 fffffe03
[ 1995.522707] [<fffffe00000935a4>] el1_irq+0x64/0xc0
[ 1995.527489] [<fffffe000010887c>] cpu_startup_entry+0x2a4/0x300
[ 1995.533311] [<fffffe000009fd48>] secondary_start_kernel+0x118/0x140
[ 1995.539569] CPU1: stopping
[ 1995.542272] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W
4.1.0-0.g5faf799-default #1
[ 1995.550959] Hardware name: Default string Default string/Default
string, BIOS ROD0074E 04/02/2015
[ 1995.559818] Call trace:
[ 1995.562258] [<fffffe0000098608>] dump_backtrace+0x0/0x150
[ 1995.567647] [<fffffe0000098778>] show_stack+0x20/0x30
[ 1995.572688] [<fffffe00006b3878>] dump_stack+0x7c/0x98
[ 1995.577729] [<fffffe00000a0368>] handle_IPI+0x1f0/0x208
[ 1995.582943] [<fffffe00000904d0>] gic_handle_irq+0x88/0x90
[ 1995.588330] Exception stack(0xfffffe03bf38fe10 to 0xfffffe03bf38ff30)
[ 1995.594760] fe00:                                     bf38c000
fffffe03 00ae0000 fffffe00
[ 1995.602926] fe20: bf38ff50 fffffe03 00094968 fffffe00 00108880
fffffe00 00000000 00000000
[ 1995.611092] fe40: 00000000 00000000 00000000 00000000 fe120c48
fffffe03 00000001 00000000
[ 1995.619258] fe60: ece63555 001c48d0 00029600 00000001 bf2ef440
fffffe03 00029601 00000001
[ 1995.627423] fe80: 00000000 00000000 00000040 00000000 7b2b5980
fffffe00 c38cd8b0 fffffe03
[ 1995.635589] fea0: c38c9b80 fffffe03 c3fd0000 fffffe03 00000007
00000000 00000001 00000000
[ 1995.643755] fec0: 99493c28 000003ff bf38c000 fffffe03 00ae0000
fffffe00 00ae06a8 fffffe00
[ 1995.651920] fee0: 00b92000 fffffe00 00000000 00000000 bf38ff60
fffffe03 00000000 00000000
[ 1995.660086] ff00: 00a95700 fffffe00 00a80b40 fffffe00 006ea000
fffffe00 bf38ff50 fffffe03
[ 1995.668251] ff20: 00094964 fffffe00 bf38ff50 fffffe03
[ 1995.673291] [<fffffe00000935a4>] el1_irq+0x64/0xc0
[ 1995.678073] [<fffffe000010887c>] cpu_startup_entry+0x2a4/0x300
[ 1995.683895] [<fffffe000009fd48>] secondary_start_kernel+0x118/0x140
[ 1995.690150] CPU0: stopping
[ 1995.692850] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
4.1.0-0.g5faf799-default #1
[ 1995.701537] Hardware name: Default string Default string/Default
string, BIOS ROD0074E 04/02/2015
[ 1995.710396] Call trace:
[ 1995.712834] [<fffffe0000098608>] dump_backtrace+0x0/0x150
[ 1995.718223] [<fffffe0000098778>] show_stack+0x20/0x30
[ 1995.723264] [<fffffe00006b3878>] dump_stack+0x7c/0x98
[ 1995.728305] [<fffffe00000a0368>] handle_IPI+0x1f0/0x208
[ 1995.733519] [<fffffe00000904d0>] gic_handle_irq+0x88/0x90
[ 1995.738907] Exception stack(0xfffffe0000ab3dd0 to 0xfffffe0000ab3ef0)
[ 1995.745336] 3dc0:                                     00ab0000
fffffe00 00ae0000 fffffe00
[ 1995.753503] 3de0: 00ab3f10 fffffe00 00094968 fffffe00 00108880
fffffe00 00000000 00000000
[ 1995.761669] 3e00: 00000000 00000000 fe0f0b84 fffffe03 30000000
00000000 00000020 00000000
[ 1995.769835] 3e20: 8fa13295 0019e67c 00c17df8 fffffe00 00000016
00000000 01000296 00000000
[ 1995.778001] 3e40: 00000000 00000000 00000040 00000000 00000001
00000000 ffffffff 00000000
[ 1995.786167] 3e60: c3175090 fffffe03 00000000 00000000 00000006
00000000 00000001 00000000
[ 1995.794333] 3e80: 99493c28 000003ff 00ab0000 fffffe00 00ae0000
fffffe00 00ae06a8 fffffe00
[ 1995.802498] 3ea0: 00b92000 fffffe00 00000000 00000000 00ab3f20
fffffe00 00000000 00000000
[ 1995.810664] 3ec0: 00a95700 fffffe00 00a80b40 fffffe00 006ea000
fffffe00 00ab3f10 fffffe00
[ 1995.818828] 3ee0: 00094964 fffffe00 00ab3f10 fffffe00
[ 1995.823869] [<fffffe00000935a4>] el1_irq+0x64/0xc0
[ 1995.828650] [<fffffe000010887c>] cpu_startup_entry+0x2a4/0x300
[ 1995.834472] [<fffffe00006afd98>] rest_init+0x78/0x88
[ 1995.839429] [<fffffe00009c09ac>] start_kernel+0x3c4/0x3dc
