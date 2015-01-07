From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 07 Jan 2015 15:30:55 +0100
Subject: [PATCH 3/3] clk: berlin: bg2q: remove non-exist "smemc" gate clock
In-Reply-To: <20150107222209.64ed24a0@xhacker>
References: <1420016272-6789-1-git-send-email-jszhang@marvell.com>
 <1420016272-6789-4-git-send-email-jszhang@marvell.com>
 <54AD3EAE.6090009@gmail.com> <20150107222209.64ed24a0@xhacker>
Message-ID: <54AD431F.6060403@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07.01.2015 15:22, Jisheng Zhang wrote:
> Dear Sebastian,
>
> On Wed, 7 Jan 2015 06:11:58 -0800
> Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:
>
>> On 31.12.2014 09:57, Jisheng Zhang wrote:
>>> The "smemc" clock is removed on BG2Q SoCs. In fact, bit19 of clkenable
>>> register is for nfc. Current code use bit19 for non-exist "smemc"
>>> incorrectly, this prevents eMMC from working due to the sdhci's
>>> "core" clk is still gated.
>>>
>>> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
>>> Cc: stable at vger.kernel.org # 3.16+
>>> ---
>>>    drivers/clk/berlin/bg2q.c | 1 -
>>>    1 file changed, 1 deletion(-)
>>>
>>> diff --git a/drivers/clk/berlin/bg2q.c b/drivers/clk/berlin/bg2q.c
>>> index 21784e4..440ef81 100644
>>> --- a/drivers/clk/berlin/bg2q.c
>>> +++ b/drivers/clk/berlin/bg2q.c
>>> @@ -285,7 +285,6 @@ static const struct berlin2_gate_data bg2q_gates[]
>>> __initconst = { { "pbridge",	"perif",	15,
>>> CLK_IGNORE_UNUSED }, { "sdio",	"perif",	16,
>>> CLK_IGNORE_UNUSED }, { "nfc",	"perif",	18 },
>
> The nfc here is really confusing, we call it as nfccore internally. Is it better
> to rename it as nfccore?

I guess it comes from some early Marvell BSP code, if there is no
issues with the name, e.g. something already depends on "nfc", feel
free to rename it to something more meaningful.

>>> -	{ "smemc",	"perif",	19 },
>>
>> Jisheng,
>>
>> if bit 19 is for nfc, how does that work out with bit 18 which is
>> still assigned to nfc? Can you re-evaluate clkenable registers for
>
> bit 19 is for nfcEcc, the "io" clock; bit 18 is for nfcCore, the "core" clock.

Ok, then both bits should be dealt with accordingly, i.e. rename
"smemc" to "nfcecc" and use it in the corresponding dts node.

If this clk_gate just disables a clock that is fed into another
gateable clock module, I can live with removing it - although I
still think it is best to leave the clk_gate in place and pick
another name that does not collide with any other clock name.

>> BG2Q and fix it up accordingly? I'd suggest to still disable as many
>
> I'll recheck the clk driver for BG2Q.

Ok, thanks a lot!

Sebastian
