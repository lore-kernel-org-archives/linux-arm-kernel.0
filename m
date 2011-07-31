From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 31 Jul 2011 02:19:11 +0200
Subject: [PATCH 09/18] dmaengine/amba-pl08x: Schedule tasklet in case of
	error interrupt
In-Reply-To: <9c81beb9cd84f84b58abbd24ebfae85dfe8d8ee1.1311936524.git.viresh.kumar@st.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<9c81beb9cd84f84b58abbd24ebfae85dfe8d8ee1.1311936524.git.viresh.kumar@st.com>
Message-ID: <CAKnu2Mp0Xs3ivj0Vd1=Euj1CyKsWpBLrf_L_jYWuOnoRMpxGGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/29 Viresh Kumar <viresh.kumar@st.com>:

(...)
> - ? ? ? u32 mask = 0;
(...)
> + ? ? ? if (!err && !tc)
> + ? ? ? ? ? ? ? return IRQ_NONE;
(...)
> -
> - ? ? ? ? ? ? ? ? ? ? ? mask |= (1 << i);
> - ? ? ? /* Clear only the terminal interrupts on channels we processed */
> - ? ? ? writel(mask, pl08x->base + PL080_TC_CLEAR);
>
> - ? ? ? return mask ? IRQ_HANDLED : IRQ_NONE;
> + ? ? ? return IRQ_HANDLED;

NAK.

These snippets illustrate what is not good about this patch, you're making
the driver fragile by removing checks for spurious IRQ.

So for example if there is an error or TC IRQ on a channel that is not
in use, what happens now?

It used to result in IRQ_NONE, now all of a sudden we start handling
spurious IRQs and claim IRQ_HANDLED with totally unpredictable
results, whereas they would previously gather error metrics for
spurious IRQs.

Yours,
Linus Walleij
