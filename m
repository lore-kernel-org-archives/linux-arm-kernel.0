From: joe@perches.com (Joe Perches)
Date: Thu, 20 Mar 2014 03:08:20 -0700
Subject: [PATCH] checkpatch.pl: Add check for Change-Id
In-Reply-To: <1395255293-3419-1-git-send-email-cov@codeaurora.org>
References: <1395255293-3419-1-git-send-email-cov@codeaurora.org>
Message-ID: <1395310100.7776.3.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-03-19 at 14:54 -0400, Christopher Covington wrote:
> A commit hook for the Gerrit code review server inserts change
> identifiers so Gerrit can track patches through multiple revisions.
> These identifiers are noise in the context of the upstream kernel.
> (Many Gerrit servers are private. Even given a public instance,
> given only a Change-Id, one must guess which server a change was
> tracked on. Patches submitted to the Linux kernel mailing lists
> should be able to stand on their own. If it's truly useful to
> reference code review on a Gerrit server, a URL is a much clearer
> way to do so.) Thus, issue an error when a Change-Id: line is
> encountered.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -1891,6 +1891,12 @@ sub process {
>  			}
>  		}
>  
> +# Check for unwanted Gerrit info
> +		if ($line =~ /^\s*change-id:/i) {
> +			ERROR("BAD_SIGN_OFF",
> +			      "Remove Gerrit Change-Id's before submitting upstream.\n" . $herecurr);
> +		}
> +

I think this needs an "$in_commit_log" test added

		if ($in_commit_log &&
		    $line =~ /^\s*change-id:/i) {

And maybe use a separate "TYPE", not "BAD_SIGN_OFF".
Maybe "GERRIT_CHANGE_ID"
