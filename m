From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Sat, 9 Oct 2010 22:25:06 +0300
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <20101009164517.GA28183@n2100.arm.linux.org.uk>
References: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
	<20101009135210.GA25564@n2100.arm.linux.org.uk>
	<AANLkTi=Sv35ipSGzSoJMjdoNU-Qee9csviPL3yMSM3uf@mail.gmail.com>
	<20101009164517.GA28183@n2100.arm.linux.org.uk>
Message-ID: <AANLkTim98Rzp=A+iFQ9Z+xQLKRbpsAFGQh5kVbT4=FCy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 9, 2010 at 7:45 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Oct 09, 2010 at 07:07:01PM +0300, Felipe Contreras wrote:
>> On Sat, Oct 9, 2010 at 4:52 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Thu, Oct 07, 2010 at 12:44:22PM +0300, Felipe Contreras wrote:

>> >> http://article.gmane.org/gmane.linux.ports.sh.devel/8560

[...]

>> > However, as can be seen from the link above, it's been known about since
>> > 8th August - two months ago. ?The problem has been discussed, and we had
>> > a good solution which would work. ?But then an oar got thrown in which
>> > basically resulted in that solution being rejected - on the basis that
>> > "it's an established API and it must work".
>>
>> I don't see anyone rejecting any solution there. Where is anybody
>> saying "it's an established API and it must work"?
>
> In a follow-on thread.
>
> http://lists.arm.linux.org.uk/lurker/thread/20100820.200530.9bd67b3a.en.html

I read that thread, I don't see anyone saying "it must work". The
strongest opinion is to revert the patch until videobuf-dma-contig.c
is fixed, so that's "temporarily it must work", which is very similar
to my proposal.

>> Can you concentrate on the patch at hand?
>> http://article.gmane.org/gmane.linux.kernel/1045670
>>
>> This doesn't break anything, nor prevents anyone coming up with solutions.
>
> and provides no motivation to fix anything either.

It does, for the people that haven't found this issue yet.

>> You haven't answered my question: what is so horrible about warning
>> only on .36, and disallowing on .37?
>
> My objection is one of methodology.
>
> It's been known for six months that this change was going to be made.
> It was discussed at the time it was proposed, and omapfb was raised as
> a concern by OMAP people.
>
> Most of the relevant parties (except sh-mobile as it wasn't obvious)
> had been told. ?The patch went in about three months ago. ?Only now is
> a major fuss being made over it.
>
> If precisely nothing has happened in six months, inspite of my (repeated)
> warnings that this change will hit mainline, then what hope is there that
> giving a further three month grace in any form will be respected to get
> drivers into shape? ?If people can't get the idea with six months of
> warning, then what is the use of adding such a restriction when no one
> takes any notice of it anyway?
>
> There's two ways to deal with no progress inspite of repeated warnings -
> you either drop the issue, forget it ever existed and let people find the
> resulting problems, or you force the issue.
>
> I chose the latter, and yes, I expected that people will complain. ?It
> gets the issue _far_ higher in peoples sights than adding silly WARN_ON
> stuff which all too easily gets ignored. ?If email messages and verbal
> discussions get ignored, what hope is there for a one-line kernel message
> amongst 75 lines of kernel spew?
>
> I doubt that a WARN_ON will result in any progress on the issue.

Let's remember that driver users != driver developers. This is not a
company where people are assigned drivers, and they are responsible of
heeding memos and fix issues in a timely manner. This is a community,
and there could be some developer out there who does have a life, but
might try .36 just for fun, see the warning, and fix the driver.

It's not about whether you think this is likely or not, it's about
following a sensible process where the potential for contributions is
maximized, and the breakage is minimized; that is, deprecate, release,
wait, obsolete. It's understandable that from your point of view this
has been deprecated since 6 months ago, and nagging the relevant
parties didn't achieve anything, so now they should be punished. But
what about the not so obviously relevant parties? Just make a release
with the warning to give them a chance, if nothing happens, _then_
obsolete, it's not so much to ask. Next time, deprecate right away,
then the warning would have been on .35, and by .36 it would have been
harder to argue that the warning alone is achieving anything, and you
could happily obsolete.

-- 
Felipe Contreras
