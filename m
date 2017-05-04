From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 4 May 2017 11:08:43 +0800
Subject: [PATCH v2 3/8] clk: sunxi-ng: Add class of phase clocks
 supporting MMC new timing modes
In-Reply-To: <20170503203402.5mwhx5wjniav24nd@lukather>
References: <20170503031658.29299-1-wens@csie.org>
 <20170503031658.29299-4-wens@csie.org>
 <20170503203402.5mwhx5wjniav24nd@lukather>
Message-ID: <CAGb2v67VhJCZuu4EGHgTATe=z6ab9meRSWpGYU-cCjWmDh6aUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, May 4, 2017 at 4:34 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Wed, May 03, 2017 at 11:16:53AM +0800, Chen-Yu Tsai wrote:
>> The MMC clocks on newer SoCs, such as the A83T and H3, support the
>> "new timing mode". Under this mode, the output of the clock is divided
>> by 2, and the clock delays no longer apply.
>>
>> Due to how the clock tree is modeled and setup, we need to model
>> this function in two places, the master mmc clock and the two
>> child phase clocks. In the mmc clock, we can easily model the
>> mode bit as an extra variable post-divider. In the phase clocks,
>> we check the bit and return -ENOTSUPP if the bit is set, signaling
>> that the phase clocks are not to be used.
>>
>> This patch introduces a class of phase clocks that checks the
>> timing mode bit.
>
> We've been over this quite some times already...
>
> How do you retrieve the mode used in the clock so that you can also
> switch the MMC driver in the new mode?

This part is covered. As mentioned above, the phase clks will return
-ENOTSUPP if the mmc clk is set in the new timing mode. The MMC driver
would try getting the current phase, check if it fails, and if it does,
realizes the clk is in new timing mode, and will switch the mmc controller
to it as well. I think this semantic fits the hardware well enough,
though it might be confusing without the accompanying comments.

See this commit for an example on how it should work.
https://github.com/wens/linux/commit/41e386f1f945a0a135a20a00601b977a001353da

> And do you prevent that from happening on the DT we already have that
> use the old clock drivers that do not support this new timing at all?

I admit this is not taken care of in this patch. Mostly because there
is no existing DT for the A83T to cater to. For the H3 and other SoCs
that do, we need some way of asking the CCU to switch the mode.

IIRC the output and sample clocks do not support a phase delay of 0.
So what if we design the semantic for this class of clocks as, if
phase == 0, switch to new timing mode, otherwise use old timing mode?
That would allow us to support this without adding extra functions,
and kind of matches what the hardware does. If you're using the new
timing mode, the delays in the mmc clk are bypassed.

Regards
ChenYu
