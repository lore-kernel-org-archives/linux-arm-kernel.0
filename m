From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 17 Jul 2015 08:39:26 +0530
Subject: [PATCH 2/2] dmaengine: xdmac: Add scatter gathered memset support
In-Reply-To: <20150716141105.GJ28632@lukather>
References: <1436177964-19380-1-git-send-email-maxime.ripard@free-electrons.com>
 <1436177964-19380-3-git-send-email-maxime.ripard@free-electrons.com>
 <20150716120154.GN5086@localhost> <20150716141105.GJ28632@lukather>
Message-ID: <20150717030926.GC5086@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 16, 2015 at 04:11:05PM +0200, Maxime Ripard wrote:
> Hi Vinod,
> 
> > > +		/*
> > > +		 * The scatterlist API gives us only the address and
> > > +		 * length of each elements.
> > > +		 *
> > > +		 * Unfortunately, we don't have the stride, which we
> > > +		 * will need to compute.
> > > +		 *
> > > +		 * That make us end up in a situation like this one:
> > > +		 *    len    stride    len    stride    len
> > > +		 * +-------+        +-------+        +-------+
> > > +		 * |  N-2  |        |  N-1  |        |   N   |
> > > +		 * +-------+        +-------+        +-------+
> > > +		 *
> > > +		 * We need all these three elements (N-2, N-1 and N)
> > > +		 * to actually take the decision on whether we need to
> > > +		 * queue N-1 or reuse N-2.
> > > +		 *
> > > +		 * We will only consider N if it is the last element.
> > > +		 */
> >
> > Why do you need stride?
> > 
> > This is scatterlist so the computation of stride sounds odd here. Ideally
> > you should take the scatterlist and program the lli for controller.
> 
> Because it is sub-optimal if the length and stride are equals from one
> descriptors to another. The XDMAC is able to repeat any given
> descriptor a given number of time (which is one by default), which
> means that if the parameters of the transfer don't change, we simply
> have to increment the number of time the descriptor has to be used,
> instead of creating a new one that the controller will have to fetch.
> 
> In the non-optimal case (ie the length and/or stride change from one
> scatterlist element to another), we simply fallback to a one LLI per
> scatter list element.
Sound fine to me. The optimization is a good one then...

Another question though, do you expect stride to be linear for your cases,
if so have you actually though about using interleaved API, for these cases

-- 
~Vinod

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150717/42815724/attachment.sig>
