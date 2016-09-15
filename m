From: pure.logic@nexus-software.ie (Bryan O'Donoghue)
Date: Thu, 15 Sep 2016 12:48:08 +0100
Subject: [GIT PULL] Greybus driver subsystem for 4.9-rc1
In-Reply-To: <20160915112029.GC6718@leverpostej>
References: <20160914100949.GA6179@kroah.com>
 <20160914173625.GB15356@leverpostej> <20160914180754.GA16053@kroah.com>
 <20160914182952.GA21615@kroah.com>
 <1473932133.10230.25.camel@nexus-software.ie>
 <20160915101330.GB6718@leverpostej>
 <1473935756.10230.42.camel@nexus-software.ie>
 <20160915112029.GC6718@leverpostej>
Message-ID: <1473940088.10230.65.camel@nexus-software.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-09-15 at 12:20 +0100, Mark Rutland wrote:
> Hi,
> 
> More questions below. Perhaps some of these will be implicitly
> answered
> when the linearised patches appear, and I'm happy to wait until then
> to
> continue the discussion, as I suspect otherwise we're all likely to
> end
> up exasperated.
> 
> Please do Cc me on those.
> 
> Regardless, until those appear and a reasonable time has been given
> for
> replies, my comments regarding the lack of review stand, as does my
> NAK
> for the series.
> 
> On Thu, Sep 15, 2016 at 11:35:56AM +0100, Bryan O'Donoghue wrote:
> > 
> > On Thu, 2016-09-15 at 11:13 +0100, Mark Rutland wrote:
> > > 
> > > On Thu, Sep 15, 2016 at 10:35:33AM +0100, Bryan O'Donoghue wrote:
> > > > 
> > > > ?
> > > I don't think the history matters,?
> > Your comment seemed to indicate you thought we were reading a
> > architectural timer directly - which we aren't.
> Sure, and as I pointed out, the comment in the HEAD commit still
> claims
> it does, even if the code doesn't. This is at best, confusing, and
> the
> history of how it came to be there doesn't really matter...

TBH a whole git history will invariably contain things developers did,
thought better of and then backed out as is the case here.

> 
> > 
> > > 
> > > and I don't think that one can rely
> > > on get_cycles() in this manner outside of arch code.
> > I don't follow your meaning. What's wrong with get_cycles() ?
> > You've
> > already said you don't think reading an architectural timer
> > directly is
> > correct.
> I pointed out a number of issues in my previous reply.

On MSM8994 the timer backing get_cycles() is one of the MMIO
architectural timers (which is why I switched over in the end). There's
not much else that can be done bar custom silicon - this particular
timer is as good as it gets, more of a "how do we synchronise time with
the hardware we have" than a "lets design in a feature to synchronise
time" - which was something we were focusing in on for later
silicon...?

> 
> For example, you have absolutely no guarantee as to what backs
> get_cycles(). Despite this, the code assumes that get_cycles() is
> backed
> by something running at the frequency described in a
> "google,greybus-frame-time-counter" node.
> 
> Even if this *happens* to match what some piece of arch code provides
> today on some platform, it is in no way *guaranteed*.

That's the point though, if you declare "google,greybus-frame-time-
counter" in your platform code - then you can use 'get_cycles()' in
this manner - if not - then you need to take steps in your own new
platform to provide that same level of functionality. You could switch
to an MSM8996 or an MSM8998 declare this node and bob's your uncle.

OTOH declaring this node on x86 would be a bit pointless. You'd be
better off providing a timer on a PCI bar, and binding that into
greybus with some x86/x86-platform code...

> 
> > 
> > The objective is to read one of the free-running counters in
> > MSM8994,
> > clocked by the PMIC. The refclk provided by PMIC is distributed to
> > each
> > processor in the system.
> > 
> > > 
> > > ?Looking at the
> > > state of the tree [1] as of the final commit [2] in the greybus
> > > branch,
> > > my points still stand:
> > > 
> > > * The "google,greybus-frame-time-counter" node is superfluous. It
> > > does
> > > ? not describe a particular device,
> > It describes a timer running @ 19.2MHz, clocked by PMIC refclk.
> ... which you assume is whatever backs get_cycles(), which you in
> practice assume is the architected timer. For which we *already* have
> a
> binding and driver.

It's a requirement rather than assumption. If you declare that node,
it's assumed the timer driving get_cycles() does what it says on the
greybus-frame-time-counter tin.

> > > ?and duplicates information we have ? elsewhere.
> > Can you give an example ?
> Trivially, the CNTFRQ register in the architected timer (which is
> common
> across MMIO/sysreg), which you can query with arch_timer_get_rate().
> 
> Note that isn't guaranteed to match get_cycles() either. You need a
> better API to call.

In that case a DT entry makes sense I'd say.

> You should definitely interrogate the relevant driver, somehow.

Hrmm. TBH if we are ruling out arch_timer_get_rate() then I think a DT
entry (which BTW is greybus specific) is the more intelligent way
forward. The greybus platform implementer needs to understand the
dependencies and take action to meet those dependencies should he or
she wish to support this feature.

I'm not opposed necessarily to calling arch_timer_get_rate() instead of
a DT binding, assuming it works, and drawing a line under it for
MSM8994. As I've said it's up to a system architect for other platforms
to go and do the necessary design to support this feature and this will
almost certainly require new platform code both here and in other
places anyway.

> 
> Without a higher-level view of what you're trying to achieve, it's
> not
> clear to me whether get_cycles() is the right interface.

I appreciate that.

---
bod
