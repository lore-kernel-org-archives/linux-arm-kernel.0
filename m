From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Oct 2013 12:17:28 +0100
Subject: [PATCH] DMA: extend documentation to provide more API details
In-Reply-To: <Pine.LNX.4.64.1310071233340.20796@axis700.grange>
References: <Pine.LNX.4.64.1310051925170.8097@axis700.grange>
 <20131005190200.GZ12758@n2100.arm.linux.org.uk>
 <Pine.LNX.4.64.1310052203060.8097@axis700.grange>
 <20131005233137.GA12758@n2100.arm.linux.org.uk>
 <20131006052029.GE2954@intel.com>
 <Pine.LNX.4.64.1310071233340.20796@axis700.grange>
Message-ID: <20131007111728.GM12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 12:45:33PM +0200, Guennadi Liakhovetski wrote:
> No, not something in the middle. I was thinking about
> 
> (1) cookie 1-3 are submitted
> (2) cookie 1 succeeds
> (3) a DMA error occurs, cookies 2-3 are discarded
> (4) cookie 4 is submitted and succeeds
> (5) the user requests status of cookie 2 and gets success back, AFAICS

This is a side effect of using a sequential cookie based system to indicate
whether a descriptor has succeeded or not.

What may be better is to change the wording here: not DMA_SUCCESS but
DMA_COMPLETED.  That doesn't imply that it has been successful, merely
that the DMA engine has finished with the transaction.

How a transaction gets to notify that it's been in error is a problem -
there is no mechanism to do that (part of that is because DMA engine slave
support grew out of the async_tx stuff which doesn't really have the
notion of failure.)

We can't fetch the descriptor after it has been completed, because it will
have been freed or recycled depending on the implementation.

If we want to have some way to report errors against descriptors, I think
we should augment the descriptor with another callback which gets called
(again from tasklet context) so that drivers which care about this can be
notified of errors.
