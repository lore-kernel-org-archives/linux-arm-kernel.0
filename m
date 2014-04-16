From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 16 Apr 2014 10:20:09 -0600
Subject: [PATCH] ARM: tegra: make Venice's +3.3V_RUN regulator always
 on
In-Reply-To: <CAL1qeaGek9H74s00T-O7P7F6Uraa9juW=3LCMjTUjCuQCZ0pBw@mail.gmail.com>
References: <1397600984-25198-1-git-send-email-swarren@wwwdotorg.org>
 <CAL1qeaGek9H74s00T-O7P7F6Uraa9juW=3LCMjTUjCuQCZ0pBw@mail.gmail.com>
Message-ID: <534EADB9.1010605@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2014 06:54 PM, Andrew Bresticker wrote:
> On Tue, Apr 15, 2014 at 3:29 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> This regulator supplies power to pretty much everything on the board, so
>> it doesn't make sense to allow it to turn off. Mark it boot-on and
>> always-on so it doesn't get turned off. Without this, I see issues with
>> the eMMC device; it can't be correctly detected during boot.
> 
> This actually isn't a complete fix.  +3V3_RUN will still toggle on a
> cold boot because the GPIO1_INVERT bit is initialized by the PMIC to
> 1, but when the regulator core requests the GPIO as an output,
> as3722_gpio_direction_output() first sets the output value to 1
> (without considering the INVERT bit!) and then clears the invert bit
> when setting the mode in as3722_pinctrl_gpio_set_direction().  The
> as3722 driver should probably not touch the INVERT bit and instead
> just take it into account when setting the GPIO value.

I'll take that as a heads-up on the existence of the AS3722 GPIO patch,
rather than an objection to this patch.
