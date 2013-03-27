From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 27 Mar 2013 15:25:24 +0530
Subject: [PATCH v4] clk: allow reentrant calls into the clk framework
In-Reply-To: <alpine.LFD.2.02.1303270941320.22263@ionos>
References: <1364368183-24420-1-git-send-email-mturquette@linaro.org>
 <alpine.LFD.2.02.1303270941320.22263@ionos>
Message-ID: <CAKohpomWZ_9a_RceQ419QAAXOR17yrtrRP0Gf4xoS3B=yzbRXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 March 2013 15:10, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, 27 Mar 2013, Mike Turquette wrote:
>
>> Reentrancy into the clock framework from the clk.h api is necessary
>> for clocks that are prepared and unprepared via i2c_transfer (which
>> includes many PMICs and discrete audio chips) as well as for several
>> other use cases.
>
> That explanation sucks.
>
> Why does an i2c clock need reentrancy? Just because it's i2c or what?

I am noway connected to this development but was just going through
your mail and i think i might know the answer why is this required.

Consider an example where an external chip has clock controller and has
bits which can be programmed to enable/disable clock. And this chip is
connected via spi/i2c to SoC.

clk_prepare(peripheral on external chip)
  -> i2c_xfer(to write to external chips register)
      -> clk_enable(i2c controller)
          ->controller-xfer-routine.. and finally we enable clk here...


Sorry if i am on the wrong side :)

--
viresh
