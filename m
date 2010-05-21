From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 21 May 2010 18:27:02 +0800
Subject: L2 cache support for pxa16x
In-Reply-To: <1274435046.6926.69.camel@pe-dt434>
References: <1273658181.6926.27.camel@pe-dt434>
	<AANLkTiky2tG7-n5bmMBqhKBIn7tq1tIT0KeWpkUee5YK@mail.gmail.com>
	<1274350676.6926.58.camel@pe-dt434>
	<AANLkTil839_xcOATFEFyQH5YVgWPwJcf31Wo1ZqmJ7Z6@mail.gmail.com>
	<1274435046.6926.69.camel@pe-dt434>
Message-ID: <AANLkTimdpvBJjF_JgnD1_K6AdnRjW2jaE_49eBb8CoMu@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 21, 2010 at 5:44 PM, Siddarth Gore <gores@marvell.com> wrote:
>
> On Thu, 2010-05-20 at 07:06 -0700, Eric Miao wrote:
> > On Thu, May 20, 2010 at 6:17 PM, Siddarth Gore <gores@marvell.com> wrote:
> > > On Wed, 2010-05-12 at 03:11 -0700, Eric Miao wrote:
> > >> On Wed, May 12, 2010 at 11:56 AM, Siddarth Gore <gores@marvell.com> wrote:
> > >> > Hi Eric/Haojian,
> > >> >
> > >> > Can the Tauros2 support be used for pxa168 as well? The one difference I
> > >> > can see is that L2 Enable is in control register instead of extra
> > >> > feature register. But rest of the things look very similar to me.
> > >> >
> > >
> > > I tried doing this. It works when I enable L2 before turning the MMU on,
> > > i.e. in __mohawk_setup
> > >
> > > But when I do the following in tauros2_init(), the kernel crashes.
> > > 1. flush and disable dcache
> > > 2. invalidate and disable icache
> > > 3. drain write buffer
> > > 4. invalidate TLB
> > > 5. invalidate L2
> > > 6. enable L2
> > > 7. enable icache
> > > 8. enable dcache
> > >
> > > I think the right place to enable L2 is in tauros2_init, so any idea
> > > what I am doing wrong here?
> > >
> >
> > I believe that was the reason why I didn't put tauros2 support to pxa168
> > at the first place. And enabling L2 after MMU is enabled is supposed to
> > be unsafe, which is mentioned in xscale3 manual, though not sure if that's
> > the case for pxa168 as well.
> >
> I did not find it mentioned anywhere in the mohawk (PJ1) datasheet. Also
> any idea why is this unsafe? I clean and disable the L1 cache first so
> all the page tables, etc. will be backed up in main memory before
> turning L2 on. plus invalidate the entire L2, so all the fetches will
> first go to main memory.
>
> other CPUs using tauros2 (also feroceon) turn L2 on after MMU, and they
> work fine.
>

Can you post here the changes you've made?
