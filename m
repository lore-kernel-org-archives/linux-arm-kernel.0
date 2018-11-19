From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Mon, 19 Nov 2018 11:08:46 +0100
Subject: [PATCH] tee: optee: avoid possible double list_del()
In-Reply-To: <20181119064139.24659-1-zhizhouzhang@asrmicro.com>
References: <20181119064139.24659-1-zhizhouzhang@asrmicro.com>
Message-ID: <20181119100845.GA26837@jax.urgonet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhizhou,

On Mon, Nov 19, 2018 at 02:41:39PM +0800, Zhizhou Zhang wrote:
> This bug occurs when:
> 
> - a new request arrives, one thread(let's call it A) is pending in
>   optee_supp_req() with req->busy is initial value false.
> 
> - tee-supplicant is killed, then optee_supp_release() is called, this
>   function calls list_del(&req->link), and set supp->ctx to NULL. And
>   it also wake up process A.
> 
> - process A continues, it firstly checks supp->ctx which is NULL,
>   then checks req->busy which is false, at last run list_del(&req->link).
>   This triggers double list_del() and results kernel panic.
> 
> So let's set req->busy to true if optee_supp_release() has already
> called list_del(&req->link).
> 
> Signed-off-by: Zhizhou Zhang <zhizhouzhang@asrmicro.com>
> ---
>  drivers/tee/optee/supp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
> index df35fc01fd3e..c8ac6636520a 100644
> --- a/drivers/tee/optee/supp.c
> +++ b/drivers/tee/optee/supp.c
> @@ -62,6 +62,7 @@ void optee_supp_release(struct optee_supp *supp)
>  
>  	/* Abort all queued requests */
>  	list_for_each_entry_safe(req, req_tmp, &supp->reqs, link) {
> +		req->busy = true;
>  		list_del(&req->link);
>  		req->ret = TEEC_ERROR_COMMUNICATION;
>  		complete(&req->c);
> -- 
> 2.17.1

This seems to work, but is a bit confusing. It turns out the busy flag
will only used to tell if the request is in the queue (and may need to be
dequeued) or not.

How about renaming the flag to "in_queue" and update the assignments and
tests appropriately to only indicate if it's in the queue or not?

That should work as well and be more clear on what's going on, or am I
missing something?

Thanks,
Jens
