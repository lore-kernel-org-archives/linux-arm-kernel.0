From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Jan 2015 15:32:54 +0000
Subject: Continuing kallsyms failures - large kernels, XIP kernels, and
 large XIP kernels
In-Reply-To: <20150130145642.GK26493@n2100.arm.linux.org.uk>
References: <20150130145642.GK26493@n2100.arm.linux.org.uk>
Message-ID: <20150130153254.GL26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the hack I'm using to avoid the veneers appearing in the kallsyms
data.  This solves my randconfig failure I saw last night - but obviously
is not bullet proof as it'll find _veneer anywhere in the symbol name.

 scripts/kallsyms.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index c6d33bd15b04..eea599c701f5 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -158,6 +158,8 @@ static int read_symbol(FILE *in, struct sym_entry *s)
 	/* exclude debugging symbols */
 	else if (stype == 'N')
 		return -1;
+	else if (strstr(sym, "_veneer"))
+		return -1;
 
 	/* include the type field in the symbol name, so that it gets
 	 * compressed together */

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
