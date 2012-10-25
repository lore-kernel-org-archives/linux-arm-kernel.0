From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 25 Oct 2012 11:04:34 +0200
Subject: [PATCH 3/5] pinctrl: dove: fix iomem and pdma clock
In-Reply-To: <CACRpkdYQ+kk1jJ-GfOBd_5pahu-KOTL4GA3_zWP85E6v+h51pA@mail.gmail.com>
References: <1351088724-11142-1-git-send-email-andrew@lunn.ch>
 <1351088724-11142-4-git-send-email-andrew@lunn.ch>
 <CACRpkdYQ+kk1jJ-GfOBd_5pahu-KOTL4GA3_zWP85E6v+h51pA@mail.gmail.com>
Message-ID: <508900A2.20005@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2012 09:04 AM, Linus Walleij wrote:
> On Wed, Oct 24, 2012 at 4:25 PM, Andrew Lunn<andrew@lunn.ch>  wrote:
>
>> Since 3.7 readl/writel require register addresses to be const void*
>> instead of unsigned int. The register addresses are converted using
>> IOMEM() and offsets are added instead of OR'ed.
>> Also a workaround for the pdma clock is added, that is required as
>> there is still no DT clock provider available on Dove.
>
> So essentially two unrelated patches squashed into one, and I
> would apply the first one right off but now the clock change makes
> me hesitate.
>
>>          clk = devm_clk_get(&pdev->dev, NULL);
>> +
>> +       /* Currently there is no DT clock provider for pdma clock,
>> +          this fallback ensures pdma clock is ticking */
>
> /*
>   * I prefer comment style like so because it's easier to read.
>   * Maybe it's a bit pedantic but bear with me.
>   */
>
>> +       if (IS_ERR(clk))
>> +               clk = clk_get_sys("dove-pdma", NULL);
>> +
>
> This is a horrible hack. But if the Marvell people agree about
> it I will live with it.

Unfortunately, it is. This is an chicken-egg-problem here, no
DT clk-provider, no clocks properties..

While writing pinctrl-dove I was planing to enable it after
the clock provider but with Andrew pushing forward - for a good
reason - there comes the trouble ;)

I don't like the hack either but the clk-gate is there and
if I don't enable it pinctrl-dove will hang the SoC.

I have a clk-dove DT clk-provider in my pocket somewhere but
didn't find the time to prepare it for posting..

Sebastian
