From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 2 Jun 2015 00:31:07 +0100
Subject: [RFC PATCH] ARM: add fixmap based earlycon support
In-Reply-To: <CAL_JsqKq6dS-i9mGY4_cn4P0MZRFv5CA_EcxwXxkLmgZJ7SFrg@mail.gmail.com>
References: <1430315508-7582-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150501161812.GN12732@n2100.arm.linux.org.uk>
 <CAKv+Gu-8ixKQtkpf=umHB76OZxo-dfGkOiQqDO7=evMebyDdUA@mail.gmail.com>
 <CAKv+Gu80bSqXbK5g9g9wBbG33mgqbrxJA68kNgAuK=LOoGDh5w@mail.gmail.com>
 <CAL_JsqKq6dS-i9mGY4_cn4P0MZRFv5CA_EcxwXxkLmgZJ7SFrg@mail.gmail.com>
Message-ID: <20150601233106.GU2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 01, 2015 at 06:26:14PM -0500, Rob Herring wrote:
> On Mon, Jun 1, 2015 at 3:26 AM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> > (thread is here: http://thread.gmane.org/gmane.linux.ports.arm.kernel/409329)
> >
> > On 2 May 2015 at 10:37, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >> On 1 May 2015 at 18:18, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> >>> On Wed, Apr 29, 2015 at 03:51:48PM +0200, Ard Biesheuvel wrote:
> >>>> This adds support for fixmap based earlycon by moving the fixmap
> >>>> initialization to an earlier stage and introducing the Kconfig symbol
> >>>> that wires up the existing code.
> >>>
> >>> I don't see the patches for this fixmap based earlycon.  What's the
> >>> status of those, and how are they getting into mainline?
> >>>
> >>
> >> They are already /in/ mainline. This single patch is all that is
> >> required to wire it up for ARM.
> >>
> >> However, I did notice after sending this that another implementation
> >> had been proposed already:
> >> http://lkml.iu.edu/hypermail/linux/kernel/1412.3/00855.html
> >>
> >> I am not sure which one is more correct, but the general idea is the
> >> same, i.e., to allocate the fixmap PTEs from bss rather than the heap.
> >
> > Anyone else care to comment on this?
> 
> You need to re-write the page table entries because the pte and pmd
> flags get adjusted during boot. For example SMP related flags get
> configured. I believe Stefan's version (based on mine which was based
> on Mark Salter's) did this. In fact, I'm surprised this works after
> paging_init, but I may have missed something.

Any changes to PMD flags for things like SMP related flags must be
done via a remove-the-mapping, flush-tlb, add-new-mapping sequence.

> > DT based earlycon is a *really* useful thing to have if you are
> > working on early kernel code.
> > With many of the DTs now having been extended with a
> > /chosen/stdout-path property, it really only takes a simple 'earlycon'
> > command line parameter (without any arguments) to get console output
> > as soon as the early DT scan is concluded. I suppose this is also a
> > useful thing for multi platform kernels?
> 
> Certainly, that's the whole point. IMO, we should rip out most of
> DEBUG_LL when this is merged.

If you think that, you're wrong.  DEBUG_LL exists to be able to debug
stuff well before the kernel gets anywhere near the C code.  It has
to stay.  It fills the gap where no C code can do any debugging.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
