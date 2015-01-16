From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 16 Jan 2015 10:17:47 +0000
Subject: [PATCH v7 1/4] Documentation: dt: add common bindings for
 hwspinlock
In-Reply-To: <CAK=WgbYQ=BbinqJ5fsw2Y+FKdy=nasLsw9mX8pw6S_o3owy9-g@mail.gmail.com>
References: <1421269101-51105-1-git-send-email-s-anna@ti.com>
 <1421269101-51105-2-git-send-email-s-anna@ti.com>
 <20150115135201.GG16217@leverpostej>
 <20150115135556.GH16217@leverpostej>
 <CAL_JsqL2LZAooMk-V8+xeF2g6acZE21M+-OBRw8aEVa-5wVHuQ@mail.gmail.com>
 <CAK=WgbYQ=BbinqJ5fsw2Y+FKdy=nasLsw9mX8pw6S_o3owy9-g@mail.gmail.com>
Message-ID: <20150116101746.GA21809@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 06:09:00AM +0000, Ohad Ben-Cohen wrote:
> On Thu, Jan 15, 2015 at 4:42 PM, Rob Herring <robherring2@gmail.com> wrote:
> > On Thu, Jan 15, 2015 at 7:55 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> >> On Thu, Jan 15, 2015 at 01:52:01PM +0000, Mark Rutland wrote:
> >>> On Wed, Jan 14, 2015 at 08:58:18PM +0000, Suman Anna wrote:
> >>> > +- hwlock-base-id:  An unique base Id for the locks for a particular hwlock
> >>> > +                   device. This property is mandatory for all platform
> >>> > +                   implementations.
> >>>
> >>> This property makes no sense. The ID encoded in the hwlock cells is
> >>> relative to the instance (identified by phandle), not global. So the DT
> >>> has no global ID space.
> >>>
> >>> Why do you think you need this?
> >>
> >> Having looked at the way this proeprty is used, NAK.
> >>
> >> If you need to carve up a Linux-internal ID space, do that dynamically.
> >> There is no need for this property.
> >
> > Better yet, don't create a Linux ID space for this. Everywhere we have
> > one, we want to get rid of it.
> 
> Rob, Mark,
> 
> The hwlock is a basic hardware primitive that allow synchronization
> between different processors in the system, which may be running Linux
> as well as other operating systems, and may have no other means of
> communication.
> 
> The hwlock id numbers are predefined, global and static across the
> entire system: Linux may boot well after other operating systems are
> already running and using these hwlocks to communicate, and therefore,
> in order to use these hardware devices, it must not enumerate them
> differently than the rest of the system.

That's not true.

In order to communicate it must agree with the other users as to the
meaning of each instance, and the protocol for use. That doesn't
necessarily mean that Linux needs to know the numerical ID from a
datasheet, and regardless that ID is separate from the logical ID Linux
uses internally.

> Given that these id numbers are global, system-wide, static and
> predefined, where Linux may just be one user of them, please
> reconsider the approach as implemented by Suman, or suggest an
> alternative one you may prefer.

To communicate with the other processors, Linux will need to understand
the protocol. So there will need to be nodes in the DT describing the
protocol. Those nodes can refer to the relevant locks using phandle +
args (with a hwlock-names list if indexing is not appropriate). The
entire point of the hwlock-cells is to allow individual locks to be
referred to in this way.

Thanks,
Mark.
