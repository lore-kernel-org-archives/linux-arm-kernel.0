From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 13 Apr 2015 10:41:18 +0100
Subject: [RFC PATCH 0/5] Add smp booting support for Qualcomm ARMv8 SoCs
In-Reply-To: <FDC755A7-ACCF-4222-8730-782EEC632159@codeaurora.org>
References: <1428601031-5366-1-git-send-email-galak@codeaurora.org>
 <20150410100529.GA6854@e104818-lin.cambridge.arm.com>
 <493B15F8-0EBE-4633-9604-671EF403F36E@codeaurora.org>
 <20150410161052.GF6854@e104818-lin.cambridge.arm.com>
 <FDC755A7-ACCF-4222-8730-782EEC632159@codeaurora.org>
Message-ID: <20150413094117.GA2745@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 10, 2015 at 02:06:33PM -0500, Kumar Gala wrote:
> On Apr 10, 2015, at 11:10 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Fri, Apr 10, 2015 at 10:24:46AM -0500, Kumar Gala wrote:
> >> On Apr 10, 2015, at 5:05 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >>> On Thu, Apr 09, 2015 at 12:37:06PM -0500, Kumar Gala wrote:
> >>>> This patch set adds support for SMP boot on the MSM8x16 family of Qualcomm SoCs.
> >>>> 
> >>>> To support SMP on the MSM8x16 SoCs we need to add ARMv8/64-bit SCM interfaces to
> >>>> setup the boot/release addresses for the secondary CPUs.  In addition we need
> >>>> a uniquie set of cpu ops.  I'm aware the desired methods for booting secondary
> >>>> CPUs is either via spintable or PSCI.  However, these SoCs are shipping with a
> >>>> firmware that does not support those methods.
> >>> 
> >>> And the reason is? Some guesses:
> >>> 
> >>> a) QC doesn't think boot interface (and cpuidle) standardisation is
> >>>  worth the effort (to put it nicely)
> >>> b) The hardware was available before we even mentioned PSCI
> >>> c) PSCI is not suitable for the QC's SCM interface
> >>> d) Any combination of the above
> >>> 
> >>> I strongly suspect it's point (a). Should we expect future QC hardware
> >>> to do the same?
> >>> 
> >>> You could argue the reason was (b), though we've been discussing PSCI
> >>> for at least two years and, according to QC press releases, MSM8916
> >>> started sampling in 2014.
> >>> 
> >>> The only valid reason is (c) and if that's the case, I would expect a
> >>> proposal for a new firmware interface protocol (it could be PSCI-based),
> >>> well documented, that can be shared with others that may encounter the
> >>> same shortcomings.
> >> 
> >> Does it matter?  I?ve always felt the kernel was a place of inclusion.
> >> Qualcomm choose for whatever reason to not use PSCI or spin table.
> >> You don?t like it, I might not like it, but it is what it is.
> > 
> > Yes, it matters, but only if Qualcomm wants the SoC support in mainline.
> > Just because Qualcomm Inc does not want to invest in implementing a
> > standard firmware interface is not a good enough reason to merge the
> > kernel code.
> 
> The reason to merge the code upstream it expands functionality for a
> platform.

This alone has never been a good enough reason. Code (both design and
style) needs to pass the review.

> There is nothing that says when someone licenses an ARM core that they
> must also implement this standard.

Just to be perfectly clear: this has nothing to do with ARM Ltd nor the
ARM hardware licensing terms. ARM Ltd doesn't even require you to use
Linux, that's your choice. But when you make an OS choice, you have to
abide by its rules.

> Qualcomm choose for whatever reasons to not implement it.  There are
> examples on other architectures supporting non-standard platforms all
> the time (x86 supported Voyager and SGI VIS for a long time).  As far
> as I can tell you are just wanting uniformity to impose this rule.

Don't confuse non-standard hardware (which has always been acceptable on
ARM) with non-standard ways of entering the kernel from firmware,
whether it's a primary or secondary CPU. Just look at how many smp_ops
structures are defined on x86.

