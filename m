From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 17 Mar 2017 17:50:49 +0000
Subject: [PATCH] arm: kprobes: Align stack to 8-bytes in test code
In-Reply-To: <20170317150557.GI21222@n2100.armlinux.org.uk>
References: <20170316135359.23019-1-tixy@linaro.org>
 <20170317121025.GD21222@n2100.armlinux.org.uk>
 <1489755542.3063.2.camel@linaro.org>
 <20170317140610.GF21222@n2100.armlinux.org.uk>
 <1489761729.3063.7.camel@linaro.org>
 <20170317150557.GI21222@n2100.armlinux.org.uk>
Message-ID: <1489773049.3063.13.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-03-17 at 15:05 +0000, Russell King - ARM Linux wrote
[...]
> I suspect we're into compiler behavioural differences, which can't be
> relied upon, so I guess we do need to do something in
> __kprobes_test_case_start() to work around it.
> 
> I'd do:
> 
> 	mov	ip, sp
> 	tst	sp, #4
> 	subeq	sp, sp, #4		@ need to mis-align as we don't save
> 	stmfd	sp!, {r4 - r11, ip}	@ an even number of registers to end
> 	sub	sp, sp, #size		@ up with an aligned stack here
> 
> and when restoring:
> 
> 	add	ip, sp, #size
> 	ldmfd	ip, {r4 - r11, sp}
> 	bx	r0

Thumb doesn't allow a lot of operations with SP (like that 'tst sp, #4'
or having SP in the reg list for LDM) which is why I ended up producing
slightly convoluted code. Some of these are deprecated for ARM too,
which means they might not be supported on newer architecture versions,
oh joy.

-- 
Tixy
