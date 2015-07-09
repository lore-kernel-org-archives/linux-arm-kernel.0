From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 9 Jul 2015 13:50:47 +0200
Subject: [PATCH v3 08/11] KVM: arm: implement dirty bit mechanism for
 debug registers
In-Reply-To: <20150707102405.GE23879@arm.com>
References: <1434969694-7432-1-git-send-email-zhichao.huang@linaro.org>
 <1434969694-7432-9-git-send-email-zhichao.huang@linaro.org>
 <20150630092020.GP11332@cbox>
 <B3B5AB0D-020C-483D-A6DE-76E355865010@linaro.org>
 <20150703115611.GB14220@lvm>
 <5A7DE9A0-E7A6-40B0-80F9-896F7DED0E47@linaro.org>
 <20150707102405.GE23879@arm.com>
Message-ID: <20150709115047.GK13530@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 07, 2015 at 11:24:06AM +0100, Will Deacon wrote:
> On Tue, Jul 07, 2015 at 11:06:57AM +0100, Zhichao Huang wrote:
> > Chazy and me are talking about how to reduce the saving/restoring
> > overhead for debug registers.
> > We want to add a state in hw_breakpoint.c to indicate whether the host
> > enable any hwbrpts or not (might export a fuction that kvm can call),
> > then we can read this state from memory instead of reading from real
> > hardware registers, and to decide whether we need a world switch or
> > not.
> > Does it acceptable?
> 
> Maybe, hard to tell without the code. There are obvious races to deal with
> if you use variables to indicate whether resources are in use -- why not
> just trap debug access from the host as well? Then you could keep track of
> the "owner" in kvm and trap accesses from everybody else.
> 
The only information we're looking for here is whether the host has
enabled some break/watch point so that we need to disable them before
running the guest.

Just to re-iterate, when we are about to run a guest, we have the
following cases:

1) Neither the host nor the guest has configured any [WB]points
2) Only the host has configured any [WB]points
3) Only the guest has configured any [WB]points
4) Both the host and the guest have configured any [WB]points

In case (1), KVM should enable trapping and swtich the register state on
guest accesses.

In cases (2), (3), and (4) we must switch the register state on each
entry/exit.

If we are to trap debug register accesses in KVM to set a flag to keep
track of the owner (iow. has the host touched the registers) then don't
we impose an ordering requirement of whether KVM or the breakpoint
functionality gets initialized first, and we need to take special care
when tearing down KVM to disable the traps?  It sounds a little complex.

I've previously suggested to simply look at the B/W control registers to
figure out what to do.  Caching the state in memory is an optimization,
do we even have any idea how important such an optimization is?

Thanks,
-Christoffer
