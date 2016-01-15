From: sonnyrao@chromium.org (Sonny Rao)
Date: Fri, 15 Jan 2016 13:48:04 -0800
Subject: [PATCH v3 3/9] ASoC: rockchip: i2s: add support for grabbing
 output clock to codec
In-Reply-To: <20160115174623.GZ6588@sirena.org.uk>
References: <1452865796-23527-1-git-send-email-wxt@rock-chips.com>
 <1452865796-23527-4-git-send-email-wxt@rock-chips.com>
 <20160115174623.GZ6588@sirena.org.uk>
Message-ID: <CAPz6YkWt-iXS6P4QBBoq3v3i7ZAGGu6=_9AHw4qgevEwDwbdTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 15, 2016 at 9:46 AM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Jan 15, 2016 at 09:49:50PM +0800, Caesar Wang wrote:
>
>> We need to claim the clock which is driving the codec so that when we
>> enable clock gating, we continue to clock the codec when needed.
>> I make this an optional clock since there might be some applications
>> where we don't need it but can still use the I2S block.
>
>> - As the perious discuss on https://patchwork.kernel.org/patch/5427131/,
>>   I think Mark likes do it in codec driver, I have to say I agree this
>>   patch in here since that's the i2s block output. I don't know if the
>>   Mark has changed his mind.
>
> If the I2S block is providing a clock to the CODEC then that's what the
> software should do so that the CODEC can gate and ungate the clock as
> required.  This patch has the I2S block using a clock, not providing
> one.

>From my read of the clock diagram for RK3288  there is a single clock
signal (labeled "clk_i2s0") that comes out of a fractional divider,
and it is split such that one path gets sent to the I2S block and the
second path is sent to a mux after which that signal is sent to an
external pin that goes to the codec.

There are separate clock gates for the two paths: one for the I2S
block and one after that mux before the external pin.

I'm not sure if it's being modeled that way in the Linux code or not,
but at least physically I don't think this clock signal actually goes
through the I2S block before being sent to the codec.

Does that help clarify?
