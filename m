From: hsnaves@gmail.com (Humberto Naves)
Date: Thu, 31 Jul 2014 23:19:48 +0200
Subject: [PATCHv2 5/5] clk: samsung: exynos5410: Added clocks DPLL, EPLL,
 IPLL, and VPLL
In-Reply-To: <53DA5E7E.9010607@gmail.com>
References: <1406805732-17372-1-git-send-email-hsnaves@gmail.com>
 <1406805732-17372-6-git-send-email-hsnaves@gmail.com>
 <53DA3F86.3020506@gmail.com>
 <CAEe5pB9Rj9rdzk-fjyNcdWyhQCfLtwxt+nAZdb4xuKDO9OpzUA@mail.gmail.com>
 <53DA5E7E.9010607@gmail.com>
Message-ID: <CAEe5pB9=0VWd+d2KAcHD=YZSqFQo_3hRfV9M2mzvq2mziZXMUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 31, 2014 at 5:19 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>
> I'm not sure I get the idea of the field you're suggesting. If I
> understand correctly, your intention would be to provide a default
> frequency if there is no table provided. I don't think there is a need
> for it, because current code can read back current settings from
> registers and calculate current rate.
>
I think I was not clear enough. I am not trying to provide a default
frequency for the clock, but I do want to specify the base frequency
on which the rate table was based upon. Let me give you an example
that will hopefully clarify the matter. Suppose I want to register my
PLL, such as in the 5410. The *current* solution would be like this:

static struct samsung_pll_rate_table ipll_24mhz_tbl[] __initdata = {
       /* PLL_35XX_RATE(rate, m, p, s, k) */
       PLL_35XX_RATE(864000000, 288, 4, 1),
       { },
};
static struct samsung_pll_clock exynos5410_plls[nr_plls] __initdata = {
       [ipll] = PLL(pll_35xx, CLK_FOUT_IPLL, "fout_ipll", "fin_pll", IPLL_LOCK,
               IPLL_CON0, NULL),
};

And in the driver initialization function, I would add the rate table
if the input clock source matches what I expected, in this case 24Mhz:

if (_get_rate("fin_pll") == 24 * MHZ) {
         exynos5410_plls[ipll].rate_table = ipll_24mhz_tbl;
}

An alternative approach would be as follows, we add a new field (say
"base_rate") to the structure samsung_pll_clock, and to the macro PLL,
and describe the pll table in a simpler way, such as follows:

static struct samsung_pll_clock exynos5410_plls[nr_plls] __initdata = {
       [ipll] = PLL(pll_35xx, CLK_FOUT_IPLL, "fout_ipll", "fin_pll", IPLL_LOCK,
               IPLL_CON0, &ipll_24mhz_tbl, 24 * MHZ),
};

and in the _samsung_clk_register_pll function, all the validation
would be performed. Here I am talking about checking if the parent
rate is what is specified on the samsung_pll_clock structure, and if
so, to check if the rates on the rate table actually match what the
coefficients are telling.

> As for the validation itself, one more thing that needs to be considered
> is that the rate table must be sorted.

The _samsung_clk_register_pll could do that in theory.

>
> We once decided to rely on the fact that tables in SoC drivers have
> rates explicitly specified and are correctly sorted, but now I'm
> inclined to reconsider this, based on the fact that those rates often
> are already incorrectly calculated in vendor code or even datasheets,
> which are main information sources for patch authors.
>
> Before mainlining PLL drivers (which was quite some time ago), we had a
> bit different implementation in our internal tree, which did not use
> explicitly specified rates at all (they could have been considered just
> comments to improve table readability) and the _register_pll() function
> simply calculated rates for all entries creating new table for internal
> use of the PLL driver that was in addition explicitly sorted to make
> sure that the order is correct. This kind of implementation is what I
> would lean toward today.

I would strongly object to such as solution. I think that in the
table, the frequency *must* be specified. As you said previously, the
coefficients should be carefully chosen. We cannot know for sure that
the same coefficients that work for a base frequency of 24 Mhz will
also work for a different base frequency. So the driver cannot simply
compute the frequency from the coefficients, and it must also check
that the input rate is correct. This is another reason why I want to
add the base_frequency field to that structure.

I believe that the the _samsung_clk_register_pll must double-check if
the frequencies match what the formula tells, and must drop the
entries (or the whole frequency table) that are faulty. And then
finally, it should sort the entries in descending order.

I hope I made myself clear now.
Best regards,
Humberto


>
> Best regards,
> Tomasz
