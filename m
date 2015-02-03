From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 03 Feb 2015 17:53:48 +0100
Subject: [alsa-devel] [RFC PATCH] ASoC: wm8731: let codec to manage clock
 by itself
In-Reply-To: <20150203124441.GK21293@sirena.org.uk>
References: <1422934415-24957-1-git-send-email-voice.shen@atmel.com>
 <CAOLZvyE6W8-X2_M+-KQNry2VPwLzwbBLuxr5Z5EdBQo7Skv2RQ@mail.gmail.com>
 <20150203124441.GK21293@sirena.org.uk>
Message-ID: <54D0FD1C.9020305@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/03/2015 01:44 PM, Mark Brown wrote:
> On Tue, Feb 03, 2015 at 08:54:57AM +0100, Manuel Lauss wrote:
>
>> +    wm8731->mclk = devm_clk_get(&spi->dev, "mclk");
>> +    if (IS_ERR(wm8731->mclk)) {
>> +        wm8731->mclk = NULL;
>> +        dev_warn(&spi->dev, "assuming static MCLK\n");
>> +    }
>
> This is broken for both deferred probe and in the case where the clock
> API genuinely returns a NULL clock.  Other than that it's the kind of
> thing that we've done for some other drivers, though it's not good to
> have to do this.  Check them for correct behaviour.

Ideally we'd introduce a {devm_}clk_get_optional(), with the same semantics 
as gpiod_get_optional(), which handles the finer details of differentiating 
between clock specified, but not yet probed, clock specified, but 
incorrectly and no clock specified, so this doesn't have to be done over and 
over by each driver.
