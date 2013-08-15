From: greg@kroah.com (Greg KH)
Date: Thu, 15 Aug 2013 09:01:54 -0700
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Trustzone-based security
 solution for ARM Linux
In-Reply-To: <CAGsJ_4xCFVy5mXPReULzH4cY_f+mVOK-vkp2eMOyBoNz836LqA@mail.gmail.com>
References: <CAGsJ_4xnivwNW_Pvhv7Jg62a94d5FChwqEwnNX3Miqd5fAxNHA@mail.gmail.com>
 <20130815042812.GA8968@kroah.com>
 <CABb+yY1YKGkAeb-8GbadUoV5g54iCdrYGnD_VSpaNmtfXXhpyA@mail.gmail.com>
 <CAGsJ_4yZ7Rf7UV-1u3cG_V9mrtCWD=LYBeuKQaz0SWLYoHhwwg@mail.gmail.com>
 <20130815080532.GB7080@kroah.com>
 <CAGsJ_4xCFVy5mXPReULzH4cY_f+mVOK-vkp2eMOyBoNz836LqA@mail.gmail.com>
Message-ID: <20130815160154.GC14792@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 15, 2013 at 04:22:18PM +0800, Barry Song wrote:
> 2013/8/15 Greg KH <greg@kroah.com>:
> > On Thu, Aug 15, 2013 at 03:45:13PM +0800, Barry Song wrote:
> >> 2013/8/15 Jassi Brar <jassisinghbrar@gmail.com>:
> >> > On Thu, Aug 15, 2013 at 9:58 AM, Greg KH <greg@kroah.com> wrote:
> >> >> On Thu, Aug 15, 2013 at 11:44:30AM +0800, Barry Song wrote:
> >> >>> For the moment, there is strong markting requirement from
> >> >>> IVI(In-Vehicle Infotainment) or mobile to use ARM Trustzone. We take
> >> >>> IVI as an example, Auto requires security enviorment to access CAN bus
> >> >>> and other car busses. Auto requires security enviorment to show
> >> >>> rearview/surround view from cameras and play alert audio. on the other
> >> >>> hand, IVI system is generically working as a video streaming sink and
> >> >>> HDMI sink instead of a source. To support HDCP and widevine, we need
> >> >>> to make sure private keys and video buffers are only visible to
> >> >>> security mode. With CAN stack, video playback backend and more tasks,
> >> >>> generically it requires a multi-task RTOS running in security mode
> >> >>> parallel with Linux in non-security mode.
> >> >>>
> >> >>> Linux is a generic purpose OS with UI and all kinds of software, but
> >> >>> we need to make sure even the Linux is ROOTed, RTOS in security mode
> >> >>> is still active. We are able to find some opensource projects like
> >> >>> SafeG[1], Multivisor[2], SierraVisor[3], but it turns out that ARM
> >> >>> Linux has no rich support for this kind of architecture:
> >> >>> 1. hypervisor running in monitor mode
> >> >>> 2. RTOS running in security mode
> >> >>> 3. Linux running in non-security mode
> >> >>
> >> >> "Linux" is just a kernel, not a whole operating system :)
> >> >>
> >> >> Anyway, why can't Linux be the RTOS kernel as well?  What are the
> >> >> requirements for that kernel that Linux does not currently meet?
> >>
> >> we will run rtos+linux instead of linux+linux. typically, Auto
> >> industry has long history to use rtos. on the other hand, we need to
> >> boot the rtos very fast in hundreds of milliseconds to make sure
> >> rearview, early audio have been ready.
> >
> > But Linux is a RTOS, and a really good one at that.  Linux already boots
> > that fast, and solves the rearview/early audio issue just fine (I've
> > seen it demoed), so please don't think that Linux can't do this.
> >
> 
> i think my key point is it doesn't really matter whether linux or rtos
> will work as backend, my key point is that we need one OS running in
> security mode, the other one running in non-security mode. if linux is
> good enough, linux can be the RTOS of backend.

Great, I'm glad we agree :)

> i believe linux can do early audio/rearview well as CSR has delivered
> this kind of solution already with some ugly hacking in kernel. it is
> not easy to upstream them.

What specific "hacks" did you have to do?  Do you have a pointer to them
anywhere so that we can see what we need to integrate into mainline?
Have you tried to merge them and gotten push-back?

> > Again, what is the requirements of this RTOS that prevent you from using
> > Linux instead in that "secure" part of the chip?  What do we need to
> > change in order to meet this need?
> 
> if we have linux+linux, we need same changes in linux as well.

I agree, do you have pointers to where you have made these changes
already to show that it can be done?

> let's just ignore the issue whether backend should be linux or another
> rtos as that doesn't change my requirement about linux :-)

Fair enough :)

> >> >>> 3. as some CPU time is stolen by security mode, so the scheduler need
> >> >>> to get this for load balance
> >> >>
> >> >> Does the kernel know this time is gone?  Or is it not aware of it (like
> >> >> MSIs on x86?)
> >> >>
> >> > The TrustedOS could share time on the same cpu as the UnTrustedOS or
> >> > be assigned a dedicated cpu on an MP.
> >>
> >> no. TrustedOS will not hold a whole CPU and we don't put a whole core
> >> to RTOS as it has low CPU loading.
> >> Linux need to know how much time has been taken by TrustOS for every
> >> core, and do load balance considering stolen time by TrustOS.
> >
> > How will it be told that it just lost an amount of time?  How is that
> > loss of time supposed to affect the scheduler?  What do you expect the
> > scheduler to do in response to this loss?
> 
> i think in kvm and xen, we need to implement a callback to tell linux
> about stolen time. but now we just trap into security, we need to tell
> linux as well.

For kvm and xen we don't have a callback into the scheduler (or at least
if we do, I don't know about it, do you have a pointer to it?)

> stolen time will affect the "power" of the core, so affect the loading
> which is equal with loading/power. after time is stolen, power will be
> less, so with same linux loading, the core with stolen time will
> result in more actual loading as its power is lower, scheduler will
> know it and balance linux tasks.

Ah, so do you say this ties into the "power scheduling" changes that
people are proposing?  Have you looked at those patches?  Otherwise,
just like with kvm and xen and vmware and hyperv, the scheduler doesn't
know anything about the "lost" ticks, nor does it need to, as it's only
concerned about scheduing the tasks it has control over, not the ones it
can't do anything about (i.e. the "stolen" time.)

thanks,

greg k-h
