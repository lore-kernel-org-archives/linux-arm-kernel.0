From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 22 Apr 2016 11:36:15 +0100
Subject: [PATCH v7 13/16] arm64: head.S: el2_setup() to accept sctlr_el1
 as an argument
In-Reply-To: <5717BDFD.4000005@arm.com>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
 <1459529620-22150-14-git-send-email-james.morse@arm.com>
 <20160420171204.GG11377@e104818-lin.cambridge.arm.com>
 <5717BDFD.4000005@arm.com>
Message-ID: <20160422103615.GC2998@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2016 at 06:35:57PM +0100, James Morse wrote:
> Hi Catalin,
> 
> On 20/04/16 18:12, Catalin Marinas wrote:
> > On Fri, Apr 01, 2016 at 05:53:37PM +0100, James Morse wrote:
> >> el2_setup() doesn't just configure el2, it configures el1 too. This
> >> means we can't use it to re-configure el2 after resume from hibernate,
> >> as we will be returned to el1 with the MMU turned off.
> >>
> >> Split the sctlr_el1 setting code up, so that el2_setup() accepts an
> >> initial value as an argument. This value will be ignored if el2_setup()
> >> is called at el1: the running value will be preserved with endian
> >> correction.
> >>
> >> Hibernate can now call el2_setup() to re-configure el2, passing the
> >> current sctlr_el1 as an argument.
> > 
> > I don't fully understand the description. The first paragraph says we
> > can't use el2_setup to re-configure el2 after resume from hibernate
> > while the last paragraph says that we can.
> 
> Then I need to rephrase the middle paragraph. Is this any clearer:
> This happens because el2_setup() generates a sctlr_el1 value needed for early
> boot, (mmu off etc). Change el2_setup() to accept this as an argument, so that
> hibernate can pass the current sctlr_el1 (with the mmu on), to el2_setup(), and
> have it re-configure el2 without changing el1.

I think I understand it now, it makes sense.

> The motivation for this patch was resuming with a different kernel version,
> which may have left el2 in an incompatible state. Running the original
> el2_setup() was the only guaranteed way to know everything was set correctly.
> If we definitely don't want to support this, then this patch can go, and the
> minimum el2-reset code can be put into hibernate-asm.S.

I suggest we leave this patch as it is for now, I just didn't understand
why it was needed.

With the slightly updated log:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
