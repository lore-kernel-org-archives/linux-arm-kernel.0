From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 17 Oct 2017 17:36:58 +0800
Subject: ARM64: Regression with commit e3067861ba66 ("arm64: add basic
 VMAP_STACK support")
In-Reply-To: <CAKv+Gu8u1cc14c5ZDeq=oNB9DC2RcHzXu8e9Cc+noHT4w+4mpg@mail.gmail.com>
References: <20171010154558.GJ27659@leverpostej>
 <da09fd83-f3f0-f800-fea4-988cfa56bac7@arm.com>
 <20171016011723.GB12470@leoy-linaro>
 <20171016134819.jv3udrcwsedc4cgs@lakrids.cambridge.arm.com>
 <34ccf02d-fd65-bade-327a-ed8df1d3eea5@arm.com>
 <20171016142622.6yjuzdwxxw3sxjed@lakrids.cambridge.arm.com>
 <dad6105d-1ec0-d5a6-e78c-ff832afe3f9e@arm.com>
 <20171017003054.GB19504@leoy-ThinkPad-T440>
 <20171017092914.op4hlzaaqfrpoizm@lakrids.cambridge.arm.com>
 <CAKv+Gu8u1cc14c5ZDeq=oNB9DC2RcHzXu8e9Cc+noHT4w+4mpg@mail.gmail.com>
Message-ID: <20171017093658.GA32000@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 10:32:21AM +0100, Ard Biesheuvel wrote:

[...]

> > AFAICT, erratum 836870 results in livelock rather than memory
> > corruption, so I think we can ignore that.
> >
> > I'm a little worried by erratum 843419. The VMAP_STACK patches changed
> > {adr,ldr}_this_cpu (and some users thereof), and it's possible we're
> > managing to tickle that issue.
> >
> > If you still have an affected kernel, could you dump the output of:
> >
> > $ aarch64-linux-gnu-objdump -d vmlinux | grep -A 3 'ff[8c]:\s\+[a-f0-9]\+\s\+adrp'
> >
> > ... that would show us if there are any affected sequences.
> >
> > From a quick scan of my own vmlinux build from commit e3067861ba66, I
> > didn't see any, but it's possible this depends on the config used.
> >
> 
> The linker should take care of that: it scans the entire executable,
> and inserts a veneer if an adrp happens to end up at a vulnerable
> offset in the page.

Is this dependent on any GCC version?

I am using GCC 6.2.1, so I get many affected sequences with Mark's command:

leoy at leoy-linaro:~/Work/reference/opensource/linux$ aarch64-linux-gnu-objdump -d vmlinux | grep -A 3 'ff[8c]:\s\+[a-f0-9]\+\s\+adrp'
ffff0000080a1ffc:	90007340 	adrp	x0, ffff000008f09000 <page_wait_table+0x1280>
ffff0000080a2000:	a900fedf 	stp	xzr, xzr, [x22,#8]
ffff0000080a2004:	91374000 	add	x0, x0, #0xdd0
ffff0000080a2008:	f9000ec0 	str	x0, [x22,#24]
--
ffff0000080b6ff8:	b0007ce0 	adrp	x0, ffff000009053000 <chunk_hash_heads+0x680>
ffff0000080b6ffc:	52901801 	mov	w1, #0x80c0                	// #32960
ffff0000080b7000:	72a02801 	movk	w1, #0x140, lsl #16
ffff0000080b7004:	9102e273 	add	x19, x19, #0xb8
--
ffff0000080f1ff8:	d00070a1 	adrp	x1, ffff000008f07000 <bit_wait_table+0xd80>
ffff0000080f1ffc:	f9406402 	ldr	x2, [x0,#200]
ffff0000080f2000:	f9405c03 	ldr	x3, [x0,#184]
ffff0000080f2004:	14002915 	b	ffff0000080fc458 <e843419@00ce_00000e94_3c4>
--
ffff0000080feff8:	90000002 	adrp	x2, ffff0000080fe000 <prio_changed_rt+0x88>
ffff0000080feffc:	9136e042 	add	x2, x2, #0xdb8
ffff0000080ff000:	f9000462 	str	x2, [x3,#8]
ffff0000080ff004:	f9448e62 	ldr	x2, [x19,#2328]
--
ffff00000810affc:	f0006fe1 	adrp	x1, ffff000008f09000 <page_wait_table+0x1280>
ffff00000810b000:	f94017a2 	ldr	x2, [x29,#40]
ffff00000810b004:	aa1303e0 	mov	x0, x19
ffff00000810b008:	1400013d 	b	ffff00000810b4fc <e843419@00e7_000010c5_338>
--
ffff00000811dff8:	d0005c80 	adrp	x0, ffff000008caf000 <kallsyms_token_index+0xaf00>
ffff00000811dffc:	912be021 	add	x1, x1, #0xaf8
ffff00000811e000:	912ae000 	add	x0, x0, #0xab8
ffff00000811e004:	97ffe6ab 	bl	ffff000008117ab0 <printk>
--
ffff000008137ff8:	f0004443 	adrp	x3, ffff0000089c2000 <clock_monotonic+0x50>
ffff000008137ffc:	910ac042 	add	x2, x2, #0x2b0
ffff000008138000:	9113c063 	add	x3, x3, #0x4f0
ffff000008138004:	71000c9f 	cmp	w4, #0x3
--
ffff00000815eff8:	b0005aa1 	adrp	x1, ffff000008cb3000 <kallsyms_token_index+0xef00>
ffff00000815effc:	91362021 	add	x1, x1, #0xd88
ffff00000815f000:	97ffffc8 	bl	ffff00000815ef20 <audit_log_format>
ffff00000815f004:	b94023a1 	ldr	w1, [x29,#32]
