From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 8 May 2013 12:19:52 +0100
Subject: [Xen-devel] [PATCH 1/3] arm_arch_timer: introduce
 arch_timer_stolen_ticks
In-Reply-To: <51892933.7090405@codeaurora.org>
References: <alpine.DEB.2.02.1305011939180.5398@kaball.uk.xensource.com>
 <1367436460-10183-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <51817CBE.4050003@codeaurora.org>
 <1367482772.21869.26.camel@zakaz.uk.xensource.com>
 <5182DBA9.9080609@codeaurora.org>
 <20130506143533.GF15278@phenom.dumpdata.com> <51892933.7090405@codeaurora.org>
Message-ID: <alpine.DEB.2.02.1305081217010.18865@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 7 May 2013, Christopher Covington wrote:
> Hi Konrad,
> 
> On 05/06/2013 10:35 AM, Konrad Rzeszutek Wilk wrote:
> >>> e.g. if a VCPU sets a timer for NOW+5, but 3 are stolen in the middle it
> >>> would not make sense (from the guests PoV) for NOW'==NOW+2 at the point
> >>> where the timer goes off. Nor does it make sense to require that the
> >>> guest actually be running for 5 before injecting the timer because that
> >>> would mean real time elapsed time for the timer would be 5+3 in the case
> >>> where 3 are stolen.
> >>
> >> This is a bit of an aside, but I think that hiding time spent at higher
> >> privilege levels can be a quite sensible approach to timekeeping in a
> >> virtualized environment, but I understand that it's not the approach taken
> >> with Xen, and as you pointed out above, adjusting the Virtual Offset Register
> >> by itself isn't enough to implement that approach.
> > 
> > This is the approach taken by Xen and KVM. Look in CONFIG_PARAVIRT_CLOCK for
> > implementation. In the user-space, the entry in 'top' of "stolen" (%st)
> > is for this exact value.
> 
> I may have been unclear with my terms, sorry. When I refer to time being
> "hidden", I mean that kernel level software (supervisor mode, EL1) cannot
> detect the passage of that time at all. I don't know whether this would really
> work, but I imagine one might be able to get close with the current
> virtualization facilities for ARM.
> 
> Am I correct in interpreting that what you're referring to is the deployment
> of paravirtualization code that ensures (observable) "stolen" time is factored
> into kernel decision-making?

Although it might be possible to hide the real time flow from the VM, it
is inadvisable: what would happen when the VM needs to deal with a real
hardware device? Or just send packets over the network?  This is why it
is much safer and more reliable to expose the stolen ticks to the VM.
