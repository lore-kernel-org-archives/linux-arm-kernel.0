From: josh.coombs@gmail.com (Josh Coombs)
Date: Fri, 14 Dec 2012 15:20:32 -0500
Subject: [RFC v2 1/1] RTL8712 alignment bug in 3.6 and up on ARMV5
In-Reply-To: <CAMW5UfZmptBK5sLq3zMdPJ6C3Arqfyy4SY5BOPfqcOB1T-sbSg@mail.gmail.com>
References: <CAMW5UfZmptBK5sLq3zMdPJ6C3Arqfyy4SY5BOPfqcOB1T-sbSg@mail.gmail.com>
Message-ID: <CAMW5UfYKHMscL6CTRzRjBPJCgYKoRTNz5_y3eN-XjT1pcoU=dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Given 3.7 has shipped, should I rebase on release and put a new RFC
post up, rebase on linux-next, wait for a 3.8-rc or just post it up as
v2 for submission this time as is?

Josh C

On Mon, Nov 26, 2012 at 4:38 PM, Josh Coombs <josh.coombs@gmail.com> wrote:
> I've been banging on my test setup for the past week.  I haven't
> tracked down the cause yet, but something in my prior build system
> results in this problem being masked with some builds.  Doing pure
> vanilla builds from git I'm able to reproduce with 3.6 and the 3.7-rc
> series reliably.  Support for my GFN doesn't exist officially prior to
> 3.6 and I didn't want to introduce new variables by back porting
> support and trying to test with that patch set so I was unable to
> isolate a start point for the failure I found.  I can reproduce the
> failure with 3.7-rc6 currently.
>
> Currently I'm running stable on 3.7-rc6 with the below patch and my
> RealTek 8712 USB NIC.
>
> I'm open to any and all suggestions on how to test further.
>
> Signed-off-by: Joshua Coombs <josh.coombs@gmail.com>
> --
> diff -ruN a/drivers/staging/rtl8712/rtl871x_sta_mgt.c
> b/drivers/staging/rtl8712/rtl871x_sta_mgt.c
> --- a/drivers/staging/rtl8712/rtl871x_sta_mgt.c 2012-11-17
> 16:21:23.000000000 -0500
> +++ b/drivers/staging/rtl8712/rtl871x_sta_mgt.c 2012-11-18
> 14:58:27.000000000 -0500
> @@ -52,11 +52,11 @@
>   s32 i;
>
>   pstapriv->pallocated_stainfo_buf = _malloc(sizeof(struct sta_info) *
> -   NUM_STA + 4);
> +   NUM_STA + 8);
>   if (pstapriv->pallocated_stainfo_buf == NULL)
>   return _FAIL;
> - pstapriv->pstainfo_buf = pstapriv->pallocated_stainfo_buf + 4 -
> - ((addr_t)(pstapriv->pallocated_stainfo_buf) & 3);
> + pstapriv->pstainfo_buf = pstapriv->pallocated_stainfo_buf + 8 -
> + ((addr_t)(pstapriv->pallocated_stainfo_buf) & 7);
>   _init_queue(&pstapriv->free_sta_queue);
>   spin_lock_init(&pstapriv->sta_hash_lock);
>   pstapriv->asoc_sta_count = 0;
