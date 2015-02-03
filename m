From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 03 Feb 2015 18:49:02 +0100
Subject: [alsa-devel] [RFC PATCH] ASoC: wm8731: let codec to manage clock
 by itself
In-Reply-To: <54D104AC.5010603@metafoo.de>
References: <1422934415-24957-1-git-send-email-voice.shen@atmel.com>
 <CAOLZvyE6W8-X2_M+-KQNry2VPwLzwbBLuxr5Z5EdBQo7Skv2RQ@mail.gmail.com>
 <20150203124441.GK21293@sirena.org.uk> <54D0FD1C.9020305@metafoo.de>
 <20150203171733.GY8656@n2100.arm.linux.org.uk> <54D104AC.5010603@metafoo.de>
Message-ID: <54D10A0E.5050907@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/03/2015 06:26 PM, Lars-Peter Clausen wrote:
> On 02/03/2015 06:17 PM, Russell King - ARM Linux wrote:
>> On Tue, Feb 03, 2015 at 05:53:48PM +0100, Lars-Peter Clausen wrote:
>>> On 02/03/2015 01:44 PM, Mark Brown wrote:
>>>> On Tue, Feb 03, 2015 at 08:54:57AM +0100, Manuel Lauss wrote:
>>>>
>>>>> +    wm8731->mclk = devm_clk_get(&spi->dev, "mclk");
>>>>> +    if (IS_ERR(wm8731->mclk)) {
>>>>> +        wm8731->mclk = NULL;
>>>>> +        dev_warn(&spi->dev, "assuming static MCLK\n");
>>>>> +    }
>>>>
>>>> This is broken for both deferred probe and in the case where the clock
>>>> API genuinely returns a NULL clock.  Other than that it's the kind of
>>>> thing that we've done for some other drivers, though it's not good to
>>>> have to do this.  Check them for correct behaviour.
>>>
>>> Ideally we'd introduce a {devm_}clk_get_optional(), with the same semantics
>>> as gpiod_get_optional(), which handles the finer details of differentiating
>>> between clock specified, but not yet probed, clock specified, but
>>> incorrectly and no clock specified, so this doesn't have to be done over and
>>> over by each driver.
>>
>> No, we don't need to.  It clk_get() already knows this distinction, and
>> it appropriately returns -ENOENT vs -EPROBE_DEFER according to whether
>> there's a clock specified in DT or not.
>
> I know, but it returns a error when no clock is specified (-ENOENT), whereas
> gpiod_get_optional()-like semantics mean, it would return no error.

What I wanted to say is that pretty much every user of clk_get() that wants 
a optional clock gets the handling wrong. E.g. they check for PTR_ERR(clk) 
== -EPROBE_DEFER rather than checking for PTR_ERR(clk) != -ENOENT. Which 
causes errors when the clock is specified, but incorrectly specified (e.g. 
invalid phandle or specifier) to be silently ignored.

My hope is that having a explicit API for requesting a optional clock might 
make it easier for users to gets things right.

If you have coccinelle you can use the following script to find good and bad 
users:

@@
expression clk;
@@
clk =
(
devm_clk_get
|
clk_get
)
  (...);
<+...
(
*PTR_ERR(clk) == -EPROBE_DEFER
|
*PTR_ERR(clk) != -ENOENT
)
...+>
