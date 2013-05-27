From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Mon, 27 May 2013 21:50:04 +1000
Subject: [PATCH 1/2] ARM: kirkwood: proper retain MAC address workaround
 on DT ethernet
In-Reply-To: <51A33447.80305@gmail.com>
References: <1369253042-15082-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130525.210441.818472895703230779.davem@davemloft.net>
 <51A26B62.4050009@gmail.com>
 <20130527.022339.791886107453761860.davem@davemloft.net>
 <1369647565.3557.28.camel@pasglop> <51A33447.80305@gmail.com>
Message-ID: <1369655404.3557.33.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-05-27 at 12:24 +0200, Sebastian Hesselbarth wrote:
> > There is an of_update_property(), we could change the name though,
> yours
> > is nicer :-)
> 
> Ben, David,
> 
> I had a quick look at sparc's of_set_property. Nothing special except
> it
> depends on OF_DYNAMIC at some place. Using of_update_property instead
> should be the correct function to use. Thanks for the hint, I'll
> update
> the patches accordingly and send v5 hopefully by today.

The only thing is that of_update_property() is a bit awkward to use,
requiring the caller to provide an allocated struct property with
associated allocated content. It also leaks the old property which
is annoying but we haven't sorted out how to deal with allocation
of properties and property content yet.

It would be handy to be able to just do something like

	of_set_property(node, name, ptr, len);

However, that wouldn't help much with the allocation/leak problem,
though at least it would be easier to use. It could also *try* to re-use
the current allocation if the new content is of smaller or equal size.

Cheers,
Ben.
