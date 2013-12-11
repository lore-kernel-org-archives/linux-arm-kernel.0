From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Dec 2013 00:51:06 +0000
Subject: [PATCH 3/8] regmap: Add support for using regmap over ssbi
In-Reply-To: <52A7AE1B.3040201@codeaurora.org>
References: <1386718523-2587-1-git-send-email-sboyd@codeaurora.org>
 <1386718523-2587-4-git-send-email-sboyd@codeaurora.org>
 <20131210235000.GK11468@sirena.org.uk>
 <52A7AE1B.3040201@codeaurora.org>
Message-ID: <20131211005106.GL11468@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 04:13:15PM -0800, Stephen Boyd wrote:
> On 12/10/13 15:50, Mark Brown wrote:
> > On Tue, Dec 10, 2013 at 03:35:18PM -0800, Stephen Boyd wrote:

> >> +		reg += sizeof(u16);

> > I'd expect this to generate out of bounds accesses and bad interactions
> > on the bus if we go through the loop more than once since it appears to
> > incrementing the address of reg for every register.  I'm also having a

> ssbi_read() just reads the same register x number of times and doesn't
> do any sort of incrementing of address. My understanding was that
> regmap_bulk_read() will read incrementing addresses and then call down
> into this code with the sequential addresses formatted into the reg
> buffer. That was the flaw. Instead we need to take reg and then

That's possibly not the ideal decision for the underlying API, if
nothing else it's confusing naming given what a read function would
normally do.

> increment reg by 1 every time through this loop. Or should we just have
> use_single_rw == true?

No, it doesn't - it increments the address of reg by the size of a
register value each time.  Using use_single_rw might make sense, or if
you can't do bulk I/O at all then hooking in via reg_read() and
reg_write() in the config rather than trying to parse out the buffers
might be even better (you can still make helpers to set that up).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131211/f07b25f5/attachment.sig>
