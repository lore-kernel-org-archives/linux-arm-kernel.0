From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 Feb 2013 12:05:25 +0000
Subject: [PATCH 10/17] ARM: update atag-to-fdt code to be endian agnostic
In-Reply-To: <1360365467-25056-11-git-send-email-ben.dooks@codethink.co.uk>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360365467-25056-11-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130209120525.GD17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 08, 2013 at 11:17:40PM +0000, Ben Dooks wrote:
> -	if (atag->hdr.tag != ATAG_CORE ||
> -	    (atag->hdr.size != tag_size(tag_core) &&
> -	     atag->hdr.size != 2))
> +	if (atag->hdr.tag != atag32_to_cpu(ATAG_CORE) ||
> +	    (atag->hdr.size != atag32_to_cpu(tag_size(tag_core)) &&
> +	     atag->hdr.size != atag32_to_cpu(2)))

This is wrong.  You're saying that "ATAG_CORE" is in LE32 format.  It
isn't.  It's in CPU endian format.  If you want to do this kind of thing,
you also need to define cpu_to_atag32() macros as well, otherwise this
will cause sparse warnings.

> -			initrd_start = atag->u.initrd.start;
> -			initrd_size = atag->u.initrd.size;
> +			initrd_start = atag32_to_cpu(atag->u.initrd.start);
> +			initrd_size = atag32_to_cpu(____atag->u.initrd.size);

Where did those four underscores come from?  Has this been built?
