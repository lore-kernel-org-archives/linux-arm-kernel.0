From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 10 Apr 2015 17:10:53 +0100
Subject: [RFC PATCH 0/5] Add smp booting support for Qualcomm ARMv8 SoCs
In-Reply-To: <493B15F8-0EBE-4633-9604-671EF403F36E@codeaurora.org>
References: <1428601031-5366-1-git-send-email-galak@codeaurora.org>
 <20150410100529.GA6854@e104818-lin.cambridge.arm.com>
 <493B15F8-0EBE-4633-9604-671EF403F36E@codeaurora.org>
Message-ID: <20150410161052.GF6854@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 10, 2015 at 10:24:46AM -0500, Kumar Gala wrote:
> On Apr 10, 2015, at 5:05 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Thu, Apr 09, 2015 at 12:37:06PM -0500, Kumar Gala wrote:
> >> This patch set adds support for SMP boot on the MSM8x16 family of Qualcomm SoCs.
> >> 
> >> To support SMP on the MSM8x16 SoCs we need to add ARMv8/64-bit SCM interfaces to
> >> setup the boot/release addresses for the secondary CPUs.  In addition we need
> >> a uniquie set of cpu ops.  I'm aware the desired methods for booting secondary
> >> CPUs is either via spintable or PSCI.  However, these SoCs are shipping with a
> >> firmware that does not support those methods.
> > 
> > And the reason is? Some guesses:
> > 
> > a) QC doesn't think boot interface (and cpuidle) standardisation is
> >   worth the effort (to put it nicely)
> > b) The hardware was available before we even mentioned PSCI
> > c) PSCI is not suitable for the QC's SCM interface
> > d) Any combination of the above
> > 
> > I strongly suspect it's point (a). Should we expect future QC hardware
> > to do the same?
> > 
> > You could argue the reason was (b), though we've been discussing PSCI
> > for at least two years and, according to QC press releases, MSM8916
> > started sampling in 2014.
> > 
> > The only valid reason is (c) and if that's the case, I would expect a
> > proposal for a new firmware interface protocol (it could be PSCI-based),
> > well documented, that can be shared with others that may encounter the
> > same shortcomings.
> 
> Does it matter?  I?ve always felt the kernel was a place of inclusion.
> Qualcomm choose for whatever reason to not use PSCI or spin table.
> You don?t like it, I might not like it, but it is what it is.

Yes, it matters, but only if Qualcomm wants the SoC support in mainline.
Just because Qualcomm Inc does not want to invest in implementing a
standard firmware interface is not a good enough reason to merge the
kernel code.

What if Qualcomm decides that it doesn't like DT, nor ACPI but comes up
with yet another way to describe hardware because that's what the
firmware provides? Should the kernel community take it? You could argue
that this is a significant change but it's about the principle. And each
SoC with its own non-standard boot protocol for no good reason is
significant.

It's not Qualcomm Inc maintaining the kernel code but individuals like
you and me who may or may not be sponsored by Qualcomm. And being
sponsored by a company to do kernel maintenance work does not mean that
said company decides what gets merged (on my side, ARM Ltd management is
aware of this, though it's not always easy for the parties involved).

We haven't really asked for anything difficult like hardware changes,
such decisions are left with Qualcomm. We asked for a standard secure
firmware interface, either an existing one or, if not suitable (with
good arguments), to come up with a proposal for an alternative
_standard_ interface. I don't even have the certitude that the firmware
interface used in these patches would be consistent across Qualcomm
SoCs, let alone being properly documented.

So please come up with proper technical arguments rather than the kernel
should take whatever SoC vendors dreamt of.

-- 
Catalin
