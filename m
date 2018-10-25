From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 25 Oct 2018 11:10:37 +0100
Subject: [PATCH 2/2] mfd: ab8500-core: Return zero in
 get_register_interruptible()
In-Reply-To: <20181025084643.tz72tsh7fulsnnzq@mwanda>
References: <20181018080534.yw2crvhguen5vajg@kili.mountain>
 <20181025082508.GJ4939@dell>
 <20181025084643.tz72tsh7fulsnnzq@mwanda>
Message-ID: <20181025101037.GR4939@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Oct 2018, Dan Carpenter wrote:

> On Thu, Oct 25, 2018 at 09:25:08AM +0100, Lee Jones wrote:
> > On Thu, 18 Oct 2018, Dan Carpenter wrote:
> > 
> > > I just noticed this in review.  The get_register_interruptible() should
> > > return zero on success but it instead returns the value that it read.
> > > 
> > > I looked at all the places that called this directly and they check for
> > > negatives and treat greater than or equal to zero as success.  This
> > > function is also called as the ->get_register() function pointer.  Some
> > > of the callers of that treat all non-zero returns as errors, so it's
> > > possible that this bug causes some problems in real life.
> > > 
> > > I could not find any callers that rely on the current behavior, and this
> > > makes the function align with the get_register_interruptible() in
> > > ab3100-core.c.
> > > 
> > > Fixes: 47c1697508f2 ("mfd: Align ab8500 with the abx500 interface")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > ---
> > >  drivers/mfd/ab8500-core.c | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
> > > index 30d09d177171..66458a329127 100644
> > > --- a/drivers/mfd/ab8500-core.c
> > > +++ b/drivers/mfd/ab8500-core.c
> > > @@ -252,16 +252,18 @@ static int get_register_interruptible(struct ab8500 *ab8500, u8 bank,
> > >  	mutex_lock(&ab8500->lock);
> > >  
> > >  	ret = ab8500->read(ab8500, addr);
> > > -	if (ret < 0)
> > > +	if (ret < 0) {
> > >  		dev_err(ab8500->dev, "failed to read reg %#x: %d\n",
> > >  			addr, ret);
> > > -	else
> > > -		*value = ret;
> > > +		return ret;
> > 
> > Looks like you just broke the AB8500.
> > 
> 
> 
> Oh wow.  I screwed up the locking.
> 
> 
> > What is it you're trying to achieve here?  Apart from attempting to
> > return with the mutex still held, what semantics have you changed?
> > 
> 
> Sorry that wasn't clear.  Here is the relevant bits from the commit
> message.
> 
> > > function is also called as the ->get_register() function pointer.  Some
> > > of the callers of that treat all non-zero returns as errors, so it's
> > > possible that this bug causes some problems in real life.
> 
> We're returning positive non-zero values on success instead of zero.
> It's definitely a bug, but I'm not sure if it has an impact in real
> life.

Oh, I see.

Maybe:

	return (ret > 0) ? 0 : ret;

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
