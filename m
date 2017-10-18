From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 18 Oct 2017 16:01:50 +0100
Subject: [PATCH v3 24/28] arm64/sve: KVM: Hide SVE from CPU features
 exposed to guests
In-Reply-To: <20171018132145.GF8900@cbox>
References: <1507660725-7986-1-git-send-email-Dave.Martin@arm.com>
 <1507660725-7986-25-git-send-email-Dave.Martin@arm.com>
 <20171017135816.GF5886@lvm>
 <20171017140749.GW19485@e103592.cambridge.arm.com>
 <2c6d9aa4-f6a8-2c6b-4138-e07d773bf4a2@arm.com>
 <20171017154708.GY19485@e103592.cambridge.arm.com>
 <20171018132145.GF8900@cbox>
Message-ID: <20171018150149.GB19485@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 18, 2017 at 03:21:45PM +0200, Christoffer Dall wrote:
> On Tue, Oct 17, 2017 at 04:47:08PM +0100, Dave Martin wrote:
> > On Tue, Oct 17, 2017 at 03:29:36PM +0100, Marc Zyngier wrote:
> > > On 17/10/17 15:07, Dave Martin wrote:
> > > > On Tue, Oct 17, 2017 at 06:58:16AM -0700, Christoffer Dall wrote:
> > > >> On Tue, Oct 10, 2017 at 07:38:41PM +0100, Dave Martin wrote:

[...]

> > > >>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c

[...]

> > > >>> @@ -897,8 +898,17 @@ static u64 read_id_reg(struct sys_reg_desc const *r, bool raz)
> > > >>>  {
> > > >>>  	u32 id = sys_reg((u32)r->Op0, (u32)r->Op1,
> > > >>>  			 (u32)r->CRn, (u32)r->CRm, (u32)r->Op2);
> > > >>> +	u64 val = raz ? 0 : read_sanitised_ftr_reg(id);
> > > >>>  
> > > >>> -	return raz ? 0 : read_sanitised_ftr_reg(id);
> > > >>> +	if (id == SYS_ID_AA64PFR0_EL1) {
> > > >>> +		if (val & (0xfUL << ID_AA64PFR0_SVE_SHIFT))
> > > >>> +			pr_err_once("kvm [%i]: SVE unsupported for guests, suppressing\n",
> > > >>> +				    task_pid_nr(current));
> > > >>
> > > >> nit: does this really qualify as an error print?
> > > > 
> > > > I have no strong opinion on this: maz suggested I should add this --
> > > > his concern was to make it difficult to ignore.
> > > > 
> > > > This is transitional: the main purpose is to circumvent bug reports from
> > > > people who find that SVE doesn't work in their guests, in the interim
> > > > before proper KVM support lands upstream.
> > > > 
> > > > Marc, do you still agree with this position?
> > > 
> > > As long as this is transitional, I'm OK with this.
> > 
> > No argument from me, since it was your request in the first place ;)
> > 
> > Christoffer?
> > 
> No (further) argument from me.

OK, thanks.  Can I take that as an Ack?

Cheers
---Dave
