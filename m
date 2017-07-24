From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 24 Jul 2017 12:07:46 +0100
Subject: Alignment issues in zImage with Linux 4.12, LZ4 and GCC5.3
In-Reply-To: <CAMiSF3Bw6SvpsNkwghMx88wtEe3mfnx=4GxaVkMF3tO-sLLDoA@mail.gmail.com>
References: <CAMiSF3Bw6SvpsNkwghMx88wtEe3mfnx=4GxaVkMF3tO-sLLDoA@mail.gmail.com>
Message-ID: <CAKv+Gu8FoiZCQV6iMO-c3be7bfzTDLm4zCd4kk2Df+zdAPH6aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 July 2017 at 11:57, Romain Izard <romain.izard.pro@gmail.com> wrote:
> Hello,
>
> While upgrading the kernel from 4.9 to 4.12 for a custom board with a
> Cortex-A5 based CPU, I have encountered a compilation issue that leads to
> a data abort during the execution of the LZ4 decompression code in
> zImage.
>
> When compiling "lib/lz4/lz4_decompress.c", the output is different in
> the full kernel and in the decompression library for zImage. The
> disassembly of the LZ4_decompress_fast function looks as follows:
>
> In lib/lz4/lz4_decompress.o:
>
> 00000830 <LZ4_decompress_fast>:
>      830:    e1a0c00d     mov    ip, sp
>      834:    e92ddff0     push    {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}
>      838:    e24cb004     sub    fp, ip, #4
>      83c:    e24dd054     sub    sp, sp, #84    ; 0x54
>      840:    e300e000     movw    lr, #0
>      844:    e340e000     movt    lr, #0
>      848:    e1a04002     mov    r4, r2
>      84c:    e50b007c     str    r0, [fp, #-124]    ; 0xffffff84
>      850:    e1a0c001     mov    ip, r1
>      854:    e1a06000     mov    r6, r0
>      858:    e24b506c     sub    r5, fp, #108    ; 0x6c
>      85c:    e8be000f     ldm    lr!, {r0, r1, r2, r3}
>      860:    e3540000     cmp    r4, #0
>      864:    e08ca004     add    sl, ip, r4
>      868:    e24b404c     sub    r4, fp, #76    ; 0x4c
>      86c:    e8a5000f     stmia    r5!, {r0, r1, r2, r3}
>      870:    e89e000f     ldm    lr, {r0, r1, r2, r3}
>      874:    e28ee010     add    lr, lr, #16
>      878:    e885000f     stm    r5, {r0, r1, r2, r3}
>      87c:    e8be000f     ldm    lr!, {r0, r1, r2, r3}
>      880:    e8a4000f     stmia    r4!, {r0, r1, r2, r3}
>      884:    e89e000f     ldm    lr, {r0, r1, r2, r3}
>      888:    e884000f     stm    r4, {r0, r1, r2, r3}
>      88c:    0a0000b0     beq    b54 <LZ4_decompress_fast+0x324>
>      890:    e24ae008     sub    lr, sl, #8
>      894:    e24a400c     sub    r4, sl, #12
>      898:    e24a9007     sub    r9, sl, #7
>      89c:    e1a01006     mov    r1, r6
>      8a0:    e24a3005     sub    r3, sl, #5
>      8a4:    e50b3070     str    r3, [fp, #-112]    ; 0xffffff90
>      8a8:    e5d18000     ldrb    r8, [r1]
>      8ac:    e2811001     add    r1, r1, #1
>      8b0:    e1a05228     lsr    r5, r8, #4
>      8b4:    e355000f     cmp    r5, #15
>      8b8:    0a00002f     beq    97c <LZ4_decompress_fast+0x14c>
>      8bc:    e08c3005     add    r3, ip, r5
>      8c0:    e153000e     cmp    r3, lr
>      8c4:    8a000097     bhi    b28 <LZ4_decompress_fast+0x2f8>
>      8c8:    e2812008     add    r2, r1, #8
>      8cc:    e5126008     ldr    r6, [r2, #-8]
>      8d0:    e28cc008     add    ip, ip, #8
>      8d4:    e5120004     ldr    r0, [r2, #-4]
>      8d8:    e2822008     add    r2, r2, #8
>      8dc:    e50c6008     str    r6, [ip, #-8]
>      8e0:    e50c0004     str    r0, [ip, #-4]
>      8e4:    e153000c     cmp    r3, ip
>      8e8:    8afffff7     bhi    8cc <LZ4_decompress_fast+0x9c>
>
> In arch/arm/boot/compressed/decompress.o:
>
> 000005fc <LZ4_decompress_fast>:
>      5fc:    e1a0c00d     mov    ip, sp
>      600:    e92ddff0     push    {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}
>      604:    e24cb004     sub    fp, ip, #4
>      608:    e24dd054     sub    sp, sp, #84    ; 0x54
>      60c:    e59fc278     ldr    ip, [pc, #632]    ; 88c
> <LZ4_decompress_fast+0x290>
>      610:    e50b0078     str    r0, [fp, #-120]    ; 0xffffff88
>      614:    e1a04001     mov    r4, r1
>      618:    e08fc00c     add    ip, pc, ip
>      61c:    e1a0a002     mov    sl, r2
>      620:    e28c5020     add    r5, ip, #32
>      624:    e1a08000     mov    r8, r0
>      628:    e3520000     cmp    r2, #0
>      62c:    e24b606c     sub    r6, fp, #108    ; 0x6c
>      630:    e8bc000f     ldm    ip!, {r0, r1, r2, r3}
>      634:    e24be04c     sub    lr, fp, #76    ; 0x4c
>      638:    e084a00a     add    sl, r4, sl
>      63c:    e8a6000f     stmia    r6!, {r0, r1, r2, r3}
>      640:    e89c000f     ldm    ip, {r0, r1, r2, r3}
>      644:    e886000f     stm    r6, {r0, r1, r2, r3}
>      648:    e8b5000f     ldm    r5!, {r0, r1, r2, r3}
>      64c:    e8ae000f     stmia    lr!, {r0, r1, r2, r3}
>      650:    e895000f     ldm    r5, {r0, r1, r2, r3}
>      654:    e88e000f     stm    lr, {r0, r1, r2, r3}
>      658:    0a000083     beq    86c <LZ4_decompress_fast+0x270>
>      65c:    e24a3008     sub    r3, sl, #8
>      660:    e24a7007     sub    r7, sl, #7
>      664:    e5d89000     ldrb    r9, [r8]
>      668:    e2888001     add    r8, r8, #1
>      66c:    e1a06229     lsr    r6, r9, #4
>      670:    e356000f     cmp    r6, #15
>      674:    0a00002b     beq    728 <LZ4_decompress_fast+0x12c>
>      678:    e0845006     add    r5, r4, r6
>      67c:    e1550003     cmp    r5, r3
>      680:    8a00006e     bhi    840 <LZ4_decompress_fast+0x244>
>      684:    e2882008     add    r2, r8, #8
>      688:    e9120003     ldmdb    r2, {r0, r1}
>      68c:    e2822008     add    r2, r2, #8
>      690:    e8840003     stm    r4, {r0, r1}
>      694:    e2844008     add    r4, r4, #8
>      698:    e1550004     cmp    r5, r4
>      69c:    8afffff9     bhi    688 <LZ4_decompress_fast+0x8c>
>
> In the second case, we can see LDM and STM instructions at addresses
> 0x688 and 0x690. As r2 does not always contain an aligned address, a
> data abort will be generated during decompression.
>
> The compilation options are a little different between both cases:
> The library is built with -O3, whereas the zImage decompressor is built
> with -O2, -DDISABLE_BRANCH_PROFILING, -fpic, -mno-single-pic-base,
> -fno-builtin. All other compilation options are shared in both cases.
>
> For Linux 4.9, the LZ4 decompressor code is completely different, which
> explains why the issue appeared when changing kernel versions.
>

I see some void* to u32* casts in the new code, which makes me think
that it is perhaps not valid C, and has maybe not been tested on an
architecture that has stricter alignment requirements than x86?

> This issue has been detected with a GCC5.3 compiler generated with
> crosstool-NG, with cortex-a5 CPU tuning. If I build with the GCC6.3
> from my workstation's distribution, and pass '-mcpu=cortex-a5' as a
> compilation option for the kernel, I do not see this problem.
>
