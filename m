From: julia@diku.dk (Julia Lawall)
Date: Mon, 28 Dec 2009 17:51:15 +0100 (CET)
Subject: [PATCH 1/5] arch/arm: Correct NULL test
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE19090200F461@mi8nycmail19.Mi8.com>
References: <Pine.LNX.4.64.0912272226360.20548@ask.diku.dk><20091227215106.GA18317@pengutronix.de>
	<Pine.LNX.4.64.0912272307310.20548@ask.diku.dk>
	<BD79186B4FD85F4B8E60E381CAEE19090200F461@mi8nycmail19.Mi8.com>
Message-ID: <Pine.LNX.4.64.0912281747570.6928@ask.diku.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 28 Dec 2009, H Hartley Sweeten wrote:

> On Sunday, December 27, 2009 3:08 PM, Julia Lawall wrote:
> >>>  	dbgfs_chan = kmalloc(sizeof(*dbgfs_state) * num_dma_channels,
> >>>  			     GFP_KERNEL);
> >>> -	if (!dbgfs_state)
> >>> +	if (!dbgfs_chan)
> >>>  		goto err_alloc;
> >> Shouldn't the malloc line read:
> >> 
> >> 	... = kmalloc(sizeof(*dbgfs_chan) * ...)
> >> 	                      ^^^^^^^^^^
> >> 
> >> ?
> >
> > Good point, thanks.  I will send a revised patch.
> 
> Wouldn't this be clearer?
> 
> 	... = kmalloc(sizeof(struct dentry) * ...)

Documentation/CodingStyle thinks otherwise:

"The preferred form for passing a size of a struct is the following:

	p = kmalloc(sizeof(*p), ...);

The alternative form where struct name is spelled out hurts readability 
and introduces an opportunity for a bug when the pointer variable type is 
changed but the corresponding sizeof that is passed to a memory allocator 
is not."

And actually, in this case, sizeof(struct dentry) would be wrong, because 
the type of dbgfs_chan is struct dentry **, not struct dentry *.  What is 
wanted is an array of pointers.

julia
