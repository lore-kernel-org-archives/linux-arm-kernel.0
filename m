From: broonie@kernel.org (Mark Brown)
Date: Tue, 10 Dec 2013 23:50:00 +0000
Subject: [PATCH 3/8] regmap: Add support for using regmap over ssbi
In-Reply-To: <1386718523-2587-4-git-send-email-sboyd@codeaurora.org>
References: <1386718523-2587-1-git-send-email-sboyd@codeaurora.org>
 <1386718523-2587-4-git-send-email-sboyd@codeaurora.org>
Message-ID: <20131210235000.GK11468@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 03:35:18PM -0800, Stephen Boyd wrote:

> +	while (val_size) {
> +		ret = ssbi_read(context, *(u16 *)reg, val, 1);
> +		if (ret)
> +			return ret;
> +		reg += sizeof(u16);
> +		val += sizeof(u8);
> +		val_size -= sizeof(u8);

I'd expect this to generate out of bounds accesses and bad interactions
on the bus if we go through the loop more than once since it appears to
incrementing the address of reg for every register.  I'm also having a
hard time understanding why this is doing a read per byte, ssbi_read()
seems to map fairly directly onto the interface of the operation so
there doesn't seem to be any reason for this loop to exist in the first
place.

Has this been tested?  

It'd be helpful to CC the entire series, or at least the patches this
builds on...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131210/1f9dde51/attachment.sig>
