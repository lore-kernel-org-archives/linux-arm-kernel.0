From: will.deacon@arm.com (Will Deacon)
Date: Thu, 24 Sep 2015 18:52:57 +0100
Subject: [PATCH] arm: perf: Add event descriptions
In-Reply-To: <20150817214035.GA25775@dreric01-gentoo.localdomain>
References: <20150804001522.GA13214@dreric01-gentoo.localdomain>
 <20150817205809.GA16506@dreric01-gentoo.localdomain>
 <20150826165148.GF30466@arm.com>
 <20150817214035.GA25775@dreric01-gentoo.localdomain>
Message-ID: <20150924175257.GH7356@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Drew,

On Mon, Aug 17, 2015 at 10:40:36PM +0100, Drew Richardson wrote:
> On Wed, Aug 26, 2015 at 05:51:49PM +0100, Will Deacon wrote:
> > but I do have reservations about putting all these
> > strings into the kernel. Why can't we put this into something like libpfm
> > instead?
> > 
> 
> My intent is to make it easier for people to use hardware counters on
> ARM, particularly with new CPUs. Currently, the developer of the tool
> needs to extract the event information from the ARM TRMs, add it to
> their tool and make a new release. This work is done by multiple
> tools, for example for the Cortex-A15:
> 
> http://sourceforge.net/p/perfmon2/libpfm4/ci/master/tree/lib/events/arm_cortex_a15_events.h
> http://sourceforge.net/p/oprofile/oprofile/ci/master/tree/events/arm/armv7-ca15/events
> https://github.com/ARM-software/gator/blob/master/daemon/events-Cortex-A15.xml
> 
> There are likely more tools, these are the ones I could easily
> find. Note that the new ARM Cortex-A72 isn't supported by most of
> them. And the perf command line tool doesn't have any of this.

So to repeat the question, why can't libpfm be used instead? It doesn't seem
like it would be too much work to integrate that with the perf tool.

> Once the tool supports the new CPUs events the user needs to make sure
> they're running a recent version of the tool that contains these
> events for their new ARM CPU. Technically the user could add the event
> information themselves and upstream the change, but not all users will
> do this.

How does moving this into the kernel remove the need to upstream new
event descriptions?

> So my suggestion to solve the problem is that the kernel can have the
> list of events as proposed in the patch.

Sorry, but I just don't buy this argument. Your problem is that the user
needs to be running an up-to-date perf tool, but with your proposed
solution, you're asking them to update the *kernel* instead, which is
(unfortunately) one of the hardest pieces of software to upgrade on a
typical ARM platform.

> This is already done for some PMUs like arm-ccn and arm-cci. If the tool
> doesn't support the particular CPU, they can fall back to the event list
> provided by the kernel. There will be some information missing like
> user-friendly descriptions of the events, but it's hopefully enough that
> users can do what they need to do and update their tool at a later time.

The problem is somewhat simpler for system PMUs, which don't suffer from
the variations that we encounter on the CPU side and are also less uniform.

Will
