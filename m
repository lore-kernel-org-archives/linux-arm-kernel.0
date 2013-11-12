From: luis.henriques@canonical.com (Luis Henriques)
Date: Tue, 12 Nov 2013 12:45:46 +0000
Subject: [3.5.y.z extended stable] Patch "scripts/kallsyms: filter symbols not
 in kernel address space" has been added to staging queue
Message-ID: <1384260346-6000-1-git-send-email-luis.henriques@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a note to let you know that I have just added a patch titled

    scripts/kallsyms: filter symbols not in kernel address space

to the linux-3.5.y-queue branch of the 3.5.y.z extended stable tree 
which can be found at:

 http://kernel.ubuntu.com/git?p=ubuntu/linux.git;a=shortlog;h=refs/heads/linux-3.5.y-queue

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.5.y.z tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Luis

------

>From beee0a7e501b0ac0d4c8d35372b93a78f49de283 Mon Sep 17 00:00:00 2001
From: Ming Lei <tom.leiming@gmail.com>
Date: Sat, 2 Nov 2013 09:11:33 +1030
Subject: scripts/kallsyms: filter symbols not in kernel address space

commit f6537f2f0eba4eba3354e48dbe3047db6d8b6254 upstream.

This patch uses CONFIG_PAGE_OFFSET to filter symbols which
are not in kernel address space because these symbols are
generally for generating code purpose and can't be run at
kernel mode, so we needn't keep them in /proc/kallsyms.

For example, on ARM there are some symbols which may be
linked in relocatable code section, then perf can't parse
symbols any more from /proc/kallsyms, this patch fixes the
problem (introduced b9b32bf70f2fb710b07c94e13afbc729afe221da)

Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Michal Marek <mmarek@suse.cz>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
[ luis: backported to 3.5: adjusted context ]
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 scripts/kallsyms.c      | 12 +++++++++++-
 scripts/link-vmlinux.sh |  2 ++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 487ac6f..9a11f9f 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -55,6 +55,7 @@ static struct sym_entry *table;
 static unsigned int table_size, table_cnt;
 static int all_symbols = 0;
 static char symbol_prefix_char = '\0';
+static unsigned long long kernel_start_addr = 0;

 int token_profit[0x10000];

@@ -65,7 +66,10 @@ unsigned char best_table_len[256];

 static void usage(void)
 {
-	fprintf(stderr, "Usage: kallsyms [--all-symbols] [--symbol-prefix=<prefix char>] < in.map > out.S\n");
+	fprintf(stderr, "Usage: kallsyms [--all-symbols] "
+			"[--symbol-prefix=<prefix char>] "
+			"[--page-offset=<CONFIG_PAGE_OFFSET>] "
+			"< in.map > out.S\n");
 	exit(1);
 }

@@ -194,6 +198,9 @@ static int symbol_valid(struct sym_entry *s)
 	int i;
 	int offset = 1;

+	if (s->addr < kernel_start_addr)
+		return 0;
+
 	/* skip prefix char */
 	if (symbol_prefix_char && *(s->sym + 1) == symbol_prefix_char)
 		offset++;
@@ -646,6 +653,9 @@ int main(int argc, char **argv)
 				if ((*p == '"' && *(p+2) == '"') || (*p == '\'' && *(p+2) == '\''))
 					p++;
 				symbol_prefix_char = *p;
+			} else if (strncmp(argv[i], "--page-offset=", 14) == 0) {
+				const char *p = &argv[i][14];
+				kernel_start_addr = strtoull(p, NULL, 16);
 			} else
 				usage();
 		}
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index cd9c6c6..7a9f7f9 100644
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -78,6 +78,8 @@ kallsyms()
 		kallsymopt=--all-symbols
 	fi

+	kallsymopt="${kallsymopt} --page-offset=$CONFIG_PAGE_OFFSET"
+
 	local aflags="${KBUILD_AFLAGS} ${KBUILD_AFLAGS_KERNEL}               \
 		      ${NOSTDINC_FLAGS} ${LINUXINCLUDE} ${KBUILD_CPPFLAGS}"

--
1.8.3.2
