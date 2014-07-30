From: will.deacon@arm.com (Will Deacon)
Date: Wed, 30 Jul 2014 11:46:04 +0100
Subject: [PATCH  0/4] ARM: perf: Support i.MX53
In-Reply-To: <53D7CE8E.70103@parkeon.com>
References: <20140729123256.13347.79778.stgit@localhost>
 <20140729125231.GM9245@arm.com> <53D7CE8E.70103@parkeon.com>
Message-ID: <20140730104604.GG12239@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 05:40:46PM +0100, Martin Fuzzey wrote:
> On 29/07/14 14:52, Will Deacon wrote:
> > Instead, how about we add a new property on the PMU node that says it
> > requires secure access, then we use that to configuer SDER in the perf code.
> 
> Ok but how would the new property be used?
> Do you just mean making the code that sets the SUNIDEN bit conditional 
> on this property?

We'd add a property to the PMU, so it would look something like:

pmu {
	compatible = "arm,cortex-a8-pmu";
	interrupts = < ... >;
	secure-reg-access;
};

Then we can match that last property in the driver and only configure the
SDER if it's present.

> So a DT for a board booting in secure mode would have the property set 
> and one booting in non secure mode would not?

Yes. It's also slightly more general in that you can set the property for
any PMU that requires SDER configuration. In practice, that probable means
`booted in secure mode' but you never know what people build.

> But is it the DT's business to know how the kernel has been booted?

I don't have an alternative other than only supporting perf in non-secure
mode.

> What happens in non secure mode?

Exactly the same as what happens now; the property would be absent so
existing behaviour would be preserved.

> I presume the kernel won't touch SDER in that case (so avoiding an 
> exception) but the counters will only work if code outside the kernel 
> (bootloader, secure monitor?)  has already set things up correctly?

Right. Secure software could restrict non-secure debug visibility, but
that's not something Linux can do anything about.

> Wouldn't it be possible to detect if the kernel is in secure mode and 
> use that instead of a DT property?
> Does the kernel have that information?

No, you can't reliably detect that in the architecture.

> > Then you can do your SoC-specific magic as part of the runtime PM hooks we
> > already have (it looks like enabled/disabling a clock really).
> This is orthogonal to the above right?
> 
> Indeed, I've tried that and it works without any extra hooks.
> 
> But what happens if we don't have CONFIG_PM_RUNTIME ?

Then you don't get perf unless you configure things correctly in your
firmware. This is just like configuring clocks.

Will
