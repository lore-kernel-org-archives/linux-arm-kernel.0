From: joe@perches.com (Joe Perches)
Date: Tue, 20 Jan 2015 14:25:16 -0800
Subject: [PATCH] checkpatch: Add ability to coalesce commit descriptions on
 multiple lines
In-Reply-To: <1421660338.9655.21.camel@x220>
References: <1421659937.9655.16.camel@x220> <1421660338.9655.21.camel@x220>
Message-ID: <1421792716.2724.11.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a git commit description is split on consecutive lines,
coalesce it before testing.

This allows:

  commit <foo> ("some long
  description")

Signed-off-by: Joe Perches <joe@perches.com>
Noticed-by: Paul Bolle <pebolle@tiscali.nl>
---
> Checkpatch in next-21050119 complains:
>     ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit fa0ce4035d48 ("ARM: 7162/1: errata: tidy up Kconfig options for PL310 errata workarounds")'
>     #7: 
>     commit fa0ce4035d48 ("ARM: 7162/1: errata: tidy up Kconfig options for
>     
>     total: 1 errors, 0 warnings, 14 lines checked
>     
>     Your patch has style problems, please review.
> 
> Perhaps it doesn't notice the quote spans two lines. Can this be fixed
> please?

Oh bother...

 scripts/checkpatch.pl | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 41223c9..6a3baa0 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2198,6 +2198,13 @@ sub process {
 				 defined $rawlines[$linenr] &&
 				 $rawlines[$linenr] =~ /^\s*\("([^"]+)"\)/) {
 				$orig_desc = $1;
+			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("[^"]+$/i &&
+				 defined $rawlines[$linenr] &&
+				 $rawlines[$linenr] =~ /^\s*[^"]+"\)/) {
+				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)$/i;
+				$orig_desc = $1;
+				$rawlines[$linenr] =~ /^\s*([^"]+)"\)/;
+				$orig_desc .= " " . $1;
 			}
 
 			($id, $description) = git_commit_info($orig_commit,
