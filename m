From: panand@redhat.com (Pratyush Anand)
Date: Wed, 8 Jun 2016 13:43:17 +0530
Subject: Support for unaligned watchpoints in arm/arm64
In-Reply-To: <CAJt8pk88RCy4s=oZ=NpkZdXCRhERB1USVdXTc9OYE-vs9chkyQ@mail.gmail.com>
References: <CAJt8pk8FBbTVMMM45SaEs86MZOp0o6xChAsMT1sO+_Xy-GENyw@mail.gmail.com>
 <20160531123827.GF24936@arm.com> <20160607065520.GD13643@dhcppc6>
 <20160607151722.GH13643@dhcppc6>
 <CAJt8pk88RCy4s=oZ=NpkZdXCRhERB1USVdXTc9OYE-vs9chkyQ@mail.gmail.com>
Message-ID: <20160608081317.GA24802@dhcppc6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

On 07/06/2016:05:15:03 PM, Pavel Labath wrote:
> On 7 June 2016 at 08:17, Pratyush Anand <panand@redhat.com> wrote:
> > On 07/06/2016:12:25:20 PM, Pratyush Anand wrote:
> >> On 31/05/2016:01:38:27 PM, Will Deacon wrote:
> >> > On Thu, May 26, 2016 at 05:04:46PM +0100, Pavel Labath wrote:
> >> > > Hello all,
> >> >
> >> > Hi Pavel,
> >> >
> >> > > I've been wondering if there are any plans about adding support for
> >> > > unaligned watchpoints to the kernel. It seems quite a shame that
> >> > > applications are not able not use them, even though the hardware
> >> > > should support that feature.
> >> >
> >> > I'm actually coming round to the idea of ditching the perf hw_breakpoint
> >> > mechanism entirely and simply writing a ptrace back-end that can expose
> >> > the hardware features directly to userspace. The two issues with this
> >> > are:
> >> >
> >> >   (1) It's a fair amount of work
> >>
> >> So, by the time this new interface would come, probably we can consider a fixup
> >> like following to resolve this issue at hand. Probably, things should work by
> >> just allowing hw_breakpoint.c to pass checks for unaligned offset when it is a
> >> WATCHPOINT, no?
> >
> > Sorry, this is not going to work.
> > There could be some BAS values where few consecutive LSBs are 0s.
> >
> 
> Thank you for the replies.
> 
> I would definitely welcome a more immediate fix to this issue,
> although I can appreciate the reluctance to add ugly fixups to make
> this work.
> 
> Pratyush, building on your proposed fix, I think we could extend it to
> make it work for watching values which are not word-aligned by
> tweaking  perf_event_attr.bp_addr field. E.g. if the BAS value is
> 00111100 then we can set bp_addr to "aligned_addr + 2" and bp_len to

I think, DBGWVR will receive only aligned address.

> 4. From an interface point of view I think this would be a nice
> solution. ptrace userspace user would set these breakpoints just like
> it would do when programming a real register, and the contents of the
> struct perf_event_attr will make perfect sense: "we have set a
> watchpoint at bp_addr with length bp_len". The only problem is that
> the code for converting between the perf_event_attr and hardware
> register representations will be quite ugly. Also, I don't know if

Yes, will have to adjust programming of both DBGWVR and DBGWCR  if bp_addr is
unaligned.

> this will cause a problem with any other users of perf_event_attr if
> they expect bp_addr field to be word-aligned.
> 
> If you would be willing to consider such a patch, I can take a stab at
> writing it. What do you think?

I am not the right person to answer this. Will Deacon is.

Thanks for your willingness to help on it :-)

~Pratyush
