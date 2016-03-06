From: mw@semihalf.com (Marcin Wojtas)
Date: Sun, 6 Mar 2016 20:21:51 +0100
Subject: [PATCH v4 net-next 8/9] net: add a hardware buffer management
 helper API
In-Reply-To: <1457217507-10778-9-git-send-email-gregory.clement@free-electrons.com>
References: <1457217507-10778-1-git-send-email-gregory.clement@free-electrons.com>
 <1457217507-10778-9-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <CAPv3WKeTGy+HfG=vyY04xi4Spy6eUTF_LX_X=V0=ZAGhxURdJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,


> +int hwbm_pool_add(struct hwbm_pool *bm_pool, unsigned int buf_num, gfp_t gfp)
> +{
> +       int err, i;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&bm_pool->lock, flags);
> +       if (bm_pool->buf_num == bm_pool->size) {

'size' field is used as a 'frag_size' but here it means pool capacity.
I think it's better to keep 'size' for pool capacity and add
'buf_size' field to struct hwbm_pool.

> +               pr_warn("pool already filled\n");
> +               return bm_pool->buf_num;
> +       }
> +
> +       if (buf_num + bm_pool->buf_num > bm_pool->size) {
> +               pr_warn("cannot allocate %d buffers for pool\n",
> +                       buf_num);
> +               return 0;
> +       }
> +
> +       if ((buf_num + bm_pool->buf_num) < bm_pool->buf_num) {

What is a point of this condition? How possibly after checking if
capacity of pool is not exceeded, this one would ever be true?

> +               pr_warn("Adding %d buffers to the %d current buffers will overflow\n",
> +                       buf_num,  bm_pool->buf_num);
> +               return 0;
> +       }
> +

Best regards,
Marcin
