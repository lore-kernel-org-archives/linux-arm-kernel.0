From: lkp@intel.com (kbuild test robot)
Date: Tue, 15 May 2018 03:23:11 +0800
Subject: [arm:to-build 14/17] arch/arm/crypto/ghash-ce-core.S:58: Error:
 Missing value for required parameter `limit' of macro `mask'
Message-ID: <201805150309.ygI8eyIQ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

First bad commit (maybe != root cause):

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git to-build
head:   645e28666dcc94625fa28a8f18338dbc46f9f35d
commit: 25dc994b00089f8fc233b4b0475c851790d768b9 [14/17] ARM: spectre-v1: add speculative safe mask and csdb macros
config: arm-omap2plus_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 25dc994b00089f8fc233b4b0475c851790d768b9
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/crypto/ghash-ce-core.S: Assembler messages:
>> arch/arm/crypto/ghash-ce-core.S:58: Error: Missing value for required parameter `limit' of macro `mask'
>> arch/arm/crypto/ghash-ce-core.S:58: Error: Missing value for required parameter `limit' of macro `mask'
>> arch/arm/crypto/ghash-ce-core.S:58: Error: ARM register expected -- `sub .req,d28,'
>> arch/arm/crypto/ghash-ce-core.S:58: Error: ARM register expected -- `bic .req,.req,d28'
>> arch/arm/crypto/ghash-ce-core.S:58: Error: ARM register expected -- `and .req,d28,.req,asr#31'
>> arch/arm/crypto/ghash-ce-core.S:218: Error: parse error -- `vmov.i8 MASK,#0xe1'
>> arch/arm/crypto/ghash-ce-core.S:219: Error: Neon double or quad precision register expected -- `vshl.u64 MASK,MASK,#57'
>> arch/arm/crypto/ghash-ce-core.S:221: Error: VFP/Neon double precision register expected -- `vmull.p64 T1,XL_L,MASK'
>> arch/arm/crypto/ghash-ce-core.S:221: Error: VFP/Neon double precision register expected -- `vmull.p64 XL,T1_H,MASK'

vim +58 arch/arm/crypto/ghash-ce-core.S

f1e866b1 Ard Biesheuvel 2015-03-10   13  
f1e866b1 Ard Biesheuvel 2015-03-10   14  	SHASH		.req	q0
3759ee05 Ard Biesheuvel 2017-07-24   15  	T1		.req	q1
3759ee05 Ard Biesheuvel 2017-07-24   16  	XL		.req	q2
3759ee05 Ard Biesheuvel 2017-07-24   17  	XM		.req	q3
3759ee05 Ard Biesheuvel 2017-07-24   18  	XH		.req	q4
3759ee05 Ard Biesheuvel 2017-07-24   19  	IN1		.req	q4
f1e866b1 Ard Biesheuvel 2015-03-10   20  
f1e866b1 Ard Biesheuvel 2015-03-10   21  	SHASH_L		.req	d0
f1e866b1 Ard Biesheuvel 2015-03-10   22  	SHASH_H		.req	d1
3759ee05 Ard Biesheuvel 2017-07-24   23  	T1_L		.req	d2
3759ee05 Ard Biesheuvel 2017-07-24   24  	T1_H		.req	d3
3759ee05 Ard Biesheuvel 2017-07-24   25  	XL_L		.req	d4
3759ee05 Ard Biesheuvel 2017-07-24   26  	XL_H		.req	d5
3759ee05 Ard Biesheuvel 2017-07-24   27  	XM_L		.req	d6
3759ee05 Ard Biesheuvel 2017-07-24   28  	XM_H		.req	d7
3759ee05 Ard Biesheuvel 2017-07-24   29  	XH_L		.req	d8
3759ee05 Ard Biesheuvel 2017-07-24   30  
3759ee05 Ard Biesheuvel 2017-07-24   31  	t0l		.req	d10
3759ee05 Ard Biesheuvel 2017-07-24   32  	t0h		.req	d11
3759ee05 Ard Biesheuvel 2017-07-24   33  	t1l		.req	d12
3759ee05 Ard Biesheuvel 2017-07-24   34  	t1h		.req	d13
3759ee05 Ard Biesheuvel 2017-07-24   35  	t2l		.req	d14
3759ee05 Ard Biesheuvel 2017-07-24   36  	t2h		.req	d15
3759ee05 Ard Biesheuvel 2017-07-24   37  	t3l		.req	d16
3759ee05 Ard Biesheuvel 2017-07-24   38  	t3h		.req	d17
3759ee05 Ard Biesheuvel 2017-07-24   39  	t4l		.req	d18
3759ee05 Ard Biesheuvel 2017-07-24   40  	t4h		.req	d19
3759ee05 Ard Biesheuvel 2017-07-24   41  
3759ee05 Ard Biesheuvel 2017-07-24   42  	t0q		.req	q5
3759ee05 Ard Biesheuvel 2017-07-24   43  	t1q		.req	q6
3759ee05 Ard Biesheuvel 2017-07-24   44  	t2q		.req	q7
3759ee05 Ard Biesheuvel 2017-07-24   45  	t3q		.req	q8
3759ee05 Ard Biesheuvel 2017-07-24   46  	t4q		.req	q9
3759ee05 Ard Biesheuvel 2017-07-24   47  	T2		.req	q9
3759ee05 Ard Biesheuvel 2017-07-24   48  
3759ee05 Ard Biesheuvel 2017-07-24   49  	s1l		.req	d20
3759ee05 Ard Biesheuvel 2017-07-24   50  	s1h		.req	d21
3759ee05 Ard Biesheuvel 2017-07-24   51  	s2l		.req	d22
3759ee05 Ard Biesheuvel 2017-07-24   52  	s2h		.req	d23
3759ee05 Ard Biesheuvel 2017-07-24   53  	s3l		.req	d24
3759ee05 Ard Biesheuvel 2017-07-24   54  	s3h		.req	d25
3759ee05 Ard Biesheuvel 2017-07-24   55  	s4l		.req	d26
3759ee05 Ard Biesheuvel 2017-07-24   56  	s4h		.req	d27
3759ee05 Ard Biesheuvel 2017-07-24   57  
3759ee05 Ard Biesheuvel 2017-07-24  @58  	MASK		.req	d28
3759ee05 Ard Biesheuvel 2017-07-24   59  	SHASH2_p8	.req	d28
3759ee05 Ard Biesheuvel 2017-07-24   60  
3759ee05 Ard Biesheuvel 2017-07-24   61  	k16		.req	d29
3759ee05 Ard Biesheuvel 2017-07-24   62  	k32		.req	d30
3759ee05 Ard Biesheuvel 2017-07-24   63  	k48		.req	d31
3759ee05 Ard Biesheuvel 2017-07-24   64  	SHASH2_p64	.req	d31
f1e866b1 Ard Biesheuvel 2015-03-10   65  
f1e866b1 Ard Biesheuvel 2015-03-10   66  	.text
f1e866b1 Ard Biesheuvel 2015-03-10   67  	.fpu		crypto-neon-fp-armv8
f1e866b1 Ard Biesheuvel 2015-03-10   68  
3759ee05 Ard Biesheuvel 2017-07-24   69  	.macro		__pmull_p64, rd, rn, rm, b1, b2, b3, b4
3759ee05 Ard Biesheuvel 2017-07-24   70  	vmull.p64	\rd, \rn, \rm
3759ee05 Ard Biesheuvel 2017-07-24   71  	.endm
3759ee05 Ard Biesheuvel 2017-07-24   72  
f1e866b1 Ard Biesheuvel 2015-03-10   73  	/*
3759ee05 Ard Biesheuvel 2017-07-24   74  	 * This implementation of 64x64 -> 128 bit polynomial multiplication
3759ee05 Ard Biesheuvel 2017-07-24   75  	 * using vmull.p8 instructions (8x8 -> 16) is taken from the paper
3759ee05 Ard Biesheuvel 2017-07-24   76  	 * "Fast Software Polynomial Multiplication on ARM Processors Using
3759ee05 Ard Biesheuvel 2017-07-24   77  	 * the NEON Engine" by Danilo Camara, Conrado Gouvea, Julio Lopez and
3759ee05 Ard Biesheuvel 2017-07-24   78  	 * Ricardo Dahab (https://hal.inria.fr/hal-01506572)
3759ee05 Ard Biesheuvel 2017-07-24   79  	 *
3759ee05 Ard Biesheuvel 2017-07-24   80  	 * It has been slightly tweaked for in-order performance, and to allow
3759ee05 Ard Biesheuvel 2017-07-24   81  	 * 'rq' to overlap with 'ad' or 'bd'.
f1e866b1 Ard Biesheuvel 2015-03-10   82  	 */
3759ee05 Ard Biesheuvel 2017-07-24   83  	.macro		__pmull_p8, rq, ad, bd, b1=t4l, b2=t3l, b3=t4l, b4=t3l
3759ee05 Ard Biesheuvel 2017-07-24   84  	vext.8		t0l, \ad, \ad, #1	@ A1
3759ee05 Ard Biesheuvel 2017-07-24   85  	.ifc		\b1, t4l
3759ee05 Ard Biesheuvel 2017-07-24   86  	vext.8		t4l, \bd, \bd, #1	@ B1
3759ee05 Ard Biesheuvel 2017-07-24   87  	.endif
3759ee05 Ard Biesheuvel 2017-07-24   88  	vmull.p8	t0q, t0l, \bd		@ F = A1*B
3759ee05 Ard Biesheuvel 2017-07-24   89  	vext.8		t1l, \ad, \ad, #2	@ A2
3759ee05 Ard Biesheuvel 2017-07-24   90  	vmull.p8	t4q, \ad, \b1		@ E = A*B1
3759ee05 Ard Biesheuvel 2017-07-24   91  	.ifc		\b2, t3l
3759ee05 Ard Biesheuvel 2017-07-24   92  	vext.8		t3l, \bd, \bd, #2	@ B2
3759ee05 Ard Biesheuvel 2017-07-24   93  	.endif
3759ee05 Ard Biesheuvel 2017-07-24   94  	vmull.p8	t1q, t1l, \bd		@ H = A2*B
3759ee05 Ard Biesheuvel 2017-07-24   95  	vext.8		t2l, \ad, \ad, #3	@ A3
3759ee05 Ard Biesheuvel 2017-07-24   96  	vmull.p8	t3q, \ad, \b2		@ G = A*B2
3759ee05 Ard Biesheuvel 2017-07-24   97  	veor		t0q, t0q, t4q		@ L = E + F
3759ee05 Ard Biesheuvel 2017-07-24   98  	.ifc		\b3, t4l
3759ee05 Ard Biesheuvel 2017-07-24   99  	vext.8		t4l, \bd, \bd, #3	@ B3
3759ee05 Ard Biesheuvel 2017-07-24  100  	.endif
3759ee05 Ard Biesheuvel 2017-07-24  101  	vmull.p8	t2q, t2l, \bd		@ J = A3*B
3759ee05 Ard Biesheuvel 2017-07-24  102  	veor		t0l, t0l, t0h		@ t0 = (L) (P0 + P1) << 8
3759ee05 Ard Biesheuvel 2017-07-24  103  	veor		t1q, t1q, t3q		@ M = G + H
3759ee05 Ard Biesheuvel 2017-07-24  104  	.ifc		\b4, t3l
3759ee05 Ard Biesheuvel 2017-07-24  105  	vext.8		t3l, \bd, \bd, #4	@ B4
3759ee05 Ard Biesheuvel 2017-07-24  106  	.endif
3759ee05 Ard Biesheuvel 2017-07-24  107  	vmull.p8	t4q, \ad, \b3		@ I = A*B3
3759ee05 Ard Biesheuvel 2017-07-24  108  	veor		t1l, t1l, t1h		@ t1 = (M) (P2 + P3) << 16
3759ee05 Ard Biesheuvel 2017-07-24  109  	vmull.p8	t3q, \ad, \b4		@ K = A*B4
3759ee05 Ard Biesheuvel 2017-07-24  110  	vand		t0h, t0h, k48
3759ee05 Ard Biesheuvel 2017-07-24  111  	vand		t1h, t1h, k32
3759ee05 Ard Biesheuvel 2017-07-24  112  	veor		t2q, t2q, t4q		@ N = I + J
3759ee05 Ard Biesheuvel 2017-07-24  113  	veor		t0l, t0l, t0h
3759ee05 Ard Biesheuvel 2017-07-24  114  	veor		t1l, t1l, t1h
3759ee05 Ard Biesheuvel 2017-07-24  115  	veor		t2l, t2l, t2h		@ t2 = (N) (P4 + P5) << 24
3759ee05 Ard Biesheuvel 2017-07-24  116  	vand		t2h, t2h, k16
3759ee05 Ard Biesheuvel 2017-07-24  117  	veor		t3l, t3l, t3h		@ t3 = (K) (P6 + P7) << 32
3759ee05 Ard Biesheuvel 2017-07-24  118  	vmov.i64	t3h, #0
3759ee05 Ard Biesheuvel 2017-07-24  119  	vext.8		t0q, t0q, t0q, #15
3759ee05 Ard Biesheuvel 2017-07-24  120  	veor		t2l, t2l, t2h
3759ee05 Ard Biesheuvel 2017-07-24  121  	vext.8		t1q, t1q, t1q, #14
3759ee05 Ard Biesheuvel 2017-07-24  122  	vmull.p8	\rq, \ad, \bd		@ D = A*B
3759ee05 Ard Biesheuvel 2017-07-24  123  	vext.8		t2q, t2q, t2q, #13
3759ee05 Ard Biesheuvel 2017-07-24  124  	vext.8		t3q, t3q, t3q, #12
3759ee05 Ard Biesheuvel 2017-07-24  125  	veor		t0q, t0q, t1q
3759ee05 Ard Biesheuvel 2017-07-24  126  	veor		t2q, t2q, t3q
3759ee05 Ard Biesheuvel 2017-07-24  127  	veor		\rq, \rq, t0q
3759ee05 Ard Biesheuvel 2017-07-24  128  	veor		\rq, \rq, t2q
3759ee05 Ard Biesheuvel 2017-07-24  129  	.endm
3759ee05 Ard Biesheuvel 2017-07-24  130  
3759ee05 Ard Biesheuvel 2017-07-24  131  	//
3759ee05 Ard Biesheuvel 2017-07-24  132  	// PMULL (64x64->128) based reduction for CPUs that can do
3759ee05 Ard Biesheuvel 2017-07-24  133  	// it in a single instruction.
3759ee05 Ard Biesheuvel 2017-07-24  134  	//
3759ee05 Ard Biesheuvel 2017-07-24  135  	.macro		__pmull_reduce_p64
3759ee05 Ard Biesheuvel 2017-07-24  136  	vmull.p64	T1, XL_L, MASK
3759ee05 Ard Biesheuvel 2017-07-24  137  
3759ee05 Ard Biesheuvel 2017-07-24  138  	veor		XH_L, XH_L, XM_H
3759ee05 Ard Biesheuvel 2017-07-24  139  	vext.8		T1, T1, T1, #8
3759ee05 Ard Biesheuvel 2017-07-24  140  	veor		XL_H, XL_H, XM_L
3759ee05 Ard Biesheuvel 2017-07-24  141  	veor		T1, T1, XL
3759ee05 Ard Biesheuvel 2017-07-24  142  
3759ee05 Ard Biesheuvel 2017-07-24  143  	vmull.p64	XL, T1_H, MASK
3759ee05 Ard Biesheuvel 2017-07-24  144  	.endm
3759ee05 Ard Biesheuvel 2017-07-24  145  
3759ee05 Ard Biesheuvel 2017-07-24  146  	//
3759ee05 Ard Biesheuvel 2017-07-24  147  	// Alternative reduction for CPUs that lack support for the
3759ee05 Ard Biesheuvel 2017-07-24  148  	// 64x64->128 PMULL instruction
3759ee05 Ard Biesheuvel 2017-07-24  149  	//
3759ee05 Ard Biesheuvel 2017-07-24  150  	.macro		__pmull_reduce_p8
3759ee05 Ard Biesheuvel 2017-07-24  151  	veor		XL_H, XL_H, XM_L
3759ee05 Ard Biesheuvel 2017-07-24  152  	veor		XH_L, XH_L, XM_H
3759ee05 Ard Biesheuvel 2017-07-24  153  
3759ee05 Ard Biesheuvel 2017-07-24  154  	vshl.i64	T1, XL, #57
3759ee05 Ard Biesheuvel 2017-07-24  155  	vshl.i64	T2, XL, #62
3759ee05 Ard Biesheuvel 2017-07-24  156  	veor		T1, T1, T2
3759ee05 Ard Biesheuvel 2017-07-24  157  	vshl.i64	T2, XL, #63
3759ee05 Ard Biesheuvel 2017-07-24  158  	veor		T1, T1, T2
3759ee05 Ard Biesheuvel 2017-07-24  159  	veor		XL_H, XL_H, T1_L
3759ee05 Ard Biesheuvel 2017-07-24  160  	veor		XH_L, XH_L, T1_H
3759ee05 Ard Biesheuvel 2017-07-24  161  
3759ee05 Ard Biesheuvel 2017-07-24  162  	vshr.u64	T1, XL, #1
3759ee05 Ard Biesheuvel 2017-07-24  163  	veor		XH, XH, XL
3759ee05 Ard Biesheuvel 2017-07-24  164  	veor		XL, XL, T1
3759ee05 Ard Biesheuvel 2017-07-24  165  	vshr.u64	T1, T1, #6
3759ee05 Ard Biesheuvel 2017-07-24  166  	vshr.u64	XL, XL, #1
3759ee05 Ard Biesheuvel 2017-07-24  167  	.endm
3759ee05 Ard Biesheuvel 2017-07-24  168  
3759ee05 Ard Biesheuvel 2017-07-24  169  	.macro		ghash_update, pn
f1e866b1 Ard Biesheuvel 2015-03-10  170  	vld1.64		{XL}, [r1]
f1e866b1 Ard Biesheuvel 2015-03-10  171  
f1e866b1 Ard Biesheuvel 2015-03-10  172  	/* do the head block first, if supplied */
f1e866b1 Ard Biesheuvel 2015-03-10  173  	ldr		ip, [sp]
f1e866b1 Ard Biesheuvel 2015-03-10  174  	teq		ip, #0
f1e866b1 Ard Biesheuvel 2015-03-10  175  	beq		0f
f1e866b1 Ard Biesheuvel 2015-03-10  176  	vld1.64		{T1}, [ip]
f1e866b1 Ard Biesheuvel 2015-03-10  177  	teq		r0, #0
f1e866b1 Ard Biesheuvel 2015-03-10  178  	b		1f
f1e866b1 Ard Biesheuvel 2015-03-10  179  
f1e866b1 Ard Biesheuvel 2015-03-10  180  0:	vld1.64		{T1}, [r2]!
f1e866b1 Ard Biesheuvel 2015-03-10  181  	subs		r0, r0, #1
f1e866b1 Ard Biesheuvel 2015-03-10  182  
f1e866b1 Ard Biesheuvel 2015-03-10  183  1:	/* multiply XL by SHASH in GF(2^128) */
f1e866b1 Ard Biesheuvel 2015-03-10  184  #ifndef CONFIG_CPU_BIG_ENDIAN
f1e866b1 Ard Biesheuvel 2015-03-10  185  	vrev64.8	T1, T1
f1e866b1 Ard Biesheuvel 2015-03-10  186  #endif
f1e866b1 Ard Biesheuvel 2015-03-10  187  	vext.8		IN1, T1, T1, #8
3759ee05 Ard Biesheuvel 2017-07-24  188  	veor		T1_L, T1_L, XL_H
f1e866b1 Ard Biesheuvel 2015-03-10  189  	veor		XL, XL, IN1
f1e866b1 Ard Biesheuvel 2015-03-10  190  
3759ee05 Ard Biesheuvel 2017-07-24  191  	__pmull_\pn	XH, XL_H, SHASH_H, s1h, s2h, s3h, s4h	@ a1 * b1
f1e866b1 Ard Biesheuvel 2015-03-10  192  	veor		T1, T1, XL
3759ee05 Ard Biesheuvel 2017-07-24  193  	__pmull_\pn	XL, XL_L, SHASH_L, s1l, s2l, s3l, s4l	@ a0 * b0
3759ee05 Ard Biesheuvel 2017-07-24  194  	__pmull_\pn	XM, T1_L, SHASH2_\pn			@ (a1+a0)(b1+b0)
f1e866b1 Ard Biesheuvel 2015-03-10  195  
3759ee05 Ard Biesheuvel 2017-07-24  196  	veor		T1, XL, XH
f1e866b1 Ard Biesheuvel 2015-03-10  197  	veor		XM, XM, T1
f1e866b1 Ard Biesheuvel 2015-03-10  198  
3759ee05 Ard Biesheuvel 2017-07-24  199  	__pmull_reduce_\pn
f1e866b1 Ard Biesheuvel 2015-03-10  200  
3759ee05 Ard Biesheuvel 2017-07-24  201  	veor		T1, T1, XH
3759ee05 Ard Biesheuvel 2017-07-24  202  	veor		XL, XL, T1
f1e866b1 Ard Biesheuvel 2015-03-10  203  
f1e866b1 Ard Biesheuvel 2015-03-10  204  	bne		0b
f1e866b1 Ard Biesheuvel 2015-03-10  205  
f1e866b1 Ard Biesheuvel 2015-03-10  206  	vst1.64		{XL}, [r1]
f1e866b1 Ard Biesheuvel 2015-03-10  207  	bx		lr
3759ee05 Ard Biesheuvel 2017-07-24  208  	.endm
3759ee05 Ard Biesheuvel 2017-07-24  209  
3759ee05 Ard Biesheuvel 2017-07-24  210  	/*
3759ee05 Ard Biesheuvel 2017-07-24  211  	 * void pmull_ghash_update(int blocks, u64 dg[], const char *src,
3759ee05 Ard Biesheuvel 2017-07-24  212  	 *			   struct ghash_key const *k, const char *head)
3759ee05 Ard Biesheuvel 2017-07-24  213  	 */
3759ee05 Ard Biesheuvel 2017-07-24  214  ENTRY(pmull_ghash_update_p64)
3759ee05 Ard Biesheuvel 2017-07-24  215  	vld1.64		{SHASH}, [r3]
3759ee05 Ard Biesheuvel 2017-07-24  216  	veor		SHASH2_p64, SHASH_L, SHASH_H
3759ee05 Ard Biesheuvel 2017-07-24  217  
3759ee05 Ard Biesheuvel 2017-07-24 @218  	vmov.i8		MASK, #0xe1
3759ee05 Ard Biesheuvel 2017-07-24 @219  	vshl.u64	MASK, MASK, #57
3759ee05 Ard Biesheuvel 2017-07-24  220  
3759ee05 Ard Biesheuvel 2017-07-24 @221  	ghash_update	p64
3759ee05 Ard Biesheuvel 2017-07-24  222  ENDPROC(pmull_ghash_update_p64)
3759ee05 Ard Biesheuvel 2017-07-24  223  

:::::: The code at line 58 was first introduced by commit
:::::: 3759ee057261a45da0505e79084de8b6ac31c4a5 crypto: arm/ghash - add NEON accelerated fallback for vmull.p64

:::::: TO: Ard Biesheuvel <ard.biesheuvel@linaro.org>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 34067 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180515/d17b0643/attachment-0001.gz>
