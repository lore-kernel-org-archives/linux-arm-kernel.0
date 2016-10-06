From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Thu, 6 Oct 2016 23:37:29 +0100
Subject: [PATCH] Revert "debugfs: ->d_parent is never NULL or negative"
In-Reply-To: <20161006220050.GN19539@ZenIV.linux.org.uk>
References: <1475789429-11414-1-git-send-email-okaya@codeaurora.org>
 <20161006213734.GM19539@ZenIV.linux.org.uk>
 <f6ba2bf7-4f0b-e874-d642-6620d5df2212@codeaurora.org>
 <20161006220050.GN19539@ZenIV.linux.org.uk>
Message-ID: <20161006223729.GO19539@ZenIV.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 06, 2016 at 11:00:51PM +0100, Al Viro wrote:
> On Thu, Oct 06, 2016 at 05:41:34PM -0400, Sinan Kaya wrote:
> > On 10/6/2016 5:37 PM, Al Viro wrote:
> > > On Thu, Oct 06, 2016 at 05:30:29PM -0400, Sinan Kaya wrote:
> > >> This reverts commit acc29fb8f792 ("debugfs: ->d_parent is never NULL or
> > >> negative") as it breaks the debugfs_remove_recursive API as show in the
> > >> callstack below.
> > > 
> > > NAK.  Fix your code, don't break global asserts.
> > > 
> > 
> > I can fix the code if you tell me what the problem is:
> 
> Getting dentries with NULL ->d_parent should never, ever happen.  Find the
> place where such a beast appears and you've got your problem.
> 
> The same goes for negative dentries with children.  Again, if your code
> triggers such a situation, find where it does so and you've found a bug.
> More than one, at that.

Note that there are exactly 4 places where ->d_parent of some struct
dentry is modified, all in fs/dcache.c.

1) __d_alloc() sets ->d_parent of new instance pointing to the instance
itself and does so before anyone else could observe that dentry.  That's
the only allocator of struct dentry - all of them start their life when
returned by it.  With non-NULL value of ->d_parent.

2) d_alloc() sets it to given (non-NULL) parent.  Note that it has
already dereferenced that parent (spin_lock(&parent->d_lock) a couple of
lines prior to that), so it would've oopsed before it reached that assignment
if it was passed NULL as parent.

3) d_alloc_cursor() - ditto, only there it had been an access to parent->d_sb.

4)?__d_move() does
                dentry->d_parent = target->d_parent;
                target->d_parent = target;
in one case and
                swap(dentry->d_parent, target->d_parent);
in another.  The values had either already been in ->d_parent of another
instance prior to that or are guaranteed to be non-NULL since we'd just
survived dereferencing them.

If you ever get NULL in ->d_parent of struct dentry instance, you are
practically certain to have a dangling pointer to memory that used to
contain a struct dentry at some point but got freed and reused since then.
Any such case is a bug, and this check only papers over that bug - after all,
we might have very well reused it for anything whatsoever, with arbitrary
values ending up in it.

As for the negatives...
	* if ->d_parent points to something other than dentry itself,
it contributes to ->d_count of parent
	* positive dentry can only be turned into negative if the
caller of d_delete() is holding the only reference to it
	* any code setting ->d_parent to another dentry does so only when
the parent to be is known to be positive at the moment.

So if you get a dentry with negative parent passed to it, the only way
it could happen (aside of outright memory corruption) is that dentry
you are passing has ->d_parent pointing to *itself* (and had never been
made positive).  If that can legitimately happen, the proper test is
IS_ROOT(dentry) && !dentry->d_inode, and I strongly suspect that the
second part is irrelevant.  But I would really like to see what leads
to that - I don't see any way for debugfs_create_{file,dir}() et.al. to
return a detached (or negative, for that matter) dentry.

are
