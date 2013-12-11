From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Dec 2013 13:27:29 +0000
Subject: [PATCH 3/8] regmap: Add support for using regmap over ssbi
In-Reply-To: <52A7C0C3.2070805@codeaurora.org>
References: <1386718523-2587-1-git-send-email-sboyd@codeaurora.org>
 <1386718523-2587-4-git-send-email-sboyd@codeaurora.org>
 <20131210235000.GK11468@sirena.org.uk>
 <52A7AE1B.3040201@codeaurora.org>
 <20131211005106.GL11468@sirena.org.uk>
 <52A7C0C3.2070805@codeaurora.org>
Message-ID: <20131211132729.GT11468@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 05:32:51PM -0800, Stephen Boyd wrote:

> Are you suggesting we implement the reg_read/reg_write as global helpers
> that the config points to and then call regmap_init()? At a quick glance

Yes, assuming your bus really is limited in the way it seems from the
code.

> it looks like we lose out on regmap_bulk_read() if we do that. There is
> one driver that will use regmap_bulk_read(), but I suppose we can just

bulk_read() should decay to individual reads if there isn't a block
operaton and it's not like the hardware actually supports bulk reads
anyway.

> With use_single_rw I think it can be this.

> static int regmap_ssbi_read(void *context,
>                             const void *reg, size_t reg_size,
>                             void *val, size_t val_size)
> {
>         BUG_ON(reg_size != 2);  
>         return ssbi_read(context, *(u16 *)reg, val, 1);
> }

Right, which is a lot simpler.  Though I'm still not sure the
ssbi_read() interface is the best.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131211/440aae0b/attachment.sig>
