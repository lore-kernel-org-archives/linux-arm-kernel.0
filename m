From: joe@perches.com (Joe Perches)
Date: Sun, 10 Jan 2016 07:07:05 -0800
Subject: [PATCH v2 1/3] checkpatch.pl: add missing memory barriers
In-Reply-To: <1452427000-4520-2-git-send-email-mst@redhat.com>
References: <1452427000-4520-1-git-send-email-mst@redhat.com>
 <1452427000-4520-2-git-send-email-mst@redhat.com>
Message-ID: <1452438425.7773.21.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2016-01-10 at 13:56 +0200, Michael S. Tsirkin wrote:
> SMP-only barriers were missing in checkpatch.pl
> 
> Refactor code slightly to make adding more variants easier.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -5116,7 +5116,25 @@ sub process {
> ?			}
> ?		}
> ?# check for memory barriers without a comment.
> -		if ($line =~ /\b(mb|rmb|wmb|read_barrier_depends|smp_mb|smp_rmb|smp_wmb|smp_read_barrier_depends)\(/) {
> +
> +		my $barriers = qr{
> +			mb|
> +			rmb|
> +			wmb|
> +			read_barrier_depends
> +		}x;
> +		my $smp_barriers = qr{
> +			store_release|
> +			load_acquire|
> +			store_mb|
> +			($barriers)
> +		}x;

If I use a variable called $smp_barriers, I'd expect
it to actually be the smp_barriers, not to have to
prefix it with smp_ before using it.

		my $smp_barriers = qr{
			smp_store_release|
			smp_load_acquire|
			smp_store_mb|
			smp_read_barrier_depends
		}x;

or

		my $smp_barriers = qr{
			smp_(?:store_release|load_acquire|store_mb|read_barrier_depends)
		}x;

?
> +		my $all_barriers = qr{
> +			$barriers|
> +			smp_($smp_barriers)
> +		}x;

And this shouldn't have a capture group.

		my $all_barriers = qr{
			$barriers|
			$smp_barriers
		}x;		
> +
> +		if ($line =~ /\b($all_barriers)\s*\(/) {

This doesn't need the capture group either (?:all_barriers)

> ?			if (!ctx_has_comment($first_line, $linenr))
> {
> ?				WARN("MEMORY_BARRIER",
> ?				?????"memory barrier without
> comment\n" . $herecurr);
