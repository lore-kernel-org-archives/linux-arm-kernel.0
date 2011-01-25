From: wharms@bfs.de (walter harms)
Date: Tue, 25 Jan 2011 12:12:45 +0100
Subject: [PATCH 2/4] arch/arm/mach-at91/clock.c: Add missing IS_ERR test
In-Reply-To: <20110125104333.GE11507@n2100.arm.linux.org.uk>
References: <1295898922-18822-1-git-send-email-julia@diku.dk>
	<1295898922-18822-3-git-send-email-julia@diku.dk>
	<4D3DD964.9020107@bluewatersys.com>
	<Pine.LNX.4.64.1101242058430.3167@ask.diku.dk>
	<20110124200515.GA30963@albatros>
	<Pine.LNX.4.64.1101242108180.3167@ask.diku.dk>
	<4D3EA6EC.5050305@bfs.de>
	<20110125104333.GE11507@n2100.arm.linux.org.uk>
Message-ID: <4D3EB02D.6090302@bfs.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Am 25.01.2011 11:43, schrieb Russell King - ARM Linux:
> On Tue, Jan 25, 2011 at 11:33:16AM +0100, walter harms wrote:
>> Would it be more easy to return NULL in the error case of clk_get() instead
>> of ERR_PTR(-ENOENT) ?
>>
>> So the default could be return NULL and an architecture depending solution
>> replacing that.
> 
> That's not how the API is defined.  The API defines error-pointers to be
> errors, everything should be considered valid.  Please don't go down the
> route of doing something architecturally different from that.
> 
> What if, say, you couldn't return the struct clk because maybe it could
> only be controlled by one user?  Returning an EBUSY error pointer would
> indicate this condition.  What if the module providing the struct clk
> hasn't finished initializing - that's another reason for EBUSY rather
> than ENOENT.
> 
> Error codes are useful to describe why something failed.  NULL pointers
> can't do that.
> 

On Mon, 24 Jan 2011, Vasiliy Kulikov wrote:
> 
...
> clk_get() is defined per-architecture, sometimes it is NULL only.
>

So these is a bug ? They should return -ENOENT ?

The interessting question is: what to do with an error ?

Obviously some architecture can live with NULL, so it is not an critical
error. An the patch shows a code that is simply a return, not even the
user is informed that something did not work as expected.
