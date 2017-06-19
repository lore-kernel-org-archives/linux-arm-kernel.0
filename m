From: hzpeterchen@gmail.com (Peter Chen)
Date: Mon, 19 Jun 2017 08:59:02 +0800
Subject: [PATCH v15 2/7] power: add power sequence library
In-Reply-To: <20170615100604.GC24157@b29397-desktop>
References: <1497319166-17287-1-git-send-email-peter.chen@nxp.com>
 <1497319166-17287-3-git-send-email-peter.chen@nxp.com>
 <CAPDyKFpOQWTPpdd__OBP1DcW58CbqnygGAOxiEFq5kqqvCm0QA@mail.gmail.com>
 <20170614015338.GA4635@b29397-desktop>
 <CAPDyKFrLL10TY1JZAhF44_0+qGETLNtFc6ujKVUu7Ay=O8+M5A@mail.gmail.com>
 <20170615065854.GA24157@b29397-desktop>
 <CAPDyKFpc8GRKK8bafMU_HPaqWNrger3grPSd5rWWCTYhUGHZLA@mail.gmail.com>
 <20170615091131.GB24157@b29397-desktop>
 <CAPDyKFrZoyoYCQA1rnRbz9tmT9vJigzSb+xyTZpJjhd=5eFA5A@mail.gmail.com>
 <20170615100604.GC24157@b29397-desktop>
Message-ID: <20170619005902.GA6456@b29397-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 15, 2017 at 06:06:04PM +0800, Peter Chen wrote:
> On Thu, Jun 15, 2017 at 11:35:20AM +0200, Ulf Hansson wrote:
> > On 15 June 2017 at 11:11, Peter Chen <hzpeterchen@gmail.com> wrote:
> > > On Thu, Jun 15, 2017 at 10:11:45AM +0200, Ulf Hansson wrote:
> > >> > Yes, you are right. This is the limitation for this power sequence
> > >> > library, the registration for the 1st power sequence instance must
> > >> > be finished before device driver uses it. I am appreciated that
> > >> > you can supply some suggestions for it.
> > >>
> > >> In general this kind of problems is solved by first parsing the DTB,
> > >> which means you will find out whether there is a resource (a pwrseq)
> > >> required for the device. Then you try to fetch that resource, and if
> > >> that fails, it means the resource is not yet available, and hence you
> > >> want to retry later and should return -EPROBE_DEFER.
> > >>
> > >> In this case, of_pwrseq_on() needs to be converted to start looking
> > >> for a pwrseq compatible in it's child node - I guess. Then if that is
> > >> found, you try to fetch the instance of the corresponding library.
> > >> Failing to fetch the library instance should then cause a return
> > >> -EPROBE_DEFER.
> > >
> > > The most difficulty for this is we can't know whether the requested
> > > pwrseq instance will be registered or not, the kernel configuration
> > > for this pwrseq library may not be chosen at all.
> > 
> > In such case it is still correct to return -EPROBE_DEFER, because the
> > driver that tries to probe its device will fail unless it can run the
> > needed pwrseq. Right?
> > 
> 
> Unlike the MMC design, there is no dts entry to indicate whether this
> device needs pwrseq or not at this design, it will only carry out power
> on sequence after matching. So, return -EPROBE_DEFER may not work since
> this device may never need pwrseq.
> 

Ulf, since it is the use case limitation, it can't work like device
driver. Do you have more comments for it, thanks.

Peter


> > >
> > >>
> > >> >
> > >> >> Moreover, I have found yet another severe problem but reviewing the code:
> > >> >> In the struct pwrseq, you have a "bool used", which you are setting to
> > >> >> "true" once the pwrseq has been hooked up with the device, when a
> > >> >> driver calls of_pwrseq_on(). Setting that variable to true, will also
> > >> >> prevent another driver from using the same instance of the pwrseq for
> > >> >> its device. So, to cope with multiple users, you register a new
> > >> >> instance of the same pwrseq library that got hooked up, once the
> > >> >> ->get() callback is about to complete.
> > >> >>
> > >> >> The problem the occurs, when there is another driver calling
> > >> >> of_pwrseq_on() in between, meaning that the new instance has not yet
> > >> >> been registered. This will simply fail, won't it?
> > >> >
> > >> > Yes, you are right, thanks for pointing that, I will add mutex_lock for
> > >> > of_pwrseq_on.
> > >>
> > >> Another option is to entirely skip to two step approach.
> > >>
> > >> In other words, make the library to cope with multiple users via the
> > >> same registered library instance.
> > >>
> > >
> > > No, the pwrseq instance stores dtb information (clock, gpio, etc), it
> > > needs to be per device.
> > 
> > I think you misunderstood my suggestion here. Of course you need to
> > allocate one pwrseq data per device.
> > 
> > However, my point is that you shouldn't need more than one instance of
> > the library functions to be registered in the list of available pwrseq
> > libraries.
> > 
> 
> This additional instance is used to store compatible information for
> this pwrseq library, it is used for the next matching between device
> and pwrseq library, it just likes we need the first pwrseq instance
> registered at boot stage.
> 
> -- 
> 
> Best Regards,
> Peter Chen
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 

Best Regards,
Peter Chen
