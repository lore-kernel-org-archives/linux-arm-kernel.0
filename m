From: david@gibson.dropbear.id.au (David Gibson)
Date: Wed, 26 Sep 2012 09:30:54 +1000
Subject: [PATCH 1/1] Fix segfault in DTC
In-Reply-To: <1348595889-6495-2-git-send-email-mmayer@broadcom.com>
References: <1348526885-2113-1-git-send-email-mmayer@broadcom.com>
 <1348595889-6495-1-git-send-email-mmayer@broadcom.com>
 <1348595889-6495-2-git-send-email-mmayer@broadcom.com>
Message-ID: <20120925233054.GL9800@truffula.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2012 at 10:58:09AM -0700, Markus Mayer wrote:
> Prior to this change, an empty input file would cause a segfault, because
> yylloc had never been initialized. There was never any characters for the
> lexer to match, so YY_USER_ACTION was never executed before the parse error
> was detected.
> 
> When the parser printed the error message, it tried to include the name of
> the file, but the structure holding the file name (yylloc.file, referenced
> as pos->file) had never been initialized.
> 
> Without the fix:
> 
> $ ./dtc /dev/null
> DTC: dts->dts  on file "/dev/null"
> Segmentation fault (core dumped)
> 
> $ gdb dtc core
> Program terminated with signal 11, Segmentation fault.
>     at scripts/dtc/srcpos.c:194
> 194			fname = pos->file->name;
> (gdb) bt
>     at scripts/dtc/srcpos.c:194
>     fmt=0x40d769 "%s", va=0x7fffbf027148) at scripts/dtc/srcpos.c:220
>     at scripts/dtc/dtc-parser.tab.c:1920
>     at scripts/dtc/treesource.c:38
>     at scripts/dtc/dtc.c:203
> (gdb) p *pos
> $1 = {first_line = 0, first_column = 0, last_line = 0, last_column = 0,
>   file = 0x0}

Which dtc version did you observe this with?  I'm unable to reproduce
the SEGV with current git.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
