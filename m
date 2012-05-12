From: olof@lixom.net (Olof Johansson)
Date: Sat, 12 May 2012 16:04:10 -0700
Subject: [GIT PULL] Renesas ARM-based platforms updates for v3.5
In-Reply-To: <201205122158.13999.rjw@sisk.pl>
References: <201205112101.59949.rjw@sisk.pl>
 <CAOesGMgFWM6K6969Oz6xGewrRekyrJA-ztGBADxsqnB1w=V2QA@mail.gmail.com>
 <201205122158.13999.rjw@sisk.pl>
Message-ID: <CAOesGMhZ9096aPsURMExjeTTf09bt4zbSz97u31F86WZwV=swQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, May 12, 2012 at 12:58 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Saturday, May 12, 2012, Olof Johansson wrote:
>> On Fri, May 11, 2012 at 12:01 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > Hi,
>> >
>> > Please pull changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3
>> >
>> > ? ?Linux 3.4-rc6
>> >
>> > with top-most commit 5658c94096c16e769203b6dea5e5f04e7ff12633
>> >
>> > ? ?Merge branch 'renesas-kzm9g' into renesas-soc-new
>> >
>> > from the git repository at:
>> >
>> > ?git://git.kernel.org/pub/scm/linux/kernel/git/rafael/renesas.git soc-new
>> >
>> > to receive new Renesas ARM-based platforms material for v3.5. ?Included are:
>> >
>> > ?* Urgent regression and SMP fixes (also included in the fixes branch that I've
>> > ? just sent a separate pull request for in the hope it is still possible to
>> > ? push them for v3.4). ?Two of those fixes are duplicated in the renesas-sh7372
>> > ? branch, which is because I learned that they were fixes for recent
>> > ? regressions after they had gone to that branch. ?Sorry about that.
>> >
>> > ?* Updates for boards based on the sh7372 and r8a7740 SoCs.
>> >
>> > ?* Support for 2 new boards, armadillo800eva and KZM-A9-GT.
>>
>> Hi Rafael,
>>
>> If you take a look at how the other ARM subarch maintainers organize
>> the patches that they feed up to us, you'll see that they group them
>> either per functional topic, or more commonly per subject such as
>> "core soc updates", "soc driver updates", "board updates", "device
>> tree updates", "cleanup", and so on.
>>
>> That fits the model we've been having on arm-soc as well, since we
>> split our tree up per category like that, and send those cross-section
>> branches between different vendors (but same categories) up to Linus
>> that way.
>>
>>
>> So, would you mind taking a look at what you have in the new-soc
>> branch and reshuffling things a bit? Looking at the history of the
>> new-soc branch and the rest of the repo, it seems that you're already
>> more or less organizing your tree the way I am asking for, it's just
>> that you merged them all together before sending this pull request.
>
> Well.
>
> I'd prefer not to rebase any branches and move commits around if that's
> what you're talking about, because I have a rule that my branches are not
> rebased, except for the next one.

Yeah, sorry for not giving you a heads up on this before. Hopefully
it's just a bootstrap issue this first merge window that you're
sending things through our tree.

> Now, there are three categories of commits in the soc-new branch,
> "core soc updates", "board updates" and "new board support". ?However,
> "board updates" depend on "core soc updates" and go together with them
> in two branches, "sh7372" and "r8a7740" (branch names are after SoC names
> and each branch contains updates for the given SoC and boards based on it).
> I can send a pull request to you separately for each of those branches,
> if you prefer, or I can merge them together and send a pull request for
> the whole (it actually is a separate branch in my tree, called "soc").

In general we don't mind seeing each branch separately, and having
dependencies between them is perfectly fine. Other subarch trees do
this all the time. So having the core updates as a prereq (and
included in) the two SoC names is perfectly fine, the dependencies
will carry over to how we merge them into our next/* branches in
arm-soc.

> The new board support stuff is just that - commits adding support for
> new boards. ?Those things, however, depend on the "core soc updates" and
> "board updates", so they are based on the "soc" branch (honestly, I don't
> think they will work without the "core" changes). ?So, while I could
> send separate pull requests for the "armadillo800eva" and "kzm9g" branches,
> I don't think that merging them without the changes in the "soc" branch will
> do any good.

Again, that's fine. We have a "waterfall" of dependencies through the
arm-soc next/* branches and this will normally fit right in.

To see how we organize (and document) the branches we have pulled in,
take a look at arch/arm/arm-soc-for-next-contents.txt in the for-next
branch of the arm-soc tree:

http://git.kernel.org/?p=linux/kernel/git/arm/arm-soc.git;a=blob;f=arch/arm/arm-soc-for-next-contents.txt;h=8ca6bef667fa81c355a0a9200804d20c16173f2d;hb=refs/heads/for-next

In general, the document is sorted such that the prerequisites for
later branches are listed above. In some cases it means that we need
to have more than one topic branch due to otherwise circular or
awkward dependencies, for example next/dt and next/dt2.


General organization and order tends to start out as:

* cleanups
* fixes
* device tree updates
* core soc support (new socs, etc)
* soc drivers and soc-related items. This time we split them up a bit
(pm, pinctrl, clock, drivers)
* boards (generally very limited new board introductions, mostly updates)

But over time order can be somewhat reshuffled due to added dependencies.


The for-next and next/* branches are not guaranteed to be stable,
since we have in the past had to drop branches and rebuild them. In
general, downstream developers should be basing their work on the
specific subarch trees and not on arm-soc. There are a few exceptions
for tree-wide cleanups but even then, basing it on regular mainline
makes much more sense.


-Olof
