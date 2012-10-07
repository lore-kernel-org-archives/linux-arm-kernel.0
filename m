From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 7 Oct 2012 15:14:40 +0200
Subject: [PATCH] ARM: sort select statements alphanumerically
In-Reply-To: <E1TKX8k-0006QP-M5@rmk-PC.arm.linux.org.uk>
References: <E1TKX8k-0006QP-M5@rmk-PC.arm.linux.org.uk>
Message-ID: <20121007131440.GC12801@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:22 Sat 06 Oct     , Russell King wrote:
> As suggested by Andrew Morton:
> 
>   This is a pet peeve of mine.  Any time there's a long list of items
>   (header file inclusions, kconfig entries, array initalisers, etc) and
>   someone wants to add a new item, they *always* go and stick it at the
>   end of the list.
>   ...
>   Guys, don't do this.  Either put the new item into a randomly-chosen
>   position or, probably better, alphanumerically sort the list.
> 
>   For this reason it looks like approximately 0% of the patchset will
>   apply, sorry.
> 
> lets sort all our select statements alphanumerically.  This commit was
> created by the following script:
> 
> #!/usr/bin/perl
> while (<>) {
> 	while (/\\\s*$/) {
> 		$_ .= <>;
> 	}
> 	undef %selects if /^\s*config\s+/;
> 	if (/^\s+select\s+(\w+).*/) {
> 		if (defined($selects{$1})) {
> 			if ($selects{$1} eq $_) {
> 				print STDERR "Warning: removing duplicated $1 entry\n";
> 			} else {
> 				print STDERR "Error: $1 differently selected\n".
> 					"\tOld: $selects{$1}\n".
> 					"\tNew: $_\n";
> 				exit 1;
> 			}
> 		}
> 		$selects{$1} = $_;
> 		next;
> 	}
> 	if (%selects and (/^\s*$/ or /^\s+help/)) {
> 		foreach $k (sort (keys %selects)) {
> 			print "$selects{$k}";
> 		}
> 		undef %selects;
> 	}
> 	print;
> }
> if (%selects) {
> 	foreach $k (sort (keys %selects)) {
> 		print "$selects{$k}";
> 	}
> }
> 
> It found two duplicates:
> 
> Warning: removing duplicated S5P_SETUP_MIPIPHY entry
> Warning: removing duplicated HARDIRQS_SW_RESEND entry
> 
> and they are identical duplicates, hence the shrinkage in the diffstat
> of two lines.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> This commit is likely to change as we get closer to the end of the merge
> window, as other changes get merged into Linus' tree.  I will be refreshing
> this from time to time, and keeping it out of linux-next, as it will cause
> more pain than its worth to put it into linux-next.
> 
> Anyone who wants to give this a review to check that it's correct are welcome,
> but I don't think it would be appropriate to collect attributation tags for
> it, as this won't be the final patch.
> 
> This patch is intentionally broken to prevent Linus from applying it - this
> is information only!
> 
> Anyone who wants to apply it can do so by first running this patch through:
> 
> 	sed 's/^-- /@@ /'
> 
>  arch/arm/Kconfig                  |  399 ++++++++++++++++++-------------------
>  arch/arm/common/Kconfig           |    4 +-
>  arch/arm/mach-at91/Kconfig        |   26 ++--
this maybe conflict with pinctrl support

Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
