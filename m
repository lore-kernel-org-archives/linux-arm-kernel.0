From: olof@lixom.net (Olof Johansson)
Date: Mon, 18 Nov 2013 13:50:08 -0800
Subject: ACPI vs DT at runtime
In-Reply-To: <528A7EA0.9050101@jonmasters.org>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <20131115095717.GC1709@e106331-lin.cambridge.arm.com>
 <5289A356.4060004@jonmasters.org>
 <20131118190929.GA5886@quad.lixom.net>
 <528A7EA0.9050101@jonmasters.org>
Message-ID: <20131118215008.GA10332@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 18, 2013 at 03:54:56PM -0500, Jon Masters wrote:
> Hi Olof,
> 
> On 11/18/2013 02:09 PM, Olof Johansson wrote:
> > Jon,
> > 
> > On Mon, Nov 18, 2013 at 12:19:18AM -0500, Jon Masters wrote:
> >> Olof, thanks for starting this thread. Mark, thanks for the followup.
> > 
> > Your mailer is dropping all ccs to your emails, so I didn't get a copy of this
> > in my inbox. You might want to check the configuration at your end.
> 
> I need to shoot Thunderbird for all kinds of reasons unrelated to this.
> I actually am having to alternate with another laptop right now to do
> email because this Thunderbird build I am running is just so sluggish
> and nasty (and the other laptop setup is what is broken). But anyway,
> that's something I need to fix, thanks for fixing the CCs.
> 
> > I've added back the cc recipients.
> > 
> >> Comments on both inline, below. But before I reply to the specific
> >> points, let me add that this is clearly an emotional topic for many.
> > 
> > I'm sorry that it's so emotional. Let's keep to technical arguments.
> 
> I agree with you. I got worried on Friday when I saw a discussion
> effectively leading with (what I read as) "let's ban all ACPI", which
> really got me concerned. But then again, I've been in bed most of the
> weekend sick, so I probably miss-read your intention. I apologize.

My stance is the same as last week: ACPI is the wrong tool for the job
at this time on ARM. The job in question is kernel and device runtime
configuration.

In the future, it might be more suitable, but likely not for at least
a couple of years, maybe more. Making strict statements about its use in
the future seems counterproductive at this time since there's no guarantee
that it'll reach that point in a given timeframe. Maybe it will for some
firmware vendors and platform vendors, while for others it won't, etc.

> >> There are a great many companies involved in ARMv8 on servers, and a
> >> great many have yet to say anything in public. I am trying to strike a
> >> balance constantly by being fair to those who have announced and those
> >> who have yet to do so. But regardless, we have one chance here to make a
> >> good server platform that can challenge the incumbent architectures. If
> >> I weren't utterly convinced of that, and of the need for such standards
> >> as UEFI and ACPI, then I wouldn't be so vocal about it. Given who is
> >> involved in this space, regardless of a decision to adopt ACPI now or
> >> later, it is coming. It can be done right now, or not.
> > 
> > And what I am saying here is that "not right now" is the right answer
> > for the linux kernel. For technical reasons.
> 
> I believe we can skip a lot of other conversation if I can summarize
> something from this thread. Is it the case that you believe there is
> room for both codepaths to exist in the upstream kernel, and for ACPI to
> mature over time as it becomes "more ready"?

As my original email said, I don't think there's a reason to pick up
and pollute the whole kernel with double code paths at this time, while
the vendors using ACPI is still trying to figure out what to do and how
to do it. It's better to keep it out of the kernel, especially since it
will require either re-abstracting all drivers and subsystems, or adding
dual code paths to them for platform support that is likely to change.

Until then, if someone wants to boot with ACPI, then the best path would
be to translate as much of the simple data over to device tree and boot
with that as the in-kernel abstraction layer. That can be done at boot
or by crafting static device trees. Likely the first few generations of
hardware will not have elaborate complex AML-based ACPI workarounds for
stuff in the first place, so chances are this will not be a big issue.

If, down the road, ACPI seems to have their act together, have worked out
their kinks and reached a usable stable platform, then we can consider
bringing in the parts of it that doesn't make the kernel explode in
complexity and messiness. When this will be is impossible to predict
today, but I expect it to take a couple of years and some generations
of hardware.

> If the above is the case, then I don't think we disagree at all! I don't
> want to kill DeviceTree, I just know (or think I do) that ACPI is going
> to be the dominant force on v8 server systems. It worries me if there's
> no way to let ACPI code be merged upstream until it's completely figured
> out. I hope I am reading the rest of the thread correctly and understand
> instead that you're saying there can be a path for both, and perhaps
> those of us who require ACPI can simply state that up front and work
> with partners to ensure support for those ACPI platforms is available -
> and binding fixes to the standard made - while those same server
> platforms might also be supported by a DeviceTree at the same time for a
> period of whatever transition is required. That seems totally
> acceptable. I don't see any reason why the same binary kernel image
> can't boot with either a DTB or an ACPI table and indeed that would be
> my preference. Some of us can require it be ACPI by policy, but others
> can build kernels that use DTB on v8 servers if that's what they need
> while the whole thing shakes itself out.

Again, merging a substantial amount of ACPI enablement is premature for
the reasons already stated in the thread; it adds complexity and is likely
to churn several times as vendors figure out just how to work with it. The
two examples at hand (APM SATA and Exynos AHCI) both indicate that.

While vendors are free to implement it in their firmware, we are much
better off not relying on it right now. ACPI was messy on x86 in the
beginning too. Luckily we have an alternative that will get the work
done while the rest is being worked out.

So, if we're not going to merge the ACPI-enabling code yet,
mandating ACPI for booting isn't going to work if you expect to rely
on native-all-the-way-through-the-kernel ACPI implementation. It will
however work to some extent for the ACPI-to-DT approach, given that
the platforms are kept reasonably simplistic. And if it doesn't, we can
fall back to static DT and native implementation of whatever stuff ACPI
would have abstracted for us (clock drivers, reset drivers) if we really
have to.


-Olof
