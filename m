From: greg@kroah.com (Greg KH)
Date: Thu, 15 Aug 2013 01:05:32 -0700
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Trustzone-based security
 solution for ARM Linux
In-Reply-To: <CAGsJ_4yZ7Rf7UV-1u3cG_V9mrtCWD=LYBeuKQaz0SWLYoHhwwg@mail.gmail.com>
References: <CAGsJ_4xnivwNW_Pvhv7Jg62a94d5FChwqEwnNX3Miqd5fAxNHA@mail.gmail.com>
 <20130815042812.GA8968@kroah.com>
 <CABb+yY1YKGkAeb-8GbadUoV5g54iCdrYGnD_VSpaNmtfXXhpyA@mail.gmail.com>
 <CAGsJ_4yZ7Rf7UV-1u3cG_V9mrtCWD=LYBeuKQaz0SWLYoHhwwg@mail.gmail.com>
Message-ID: <20130815080532.GB7080@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 15, 2013 at 03:45:13PM +0800, Barry Song wrote:
> 2013/8/15 Jassi Brar <jassisinghbrar@gmail.com>:
> > On Thu, Aug 15, 2013 at 9:58 AM, Greg KH <greg@kroah.com> wrote:
> >> On Thu, Aug 15, 2013 at 11:44:30AM +0800, Barry Song wrote:
> >>> For the moment, there is strong markting requirement from
> >>> IVI(In-Vehicle Infotainment) or mobile to use ARM Trustzone. We take
> >>> IVI as an example, Auto requires security enviorment to access CAN bus
> >>> and other car busses. Auto requires security enviorment to show
> >>> rearview/surround view from cameras and play alert audio. on the other
> >>> hand, IVI system is generically working as a video streaming sink and
> >>> HDMI sink instead of a source. To support HDCP and widevine, we need
> >>> to make sure private keys and video buffers are only visible to
> >>> security mode. With CAN stack, video playback backend and more tasks,
> >>> generically it requires a multi-task RTOS running in security mode
> >>> parallel with Linux in non-security mode.
> >>>
> >>> Linux is a generic purpose OS with UI and all kinds of software, but
> >>> we need to make sure even the Linux is ROOTed, RTOS in security mode
> >>> is still active. We are able to find some opensource projects like
> >>> SafeG[1], Multivisor[2], SierraVisor[3], but it turns out that ARM
> >>> Linux has no rich support for this kind of architecture:
> >>> 1. hypervisor running in monitor mode
> >>> 2. RTOS running in security mode
> >>> 3. Linux running in non-security mode
> >>
> >> "Linux" is just a kernel, not a whole operating system :)
> >>
> >> Anyway, why can't Linux be the RTOS kernel as well?  What are the
> >> requirements for that kernel that Linux does not currently meet?
> 
> we will run rtos+linux instead of linux+linux. typically, Auto
> industry has long history to use rtos. on the other hand, we need to
> boot the rtos very fast in hundreds of milliseconds to make sure
> rearview, early audio have been ready.

But Linux is a RTOS, and a really good one at that.  Linux already boots
that fast, and solves the rearview/early audio issue just fine (I've
seen it demoed), so please don't think that Linux can't do this.

Again, what is the requirements of this RTOS that prevent you from using
Linux instead in that "secure" part of the chip?  What do we need to
change in order to meet this need?

> > Yes, in fact at least during development Linux usually runs in Secure mode.
> > Ideally I would love to see 2 instances of Linux running - one in
> > NonSecure mode and another in Secure mode, getting capabilities via 2
> > corresponding DTBs reflecting the h/w partitioning done by the TZ.
> 
> not real. i think there are similar users in linux already. at least
> omap and exynos have some chip specific codes like omap-smc.S,
> sleep34xx.S, exynos-smc.S and so on.
> 
> and i have explained why we don't use linux+linux.

I still don't understand why not.  Boot/audio don't seem like good
reasons, again because other people have used Linux just fine for that
application, meeting those legal requirements, in IVI systems.  I know
of a number of companies that will sell you Linux for that very
application, so you could just buy it from someone else if you don't
want to build it yourself :)

> >>> 3. as some CPU time is stolen by security mode, so the scheduler need
> >>> to get this for load balance
> >>
> >> Does the kernel know this time is gone?  Or is it not aware of it (like
> >> MSIs on x86?)
> >>
> > The TrustedOS could share time on the same cpu as the UnTrustedOS or
> > be assigned a dedicated cpu on an MP.
> 
> no. TrustedOS will not hold a whole CPU and we don't put a whole core
> to RTOS as it has low CPU loading.
> Linux need to know how much time has been taken by TrustOS for every
> core, and do load balance considering stolen time by TrustOS.

How will it be told that it just lost an amount of time?  How is that
loss of time supposed to affect the scheduler?  What do you expect the
scheduler to do in response to this loss?

thanks,

greg k-h
