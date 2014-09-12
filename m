From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 12 Sep 2014 09:42:29 +0200
Subject: [PATCH] clk: don't use __initconst for non-const arrays
In-Reply-To: <20140911220445.GQ3755@pengutronix.de>
References: <1410469471-31027-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140911220445.GQ3755@pengutronix.de>
Message-ID: <CAKv+Gu9LubyPHoYJsRfRoqgONAApb3nEoXAxUa9g6tecP=McOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 September 2014 00:04, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hello,
>
> On Thu, Sep 11, 2014 at 11:04:31PM +0200, Uwe Kleine-K?nig wrote:
>>  /* Mux parent lists. */
>> -static const char *fin_pll_p[] __initconst = {
>> +static const char *fin_pll_p[] __initdata = {
>>       "xxti",
>>       "xusbxti"
>>  };
> As discussed with Tomasz on irc: The sad thing here is that for this
> array only 8 bytes are freed when .init.rodata is thrown away (that is
> two pointers). The actual data---5 + 8 bytes + maybe aligning---isn't
> freed though.
>
> We wondered if there is a nice and easy way to throw away the
> characters, too.
>
> The only way I currently see is:
>
>         const char xxti[] __initconst = "xxti";
>         ...
>
>         static const char *fin_pll_p[] __initdata = {
>                 xxti,
>                 ...
>         };
>
> but this definitively doesn't qualify as "nice and easy". Is there an
> alternative?
>

What about doing

static const char fin_pll_p[][8] __initconst = {
     "xxti",
     "xusbxti"
};
