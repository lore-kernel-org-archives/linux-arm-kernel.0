From: dianders@chromium.org (Doug Anderson)
Date: Fri, 5 Sep 2014 15:11:47 -0700
Subject: [PATCH] clocksource: arch_timer: Fix code to use physical timers
 when requested
In-Reply-To: <20140828093505.GC14650@leverpostej>
References: <1409173419-13076-1-git-send-email-sonnyrao@chromium.org>
 <CAOesGMjK65Rc-K0fyFUUJLw6huLT82E-nqJwZO4PqhgopF96Ow@mail.gmail.com>
 <CAPz6YkWAPtuy4sAuAK9GtpDgfGsccxeS+pqqe_t_R818Jt01qA@mail.gmail.com>
 <53FE5B09.2020403@codeaurora.org>
 <CAOesGMhTivDzJFuxONggcJ6N5UvZopKa=+tv9PoPX593cpnm0A@mail.gmail.com>
 <53FE7E3B.1010500@codeaurora.org>
 <CAOesGMgXnsqttHwAxEW4a7-Rx-nmSwpJd_Dt1iCcFOvzDwbzdA@mail.gmail.com>
 <CAD=FV=VjN6Xam-nRRcxvOoN-gokU6DbGVjoPXN_fkTJssH1RWA@mail.gmail.com>
 <20140828093505.GC14650@leverpostej>
Message-ID: <CAD=FV=UwfP0x-bswbtV_eUvpKeOSNnsVVLTE3VHguyhm_jiSug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Thu, Aug 28, 2014 at 2:35 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> Not if you boot Linux at hyp, as we've recommended for this precise
> reason. That doesn't fix other things like CNTFRQ if the secure
> initialisation doesn't poke that, however.

I'll freely admit that I'm out of my league and out of my comfort zone
here, but...

In the theory that firmware ought to be as minimal as possible
(because it's hard to update and hard to keep in sync with kernel
versions), it seems like firmware ought to start the kernel out in as
permissive mode as it's willing to provide, right?

If the kernel is started out as permissive as possible then it can do
anything it needs to.  Future versions of the kernel can be
implemented to do any way-cool things that they want to do without an
update to firmware, right?  ...and current versions of the kernel can
just shed permissions if they don't want them.

...so if I understand correctly, "Secure SVC" mode is more permissive
than "Non Secure HYP" mode, right?  It looks to me as if we currently
start the kernel in "Secure SVC" mode.  What do you think about the
kernel detecting Secure SVC and then dropping down permission levels
(to Non Secure HYP).  Once it did this, it could update things like
the virtual offset and then transition down further into non-secure
SVC mode.


...or maybe this has been discussed millions of times already and I'm
just clueless.  ...or maybe this is just too hard for the kernel to do
in a generic way?


-Doug
