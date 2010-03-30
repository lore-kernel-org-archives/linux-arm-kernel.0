From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Tue, 30 Mar 2010 17:08:39 +0200
Subject: [E3-hacking] [RFC][PATCH v2 1/5] omap1: Amstrad Delta: add FIQ
	handler for serial keyboard port interrupt processing
In-Reply-To: <20100329183211.F105C493B@blake.inputplus.co.uk>
References: <201003291619.25878.jkrzyszt@tis.icnet.pl>
	<201003291624.10034.jkrzyszt@tis.icnet.pl>
	<20100329183211.F105C493B@blake.inputplus.co.uk>
Message-ID: <201003301708.41634.jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Monday 29 March 2010 20:32:11 Ralph Corderoy wrote:
> Hi Janusz,
>
> My ARM's not used much these days so I don't know how much this matters
> and may be incorrect so I've cut down the CC list, but given it's a FIQ
> handler and speed matters...

Hi Ralph,

Not only speed; there is a very low size limit for FIQ handler and I already 
have had problems with fitting into the available space with the code, so your 
hints are really appreciated.

And thanks for pushing me into reading the ARM Assembly Language book, so I 
would be able to do more than just understanding and copy-pasting the code ;).

> > +key:	@Is it a keyboard interrupt?
> > +	ldr r11, [r12,#GPIO_INTERRUPT_STATUS]	@ get GPIO interrupt status
> > +	and r10, r11, #MBRD_CLK_MASK		@ reveal keyboard bit
> > +	cmp r10, #MBRD_CLK_MASK 		@ is keyboard bit low?
> > +	bne mdm					@ no - spurious - try mdm
>
> Couldn't that be an `ands' instruction if MBRD_CLK_MASK has one-bit set?
> Then the cmp could be deleted.

Agree.

> > +state:
> > +	ldr r10, [r9,#FIQ_STATE]
> > +	cmp r10, #0				@ are we expecting start bit?
> > +	bne data				@ no - in data processing state
>
> Similarly, an `ldrs' here would make the cmp redundant.

I'm not sure if the S suffix is also valid for memory transfer instructions, 
so I readd linux-omap and linux-arm-kernel to the CC list.

> There's other similar bits elsewhere.

Yes, I'll try to recognize and optimize them all for next version.

Thanks,
Janusz
