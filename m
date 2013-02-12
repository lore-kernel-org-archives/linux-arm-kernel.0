From: joe@perches.com (Joe Perches)
Date: Mon, 11 Feb 2013 16:00:26 -0800
Subject: [PATCH V3 1/2] get_maintainer: allow keywords to match filenames
In-Reply-To: <1360626016-23332-1-git-send-email-swarren@wwwdotorg.org>
References: <1360626016-23332-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1360627226.4707.6.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-02-11 at 16:40 -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Allow K: entries in MAINTAINERS to match directly against filenames;
> either those extracted from patch +++ or --- lines, or those specified
> on the command-line using the -f option.
[]
> I don't think setting exact_pattern_match_hash would be appropriate here;
> at least for intended Tegra use case, this feature is to ensure that all
> Tegra-related driver changes get Cc'd to the Tegra mailing list. Setting
> exact_pattern_match_hash would prevent git history parsing for e.g. S-o-b
> tags, which still seems like it would be useful. Hence, this flag isn't
> set.

And I don't think that's necessary because for filenames,
you could add the appropriate control to the MAINTAINERS

"K:	^pattern$"

> The value in $hash{$tvi} doesn't seem relevant, so I just assign 0.

0 is good.

It would be relevant if --pattern-depth was set.

> Joe, I'm not sure if you care where this gets merged; could it go through
> arm-soc together with patch 2/2? A quick look at git history of the
> script in linux-next indicates there won't be conflicts doing that.

I don't care how it gets merged.

Andrew Morton typically picks these up but
if you want to get it merged separately,
I don't see a problem.

trivial comment below:

> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
[]
> @@ -611,6 +611,10 @@ sub get_maintainers {
>  				    $hash{$tvi} = $value_pd;
>  				}
>  			    }
> +			} elsif ($type eq "K") {

This should probably be 'K' to match the other
'F' use above it.
