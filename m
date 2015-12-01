From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Dec 2015 17:10:14 +0000
Subject: [PATCH v2 1/2] scripts: Add a recorduidiv program
In-Reply-To: <20151201114929.655433a2@gandalf.local.home>
References: <1448488264-23400-1-git-send-email-sboyd@codeaurora.org>
 <1448488264-23400-2-git-send-email-sboyd@codeaurora.org>
 <20151125234711.GT8644@n2100.arm.linux.org.uk>
 <565C6714.802@suse.com>
 <20151130153208.GR8644@n2100.arm.linux.org.uk>
 <565C6DE9.2020302@suse.com> <565DC5A9.2010305@suse.cz>
 <20151201161944.GX8644@n2100.arm.linux.org.uk>
 <20151201114929.655433a2@gandalf.local.home>
Message-ID: <20151201171014.GY8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 01, 2015 at 11:49:29AM -0500, Steven Rostedt wrote:
> On Tue, 1 Dec 2015 16:19:44 +0000
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>  
> > They hardly "do nothing", as the (eg) recordmcount plasters the build
> > log with warnings.  A solution to that would be to make recordmcount
> > silent if the section is already present.
> 
> Note, that warning found plenty of bugs when modifications of the build
> system was being done and broke recordmcount.c. I really don't want to
> silent it.
> 
> But for some reason, your build is causing lots of warnings and not for
> others. Perhaps we can add a "SILENT_RECORDMCOUNT" environment variable
> and have it set when something like CCACHE_HARDLINK or whatever is
> causing it to trigger when we don't care.

The case is:

Build 1 runs with CCACHE_HARDLINK enabled.
- Each object ccache creates will be stored in ccache, and hard linked
  into the throw-away object tree.
- recordmcount modifies in-place the object in the object tree, which
  also modifies the object in the ccache repository.

The throw-away object tree is thrown away, and a new tree is created,
and the build re-run.  It doesn't matter what CCACHE options are used,
the effect will now be the same:
- Each "hit" ccache object from the previous build will be linked or
  copied to the new throw-away object tree.
- recordmcount will be re-run on the object, which now contains the
  results of the previous recordmcount in-place modification.  This
  causes recordmcount to issue a warning.

There's two solutions to this: one is to disable CCACHE_HARDLINK for
all kernel builds which use in-place object modification.  The other
solution is to avoid in-place object modification, instead doing a
read-write-rename.

I think I ought to ask another question though, before we decide what
to do.  With recordmcount doing in-place object modification, what
happens if a SIGINT or similar is received half way through the
modification of an object?  I would hope that make would delete the
object and not leave it around.

Another suggestion - maybe recordmcount, which fstat()s the file,
should check the st_nlink before modifying the file, and error out
with a helpful error message telling people not to use hardlinks,
which would stop nasty surprises (and make it a rule that this should
be implemented as a general principle for good build behaviour) - iow,
something like this (untested):

 scripts/recordmcount.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index 698768bdc581..bb7589fd7392 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -203,6 +203,10 @@ static void *mmap_file(char const *fname)
 		fprintf(stderr, "not a regular file: %s\n", fname);
 		fail_file();
 	}
+	if (sb.st_nlink != 1) {
+		fprintf(stderr, "file is hard linked: %s\n", fname);
+		fail_file();
+	}
 	addr = mmap(0, sb.st_size, PROT_READ|PROT_WRITE, MAP_PRIVATE,
 		    fd_map, 0);
 	mmap_failed = 0;


-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
