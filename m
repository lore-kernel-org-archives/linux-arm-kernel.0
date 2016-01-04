From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Jan 2016 16:11:23 +0000
Subject: [PATCH 1/3] checkpatch.pl: add missing memory barriers
In-Reply-To: <1451923660.4334.83.camel@perches.com>
References: <1451907395-15978-1-git-send-email-mst@redhat.com>
 <1451907395-15978-2-git-send-email-mst@redhat.com>
 <1451923660.4334.83.camel@perches.com>
Message-ID: <20160104161123.GJ19062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 08:07:40AM -0800, Joe Perches wrote:
> On Mon, 2016-01-04 at 13:36 +0200, Michael S. Tsirkin wrote:
> > +		my $all_barriers = join('|', (@barriers, @smp_barriers));
> > +
> > +		if ($line =~ /\b($all_barriers)\(/) {
> 
> It would be better to use /\b$all_barriers\s*\(/
> as there's no reason for the capture and there
> could be a space between the function and the
> open parenthesis.

I think you mean

	/\b(?:$all_barriers)\s*\(/

as 'all_barriers' will be:

	mb|wmb|rmb|smp_mb|smp_wmb|smp_rmb

and putting that into your suggestion results in:

	/\bmb|wmb|rmb|smp_mb|smp_wmb|smp_rmb\s*\(/

which is clearly wrong - the \b only applies to 'mb' and the \s*\( only
applies to smp_rmb.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
