From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Sep 2012 09:29:42 +0100
Subject: [PATCH] ARM: Dove: allow PCI to be disabled
In-Reply-To: <20120910014422.GQ4575@titan.lakedaemon.net>
References: <E1TAnGn-00086i-Lb@rmk-PC.arm.linux.org.uk>
 <20120909204705.GD3451@lunn.ch>
 <20120909205521.GI13739@n2100.arm.linux.org.uk>
 <20120909210126.GM4575@titan.lakedaemon.net>
 <20120910004511.GN13739@n2100.arm.linux.org.uk>
 <20120910014422.GQ4575@titan.lakedaemon.net>
Message-ID: <20120910082941.GO13739@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 09, 2012 at 09:44:22PM -0400, Jason Cooper wrote:
> iiuc, the regression you are refering to would occur iff this patch
> (without the select) makes it into mainline _before_ Andrew's patch in
> Greg's tree.  As I haven't pulled this patch yet, I can add a dependency
> in the tag message listing the patch in gregkh's usb tree.

For the regression to occur, you need to land on a commit in the tree
where this patch (without the select) is in the history but not the
patch in Greg's tree.

The commit history remains a series of independent branches even after
trees are merged into Linus' tree - there is _no_ linearisation of the
history in git.

This means when anyone comes to use git bisect, they _can_ land on any
commit in any branch, which means if this patch and the other patch
take two different routes, and this patch does not have the select, you
_will_ hit the regression.

Let me illustrate:

---A----B----C----D---...---E----M
   `--G----H----I----J---...---K-'

Let's say A-E is Greg's tree, and D is the commit you are talking about.
Let's say G-K is Arnd's tree, and H is my patch without the 'select'
statement.  Let's also say that '...' in each case includes a significant
number of commits.

If, through a git bisect (or manual commit selection) you end up trying
to build at any commit I to K, you will not be builting a tree with D
in, but you will be building a tree with H in.  You end up with EHCI
being disabled in your configuration.

What this also means is that when building Arnd's tree without Greg's tree,
you will also end up with EHCI disabled in those configurations (because
you also don't have commit D.)

See?  There is no such thing as "lets make sure tree X gets merged before
tree Y because commit A depends on commit B".  That "solution" doesn't fix
any dependency between the two commits - it merely gives the impression
that it does because you're looking only at the result.

That kind of solution is broken thinking.

> Arnd and
> Olof would heed this and make sure this patch comes after Andrews.  This
> should prevent the regression.

As you can see from the above, tree order does not solve these issues.
It gives the impression from the final result that it does, but it
doesn't.  It breaks at least our most powerful regression debug tool -
git bisect.
