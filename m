From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 22 Feb 2012 10:00:03 +0530
Subject: [PATCH] arm/spear600: fix one-shot timer
In-Reply-To: <1329862755-7439-1-git-send-email-gilles.chanteperdrix@xenomai.org>
References: <1329862755-7439-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Message-ID: <4F446F4B.3030008@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/22/2012 3:49 AM, Gilles Chanteperdrix wrote:
> diff --git a/arch/arm/plat-spear/time.c b/arch/arm/plat-spear/time.c
> index 0c77e42..ac15ff3 100644
> --- a/arch/arm/plat-spear/time.c
> +++ b/arch/arm/plat-spear/time.c
> @@ -147,9 +147,12 @@ static int clockevent_next_event(unsigned long cycles,
>  {
>  	u16 val;
>  
> +	val = readw(gpt_base + CR(CLKEVT));

can merge above three lines now.

> +	if ((val & CTRL_ENABLE))

no need of extra (). Did you run checkpatch? I believe checkpatch
reports such issues.

> +		writew(val & ~CTRL_ENABLE, gpt_base + CR(CLKEVT));
> +
>  	writew(cycles, gpt_base + LOAD(CLKEVT));
>  
> -	val = readw(gpt_base + CR(CLKEVT));
>  	val |= CTRL_ENABLE | CTRL_INT_ENABLE;
>  	writew(val, gpt_base + CR(CLKEVT));

Otherwise,

Acked-by: Viresh Kumar <viresh.kumar@st.com>

-- 
viresh
