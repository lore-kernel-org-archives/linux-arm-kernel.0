From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Wed, 21 Nov 2018 07:48:00 +0100
Subject: [PATCH] tee: optee: avoid possible double list_del()
In-Reply-To: <20181121030143.31180-1-zhizhouzhang@asrmicro.com>
References: <20181121030143.31180-1-zhizhouzhang@asrmicro.com>
Message-ID: <20181121064759.GA12645@jax.urgonet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhizhou,

On Wed, Nov 21, 2018 at 11:01:43AM +0800, Zhizhou Zhang wrote:
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
> For solve this problem, we rename req->busy to req->in_queue, and
> associate it with state of whether req is linked to supp->reqs. So we
> can just only check req->in_queue to make decision calling list_del()
> or not.
> 
> Signed-off-by: Zhizhou Zhang <zhizhouzhang@asrmicro.com>
> ---
>  drivers/tee/optee/supp.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 

Looks good. I'm picking this up.

Thanks,
Jens
