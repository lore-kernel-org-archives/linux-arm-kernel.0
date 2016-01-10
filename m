From: joe@perches.com (Joe Perches)
Date: Sun, 10 Jan 2016 07:08:39 -0800
Subject: [PATCH v2 2/3] checkpatch: check for __smp outside barrier.h
In-Reply-To: <1452427000-4520-3-git-send-email-mst@redhat.com>
References: <1452427000-4520-1-git-send-email-mst@redhat.com>
 <1452427000-4520-3-git-send-email-mst@redhat.com>
Message-ID: <1452438519.7773.23.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2016-01-10 at 13:57 +0200, Michael S. Tsirkin wrote:
> Introduction of __smp barriers cleans up a bunch of duplicate code, but
> it gives people an additional handle onto a "new" set of barriers - just
> because they're prefixed with __* unfortunately doesn't stop anyone from
> using it (as happened with other arch stuff before.)
> 
> Add a checkpatch test so it will trigger a warning.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -5141,6 +5141,16 @@ sub process {
> ?			}
> ?		}
> ?
> +		my $underscore_smp_barriers = qr{__smp_($smp_barriers)}x;

another unnecessary capture group

> +
> +		if ($realfile !~ m@^include/asm-generic/@ &&
> +		????$realfile !~ m@/barrier\.h$@ &&
> +		????$line =~ m/\b($underscore_smp_barriers)\s*\(/ &&
> +		????$line !~ m/^.\s*\#\s*define\s+($underscore_smp_barriers)\s*\(/) {
> +			WARN("MEMORY_BARRIER",
> +			?????"__smp memory barriers shouldn't be used outside barrier.h and asm-generic\n" . $herecurr);
> +		}
> +
> ?# check for waitqueue_active without a comment.
> ?		if ($line =~ /\bwaitqueue_active\s*\(/) {
> ?			if (!ctx_has_comment($first_line, $linenr)) {
