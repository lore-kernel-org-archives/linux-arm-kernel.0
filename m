From: mugdha@ti.com (Kamoolkar, Mugdha)
Date: Fri, 22 Oct 2010 15:29:52 +0530
Subject: [PATCH 3/3] omap: add hwspinlock device
In-Reply-To: <AANLkTi=dfw==t+u1Ap26iwPHH9A2M-cEU0hs92Gxdkxc@mail.gmail.com>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
	<1287387875-14168-4-git-send-email-ohad@wizery.com>
	<87r5fmxghm.fsf@deeprootsystems.com>
	<AANLkTinZ2+ocJCfUpT15Ow3J9XBa-8XWnVC3gDDJ7s-v@mail.gmail.com>
	<87bp6pviwf.fsf@deeprootsystems.com>
	<AANLkTikE1dCXW-7ScVoDgEK3sxai_TyFzstSG+zvNm2F@mail.gmail.com>
	<8739s0sobc.fsf@deeprootsystems.com>
	<AANLkTikdjtYtzhgM_=io3SFdUZq=8Xcc8n24bW=SFgTA@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930233F94602@dbde02.ent.ti.com>
	<AANLkTi=dfw==t+u1Ap26iwPHH9A2M-cEU0hs92Gxdkxc@mail.gmail.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593023458C2BA@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Ohad Ben-Cohen [mailto:ohad at wizery.com]
> Sent: Thursday, October 21, 2010 2:37 PM
> To: Kamoolkar, Mugdha
> Cc: Kevin Hilman; Krishnamoorthy, Balaji T; Kamat, Nishant; linux-
> omap at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; akpm at linux-foundation.org; Greg KH; Tony
> Lindgren; Cousson, Benoit; Grant Likely; Kanigeri, Hari; Anna, Suman
> Subject: Re: [PATCH 3/3] omap: add hwspinlock device
> 
> On Thu, Oct 21, 2010 at 10:36 AM, Kamoolkar, Mugdha <mugdha@ti.com>
> wrote:
> >> <khilman@deeprootsystems.com> wrote:
> >> > Yes, that would indeed simplify things.
> >>
> >> Balaji, Nishant, are you OK with this ?
> >>
> > The problem with this approach is that the i2c driver would have to
> > sync up on the shared memory location that it uses to share the
> > information of the spinlock ID.
> 
> I agree.
> 
> But we seem to have this sort of problem anyway:
> 
> Since we are forbidden to take a hwspinlock over a lengthy period of
> time, i2c-omap can't really use it directly to achieve mutual
> exclusion over the entire i2c transfer (which is long and involved
> sleeping).
> 
> It was suggested that i2c-omap would only use the hwspinlock to
> protect a shared memory entry which would indicate the owner of the
> i2c bus. Either that, or use something like Peterson's mutual
> exclusion algorithm which is entirely implemented in software.
> 
> Both of the latter approaches involves sync'ing up on a shared memory
> location..  so it seems like i2c-omap anyway has to deal with this
> kind of pain, and having a predefined hwspinlock id number doesn't
> relieve it.
> 
> What do you think ?
That is true. Perhaps we should consider adding a software 
implementation over HW spinlocks. We were anyway considering doing this, 
because the number of hw spinlocks available for our usage are not 
sufficient when we look at multi-channel use-cases. So adding a software 
module that uses a hardware spinlock for protection of its shared memory 
could be written, and then i2c could use that software module. In that 
case, if this is the only reason why i2c driver needs shared memory, 
that need would go away.

> 
> Thanks,
> Ohad.
