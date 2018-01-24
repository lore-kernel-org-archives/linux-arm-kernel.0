From: will.deacon@arm.com (Will Deacon)
Date: Wed, 24 Jan 2018 16:43:24 +0000
Subject: [PATCH] arm64: turn off xgene branch prediction while in kernel
 space
In-Reply-To: <1516811703.2957.47.camel@redhat.com>
References: <1516760007-14670-1-git-send-email-kdinh@apm.com>
 <aacf7d03-faa7-c17d-b763-c80b293106ea@arm.com>
 <1516811703.2957.47.camel@redhat.com>
Message-ID: <20180124164324.GA30462@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 24, 2018 at 11:35:03AM -0500, Mark Salter wrote:
> On Wed, 2018-01-24 at 10:58 +0000, Marc Zyngier wrote:
> > Khuong,
> > 
> > On 24/01/18 02:13, Khuong Dinh wrote:
> > > Aliasing attacks against CPU branch predictors can allow an attacker to
> > > redirect speculative control flow on some CPUs and potentially divulge
> > > information from one context to another.
> > > 
> > > This patch only supports for XGene processors.
> > > 
> > > Signed-off-by: Mark Salter <msalter@redhat.com>
> > > Signed-off-by: Khuong Dinh <kdinh@apm.com>
> > > ---
> > >  arch/arm64/include/asm/cpucaps.h |    3 ++-
> > >  arch/arm64/include/asm/fixmap.h  |    4 ++++
> > >  arch/arm64/kernel/cpu_errata.c   |   18 ++++++++++++++++++
> > >  arch/arm64/kernel/entry.S        |   28 ++++++++++++++++++++++++++++
> > >  arch/arm64/kernel/smp.c          |   34 ++++++++++++++++++++++++++++++++++
> > >  5 files changed, 86 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> > > index bb26382..dc9ada1 100644
> > > --- a/arch/arm64/include/asm/cpucaps.h
> > > +++ b/arch/arm64/include/asm/cpucaps.h
> > > @@ -45,7 +45,8 @@
> > >  #define ARM64_HARDEN_BRANCH_PREDICTOR		24
> > >  #define ARM64_HARDEN_BP_POST_GUEST_EXIT		25
> > >  #define ARM64_HAS_RAS_EXTN			26
> > > +#define ARM64_XGENE_HARDEN_BRANCH_PREDICTOR	27
> > >  
> > 
> > Why isn't this using the infrastructure that is already in place?
> 
> That infrastructure relies on a cpu-specific flush of the branch
> predictor. XGene does not have the ability to flush the branch
> predictor. It can only turn it on or off.

So how does this patch protect one user application from another? Sounds
like you need to turn the thing off at boot and leave it that way, or find
a sequence of branch instructions to effectively do the invalidation.

Will
