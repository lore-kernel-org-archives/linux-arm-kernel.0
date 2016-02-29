From: eric@anholt.net (Eric Anholt)
Date: Mon, 29 Feb 2016 15:44:16 -0800
Subject: [PATCH 5/6] clk: bcm2835: correctly enable fractional clock
 support
In-Reply-To: <0ED2FB7F-B112-487B-B222-08E5FAEE27F9@martin.sperl.org>
References: <1456745963-2403-1-git-send-email-kernel@martin.sperl.org>
 <1456745963-2403-6-git-send-email-kernel@martin.sperl.org>
 <87mvqj5k9r.fsf@eliezer.anholt.net>
 <0ED2FB7F-B112-487B-B222-08E5FAEE27F9@martin.sperl.org>
Message-ID: <87lh63jd4f.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Sperl <kernel@martin.sperl.org> writes:

>> On 29.02.2016, at 21:33, Eric Anholt <eric@anholt.net> wrote:
>> 
>> kernel at martin.sperl.org writes:
>> 
>>> From: Martin Sperl <kernel@martin.sperl.org>
>>> 
>>> The current driver calculates the clock divider with
>>> fractional support enabled.
>>> 
>>> But it does not enable fractional support in the
>>> control register itself resulting in an integer only divider,
>>> but in clk_set_rate responds back the fractionally divided
>>> clock frequency.
>>> 
>>> This patch enables fractional support in the control register
>>> whenever there is a fractional bit set in the requested clock divider.
>>> 
>>> Mash clock limits are are also handled for the PWM clock
>>> applying the correct divider limits (2 and max_int) applicable to
>>> basic fractional divider support (mash order of 1).
>>> 
>>> It also adds locking to protect the read/modify/write cycle of
>>> the register modification.
>>> 
>>> Fixes: 41691b8862e2 ("clk: bcm2835: Add support for programming the
>>> audio domain clocks")
>>> 
>>> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
>> 
>> Rewrite of the commit message:
>> 
>> The driver has been using fractional dividers for all clocks with
>> fractional bits.  However, MASH clocks (those used to drive audio) only
>> do fractional division when in MASH mode, which is used to push clock
>> jitter out of the audio band.  The PWM clock (used to drive i2s audio)
>> is the only MASH clock currently enabled in the driver.
>> 
>> Additional MASH modes are available that widen the frequency range, but
>> only 1-level MASH is used for now, until we characterize some better
>> policy.
>> 
>> Fixes: 41691b8862e2 ("clk: bcm2835: Add support for programming the
>> audio domain clocks?)
>
> That is not 100% true - non mash modes have CM_FRAC and CM_FRAC = CM_MASH0
> so these map each other

Once again, trusting the docs turns out to be a bad idea.  You're right,
the non-MASH clocks *do* have a bit 9 to enable fractional mode.  Sigh.

So, this patch is:

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160229/9a4365e6/attachment.sig>
