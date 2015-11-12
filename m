From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 12 Nov 2015 13:43:18 +0800
Subject: aarch64-linux-gnu-objdump gives all zeros in init_sequence_f[]
Message-ID: <20151112054316.GA5043@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I need some help to understand aarch64-linux-gnu-objdump output in .data
section as below.  It's part of the dump of u-boot image with command
'aarch64-linux-gnu-objdump -D -z u-boot'.

Disassembly of section .data:

0000000035039898 <reserved_list>:
	<snip>

0000000035039948 <init_sequence_f>:
    35039948:   00000000        .word   0x00000000
    3503994c:   00000000        .word   0x00000000
    35039950:   00000000        .word   0x00000000
    35039954:   00000000        .word   0x00000000
    35039958:   00000000        .word   0x00000000
    3503995c:   00000000        .word   0x00000000
    35039960:   00000000        .word   0x00000000
    35039964:   00000000        .word   0x00000000
    35039968:   00000000        .word   0x00000000
    3503996c:   00000000        .word   0x00000000
    35039970:   00000000        .word   0x00000000
    35039974:   00000000        .word   0x00000000
    35039978:   00000000        .word   0x00000000
    3503997c:   00000000        .word   0x00000000
    35039980:   00000000        .word   0x00000000
    35039984:   00000000        .word   0x00000000
    35039988:   00000000        .word   0x00000000
    3503998c:   00000000        .word   0x00000000
    35039990:   00000000        .word   0x00000000
    35039994:   00000000        .word   0x00000000
    35039998:   00000000        .word   0x00000000
    3503999c:   00000000        .word   0x00000000
    350399a0:   00000000        .word   0x00000000
    350399a4:   00000000        .word   0x00000000
    350399a8:   00000000        .word   0x00000000
    350399ac:   00000000        .word   0x00000000
    350399b0:   00000000        .word   0x00000000
    350399b4:   00000000        .word   0x00000000
    350399b8:   00000000        .word   0x00000000
    350399bc:   00000000        .word   0x00000000
    350399c0:   00000000        .word   0x00000000
    350399c4:   00000000        .word   0x00000000
    350399c8:   00000000        .word   0x00000000
    350399cc:   00000000        .word   0x00000000
    350399d0:   00000000        .word   0x00000000
    350399d4:   00000000        .word   0x00000000
    350399d8:   00000000        .word   0x00000000
    350399dc:   00000000        .word   0x00000000
    350399e0:   00000000        .word   0x00000000
    350399e4:   00000000        .word   0x00000000
    350399e8:   00000000        .word   0x00000000
    350399ec:   00000000        .word   0x00000000
    350399f0:   00000000        .word   0x00000000
    350399f4:   00000000        .word   0x00000000
    350399f8:   00000000        .word   0x00000000
    350399fc:   00000000        .word   0x00000000
    35039a00:   00000000        .word   0x00000000
    35039a04:   00000000        .word   0x00000000
    35039a08:   00000000        .word   0x00000000
    35039a0c:   00000000        .word   0x00000000
    35039a10:   00000000        .word   0x00000000
    35039a14:   00000000        .word   0x00000000
    35039a18:   00000000        .word   0x00000000
    35039a1c:   00000000        .word   0x00000000
    35039a20:   00000000        .word   0x00000000
    35039a24:   00000000        .word   0x00000000
    35039a28:   00000000        .word   0x00000000
    35039a2c:   00000000        .word   0x00000000
    35039a30:   00000000        .word   0x00000000
    35039a34:   00000000        .word   0x00000000
    35039a38:   00000000        .word   0x00000000
    35039a3c:   00000000        .word   0x00000000
    35039a40:   00000000        .word   0x00000000
    35039a44:   00000000        .word   0x00000000
    35039a48:   00000000        .word   0x00000000
    35039a4c:   00000000        .word   0x00000000

The init_sequence_f[] is an array defined in U-Boot v2015.04 source
common/board_f.c, which holds a bunch of pointers to critical
initialization functions that have to be called during boot.  Obviously,
the array cannot be all zeros like what objdump tells.  And I confirmed
that by printing the pointers at run-time as below.