> > What if Qualcomm decides that it doesn't like DT, nor ACPI but comes up
> > with yet another way to describe hardware because that's what the
> > firmware provides? Should the kernel community take it? You could argue
> > that this is a significant change but it's about the principle. And each
> > SoC with its own non-standard boot protocol for no good reason is
> > significant.
> 
> I wouldn?t argue that because we are talking about something that has
> an extremely small impact on the maintainability or changes to how the
> kernel actually functions.

It's not about one particular case but about where to draw the line.
Just multiply this change by the number of SoC variants and you'll no
longer see this as "extremely small impact". Why would we accept it for
Qualcomm and reject it for others? It's either giving up trying to
standardise this altogether or enforcing rules. Since you only care
about Qualcomm hardware, you don't care about the overall picture.

By your reasoning, Qualcomm may solely decide to change the booting for
the primary CPU as well, ignore single Image requirements (well, why
would Qualcomm care about other SoCs) and so on. The kernel community
should just accept such changes without questioning because they expand
platform functionality. I am not asking for *hardware* standardisation
here, but common software interfaces.

> Also, if Qualcomm did come up with some other means to replace DT or
> ACPI and felt it was worth trying to get accepted upstream, I would
> hope the upstream would look at it before just saying it was not using
> some standard.

We would still expect proper technical arguments. That's exactly what
I'm asking here; is PSCI not suitable for Qualcomm? If not, can it be
improved? If you have completely different needs, can you come up with a
standard firmware interface, which may only be used by Qualcomm for the
time being, but at least guarantee consistency between subsequent
Qualcomm SoC revisions? But the message you give is pretty much
"Qualcomm cannot be bothered to explain itself to the kernel community".

And what makes you think no-one looked at your code (there's an
unanswered question, asked twice, from Arnd already)? One of the first
steps in a review is looking at the overall design and asking questions
if the choices made are not clear. The review is not just about coding
style or spotting bugs.

Looking beyond this set of patches, I can foresee that you won't care
about the generic arm64 cpuidle driver either, or more precisely the
separation between cpuidle subsystem+driver and the SoC-specific
back-end (cpu_operations).

> > It's not Qualcomm Inc maintaining the kernel code but individuals like
> > you and me who may or may not be sponsored by Qualcomm. And being
> > sponsored by a company to do kernel maintenance work does not mean that
> > said company decides what gets merged (on my side, ARM Ltd management is
> > aware of this, though it's not always easy for the parties involved).
> 
> Fair enough, but you?ve not given any reasons the code isn?t
> maintainable.  You?ve only said you don?t like it because it doesn?t
> use one of the defacto ?standards?.

See above about maintainability and how it no longer scales to tens of
SoCs on the long term.

> As you say, its individual doing the maintenance, so those individuals
> are not likely to have access to change firmware on a given device.
> So saying go change firmware is pretty much saying we don?t want to
> support your platform or code upstream.

I don't blame you here for the lack of standard firmware interfaces. But
it's a message you should have given back to Qualcomm 2-3 years ago.
Maybe you did and Qualcomm ignored it, which kind of makes it worse.

> > We haven't really asked for anything difficult like hardware changes,
> > such decisions are left with Qualcomm. We asked for a standard secure
> > firmware interface, either an existing one or, if not suitable (with
> > good arguments), to come up with a proposal for an alternative
> > _standard_ interface. I don't even have the certitude that the firmware
> > interface used in these patches would be consistent across Qualcomm
> > SoCs, let alone being properly documented.
> 
> If and when those issues arise we can accept or reject that code.
> Right now when I look at the impact to supporting this to generic
> arch/arm64 kernel it is either non-existant if we use the
> CPU_OF_TABLES or extremely minor if we just add an entry to the
> supported_cpu_ops struct.

Again, see above about how such change is no longer small when each SoC
does the same.

> > So please come up with proper technical arguments rather than the kernel
> > should take whatever SoC vendors dreamt of.
> 
> There is no technical argument to be made.  This is about the
> community and you as maintainer wanting to accept code that complies
> to your decision or not.

If you are not willing to make technical arguments, I don't have to
provide any further reasons in this thread. It's your choice. In the
meantime, the short answer is NAK.

-- 
Catalin
