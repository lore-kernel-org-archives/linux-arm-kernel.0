From: illusionist.neo@gmail.com (Shubham Bansal)
Date: Thu, 25 May 2017 21:42:13 +0530
Subject: [PATCH] RFC: arm: eBPF JIT compiler
In-Reply-To: <CAHgaXdKn4J==r_22T3N_7O5oESd8xwL6L+Ot8nT9bGCsSjAkHw@mail.gmail.com>
References: <1495564433-9750-1-git-send-email-illusionist.neo@gmail.com>
 <20170523204608.GG24807@lunn.ch>
 <CAHgaXdJH7VjS__KPOc1scN9d=wxzY0DEQHutiL3qhtQAWd-v-A@mail.gmail.com>
 <20170523232555.GY13759@lunn.ch>
 <CAHgaXdKn4J==r_22T3N_7O5oESd8xwL6L+Ot8nT9bGCsSjAkHw@mail.gmail.com>
Message-ID: <CAHgaXdKn_KYAxxkdhT+Bu7OMMsM=WViG0aK6RQqXfLeDErfLmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Did you get the chance to test the patch?
Best,
Shubham Bansal


On Thu, May 25, 2017 at 2:01 AM, Shubham Bansal
<illusionist.neo@gmail.com> wrote:
> Hi Andrew,
>
> I am attaching the latest patch which should work on ARMv5 , ARMv6 and ARMv7.
>
> Please test on your machines. Apologies for the last patch. This patch
> should work though.
>
> Best,
> Shubham Bansal
>
>
> On Wed, May 24, 2017 at 4:55 AM, Andrew Lunn <andrew@lunn.ch> wrote:
>> root at qnap:~# test_bpf: #0 TAX jited:0 241 466 241 PASS
>> test_bpf: #1 TXA jited:1 51 117 51 PASS
>> test_bpf: #2 ADD_SUB_MUL_K jited:0 167 PASS
>> test_bpf: #3 DIV_MOD_KX jited:0 571 PASS
>> test_bpf: #4 AND_OR_LSH_K jited:1 54 54 PASS
>> test_bpf: #5 LD_IMM_0 jited:1 45 PASS
>> test_bpf: #6 LD_IND jited:0 143 143 143 PASS
>> test_bpf: #7 LD_ABS jited:0 120 133 120 PASS
>> test_bpf: #8 LD_ABS_LL
>> Unable to handle kernel paging request at virtual address 9e096420
>> pgd = daa30000
>> [9e096420] *pgd=00000000
>> Internal error: Oops: 805 [#1] PREEMPT ARM
>> Modules linked in: test_bpf(+) [last unloaded: test_bpf]
>> CPU: 0 PID: 1886 Comm: modprobe Not tainted 4.12.0-rc2-00275-g17a0ff4ded06-dirty #1784
>> Hardware name: Marvell Kirkwood (Flattened Device Tree)
>> task: df7d4ba0 task.stack: de738000
>> PC is at imm_offset+0xa4/0x108
>> LR is at 0x8
>> pc : [<c0015080>]    lr : [<00000008>]    psr: 60000013
>> sp : de739c6c  ip : 0000002c  fp : 00000003
>> r10: de739cf8  r9 : e1356000  r8 : 0000001c
>> r7 : de59c840  r6 : de59c840  r5 : bf2c2944  r4 : 00000000
>> r3 : dedd3adc  r2 : dedd3adc  r1 : de739cf8  r0 : ffe00000
>> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
>> Control: 0005397f  Table: 1aa30000  DAC: 00000051
>> Process modprobe (pid: 1886, stack limit = 0xde738190)
>> Stack: (0xde739c6c to 0xde73a000)
>> 9c60:                            00000001 00000030 00000003 c05c5d5e c001a560
>> 9c80: de739cf4 00000000 e1356038 00000000 c05c5d34 ffe00000 c05c5d42 00000000
>> 9ca0: 00000000 0000001a e1356000 00000000 5e3b2a64 00000f04 00000000 e1356000
>> 9cc0: e1356000 c078105c 00000000 000000f8 bf2c2000 00000000 bf1661c0 c001c64c
>> 9ce0: de57f0c8 00000008 00000002 de739d54 00000eec bf2c2944 e1356000 0000001c
>> 9d00: 0000002c 00000038 00000001 00000000 de59c9a0 bf2c2944 00040008 de59c840
>> 9d20: e1356000 de739d50 de57f0c0 00000005 de59c9a0 0000ffff 00000001 c008fb98
>> 9d40: e1356000 e1356000 de57f0c0 c04a8384 00000000 00000008 e1356000 de739dd8
>> 9d60: 00000000 e1356000 00000028 de739dd4 bf165140 00000000 bf1661c0 c04a84d0
>> 9d80: 00000005 e1354000 bf1651c8 00000000 e1354000 bf2af218 dedcfd20 ffffe000
>> 9da0: df45ef80 bf1651c4 00000008 00000008 00000003 00000008 00000003 00000000
>> 9dc0: bf1650a5 bf165144 79f5179d 0000004e 00000000 e1354000 00000005 bf1651c8
>> 9de0: 00000000 ffffe000 bf2af000 00000000 de57f9e4 00000001 bf2acee0 c007aa88
>> 9e00: 00000124 c0009738 ffffffff 00000000 00000001 dfbe78b0 c07c25ac 0080007f
>> 9e20: dfbe78a4 00000000 00000000 0000001f 00000000 dffc3d60 de738000 df401f00
>> 9e40: de56b080 c007d6e0 00016acf c007aa88 bf2acee0 00000001 de59c280 00000001
>> 9e60: bf2acee0 c00a1548 00000001 de57f9c0 de739f54 00000001 de57f9c0 c007d6e8
>> 9e80: bf2aceec 00007fff bf2acee0 c007afd4 de739f48 00000000 bf2acf28 00000000
>> 9ea0: 00000000 bf2ad074 e1344928 c05c76a8 bf2aceec 00000000 de739f44 c00f6fa8
>> 9ec0: 001879a0 00000000 c00f7684 00000000 00000000 00000000 00000000 00000000
>> 9ee0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> 9f00: 00000000 00000000 7fffffff 00000000 00000003 7f59f510 0000017b c000a544
>> 9f20: de738000 00000000 00000000 c007de58 7fffffff 00000000 00000003 00000000
>> 9f40: 00000000 e11bd000 001879a0 00000000 00000874 e11bd000 001879a0 e13441d0
>> 9f60: e1343ff0 e1337960 00154550 001547c0 00000000 00000000 00000000 000014ec
>> 9f80: 0000002f 00000030 0000001b 00000000 00000015 00000000 ca81c300 7f5b2810
>> 9fa0: 00000000 c000a3a0 ca81c300 7f5b2810 00000003 7f59f510 00000000 7f59fd00
>> 9fc0: ca81c300 7f5b2810 00000000 0000017b 7f59f510 00000000 7f5b21d0 00000000
>> 9fe0: bee273a0 bee27390 7f593acc b6ed1130 60000010 00000003 00000000 00000000
>> [<c0015080>] (imm_offset) from [<c001a560>] (build_body+0x5164/0x70ec)
>> [<c001a560>] (build_body) from [<c001c64c>] (bpf_int_jit_compile+0x160/0x314)
>> [<c001c64c>] (bpf_int_jit_compile) from [<c008fb98>] (bpf_prog_select_runtime+0x14/0x124)
>> [<c008fb98>] (bpf_prog_select_runtime) from [<c04a8384>] (bpf_prepare_filter+0x7b0/0x888)
>> [<c04a8384>] (bpf_prepare_filter) from [<c04a84d0>] (bpf_prog_create+0x74/0xa4)
>> [<c04a84d0>] (bpf_prog_create) from [<bf2af218>] (test_bpf_init+0x218/0x77c [test_bpf])
>> [<bf2af218>] (test_bpf_init [test_bpf]) from [<c0009738>] (do_one_initcall+0x40/0x178)
>> [<c0009738>] (do_one_initcall) from [<c00a1548>] (do_init_module+0x58/0x1bc)
>> [<c00a1548>] (do_init_module) from [<c007d6e8>] (load_module+0x1ae0/0x2050)
>> [<c007d6e8>] (load_module) from [<c007de58>] (SyS_finit_module+0xa4/0xb8)
>> [<c007de58>] (SyS_finit_module) from [<c000a3a0>] (ret_fast_syscall+0x0/0x38)
>>
>> Looking at the .lst file:
>>
>>         /* constants go just after the epilogue */
>>         offset =  ctx->offsets[ctx->prog->len];
>> c0015054:       e591c000        ldr     ip, [r1]
>> c0015058:       e5912018        ldr     r2, [r1, #24]
>>         offset += ctx->prologue_bytes;
>>         offset += ctx->epilogue_bytes;
>> c001505c:       e1d132b0        ldrh    r3, [r1, #32]
>>         offset =  ctx->offsets[ctx->prog->len];
>> c0015060:       e59ce008        ldr     lr, [ip, #8]
>>         offset += ctx->epilogue_bytes;
>> c0015064:       e591c008        ldr     ip, [r1, #8]
>> c0015068:       0591501c        ldreq   r5, [r1, #28]
>>         offset =  ctx->offsets[ctx->prog->len];
>> c001506c:       e792210e        ldr     r2, [r2, lr, lsl #2]
>>         offset += ctx->epilogue_bytes;
>> c0015070:       e083300c        add     r3, r3, ip
>> c0015074:       e0833002        add     r3, r3, r2
>>         offset += i * 4;
>> c0015078:       e0833004        add     r3, r3, r4
>>
>>         ctx->target[offset / 4] = k;
>> c001507c:       e3c32003        bic     r2, r3, #3
>> c0015080:       e7850002        str     r0, [r5, r2]
>>
>>         /* PC in ARM mode == address of the instruction + 8 */
>>         imm = offset - (8 + ctx->idx * 4);
>>
>>         Andrew
