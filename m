From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Wed, 18 May 2011 17:06:58 +0100 (BST)
Subject: Question on ARM inline assembly - stackframes, sp/fp usage,
	__naked
In-Reply-To: <alpine.DEB.2.00.1105181505080.2374@localhost6.localdomain6>
References: <alpine.DEB.2.00.1105181505080.2374@localhost6.localdomain6>
Message-ID: <alpine.DEB.2.00.1105181658010.2374@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


I've found that the key difference to code generation in this case seems 
to be the use of the register clobber list. While gcc targeting armv7 / 
omap3 looks to be pretty happy about that matching reality (it still 
allocates local vars to registers alright - i.e. it recoginzes that the 
clobber happens after), that's not the case for armv6 / s5p6450. On those, 
seeing the r0-r15 clobber list, gcc insists on having "one tiny reg, just 
one little teeny tinsy reg for itself", with FP as last resort ... and the 
shown consequences for code generation if one lets fp through.


Now since the inline asm statement is finalizing the function anyway, 
there's no real harm in not specifying a clobber list at all
there's never anything after it that could depend on saved state.
Doing so makes the generated armv6 code use the same regs as the armv7 
does.

Is it, for the sake of fooling gcc under all circumstances, necessary to 
go via the naked trampoline ?


FrankH.
