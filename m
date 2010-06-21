From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Mon, 21 Jun 2010 19:34:59 +0200
Subject: [PATCH V2] GPIO PL061: Adding Clk framework support
In-Reply-To: <20100621154121.GA4290@debian>
References: <1277103463-7311-1-git-send-email-viresh.kumar@st.com>
	<20100621154121.GA4290@debian>
Message-ID: <AANLkTim0x5_4re3CWzWDRr1QMq46sQa1SCSyAiymmiUW@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/6/21 Rabin Vincent <rabin@rab.in>:
> On Mon, Jun 21, 2010 at 12:27:43PM +0530, Viresh KUMAR wrote:
>> GPIO Clk is never enabled on Platforms, like: SPEAr, which are based upon clock
>> framework and use PL061 driver. This patch adds support for Clk enabling and
>> disabling as and when gpios are requested and freed.
> [...]
>> + ? ? chip->clk = clk_get(&dev->dev, NULL);
>> + ? ? if (IS_ERR(chip->clk)) {
>> + ? ? ? ? ? ? ret = PTR_ERR(chip->clk);
>> + ? ? ? ? ? ? goto iounmap;
>> + ? ? }
>
> Have you verified that all platforms using this driver already have
> clocks with the appropriate names? ? Otherwise this patch will break
> those platforms.

The ARM Versatiles and RealViews are always clocked I think,
so clock support should be optional.

When I added a clock lookup to the PL08x block recently I used
a construct like this for an optional clock:

chip->clk = clk_get(&dev->dev, NULL);
if (IS_ERR(chip->clk)) {
       ret = PTR_ERR(chip->clk);
       if (ret == -ENOENT)
          /* No block clock in this platform */
          chip->clk = NULL;
       else
          goto iounmap;
}

This will work whenever clkdevice is used, since that
returns -ENOENT for nonexisting entries.

Then:

if (chip->clk)
  clk_enable(chip->clk);

etc

Yours,
Linus Walleij
