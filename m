From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 16 Apr 2014 19:24:34 -0600
Subject: [PATCH v5 2/4] arm64: dts: APM X-Gene PCIe device tree nodes
In-Reply-To: <20140417002041.GE4858@bart>
References: <1395270762-6055-1-git-send-email-tinamdar@apm.com>
 <1395270762-6055-3-git-send-email-tinamdar@apm.com>
 <CAL_Jsq+XxAtUeNKFi0hH=ehb_fhFvkM0U1Zm_j1LdtQZbvSzfA@mail.gmail.com>
 <20140416170545.GD4858@bart>
 <20140416212104.GA3469@obsidianresearch.com>
 <20140417002041.GE4858@bart>
Message-ID: <20140417012434.GA8734@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 17, 2014 at 01:20:42AM +0100, Liviu Dudau wrote:

> > No spec says you can put config space into the ranges at all, nobody
> > should be doing that today, obviously some cases were missed during
> > review..
> 
> ePAPR documents allows that when ss == 00.

Which do you mean? The 'PCI Bus Binding' spec has fairly specific
language on how ranges should be used and interpreted, and it
precludes doing anything meaningful with config space (like requiring
b,d,f and r to be zeroed when doing compares against ranges, requiring
the ranges to represent the bridge windows, etc).

There is certainly room to invent something (like ECAM mapping) but
nothing is specified in that document.

The ePAPR document I have doesn't talk about PCI..

If you've found a document that defines how it works then that changes
things.. ;)

> > The comment about ECAM was intended as a general guidance on what
> > config space in ranges could/should be used for.
> > 
> > Right now config space shouldn't propagate out side any driver, so you
> > can probably just filter it in your generic code, and make it very hard
> > and obviously wrong for a driver to parse ranges for config space, so
> > we don't get more usages.
> 
> OK, this goes slightly against your email from 26th March:
> 
> "When we talked about this earlier on the DT bindings list the
> consensus seemed to be that configuration MMIO ranges should only be
> used if the underlying memory was exactly ECAM, and was not to be used
> for random configuration related register blocks.
> 
> The rational being that generic code, upon seeing that ranges entry,
> could just go ahead and assume ECAM mapping."
> 
> What I'm saying is that the only code that will see this ranges entry will
> be the parsing code as if we try to create a resource out of the range
> and add it to the host bridge structure (not driver) we will confuse the
> rest of the pci_host_bridge API. So we cannot do any ECAM accesses (yet?).

Sorry if this seems unclear, what you quoted was from a specification
standpoint - someday defining config space ranges to be the ECAM
window makes the most sense. This is from the direction of precluding
drivers from using it for random purposes.

>From a Linux standpoint, there is simply no infrastructure for generic
config access outside the driver, so config space must remain
contained in the driver, and shouldn't leak into the host bridge or
other core structures.

I think the shared code you are working on should simply ignore config
ss ranges entirely, they have no defined meaning..

Regards,
Jason
