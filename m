From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 19 May 2011 17:08:19 +0100
Subject: [PATCH v2] arm: Add Cortex A5 proc info
In-Reply-To: <1305819084.17656.63.camel@hornet.cambridge.arm.com>
References: <1305720361.17656.44.camel@hornet.cambridge.arm.com>
	<1305737066-11900-1-git-send-email-pawel.moll@arm.com>
	<000d01cc162e$723081b0$56918510$@deacon@arm.com>
	<1305819084.17656.63.camel@hornet.cambridge.arm.com>
Message-ID: <20110519160819.GD2431@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 19, 2011 at 04:31:24PM +0100, Pawel Moll wrote:
> > Please can you do the same for the __v7_proc_info struct? 
> 
> Yeah, I could if we want to... The thing is that the macro will have to
> take full ID and mask value then. And a name for the structure. So extra
> 3 parameters. Not a big deal I suppose.

Optionally, you could just omit the label and mask/match words from the
macro.  Those are always at the start, so we don't need to cunningly
insert them in the middle of the macro expansion.

By definition, they will be different per expansion, too.  So it makes
less sense to have these in the macro definition itself.

Similarly, you could just leave the .size directive out of the macro
to avoid having to generlise it -- after all, it's not generalised
for the other proc_info definitions so this makes the situation no
worse.

> 
> > On top of that, I think you should take optional, additional HWCAPs as
> > arguments to the macro which get ORd with the base v7 HWCAPs. 
> 
> Em, the "optional" bit here is a problem. I can't just do
> 
> #define INFO(_a, _extra_hwcaps...) \
> 	.long HWCAP | _extra_hwcaps;
> 
> 
> Because the output would be ".long HWCAP | ;" when no _extra_hwcaps are
> given... Unless I'm missing some preprocessor trick? :-)

You could use an assembler macro instead.

.macro blarg insert_hwcaps=0
	/* blah */
	.long HWCAP_ALICE | HWCAP_BOB | HWCAP_CHARLIE | ( \insert_hwcaps )
	/* blah */
.endm

As an added bonus, this could substantially reduce the diffstat, because
assembler macro definitions can have multiple lines, so you don't need
all that awful semicolon-backslash line continuation stuff.

Not everyone likes assembler macros, though...

> 
> > This might be useful for A15 where we have integer division.
> 
> What HWCAP would this be? I've checked Catalin's repo and the only
> difference I've spotted between A9 and A15 proc info were the mmu
> flags...

You could invent one, if none is defined yet.  You probably want to
check with Catalin or Will.

---Dave
