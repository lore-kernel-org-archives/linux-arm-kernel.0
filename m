From: joe@perches.com (Joe Perches)
Date: Mon, 04 Jan 2016 14:15:50 -0800
Subject: [PATCH 1/3] checkpatch.pl: add missing memory barriers
In-Reply-To: <20160104224415-mutt-send-email-mst@redhat.com>
References: <1451907395-15978-1-git-send-email-mst@redhat.com>
 <1451907395-15978-2-git-send-email-mst@redhat.com>
 <1451923660.4334.83.camel@perches.com>
 <20160104224415-mutt-send-email-mst@redhat.com>
Message-ID: <1451945750.4334.111.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-01-04 at 22:45 +0200, Michael S. Tsirkin wrote:
> On Mon, Jan 04, 2016 at 08:07:40AM -0800, Joe Perches wrote:
> > On Mon, 2016-01-04 at 13:36 +0200, Michael S. Tsirkin wrote:
> > > SMP-only barriers were missing in checkpatch.pl
> > > 
> > > Refactor code slightly to make adding more variants easier.
> > > 
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > > ?scripts/checkpatch.pl | 9 ++++++++-
> > > ?1 file changed, 8 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > index 2b3c228..0245bbe 100755
> > > --- a/scripts/checkpatch.pl
> > > +++ b/scripts/checkpatch.pl
> > > @@ -5116,7 +5116,14 @@ sub process {
> > > ?			}
> > > ?		}
> > > ?# check for memory barriers without a comment.
> > > -		if ($line =~ /\b(mb|rmb|wmb|read_barrier_depends|smp_mb|smp_rmb|smp_wmb|smp_read_barrier_depends)\(/) {
> > > +
> > > +		my @barriers = ('mb', 'rmb', 'wmb', 'read_barrier_depends');
> > > +		my @smp_barriers = ('smp_store_release', 'smp_load_acquire', 'smp_store_mb');
> > > +
> > > +		@smp_barriers = (@smp_barriers, map {"smp_" . $_} @barriers);
> > 
> > I think using map, which so far checkpatch doesn't use,
> > makes smp_barriers harder to understand and it'd be
> > better to enumerate them.
> 
> Okay - I'll rewrite using foreach.
> 

I think using the qr form (like 'our $Attribute' and
a bunch of others) is the general style that should
be used for checkpatch.
