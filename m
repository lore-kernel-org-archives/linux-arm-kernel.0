From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Jul 2015 16:11:05 +0200
Subject: [PATCH 2/2] dmaengine: xdmac: Add scatter gathered memset support
In-Reply-To: <20150716120154.GN5086@localhost>
References: <1436177964-19380-1-git-send-email-maxime.ripard@free-electrons.com>
 <1436177964-19380-3-git-send-email-maxime.ripard@free-electrons.com>
 <20150716120154.GN5086@localhost>
Message-ID: <20150716141105.GJ28632@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

> > +		/*
> > +		 * The scatterlist API gives us only the address and
> > +		 * length of each elements.
> > +		 *
> > +		 * Unfortunately, we don't have the stride, which we
> > +		 * will need to compute.
> > +		 *
> > +		 * That make us end up in a situation like this one:
> > +		 *    len    stride    len    stride    len
> > +		 * +-------+        +-------+        +-------+
> > +		 * |  N-2  |        |  N-1  |        |   N   |
> > +		 * +-------+        +-------+        +-------+
> > +		 *
> > +		 * We need all these three elements (N-2, N-1 and N)
> > +		 * to actually take the decision on whether we need to
> > +		 * queue N-1 or reuse N-2.
> > +		 *
> > +		 * We will only consider N if it is the last element.
> > +		 */
>
> Why do you need stride?
> 
> This is scatterlist so the computation of stride sounds odd here. Ideally
> you should take the scatterlist and program the lli for controller.

Because it is sub-optimal if the length and stride are equals from one
descriptors to another. The XDMAC is able to repeat any given
descriptor a given number of time (which is one by default), which
means that if the parameters of the transfer don't change, we simply
have to increment the number of time the descriptor has to be used,
instead of creating a new one that the controller will have to fetch.

In the non-optimal case (ie the length and/or stride change from one
scatterlist element to another), we simply fallback to a one LLI per
scatter list element.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150716/6bf563a7/attachment.sig>
