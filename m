From: zhizhouzhang@asrmicro.com (=?utf-8?B?WmhhbmcgWmhpemhvdSjlvKDmsrvmtLIp?=)
Date: Mon, 19 Nov 2018 10:32:29 +0000
Subject: [PATCH] tee: optee: avoid possible double list_del()
In-Reply-To: <20181119100845.GA26837@jax.urgonet>
References: <20181119064139.24659-1-zhizhouzhang@asrmicro.com>
 <20181119100845.GA26837@jax.urgonet>
Message-ID: <10ab2d334e5b43558ed0a7a922a038f6@mail2012.asrmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Jens Wiklander [mailto:jens.wiklander at linaro.org]
> Sent: Monday, November 19, 2018 6:09 PM
> To: Zhang Zhizhou(???) <zhizhouzhang@asrmicro.com>
> Cc: tee-dev at lists.linaro.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] tee: optee: avoid possible double list_del()
> 
> Hi Zhizhou,
> 
> On Mon, Nov 19, 2018 at 02:41:39PM +0800, Zhizhou Zhang wrote:
> > This bug occurs when:
> >
> > - a new request arrives, one thread(let's call it A) is pending in
> >   optee_supp_req() with req->busy is initial value false.
> >
> > - tee-supplicant is killed, then optee_supp_release() is called, this
> >   function calls list_del(&req->link), and set supp->ctx to NULL. And
> >   it also wake up process A.
> >
> > - process A continues, it firstly checks supp->ctx which is NULL,
> >   then checks req->busy which is false, at last run list_del(&req->link).
> >   This triggers double list_del() and results kernel panic.
> >
> > So let's set req->busy to true if optee_supp_release() has already
> > called list_del(&req->link).
> >
> > Signed-off-by: Zhizhou Zhang <zhizhouzhang@asrmicro.com>
> > ---
> >  drivers/tee/optee/supp.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
> > index df35fc01fd3e..c8ac6636520a 100644
> > --- a/drivers/tee/optee/supp.c
> > +++ b/drivers/tee/optee/supp.c
> > @@ -62,6 +62,7 @@ void optee_supp_release(struct optee_supp *supp)
> >
> >  	/* Abort all queued requests */
> >  	list_for_each_entry_safe(req, req_tmp, &supp->reqs, link) {
> > +		req->busy = true;
> >  		list_del(&req->link);
> >  		req->ret = TEEC_ERROR_COMMUNICATION;
> >  		complete(&req->c);
> > --
> > 2.17.1
> 
> This seems to work, but is a bit confusing. It turns out the busy flag
> will only used to tell if the request is in the queue (and may need to be
> dequeued) or not.
> 
> How about renaming the flag to "in_queue" and update the assignments and
> tests appropriately to only indicate if it's in the queue or not?

You're right. I will send you a V2 patch later. Thanks!
> 
> That should work as well and be more clear on what's going on, or am I
> missing something?

When I was making this patch, I also had the same concern. This patch make busy doesn't mean busy any more. But I'm afraid of changing too much, so I sent you a only one line changed patch. ;-)
> 
> Thanks,
> Jens
