From: will.deacon@arm.com (Will Deacon)
Date: Wed, 17 Jan 2018 10:07:15 +0000
Subject: [PATCH v2 07/11] arm64: Add skeleton to harden the branch
 predictor against aliasing attacks
In-Reply-To: <01c224eb-9bec-6b16-7ecf-14837cc107b6@huawei.com>
References: <1515157961-20963-1-git-send-email-will.deacon@arm.com>
 <1515157961-20963-8-git-send-email-will.deacon@arm.com>
 <01c224eb-9bec-6b16-7ecf-14837cc107b6@huawei.com>
Message-ID: <20180117100715.GA27892@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 12:10:33PM +0800, Yisheng Xie wrote:
> Hi Will,
> 
> On 2018/1/5 21:12, Will Deacon wrote:
> > diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
> > index 5f7097d0cd12..d99b36555a16 100644
> > --- a/arch/arm64/mm/context.c
> > +++ b/arch/arm64/mm/context.c
> > @@ -246,6 +246,8 @@ asmlinkage void post_ttbr_update_workaround(void)
> >  			"ic iallu; dsb nsh; isb",
> >  			ARM64_WORKAROUND_CAVIUM_27456,
> >  			CONFIG_CAVIUM_ERRATUM_27456));
> > +
> > +	arm64_apply_bp_hardening();
> >  }
> 
> post_ttbr_update_workaround was used for fix Cavium erratum 2745? so does that
> means, if we do not have this erratum, we do not need arm64_apply_bp_hardening()?
> when mm_swtich and kernel_exit?
> 
> From the code logical, it seems not only related to erratum 2745 anymore?
> should it be renamed?

post_ttbr_update_workaround just runs code after a TTBR update, which
includes mitigations against variant 2 of "spectre" and also a workaround
for a Cavium erratum. These are separate issues.

Will
