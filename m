From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 10 Sep 2014 16:47:09 +0100
Subject: [PATCH] clocksource: arch_timer: Fix code to use physical timers
 when requested
In-Reply-To: <54106707.4010006@codeaurora.org>
References: <CAOesGMjK65Rc-K0fyFUUJLw6huLT82E-nqJwZO4PqhgopF96Ow@mail.gmail.com>
 <CAPz6YkWAPtuy4sAuAK9GtpDgfGsccxeS+pqqe_t_R818Jt01qA@mail.gmail.com>
 <53FE5B09.2020403@codeaurora.org>
 <CAOesGMhTivDzJFuxONggcJ6N5UvZopKa=+tv9PoPX593cpnm0A@mail.gmail.com>
 <53FE7E3B.1010500@codeaurora.org>
 <CAOesGMgXnsqttHwAxEW4a7-Rx-nmSwpJd_Dt1iCcFOvzDwbzdA@mail.gmail.com>
 <CAD=FV=VjN6Xam-nRRcxvOoN-gokU6DbGVjoPXN_fkTJssH1RWA@mail.gmail.com>
 <20140828093505.GC14650@leverpostej>
 <CAD=FV=UwfP0x-bswbtV_eUvpKeOSNnsVVLTE3VHguyhm_jiSug@mail.gmail.com>
 <54106707.4010006@codeaurora.org>
Message-ID: <20140910154709.GF31237@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 03:58:15PM +0100, Christopher Covington wrote:
> On 09/05/2014 06:11 PM, Doug Anderson wrote:
> > On Thu, Aug 28, 2014 at 2:35 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> >> Not if you boot Linux at hyp, as we've recommended for this precise
> >> reason. That doesn't fix other things like CNTFRQ if the secure
> >> initialisation doesn't poke that, however.
> > 
> > I'll freely admit that I'm out of my league and out of my comfort zone
> > here, but...
> > 
> > In the theory that firmware ought to be as minimal as possible
> > (because it's hard to update and hard to keep in sync with kernel
> > versions), it seems like firmware ought to start the kernel out in as
> > permissive mode as it's willing to provide, right?
> > 
> > If the kernel is started out as permissive as possible then it can do
> > anything it needs to.  Future versions of the kernel can be
> > implemented to do any way-cool things that they want to do without an
> > update to firmware, right?  ...and current versions of the kernel can
> > just shed permissions if they don't want them.
> > 
> > ...so if I understand correctly, "Secure SVC" mode is more permissive
> > than "Non Secure HYP" mode, right?  It looks to me as if we currently
> > start the kernel in "Secure SVC" mode.  What do you think about the
> > kernel detecting Secure SVC and then dropping down permission levels
> > (to Non Secure HYP).  Once it did this, it could update things like
> > the virtual offset and then transition down further into non-secure
> > SVC mode.
> > 
> > ...or maybe this has been discussed millions of times already and I'm
> > just clueless.  ...or maybe this is just too hard for the kernel to do
> > in a generic way?
> 
> I think this is a great idea. When running on simulators, it would make (the
> non-DTB parts of) the bootwrapper and QEMU's built-in bootloader unnecessary.
> 
> Implementing it on AArch64 should be trivial as you can just read CurrentEL
> and work from whatever EL/PL you're at. Is there an easy way to check whether
> you're in secure or nonsecure mode in AArch32? I seem to recall discussion
> about putting this information into the DTB, which makes me think there isn't.

(I replied couple of days ago but the SMTP server I was using still
hasn't delivered it)

Anyway, for AArch64 you get the CurrentEL but does not tell you whether
it's secure or not (the same as the mode bits in CPSR basically). Secure
EL1 is not more permissive than non-secure EL2, you still have to go
through EL3 firmware using an SMC call to be able to switch to EL2. So
for AArch64, you need to rely on firmware to do at least the correct
initialisation (unless you start the kernel at EL3).

-- 
Catalin
