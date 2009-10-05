From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 05 Oct 2009 10:37:28 +0100
Subject: git an patches: Some questions
In-Reply-To: <4AC660CE.600@techworks.ie>
References: <4AC660CE.600@techworks.ie>
Message-ID: <1254735448.371.36.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2009-10-02 at 21:21 +0100, Christian Gagneraud wrote:
> I would like to have some advice on how to manage my git tree, patches
> that I pick on this list (EP93XX related) and patches that I would
> like to submit (TS-72XX related).
> 
> First of all I would like to know what tools people are using, I've
> read about stg [1][2] and it looks to me that it fits well my needs.

Apart from stgit you can use plain git (maybe in combination with
cherry-picking and amending the top commit), guilt or topgit (see
http://git-scm.com/tools).

> Next, I'm would like to know the best strategy to track the latest
> patches from linux-arm and at the same time work on my own patches.
> Should I create a branch, say ep93xx, that track linux tree and on
> which i apply the EP93xx patches, and set up another branch, say
> ts72xx, that track the ep93xx branch? Or should i use only one branch
> and use "stg import" for patches I'm not the author and "stg new" for
> my own work.

I think the best workflow comes with individual's experience. I'm can't
say if my workflow would work for you.

I would say your patches should be based against Linus' tree, especially
if you send a git pull request to Russell. I usually only rebase the
patches on top of Russell's arm devel tree if asked explicitly (i.e.
merge conflict is not trivial).

It also depends on the number of patches you have and whether you want
to keep separate branches. If you don't have a huge number of patches,
just use a single branch which you can rebase on whatever you want to
test (Linus' tree or Russell's tree).

Another strategy is to keep your patches on top of Linus' tree and use a
separate (temporary maybe) branch to merge Russell's tree with your
stgit-managed branch for testing. You can also enabled git-rerere in
your .git/config to avoid solving the same conflict next time you want
to test.

If you want to make your stgit branch public, the rebasing workflow may
cause conflicts for people periodically pulling your tree. To avoid
this, stgit (latest versions) has a command called "publish" which
creates and maintains a branch with linear history but with the same
tree as your stgit branch.
> 
> Using stg import/new looks interesting, but then if I want to submit
> my patches by email, stg will send all the patch part of the series
> including the one that I've imported but that's not what I'm looking
> for.

You can submit only the patches you want - "stg mail patch1..patchN".

But to reduce problems with merging or patches depending on others which
are not submitted, I would recommend to create a separate branch (e.g.
"for-rmk") based on latest mainline and only pick import the patches
meant for upstream from your other branches. Something like:

	stg branch -c for-rmk origin/master
	stg pick devel:patch1
	stg pick -B devel patch2..patchN
	... test ...
	stg mail --to=linux-arm-kernel -a

(you can put e-mail aliases in the .git/config or ~/.gitconfig files,
see the example giconfig that comes with stgit)

For submitting patches, you can either publish your git tree and send a
pull request for your "for-rmk" branch or just send the patches to
Russell's patch system.

You can also automate the sending to the patch system with stgit but
make sure that you either use long delays between each patch (mail
--sleep or send them one by one waiting for the patch system reply) or
add some numbering to each patch so that Russell know the order. The stg
mail command allows custom templates, so for the patch system I use:


From: %(sender)s
To: patches at arm.linux.org.uk
Subject: %(prefix)s%(shortdescr)s

%(longdescr)s
PATCH FOLLOWS
KernelVersion:%(version)s
%(diff)s


and the stgit command:

	stg mail -t .git/patchmail.tmpl -v 2.6.32-rc1 <patch>

(the -v/--version option is important otherwise the patch system rejects
your patch)

I also thought about using a subject line like below to add a counter to
each patch but I haven't sent any patches like this yet (pull requests
are easier):

Subject: (patch%(number)s) %(prefix)s%(shortdescr)s

-- 
Catalin
