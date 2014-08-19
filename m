From: geoff@infradead.org (Geoff Levand)
Date: Mon, 18 Aug 2014 18:10:32 -0700
Subject: [PATCH] Arm64: convert soft_restart() to assembly code
In-Reply-To: <CAMJs5B9iCKBsSSbXvX6Y+QpOcUgEVtjBcWkcLonu3761_BkPsg@mail.gmail.com>
References: <1407847365-10873-1-git-send-email-achandran@mvista.com>
 <1408123221.22761.38.camel@smoke> <20140815182157.GD21908@leverpostej>
 <1408128799.22761.47.camel@smoke> <20140818160253.GB3302@leverpostej>
 <CAMJs5B9iCKBsSSbXvX6Y+QpOcUgEVtjBcWkcLonu3761_BkPsg@mail.gmail.com>
Message-ID: <1408410632.22761.122.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On Mon, 2014-08-18 at 19:33 +0200, Christoffer Dall wrote:
> On Mon, Aug 18, 2014 at 6:02 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > I just realised that this is still missing the jump to EL2 that I
> > mentioned a while back.
> >
> > I think what we need to do is:
> >
> > * Have KVM (if present) tears itself down prior to cpu_die, restoring
> >   the __hyp_stub_vectors in VBAR_EL2 and disabling the MMU, and caches.
> >
> > * Add a mechanism to __hyp_stub_vectors to allow a hypercall to
> >   call a function at EL2. We should be able to replace the current
> >   hyp_stub el1_sync handler with that, and rework KVM to call a function
> >   at EL2 to setup VBAR_EL2 appropriately at init time.
> >
> Why do you need to change the current mechanism?  Is this due to the
> CPU being in a different state when restarted with the MMU enabled in
> EL2 or something like that?

I haven't looked into the details of how to do it too closely yet,
but we need to handle the case where a 1st stage kernel that is not
configured with visualization support, needs to kexec re-boot to a
2nd stage kernel that will support visualization.

Also, the current arm64 bootwrapper program expects to be entered in
EL2 or higher, so a CPU running at EL1 needs to get back to EL2
before re-entering the bootwrapper program on a CPU hot-unplug.

-Geoff
