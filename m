From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 7 Jun 2013 10:03:23 +1000
Subject: [PATCH v7] arm: use built-in byte swap function
In-Reply-To: <20130606221234.GQ18614@n2100.arm.linux.org.uk>
References: <20130220214943.9b28a5b208da9f081387c55e@freescale.com>
 <alpine.LFD.2.03.1302202327370.6419@syhkavp.arg>
 <20130221005221.15279b1372501af12c1e4f32@freescale.com>
 <alpine.LFD.2.03.1302211134160.6419@syhkavp.arg>
 <20130221203327.6558f89277468f7ffffa6506@freescale.com>
 <alpine.LFD.2.03.1302212219100.6419@syhkavp.arg>
 <20130222194032.f7b44aefa5e2723d16767a1b@freescale.com>
 <1361661654.18110.102.camel@shinybook.infradead.org>
 <20130523114654.1f273241725205c6703b2226@freescale.com>
 <20130523231336.GS18614@n2100.arm.linux.org.uk>
 <20130606221234.GQ18614@n2100.arm.linux.org.uk>
Message-ID: <20130607100323.be805fa79db5f446fcfa14c2@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Thu, 6 Jun 2013 23:12:34 +0100 Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>
> So, we have a problem here - the kind which appears when people stuff
> things into the -next tree which aren't destined for the next merge
> window.  This is the relevant context from your patch, which is
> against linux-next:
> 
> -                lib1funcs.o lib1funcs.S ashldi3.o ashldi3.S \
> -                font.o font.c head.o misc.o $(OBJS)
> +                lib1funcs.o lib1funcs.S ashldi3.o ashldi3.S bswapsdi2.o \
> +                bswapsdi2.S font.o font.c head.o misc.o $(OBJS)
> 
>  # Make sure files are removed during clean
>  extra-y       += piggy.gzip piggy.lzo piggy.lzma piggy.xzkern piggy.lz4 \
>                                                                ^^^^^^^^^
> -                lib1funcs.S ashldi3.S $(libfdt) $(libfdt_hdrs)
> +                lib1funcs.S ashldi3.S bswapsdi2.S $(libfdt) $(libfdt_hdrs)
> 
> the underlined bit - piggy.lz4 for those who read mail with proportional
> fonts.
> 
> That is not in any kernel I have, and if it _is_ something that is
> destined for the next merge window, it should be in my tree as it's
> a core ARM feature, not in some random other tree.

That is commit d8a6bf1b25bd ("arm: add support for LZ4-compressed
kernel") from next-20130606 from the akpm tree.  (adding author cc)  That
patch was cc'd to you, and is part of a series that adds LZ4 compression
to the kernel, so would not work on its own.  The first patch in the
series is "decompressor: add LZ4 decompressor module".


> Short of hand-editing and manually applying the patch, a solution would
> be to rebase it on a mainline kernel version, like -rc4, and resubmit
> that version instead.  That will ultimately then give sfr a conflict
> which should be trivial to resolve - and hopefully we'll find out who's
> carrying the LZ4 patch and putting it into linux-next.

People should *never, ever* submit patches based on linux-next (unless,
of course they are to me to help fix merge conflicts in linux-next, etc).
Patches submitted to a particular maintainer should be based on (an
ancestor of) that maintainer's current tree.

Sure, test new code before and after merging linux-next, but don;t base
new code on it.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130607/4ab2eaa3/attachment.sig>
