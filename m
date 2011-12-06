From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Dec 2011 21:18:52 +0000
Subject: [RFC][PATCH] ARM: kirkwood: Remove eSATA SheevaPlug board support
In-Reply-To: <1323202967.3019.12.camel@computer2>
References: <1322737480.9622.5.camel@phoenix>
 <1322912383.2378.79.camel@computer2>
 <alpine.LFD.2.02.1112031247230.2357@xanadu.home>
 <1323155228.2237.10.camel@computer2>
 <alpine.LFD.2.02.1112061442430.2357@xanadu.home>
 <1323202967.3019.12.camel@computer2>
Message-ID: <20111206211852.GX14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2011 at 08:22:47PM +0000, Tixy wrote:
> On Tue, 2011-12-06 at 14:45 -0500, Nicolas Pitre wrote:
> > The arm-soc tree is probably more appropriate.  Don't include the 
> > mach-types changes though as it is preferable if they come through RMK's 
> > database updates.
> 
> It's already gone through Russell's tree.
> 
> I realised that a mach-types patch couldn't go into arm-soc as that
> doesn't have the removed machine entries, and the only other changes in
> linux-next for the sheevaplug and ts209 files were from Russell's tree
> anyway. And finally, I thought that Russel's mach-types generation
> script would want to see the fixed files in his tree, otherwise it would
> want to delete the machine entries.

Let me take you through what I did to deal with this.  You supplied me
a patch to go on top of current stuff.  So, I selected the 'misc' branch
to apply it, which had the recent mach-types update as the last thing.
Then:

1. I applied your patch as-is and committed it.  So the tree looked like:
	Nov. mach-types update -> your patch
2. I shuffled your patch before the mach-types update, which caused
   conficts which had to be fixed manually.  So this resulted in:
	your patch -> Nov. mach-types update
3. I resolved the entries in the machine database - by hand in SQL -
   to fix up the entries how you want them.
4. I did another update to mach-types.  At this point, the tree
   looks like:
	your patch -> Nov. mach-types update -> Dec. mach-types update
   and, because I'd fixed the entries in the machine database, they
   didn't get removed this time.
5. I combined the two mach-types update into a single December time
   mach-types update.  Finally, we have what is visible today:
	your patch -> Dec. mach-types update

What we now have is a completely bisectable change with no commit which
fails to build for these platforms.  Of course, as a result of the
juggling, your patch is no longer exactly what you sent on the list
(it's changing the entry in mach-types rather than adding it back) but
my sign-off on committing your change covers that - DCO condition (b).)