init_sequence_f[0]: 0000000035004280
init_sequence_f[1]: 00000000350042a8
init_sequence_f[2]: 0000000035004380
init_sequence_f[3]: 00000000350042a0
init_sequence_f[4]: 00000000350044b8
init_sequence_f[5]: 0000000035004388
init_sequence_f[6]: 0000000035029538
init_sequence_f[7]: 000000003500675c
init_sequence_f[8]: 000000003500447c
init_sequence_f[9]: 000000003501d864
init_sequence_f[10]: 0000000035013778
init_sequence_f[11]: 0000000035004398
init_sequence_f[12]: 0000000035028ab8
init_sequence_f[13]: 0000000035004278
init_sequence_f[14]: 0000000035004270
init_sequence_f[15]: 000000003500445c
init_sequence_f[16]: 0000000035001f20
init_sequence_f[17]: 0000000035004574
init_sequence_f[18]: 00000000350042b0
init_sequence_f[19]: 00000000350042c4
init_sequence_f[20]: 00000000350042cc
init_sequence_f[21]: 00000000350042f8
init_sequence_f[22]: 00000000350044d4
init_sequence_f[23]: 000000003500430c
init_sequence_f[24]: 0000000035004314
init_sequence_f[25]: 0000000035004330
init_sequence_f[26]: 0000000035004390
init_sequence_f[27]: 00000000350045bc
init_sequence_f[28]: 0000000035004550
init_sequence_f[29]: 0000000035004518
init_sequence_f[30]: 0000000035004378
init_sequence_f[31]: 0000000035004428
init_sequence_f[32]: 00000000350043f0

Dumping an u-boot image built for 32-bit platform with
arm-linux-gnueabi-objdump gives correct pointer values for the same
array.

17853c7c <init_sequence_f>:
17853c7c:       17805600        strne   r5, [r0, r0, lsl #12]
17853c80:       17805620        strne   r5, [r0, r0, lsr #12]
17853c84:       1780574c        strne   r5, [r0, ip, asr #14]
17853c88:       178007ec        strne   r0, [r0, ip, ror #15]
17853c8c:       1780583c                        ; <UNDEFINED> instruction: 0x1780583c
17853c90:       17805834                        ; <UNDEFINED> instruction: 0x17805834
17853c94:       1780315c                        ; <UNDEFINED> instruction: 0x1780315c
17853c98:       178015f4                        ; <UNDEFINED> instruction: 0x178015f4
17853c9c:       17800890                        ; <UNDEFINED> instruction: 0x17800890
17853ca0:       17801c0c        strne   r1, [r0, ip, lsl #24]
17853ca4:       178078f8                        ; <UNDEFINED> instruction: 0x178078f8
17853ca8:       17805808        strne   r5, [r0, r8, lsl #16]
17853cac:       17829564        strne   r9, [r2, r4, ror #10]
17853cb0:       17816104        strne   r6, [r1, r4, lsl #2]
17853cb4:       1783dea4        strne   sp, [r3, r4, lsr #29]
17853cb8:       178055f8                        ; <UNDEFINED> instruction: 0x178055f8
17853cbc:       17801a54                        ; <UNDEFINED> instruction: 0x17801a54
17853cc0:       17805b4c        strne   r5, [r0, ip, asr #22]
17853cc4:       178057e0        strne   r5, [r0, r0, ror #15]
17853cc8:       178057c8        strne   r5, [r0, r8, asr #15]
17853ccc:       17802e20        strne   r2, [r0, r0, lsr #28]
17853cd0:       17805910        usada8ne        r0, r0, r9, r5
17853cd4:       17805628        strne   r5, [r0, r8, lsr #12]
17853cd8:       17805640        strne   r5, [r0, r0, asr #12]
17853cdc:       17805678                        ; <UNDEFINED> instruction: 0x17805678
17853ce0:       17805680        strne   r5, [r0, r0, lsl #13]
17853ce4:       178056b0                        ; <UNDEFINED> instruction: 0x178056b0
17853ce8:       17805850                        ; <UNDEFINED> instruction: 0x17805850
17853cec:       178056c8        strne   r5, [r0, r8, asr #13]
17853cf0:       178056dc                        ; <UNDEFINED> instruction: 0x178056dc
17853cf4:       178056f8                        ; <UNDEFINED> instruction: 0x178056f8
17853cf8:       17805768        strne   r5, [r0, r8, ror #14]
17853cfc:       17805950                        ; <UNDEFINED> instruction: 0x17805950
17853d00:       178058ec        strne   r5, [r0, ip, ror #17]
17853d04:       17805894                        ; <UNDEFINED> instruction: 0x17805894
17853d08:       17805744        strne   r5, [r0, r4, asr #14]
17853d0c:       17805798                        ; <UNDEFINED> instruction: 0x17805798
17853d10:       17805770                        ; <UNDEFINED> instruction: 0x17805770
17853d14:       00000000        andeq   r0, r0, r0

Here are my questions:

- Is this only because that ARM 64-bit toolchain doesn't show the real
  value of the pointers, or there are some linking or run-time magics to
  get these pointers correct when the binary is actually running?

- Is this different behavior between ARM 32-bit and 64-bit toolchain
  expected?  Or did I miss anything on 64-bit toolchain usage?

Any hints or comments are much appreciated.

Thanks,
Shawn
