From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Mar 2012 11:55:16 +0000
Subject: Conflict between Versatile Express DT conversion and local timer
 updates
In-Reply-To: <4F5F2859.5020407@arm.com>
References: <20120312231016.GC10830@n2100.arm.linux.org.uk>
 <20120313101525.GA569@n2100.arm.linux.org.uk> <4F5F2859.5020407@arm.com>
Message-ID: <201203131155.16454.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 March 2012, Marc Zyngier wrote:
> On 13/03/12 10:15, Russell King - ARM Linux wrote:
> > On Tue, Mar 13, 2012 at 09:39:57AM +0000, Marc Zyngier wrote:
> >> On 13/03/12 01:23, Olof Johansson wrote:
> >>> Hi,
> >>>
> >>> On Mon, Mar 12, 2012 at 4:59 PM, Russell King - ARM Linux
> >>> <linux@arm.linux.org.uk> wrote:
> >>>>
> >>>> Correction: I haven't been pushing out my devel-stable branch for
> >>>> apparantly two months (according to gitweb, and no one noticed?), so I
> >>>> could drop the merge of Marc's tree until the conflicts can be sanely
> >>>> resolved.
> >>>
> >>> I haven't noticed because I stopped tracking your tree directly when
> >>> you were having server load issues; I tend to have kept an eye on
> >>> linux-next-level breakage instead, but probably not as close as I
> >>> should have.
> >>>
> >>> Dropping Marc's branch and having him either resubmit on top of
> >>> arm-soc like the io cleanup was done, or pull it in as an early
> >>> dependency for 3.5 and stage it in an for-armsoc branch sounds like
> >>> two good options to me, with no real preference in either direction.
> >>
> >> I'm happy to rebase my patches on anything that will make the merge
> >> easier (IOW conflict-less).
> >>
> >> Russell, would you prefer this series to go via armsoc? This seems the
> >> cleanest solution for the time being.
> > 
> > With a lot of these core ARM changes, there's a very fine line between
> > whether they are core ARM changes or whether they're platform level
> > changes (many core ARM changes will impact lots of platforms.)  I'm just
> > wondering if there's any point to taking these changes through my tree.
> > It seems utterly pointless if they're going to keep conflicting with
> > platform stuff.
> 
> Fair enough.
> 
> Olof, Arnd: which is the most base for you to take this series?

I'm not sure I understand your question. The conflicts that Russell
mentioned are with the ux500/timer (in next/soc) and with the
vexpress/dt (in next/dt) branches. There are multiple ways out of
here:

a) take your series first, but merge it into the next/dt and next/soc
   branches, resolving the conflicts in the process. This would be
   fairly easy to do if you can provide the merge resolution as
   a git pull and let Russell still take your series as is.

b) rebase your series on top of vexpress/dt, merge it into the next/soc
   branch.

c) rebase your series on top of ux500/timer, merge it into the next/dt
   branch.

d) create a new next/timer branch in arm-soc that has Pawel's     
   98ed4ceb "ARM: vexpress: Get rid of MMIO_P2V" (the first patch from
   vexpress/dt, your patches and the ux500/timer series. Also put
   98ed4ceb into the next/cleanup branch.

Any of those will work for us, my preference would be on #4. I have
created the next/timer branch in the arm-soc tree, so you can use
that and either rebase your patches on top or merge your tree into
it and fix up the merge conflicts.

	Arnd
