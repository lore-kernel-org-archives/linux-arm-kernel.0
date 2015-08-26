From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Aug 2015 21:34:46 +0100
Subject: Prevent list poison values from being mapped by userspace
 processes
In-Reply-To: <CAGXu5jK=xfSpJFk9owMoNg7dybdaap+DWzGy+TPTYDHNb+V1Mg@mail.gmail.com>
References: <CABXk95C=CpeL4mNmS6-jJ-0bMJf6fawwfs6DM1-p8FctTEFbpw@mail.gmail.com>
 <20150821133043.GV7557@n2100.arm.linux.org.uk>
 <CAGXu5jJ8KOoVkx99rrajEEx77Z6zO4TzCXaXkB74zv9QQFuJFw@mail.gmail.com>
 <20150824184709.GE7557@n2100.arm.linux.org.uk>
 <CAGXu5jJFf+9OgnGt_Cx5Q-Pht7LAT7M-sSXftTDORybrr+SECg@mail.gmail.com>
 <20150824191427.GF7557@n2100.arm.linux.org.uk>
 <CAGXu5jLW-nfUr40cit25_GsBrPJ6e0topdBQ1RY6vSm2dBFyDA@mail.gmail.com>
 <20150824193256.GG7557@n2100.arm.linux.org.uk>
 <CAGXu5jK=xfSpJFk9owMoNg7dybdaap+DWzGy+TPTYDHNb+V1Mg@mail.gmail.com>
Message-ID: <20150826203446.GD21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 03:01:06PM -0700, Kees Cook wrote:
> On Mon, Aug 24, 2015 at 12:32 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > That's one way of looking at it.
> >
> > Another way of looking at it is that by looking at their work, and
> > merging their ideas into your own, it becomes an encouragement for
> > working outside of mainline - not only do they get the kernel itself
> > free, but they get their feature merged without themselves doing any
> > work - while some other bugger has to sort out making their code
> > mergable.
> >
> > Therefore, my standard point of view is that if people can't be
> > bothered to talk about their ARM specific kernel features here with
> > a view to having them merged, they are leeching off the efforts of
> > the upstream kernel community, and their code just isn't worth
> > looking at.
> >
> > I hold the same view on "community" kernel trees which don't bother
> > pushing their code upstream as well.
> >
> > Sorry, I'm *not* supporting leeches.
> >
> > I've already been accused this year by one very mistaken individual
> > for not pushing _my_ iMX6 work into community kernel trees - when
> > the work that I do is solely targetted at mainline kernels.  The
> > leeches are going mad, and I'm saying no more to this crap.  If it's
> > not talked about on a recognised mainline kernel mailing list, it
> > doesn't exist, and deserves to be rewritten.
> 
> I certainly see your point, but I'm not sure it serves end users best
> to ignore proven technologies. I am trying to bring up the discussion
> on a mainline list, and it seemed redundant to paste the entire grsec
> forum post here as a starting point. :)

As kernel developers feeding code into mainline, we can't go around
picking "proven technologies" from other people's trees.  Doing that
carries with it risk.

Consider the difference between:

1) Individual A sends their code onto mailing lists for review, asking
   it to be merged.  It gets reviewed by multiple people, gains acks
   and tested-bys, and the proper well established and proven kernel
   submission process is followed.  Individual B merges the code and
   sends it upstream.

2) Individual A merges code into their own tree and publishes it on
   the Internet.  Individual B searches the Internet, finds this code,
   downloads, modifies it a bit to get it to apply, and sends it out
   for review.  It gains acks and tested-bys and eventually B merges
   the code and sends it upstream.

Sometime later, patent and/or copyright lawyers start creating a ruckus
over the code which has been merged.  In each case, where does the bulk
of the blame lie - would it be with individual A or individual B?

My _personal_ view is that in (2), much more of the blame lies on
individual B who _took_ code from individual A, potentially without
their knowledge and merged it into another "project".  Individual A
may share some of the blame too, but they have the ability to say
"I never submitted it to that project."  If lawyers target a project,
then the way that would work is they'd target the project, and leave
the project to fight it out with the next stage along.  (You see this
happening between companies: Company A (re)publishes work which
Company B did.  Company A gets sued.  Company A then has to sue
company B to recover costs and damages.)

As part of the process in (1) above, we require that the _sender_ of
the code signs-off that _submission_, and by doing so, they're basically
asserting that the code conforms with the statements in the DCO and
therefore they are taking the bulk of the responsibility.

To re-iterate the point, if I were to take someone elses code, then
_I_ would have to assert DCO (b) - I'm making that assertion, therefore
I'm the one at the end of the submission path for the project.

So, my view is that DCO (b) carries with it more risk than the other
sub-clauses, irrespective of what the GPL says.


As for my comments about leeching, those are a view that I've held
for well over a decade.  Trees which take from mainline but never
contribute back are trees which leech off the efforts of the many
who do contribute to mainline.  Such trees benefit from mainline, but
do not supply any benefit back to mainline.  I find such trees totally
abhorrent and disgusting, but I _can_ understand that it's human
nature.  Sure, the GPL does not require that code gets contributed
back, but there is a clear moral, ethical and fairness issue here.

In this case, it's more than that though.  Kees, in your comment
above, you talk about "proven technologies" and serving the best
interests of our users.  I think you're totally missing the point
here.  Are users best interests served by having these trees keep
their "proven technologies" to themselves, or are they best served
by having these proven technologies submitted into mainline in a
timely manner?

Consider the recent networking use-after-free bug which is the
subject of these domain patches, and think about this.  If this
"proven technology" was already in mainline and enabled, then this
particular use-after-free would not be a privilege escalation because
with this additional protection against dereference of LIST_POISON*,
there is no way userspace could exploit it.  Sure, they can oops the
kernel, but that's _far_ better than a privilege escalation and
potential undetected information leak.

So, in my mind, it's the leeches which are doing a dis-service to
users, not those of us who spend their time trying to fix the
problems which the leeches have already fixed but failed contribute
back.

It intensely annoys me when I _do_ find out that some feature
(especially bug fixes) has already been created but not fed back,
and I've spent time re-creating it.  It's really a waste of my
time.  That's what leads me to decide that no, I'm not going to
waste even more of my time trying to rip a feature out of a
leeching tree and allow them to have some of the credit for it.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
