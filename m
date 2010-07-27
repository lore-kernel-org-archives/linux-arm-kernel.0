From: viresh.kumar@st.com (Viresh KUMAR)
Date: Tue, 27 Jul 2010 10:20:44 +0530
Subject: [PATCH] Watchdog: Adding support for ARM Primecell SP805 Watchdog
In-Reply-To: <4C43DD7E.5050800@st.com>
References: <1274344428-28329-1-git-send-email-viresh.kumar@st.com>
	<AANLkTik1vSgASNLXSpYD2MVgmQGgvCx-5mFY_3YFsuHL@mail.gmail.com>
	<4C43DD7E.5050800@st.com>
Message-ID: <4C4E65A4.7030005@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/19/2010 10:37 AM, vireshk wrote:
>>> +/* This routine finds load value that will reset system in required timout */
>>> >> +static void wdt_setload(unsigned int timeout)
>>> >> +{
>>> >> +       u64 load, rate;
>>> >> +
>>> >> +       rate = clk_get_rate(wdt->clk);
>>> >> +
>>> >> +       /*
>>> >> +        * sp805 runs counter with given value twice, after the end of first
>>> >> +        * counter it gives an interrupt and then starts counter again. If
>>> >> +        * interrupt already occured then it resets the system. This is why
>>> >> +        * load is half of what should be required.
>>> >> +        */
>>> >> +       load = div_u64(rate, 2) * timeout - 1;
>>> >> +
>>> >> +       load = (load > LOAD_MAX) ? LOAD_MAX : load;
>>> >> +       load = (load < LOAD_MIN) ? LOAD_MIN : load;
>>> >> +
>>> >> +       spin_lock(&wdt->lock);
>>> >> +       wdt->load_val = load;
>>> >> +       /* roundup timeout to closest positive integer value */
>>> >> +       wdt->timeout = div_u64((load + 1) * 2 + (rate / 2), rate);
>> > 
>> > Look in linux/kernel.h, use the
>> > DIV_ROUND_CLOSEST() macro instead of this.
> OK.
> 

Linus,

Now i remember why i didn't choose DIV_ROUND_CLOSEST in V1 of this patch.
As it is a u64 division, i get following compilation error if i use
DIV_ROUND_CLOSEST. I wasn't sure if inclusion of some header file can remove
this error, and so i used div_u64.

error:
"undefined reference to '__aeabi_uldivmod'"

Do you have some other solution to fix this error??

viresh.
