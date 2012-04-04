From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Apr 2012 15:26:16 +0100
Subject: [PATCH] ARM: versatile: fix build failure in pci.c
In-Reply-To: <4F7C5244.4040700@windriver.com>
References: <1333410505-17257-1-git-send-email-paul.gortmaker@windriver.com>
 <CAP=VYLpim2TCMO5nDVNe0bdm9ZQ+czUWNpxxWugDzrHO6aYVAQ@mail.gmail.com>
 <CAOMZO5A-+tcz6ewTykXL33opRVP9U4o7Ltdkbr7LLqWMBQczSQ@mail.gmail.com>
 <201204030819.48798.arnd@arndb.de> <4F7AFF61.3070803@windriver.com>
 <20120404090754.GR24211@n2100.arm.linux.org.uk>
 <4F7C5244.4040700@windriver.com>
Message-ID: <20120404142616.GZ24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 04, 2012 at 09:53:08AM -0400, Paul Gortmaker wrote:
> On 12-04-04 05:07 AM, Russell King - ARM Linux wrote:
> > On Tue, Apr 03, 2012 at 09:47:13AM -0400, Paul Gortmaker wrote:
> >> As a side note, the fact that struct pci_sys_data is ARM specific
> >> does make one think it would be nice if the name somehow did
> >> reflect that...  wonder if it is worth changing.  Anyway, that is
> >> a separate topic.
> > 
> > And what's wrong with the existing name when it's limited to only
> > ARM specific files?
> 
> Just in the context of Arnd's original comment, he thought I
> screwed up by feeding an ARM specific struct into generic
> PCI code, because I wasn't aware it was ARM specific.
> 
> That wasn't the case, but he's right that something like that
> could happen  A minor nit, sure, but if it was something like
> pci_arm_data, the name itself would convey it was arm specific,
> even in reduced context scenarios (like grep output etc).

If the struct ends up being fed into non-ARM code, then non-ARM code
isn't going to be able to dereference it because there isn't a definition
for it outside of arch/arm/.

The risk which exists is that generic code invents its own pci_sys_data.
At that point, we end up with two definitions for the struct, and the
compiler will error out.

We really don't need the churn of changing this.  It ain't broken, so
don't try to fix it.  Moreover, you'll only end up with conflicts to
deal with if the ixp2xxx stuff is removed (and other people will have
similar problems if they're dealing with code in this area too.)
