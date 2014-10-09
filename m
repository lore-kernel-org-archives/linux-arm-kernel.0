From: balbi@ti.com (Felipe Balbi)
Date: Thu, 9 Oct 2014 15:35:05 -0500
Subject: RCU bug with v3.17-rc3 ?
In-Reply-To: <20141009162656.GE16002@saruman>
References: <20140904184021.GA13421@saruman.home>
 <20140904191642.GJ5001@linux.vnet.ibm.com>
 <20140904192535.GJ13421@saruman.home>
 <20140904200403.GL13421@saruman.home>
 <20140905213216.GD5001@linux.vnet.ibm.com>
 <20141008171322.GH22688@saruman> <20141008175707.GI22688@saruman>
 <20141008212938.GP22688@saruman>
 <20141009160138.GA2396@cmpxchg.org>
 <20141009162656.GE16002@saruman>
Message-ID: <20141009203505.GD25729@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 09, 2014 at 11:26:56AM -0500, Felipe Balbi wrote:
> > I'm thinking it's not the slot pointer itself that's bad, because
> > __radix_tree_lookup() dereferences that to test if it's populated
> > before returning it, and slot life-time is guaranteed by RCU.
> > 
> > That would only leave garbage in the slot itself, crashing during
> > page_cache_get_speculative().
> > 
> > I'll keep staring at this change, but nothing stands out to me yet.
> 
> alright, it's pretty deterministic however. Always on the same test, no
> matter which USB controller, no matter if backing store is RAM or MMC.
> 
> Those two undefined instructions on the disassembly caught my attention,
> perhaps I'm facing a GCC bug ?

no, probably not a GCC bug. Looking at your commit, however. Man, it
does quite many things at once. Moves code around, adds new functions by
refactoring (and changing) code, renames things, changes int offset into
unsigned ints. Should not be too difficult too to miss a bug in there.

I'll continue digging here.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141009/eed04930/attachment.sig>
