From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 20 Oct 2017 17:08:37 +0100
Subject: [PATCH 3/4] arm64: traps: Pretty-print pstate in register dumps
In-Reply-To: <20171020155836.GB1593@arm.com>
References: <1508428534-20694-1-git-send-email-will.deacon@arm.com>
 <1508428534-20694-4-git-send-email-will.deacon@arm.com>
 <20171019161754.5xnqloqx52sjbtvr@lakrids.cambridge.arm.com>
 <20171020155836.GB1593@arm.com>
Message-ID: <20171020160836.7q4n67nhwzizwunp@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 20, 2017 at 04:58:37PM +0100, Will Deacon wrote:
> On Thu, Oct 19, 2017 at 05:17:55PM +0100, Mark Rutland wrote:
> > On Thu, Oct 19, 2017 at 04:55:33PM +0100, Will Deacon wrote:
> > > We can decode the PSTATE easily enough, so pretty-print it in register
> > > dumps.
> > > 
> > > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > > ---
> > >  arch/arm64/kernel/process.c | 20 +++++++++++++++++++-
> > >  1 file changed, 19 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > > index c20896b8fb2d..be3cf9cd7dec 100644
> > > --- a/arch/arm64/kernel/process.c
> > > +++ b/arch/arm64/kernel/process.c
> > > @@ -170,6 +170,23 @@ void machine_restart(char *cmd)
> > >  	while (1);
> > >  }
> > >  
> > > +static void print_pstate(struct pt_regs *regs)
> > > +{
> > > +	u64 pstate = regs->pstate;
> > > +	printk("pstate: %08llx (%c%c%c%c %c%c%c%c %cPAN %cUAO)\n",
> > > +		pstate,
> > > +		pstate & PSR_N_BIT ? 'N' : 'n',
> > > +		pstate & PSR_Z_BIT ? 'Z' : 'z',
> > > +		pstate & PSR_C_BIT ? 'C' : 'c',
> > > +		pstate & PSR_V_BIT ? 'V' : 'v',
> > > +		pstate & PSR_D_BIT ? 'D' : 'd',
> > > +		pstate & PSR_A_BIT ? 'A' : 'a',
> > > +		pstate & PSR_I_BIT ? 'I' : 'i',
> > > +		pstate & PSR_F_BIT ? 'F' : 'f',
> > > +		pstate & PSR_PAN_BIT ? '+' : '-',
> > > +		pstate & PSR_UAO_BIT ? '+' : '-');
> > > +}
> > 
> > Given we use __show_regs for user state, I think we need to check
> > compat_user_mode() regs, and adjust the decoding accordingly.
> > 
> > e.g. AArch32 has an E bit where the D in DAIF is.
> 
> Yes, you're right. There's lots of exciting bits in the AArch32 pstate
> too. I ended up with the diff below.
> 
> Will
> 
> --->8
> 
> +static void print_pstate(struct pt_regs *regs)
> +{
> +	u64 pstate = regs->pstate;
> +
> +	if (compat_user_mode(regs))
> +		printk("pstate: %08llx (%c%c%c%c %c %s %s-endian %c%c%c)\n",
> +			pstate,
> +			pstate & COMPAT_PSR_N_BIT ? 'N' : 'n',
> +			pstate & COMPAT_PSR_Z_BIT ? 'Z' : 'z',
> +			pstate & COMPAT_PSR_C_BIT ? 'C' : 'c',
> +			pstate & COMPAT_PSR_V_BIT ? 'V' : 'v',
> +			pstate & COMPAT_PSR_Q_BIT ? 'Q' : 'q',
> +			pstate & COMPAT_PSR_T_BIT ? "T32" : "A32",
> +			pstate & COMPAT_PSR_E_BIT ? "big" : "little",

We could say BE/LE for these so as to keep the line short.

> +			pstate & COMPAT_PSR_A_BIT ? 'A' : 'a',
> +			pstate & COMPAT_PSR_I_BIT ? 'I' : 'i',
> +			pstate & COMPAT_PSR_F_BIT ? 'F' : 'f');
> +	else

Given the either side of the if-else is several lines, could we add
braces for clarity?

> +		printk("pstate: %08llx (%c%c%c%c %c%c%c%c %cPAN %cUAO)\n",
> +			pstate,
> +			pstate & PSR_N_BIT ? 'N' : 'n',
> +			pstate & PSR_Z_BIT ? 'Z' : 'z',
> +			pstate & PSR_C_BIT ? 'C' : 'c',
> +			pstate & PSR_V_BIT ? 'V' : 'v',
> +			pstate & PSR_D_BIT ? 'D' : 'd',
> +			pstate & PSR_A_BIT ? 'A' : 'a',
> +			pstate & PSR_I_BIT ? 'I' : 'i',
> +			pstate & PSR_F_BIT ? 'F' : 'f',
> +			pstate & PSR_PAN_BIT ? '+' : '-',
> +			pstate & PSR_UAO_BIT ? '+' : '-');
> +}

Otherwise, looks good!

Thanks,
Mark.
