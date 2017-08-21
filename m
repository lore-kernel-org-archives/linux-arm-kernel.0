From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 21 Aug 2017 15:38:18 +0100
Subject: [PATCH 07/27] arm64/sve: Low-level SVE architectural state
 manipulation functions
In-Reply-To: <878tid5ixn.fsf@linaro.org>
References: <1502280338-23002-1-git-send-email-Dave.Martin@arm.com>
 <1502280338-23002-8-git-send-email-Dave.Martin@arm.com>
 <878tid5ixn.fsf@linaro.org>
Message-ID: <20170821143818.GR6321@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 21, 2017 at 11:11:48AM +0100, Alex Benn?e wrote:
> 
> Dave Martin <Dave.Martin@arm.com> writes:
> 
> > Manipulating the SVE architectural state, including the vector and
> > predicate registers, first-fault register and the vector length,
> > requires the use of dedicated instructions added by SVE.
> >
> > This patch adds suitable assembly functions for saving and
> > restoring the SVE registers and querying the vector length.
> > Setting of the vector length is done as part of register restore.
> >
> > Since people building kernels may not all get an SVE-enabled
> > toolchain for a while, this patch uses macros that generate
> > explicit opcodes in place of assembler mnemonics.
> >
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > ---
> >  arch/arm64/include/asm/fpsimd.h       |   5 ++
> >  arch/arm64/include/asm/fpsimdmacros.h | 137 ++++++++++++++++++++++++++++++++++
> >  arch/arm64/kernel/entry-fpsimd.S      |  17 +++++
> >  3 files changed, 159 insertions(+)

[...]

> > diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
> > index 0f5fdd3..5023064 100644
> > --- a/arch/arm64/include/asm/fpsimdmacros.h
> > +++ b/arch/arm64/include/asm/fpsimdmacros.h

[...]

> > +.macro _sve_str_v nz, nxbase, offset=0
> > +	_sve_check_zreg \nz
> > +	_check_general_reg \nxbase
> > +	_check_num (\offset), -0x100, 0xff
> > +	.inst	0xe5804000			\
> > +		| (\nz)				\
> > +		| ((\nxbase) << 5)		\
> > +		| (((\offset) & 7) << 10)	\
> > +		| (((\offset) & 0x1f8) << 13)
> > +.endm
> 
> Can we have references to the ARM ARM titles (the section numbers keep
> changing) for each hand-hacked instruction please. Otherwise it is
> impossible to verify each one.

That's fair -- will do.

The supplement didn't exist at the time I first wrote this code...

[...]

Cheers
---Dave
