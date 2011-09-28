From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 28 Sep 2011 09:12:45 +0530
Subject: [linux-pm Query] Power Management Device Suspend/ Resume
In-Reply-To: <4E8293C4.5090009@st.com>
References: <CAO1yOm2pbApTwa0gj3Q9RsC1mxNGGirxm6FzaDC7zbgjHdkKDw@mail.gmail.com>
	<4E8293C4.5090009@st.com>
Message-ID: <1317181365.1573.1636.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-09-28 at 08:55 +0530, Viresh Kumar wrote:
> Hi,
> 
> Can somebody please help us understand suspend/resume.
> It would be a great help, even if you can point us to some earlier fruitful
> discussion.
are you trying to do runtime power management or traditional suspend and
resume? IMO both should be done...
> 
> --
> viresh
> 
> On 9/22/2011 4:19 PM, Deepak Sikri wrote:
> > Hi,
> >  
> > We are in the process of adding Suspend/ Resume call backs for the devices on SPEAr platform.
> > The platform makes use of various power domains which could be turned off (during suspend, implying
> > the devices in those power domains lose their context).
> >  
> > *There are certain queries*.
> >  
> > *Query- 1*. Suppose my platform has a ADC driver under char framework, which internally uses the
> > DMA driver (channels). Now, ADC driver can be used by other kernel drivers or directly from user application.
> >  
> > *1. a.* What are the expectations from the suspend and resume routines of both the devices, DMA & ADC ?
> >  
> > */-- Given that few of the options are/*
> > */1.a.1. On suspend,/*
> > In ADC suspend function: ADC releases all the DMA channels, latches its registers; and
> > DMA suspend function: DMA does nothing except for lataching of registers if required.
> >  
> > */1.a.2. On suspend, /*
> > ADC suspend function: ADC just latches its registers and stops R/W through DMA, no DMA channel release;
> > DMA suspend function: DMA halts its operating channels, and latches its registers if required.
Well channel release/alloc is not really required. You can goto suspend
in between as well. if you have queued but not active descriptors on all
channels then dmac is idle and you can use this time to goto suspend.

> >  
> > */1.a.3 Some other alternative/*
> > *//* 
> >  
> > *1.b* Will the suspend resume for the dependent drivers follow sequencing, i.e. Suspend of ADC followed by
> > Suspend of DMA? (Assume both of these devices are hooked on to Platform bus, given that ADC uses DMA)
why do you care?
Each driver is independent and should manage its own resources properly
> >  
> > *Query-2*
> >  
> > 2.1 The user space threads freeze first followed by kernel space.  In case the user space process issues a a system
> > call (lets assume an ioctl system call), how will the user space thread respond in case of suspend to ram?
all user space processes are frozen on STR
> >  
> > 2.2 Will the kernel thread running on behalf of user space process complete the ioctl call OR 
> >  freeze upon in the middle of execution?
IIRC, It will be frozen

> >  
> > *Query-3*
> > ** 
> > Are there any modalities w.r.t latching and restoring the contents at the driver level ?
> > that is: Should this process be handled at drier level or platform specific code can also handle this
kernel context is not lost during suspend, so I don't think you need to
do much apart from resuming your device properly


-- 
~Vinod
