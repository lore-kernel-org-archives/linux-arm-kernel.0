From: greg@kroah.com (Greg KH)
Date: Tue, 12 Apr 2011 08:16:12 -0700
Subject: [RFC][PATCH V3] axi: add AXI bus driver
In-Reply-To: <BANLkTikR2AwBdORYUdTCcAOPeMkKN7azQQ@mail.gmail.com>
References: <BANLkTim155YxMUVJ=pmVs-rNhkovGPG6OQ@mail.gmail.com>
	<20110411212513.GA17809@kroah.com>
	<BANLkTingqXAWTeOhcL6ER0UJfEdQF5Bo2A@mail.gmail.com>
	<20110411215619.GA27943@kroah.com>
	<BANLkTimjThXn347+=m98NsBXY84guJjNqA@mail.gmail.com>
	<20110411223632.GB31833@kroah.com>
	<BANLkTinpKKRCrBik6-9C5WqcSDGuEt5yCw@mail.gmail.com>
	<20110411233506.GA13240@kroah.com>
	<BANLkTi=cG3U8yXaQ6PusmNaWcr+AWv3e_w@mail.gmail.com>
	<BANLkTikR2AwBdORYUdTCcAOPeMkKN7azQQ@mail.gmail.com>
Message-ID: <20110412151612.GB20978@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2011 at 01:40:36PM +0200, Rafa? Mi?ecki wrote:
> 2011/4/12 Rafa? Mi?ecki <zajec5@gmail.com>:
> > 2011/4/12 Greg KH <greg@kroah.com>:
> >> On Tue, Apr 12, 2011 at 12:45:33AM +0200, Rafa? Mi?ecki wrote:
> >>> 2011/4/12 Greg KH <greg@kroah.com>:
> >>> > Then in your release function, free the struct axi_device. ?It's that
> >>> > simple. ?To try to free it before then would be wrong and cause
> >>> > problems.
> >>>
> >>> This is because it is defined as:
> >>> struct axi_device cores[AXI_MAX_NR_CORES];
> >>
> >> No way, seriously?
> >>
> >> You can't do that, no static struct devices please. ?Make these dynamic
> >> and everything will be fine. ?The -mm tree used to have a huge warning
> >> if you ever tried to register a statically allocated struct, but that
> >> didn't really work out, but would have saved you a lot of time here,
> >> sorry.
> >>
> >> So dynamically allocate the structures and you will be fine.
> >
> > Well, I saw that along kernel, I had no idea there is anything wrong
> > about this. It seems more ppl do not know about this:
> > struct radeon_ib ? ? ? ?ibs[RADEON_IB_POOL_SIZE];
> > struct radeon_pm_clock_info clock_info[8];
> > struct radeon_pm_profile profiles[PM_PROFILE_MAX];
> > struct radeon_surface_reg surface_regs[RADEON_GEM_MAX_SURFACES];
> > struct radeon_i2c_chan *i2c_bus[RADEON_MAX_I2C_BUS];
> >
> > struct b43_key key[B43_NR_GROUP_KEYS * 2 + B43_NR_PAIRWISE_KEYS];
> >
> > struct ssb_device devices[SSB_MAX_NR_CORES];
> > I guess I could fine more examples by simple grepping .h files.
> >
> > Is there some guide around with things like this we should avoid?
> > checkpatch does no catch this, so maybe just some manual? Could you
> > point me to it?
> 
> Greg, my:
> struct ssb_device devices[SSB_MAX_NR_CORES];
> is part of "struct axi_bus", which we allocate dynamically anyway:
> 
> struct axi_bus *bus;
> bus = kzalloc(sizeof(*bus), GFP_KERNEL);
> if (!bus)
> 	goto out;
> 
> So do we really need to dynamically alloc main structure and
> separately every of it's array of structs? Does it really make sense?

What?  You allocate the bus and all of the devices all at once?  That's
insane.

> Please point me to some place where I can read more about this. Some
> tips about coding style for such things, cases.

Any structure that is reference counted, can only be reference counted
by one part of that object, AND it has to be unique from all other
objects.

thanks,

greg k-h
