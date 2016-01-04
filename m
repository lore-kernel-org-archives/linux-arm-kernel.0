From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 04 Jan 2016 11:46:28 +0100
Subject: [PATCH v2] udf: avoid uninitialized variable use
In-Reply-To: <20160104095605.GC3888@quack.suse.cz>
References: <9221187.T0u8gszVyj@wuerfel> <5491623.oZlI0zcRmi@wuerfel>
 <20160104095605.GC3888@quack.suse.cz>
Message-ID: <3635579.F68L9XXk6v@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 January 2016 10:56:05 Jan Kara wrote:
> On Fri 01-01-16 15:21:54, Arnd Bergmann wrote:
> > A new warning about a real bug has come up from a recent cleanup:
> > 
> > fs/udf/inode.c: In function 'udf_setup_indirect_aext':
> > fs/udf/inode.c:1927:28: warning: 'adsize' may be used uninitialized in this function [-Wmaybe-uninitialized]
> > 
> > If the alloc_type is neither ICBTAG_FLAG_AD_SHORT nor ICBTAG_FLAG_AD_LONG,
> > the value of adsize is undefined. This changes the code to use zero for adsize
> > in that case, which may be the correct solution, though I have not looked
> > at the code in enough detail to know if it should be something else instead.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Fixes: fcea62babc81 ("udf: Factor out code for creating indirect extent")
> > ---
> > sorry for missing another instance the first time around. The warning is
> > a bit unreliable and it seems in my first configuration I got it only
> > for one of the two instances that show it in other configuration.
> > 
> > After checking the remaining functions in this file for the same possible
> > problem, I found that the other functions use either 'BUG()' or 'return -EIO'
> > in the 'else' path, so I assume the two functions here should one of those
> > as well, but I don't know which.
> 
> Callers of these functions make sure alloc_type is one of the two valid
> ones. However for future-proofing you're right that probably we should
> handle the invalid case as well. Setting adsize to zero is problematic -
> not sure what the code would actually do but it wouldn't definitely work.
> I'd just return -EIO. Attached is the patch I have merged.
> 
> 

Looks good, thanks!

	Arnd
