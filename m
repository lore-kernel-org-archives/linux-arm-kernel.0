From: agruen@suse.de (Andreas Gruenbacher)
Date: Sat, 4 Sep 2010 00:58:17 +0200
Subject: [bug-patch] [BUG?] rename patch accepted with --dry-run,
	rejected without (Re: [PATCH V3] arm & sh: factorised duplicated
	clkdev.c)
In-Reply-To: <20100903184351.GC2341@burratino>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com>
	<20100903182323.GA17152@pengutronix.de>
	<20100903184351.GC2341@burratino>
Message-ID: <201009040058.18028.agruen@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday 03 September 2010 20:43:51 Jonathan Nieder wrote:
> Uwe Kleine-K?nig wrote:
> > On Fri, Sep 03, 2010 at 07:18:43PM +0900, Magnus Damm wrote:
> 
> >> Using --dry-run is fine, but omitting dry-run gives me:
> >> 
> >> ...
> >> patching file arch/arm/common/clkdev.c
> >> patching file arch/sh/include/asm/clkdev.h
> >> Hunk #1 FAILED at 1.
> >> Hunk #2 FAILED at 11.
> >> 2 out of 2 hunks FAILED -- saving rejects to file
> >> arch/sh/include/asm/clkdev.h.rej
> >> 
> >> I guess this is caused by the last "renaming" hunk, see below.
> 
> Yep, I can reproduce this.  Patch applies with "git apply",
> "patch --dry-run -p1" accepts it, "patch -p1" fails.
> 
>  $ patch --version | head -1
>  GNU patch 2.6.1.85-423d
>  $ cd ~/src/linux-2.6
>  $ git checkout 2bfc96a12
>  $ git clean -fd
>  $ wget http://download.gmane.org/gmane.linux.ports.sh.devel/8747/8748
> [...]

something pretty bizarre is going on here.  The wget output modifies the same 
file twice, but both patches to this file have the same source sha1 (5645f35):

> diff --git a/arch/sh/include/asm/clkdev.h b/arch/sh/include/asm/clkdev.h
> dissimilarity index 69%
> index 5645f35..6ba9186 100644
> --- a/arch/sh/include/asm/clkdev.h
> +++ b/arch/sh/include/asm/clkdev.h

> diff --git a/arch/sh/include/asm/clkdev.h b/include/linux/clkdev.h
> similarity index 85%
> rename from arch/sh/include/asm/clkdev.h
> rename to include/linux/clkdev.h
> index 5645f35..457bcb0 100644

So "git apply" and "patch --dry-run" seem to work only by accident.

How was this patch generated: with git itself?

The fact that "patch --dry-run" may not work for patches that modify the same 
file twice is a known defect.  I don't know how to solve this in a reasonably 
elegant way.  Luckily the problem only triggers when people are doing 
something "strange" such as concatenating patches.

Andreas
