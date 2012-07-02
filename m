From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 02 Jul 2012 12:54:30 +0530
Subject: [PATCH] clk: __clk_set_parent: set uninitialized variable
In-Reply-To: <20120702064737.GB22016@pengutronix.de>
References: <1341177539-27716-1-git-send-email-mkl@pengutronix.de>
 <4FF13839.5000804@ti.com> <20120702064737.GB22016@pengutronix.de>
Message-ID: <4FF14CAE.9040304@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 July 2012 12:17 PM, Uwe Kleine-K?nig wrote:
> On Mon, Jul 02, 2012 at 11:27:13AM +0530, Rajendra Nayak wrote:
>> On Monday 02 July 2012 02:48 AM, Marc Kleine-Budde wrote:
>>> This patch fixes the following warning:
>>>
>>>      drivers/clk/clk.c: In function '__clk_set_parent':
>>>      drivers/clk/clk.c:1083:5: warning: 'i' may be used uninitialized in this function [-Wuninitialized]
>>>
>>> which has been introduced with commit:
>>
>> hmm, are you sure about that? The below commit neither introduces the
>> variable 'i', nor seem to change the way the variable is used in the
>> function.
> It does. The following hunk:
>
> -       for (i = 0; i<  clk->num_parents; i++)
> -               if (clk->parents[i] == parent)
> -                       break;
> +       if (clk->parents)
> +               for (i = 0; i<  clk->num_parents; i++)
> +                       if (clk->parents[i] == parent)
> +                               break;
> +       else
> +               clk->parents = kzalloc((sizeof(struct clk*) * clk->num_parents),
> +                                                               GFP_KERNEL);
>
> results in i being uninitialized if clk->parents is NULL. But I wonder

ok, got it.

> if for this case i should be set to clk->num_parents instead of 0?

yes, that seems like the right thing to do.

>
> Best regards
> Uwe
>
