From: balbi@ti.com (Felipe Balbi)
Date: Sat, 8 Sep 2012 22:04:25 +0300
Subject: [PATCH v4 00/21] OMAP UART Patches
In-Reply-To: <87oblhmu6g.fsf@deeprootsystems.com>
References: <20120906122948.GC29202@arwen.pp.htv.fi>
 <1346935540-1792-1-git-send-email-balbi@ti.com>
 <87harahiv6.fsf@deeprootsystems.com>
 <20120907054932.GB3136@arwen.pp.htv.fi>
 <87oblhmu6g.fsf@deeprootsystems.com>
Message-ID: <20120908190423.GA14771@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 07, 2012 at 01:53:11PM -0700, Kevin Hilman wrote:
> Felipe Balbi <balbi@ti.com> writes:
> 
> > Hi,
> >
> > On Thu, Sep 06, 2012 at 03:44:13PM -0700, Kevin Hilman wrote:
> >> Felipe Balbi <balbi@ti.com> writes:
> >> 
> >> > Hi guys,
> >> >
> >> > here's v4 of the omap uart patchset. No changes other than a rebase on top of
> >> > Greg's tty-next branch and Tony's Acked-by being added to a couple patches
> >> >
> >> > Note: I'm resending the series with Vikram's Software Flow Control fix anyway
> >> > as it can just be ignored if it's decided it needs to go into this merge
> >> > window.
> >> 
> >> Sorry to be late to the party... just getting back from some time off.
> >> 
> >> I'm assuming that this was not tested with PM, so decided I better do it
> >
> > you assumed wrong. See the previous versions of the series and you'll
> > see I mention all the basic pm testing I did.
> 
> My apologies for not reading the previous versions.  I don't think it's
> unusual that a reviewer should expect everything he to know about a
> series (including how it was tested) is in the cover letter or in the
> changelogs of the latest series.  I don't expect to have to look through

you've got a point there. My bad, should've kept series history on all
revisions.

> all the previous versions for this kind of info.  Since I wasn't around
> to review/test the earlier versions, I just looked at the latest (v4)
> and didn't see any mention of testing of any sort in the cover letter.

Well, fair enough. Maybe I wasn't too verbose, but here's what I did on
panda:

. check that console still works
. check that IRQs increase as I type on console
. check that pm_runtime suspend callback is called after 1 second of
	inactivity (with printk)
. check that device resumes properly when I type on console again
. enable UART wakeup (through sysfs) and 'echo mem > /sys/power/state'
	then check that I can wakeup from suspend and check that all
	powerdomains actually reached low power state

> Looking back at the previous cover letters, I don't see any description
> of the PM testing either.  I only see it was tested on pandaboard.

Yeah, initially I wasn't testing PM because UART wakeup was known to be
broken, but then I decided to test and sent it as a reply to cover
letter v2, then I forgot to keep the history on v3 and v4. My bad.

> Since mainline doesn't have full PM support for OMAP4, testing on panda
> doesn't really test UART PM at all.

Fair enough. What's missing for omap4 panda ? I could reach suspend2ram
with echo mem > /sys/power/state and wakeup from it.

> Could you please point me to the descriptions in earlier mails of how
> you did PM testing, and on what platforms?

Though not on a cover letter, this is how I was testing from v2 and
onwards:

http://marc.info/?l=linux-omap&m=134555434407362&w=2

> In addition, IMO, if this was only tested on Panda (as suggested by
> earlier cover letters), it really should not have been merged until it
> got some broader testing.

Shubhro's got his Tested-by tag. I believe he tested on beagleboard and
omap4sdp. Shubhro, can you confirm which platforms you tested the UART
patches ? cheers

> >> myself seeing that Greg is has already merge it.  To test, I merged
> >> Greg's tty-next branch with v3.6-rc4 and did some PM testing.
> >> 
> >> The bad news is that it doesn't even compile (see reply to [PATCH v4
> >> 20/21]).  
> >
> > yeah, that was an automerge issue when rebasing on greg's tty-next
> > branch, plus me assuming omap serial was already enabled on my .config
> > and not checking the compile output. Sent a patch now.
> 
> As I reported in my reply to [PATCH v4 20/21], that patch also had
> another problem where it introduced a new (but unused) field.  Maybe
> another rebase problem?  I see the same problem in v3 and v4.

I'll check it out and make sure to delete any such unused fields. Thanks

> >> Also, there is a big WARNING on boot[1], which seems to be triggered by
> >> a new check added for v3.6-rc3[2].  This appears to be introduced by
> >> $SUBJECT series, because I don't see it on vanilla v3.6-rc4.
> 
> [...]
> 
> > This doesn't seem to be caused by $SUBJECT at all. See that we are
> > calling uart_add_one_port() which will call tty_port_register_device()
> > which, in turn, will call tty_port_link_device() and that will set
> > driver->ports[index] correctly.
> >
> > Have you checked if this doesn't happen without my series before waving
> > your blame hammer ? FWIW, that part of the code wasn't change by
> > $SUBJECT at all.
> 
> Whoa.  This was only test report.  No need to get personal.  All I said
> is that it "seemed" to introduced by $SUBJECT series.  Hardly waiving
> "blame hammer."

fair enough.

> And yes, I did check without your series.  As I reported above, the

What about v3.6-rc4 + the patch which added the warning ? :-)

> warning didn't exist with v3.6-rc4, and it did with yesterday's tty-next
> branch.  The WARNING pointed a finger at ttyO (omap-serial) so I assumed
> it was in $SUBJECT series.
> 
> Testing with todays tty-next, the problem is gone.  The patch
> 'tty_register_device_attr updated for tty-next'[1] seems to have made
> the problem go away.  So it's now clear that it wasn't introduced by
> $SUBJECT series.   My bad.

Thankfully...

> Yesterday, it wasn't that obvious, so I made an assumption in order to
> report a problem uncovered in my testing in the hopes that it would be
> helpful to you in fixing a potential problem. My assumption was wrong, I
> was wrong.  I'm wrong a lot, and I'm OK with that. The bug was
> elsewhere, and is already fixed.
>
> My apologies if it seemed like I was blaming you.

I'm the one who owes you an apology for misunderstanding your bug
report. I'm sorry.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120908/140f2e45/attachment.sig>
