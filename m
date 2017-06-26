From: jeffy.chen@rock-chips.com (jeffy)
Date: Mon, 26 Jun 2017 11:27:32 +0800
Subject: [PATCH v2 4/4] arm64: dts: rockchip: use cs-gpios for cros_ec_spi
In-Reply-To: <CAD=FV=XjW4a9mqH0UtUAmHkj-aAO75bpSXuyy__jBB7YC8PBVg@mail.gmail.com>
References: <1497331543-8565-1-git-send-email-jeffy.chen@rock-chips.com>
 <1497331543-8565-4-git-send-email-jeffy.chen@rock-chips.com>
 <20170613175043.GC9026@google.com>
 <20170613182225.smahsf3jzvbc7w7z@sirena.org.uk>
 <20170620004739.GA67314@google.com>
 <CAD=FV=UKe5M-M=gXwdjp25vpR0CHtk1APRF0_b4PXQrGOc40+A@mail.gmail.com>
 <594C905E.1040208@rock-chips.com>
 <CAD=FV=VWjbGpY4nj2L0_6xaYY2_tp0pJ5q=BgppL9GWefBUGog@mail.gmail.com>
 <594D0723.7010108@rock-chips.com>
 <CAD=FV=XjW4a9mqH0UtUAmHkj-aAO75bpSXuyy__jBB7YC8PBVg@mail.gmail.com>
Message-ID: <59507F24.4000309@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

On 06/24/2017 12:14 AM, Doug Anderson wrote:
> Jeffy
>
> On Fri, Jun 23, 2017 at 5:18 AM, jeffy <jeffy.chen@rock-chips.com> wrote:
>>>>> So how do we fix this?  IMHO:
>>>>>
>>>>> Add 4 new pinctrl states in rk3399.dtsi:
>>>>>
>>>>>      cs_low_clk_low, cs_low_clk_high, cs_high_clk_low, cs_high_clk_high
>>>>>
>>>>> These would each look something like this:
>>>>>
>>>>> spi5_cs_low_data_low: spi5-cs-low-data-low {
>>>>>      rockchip,pins = <2 22 RK_FUNC_0 &pcfg_output_low>,
>>>>>        <2 23 RK_FUNC_0 &pcfg_output_low>;
>>>>> };
>>>>>
>>>>> Where "pcfg_output_low" would be moved from the existing location in
>>>>> "rk3399-gru.dtsi" to the main "rk3399.dtsi" file.
>>>>>
>>>>>
>>>>> ...now, you'd define runtime_suspend and runtime_resume functions
>>>>> where you'd look at the current state of the chip select and output
>>>>> and select one of these 4 pinmuxes so that things _don't_ change.
>>
>
> *** NOTE *** The more I look at this, the more I'm getting convinced
> that the right thing to do is to just disable Runtime PM while the
> chip select is asserted.  ...so probably you can just skip the next
> chunk of text and go straight to "PROPOSAL".
ok
>
>> it looks like the clk would be low when spi idle, so do we only need
>> *_clk_low?
>
> You're only looking at one polarity.  From Wikipedia
> <https://en.wikipedia.org/wiki/Serial_Peripheral_Interface_Bus>, the
> source of all that is "true":
>
> * At CPOL=0 the base value of the clock is zero, i.e. the idle state
> is 0 and active state is 1.
> -> For CPHA=0, data are captured and output on the clock's rising edge
> (low?high transition)
> -> For CPHA=1, data are captured and output on the clock's falling edge.
>
> * At CPOL=1 the base value of the clock is one (inversion of CPOL=0),
> i.e. the idle state is 1 and active state is 0.
> -> For CPHA=0, data are captured and output on clock's falling edge.
> -> For CPHA=1, data are captured and output on clock's rising edge.
>
> If you're adding code to the generic Rockchip SPI driver you need to
> handle both polarities.
>
>
>> and the rockchip spi supports 2 cs, so should we use cs0_low_cs1_low_clk_low
>> or should we put these pinmux into sub spi device?
>
> By default the pinctrl for rk3399.dtsi just sets up cs0, so I'd worry
> about that.  If someone wants to make cs1 work then they'd have to
> specify the right pinctrl there.
>
>
>>> * You'd want to add the pinmux configs to the main rk3399.dtsi file
>>> and then add code to the rockchip SPI driver to select the right
>>> pinmux (depending on the current state of the chip select and the
>>> current polarity) at runtime suspend.  ...then go back to "default"
>>> mode at runtime resume.
>>
>> i uploaded 2 testonly CLs:
>> remote:   https://chromium-review.googlesource.com/544391 TESTONLY: spi:
>> rockchip: use pinmux to config cs
>> remote:   https://chromium-review.googlesource.com/544392 TESTONLY: dts:
>> bob: only enable ec spi
>>
>> but they are not working well, not sure why, maybe cs still toggled will
>> switching pinmux? will use scope to check it next week.
>
> Yeah, scope is probably the right thing to do.  One thing you'd have
> to make sure is that everything is being done glitch free.  In other
> words, if this is happening:
>
> A) Pinmux to GPIO
> B) Set GPIO to output
> C) Drive GPIO state low
>
> Then that's bad because:
>
> After step A but before step B, you might still be an input and pulls
> might take effect.  Thus you could glitch the line.
>
> After step B but before step C, you might be outputting something else
> if the GPIO had previously been configured to output high.
>
>
> You need to make sure that the sequence is instead:
>
> A) Drive GPIO state high
> B) Set GPIO to output
> C) Pinmux to GPIO
>
>
> Ensuring things are glitch free and dealing with two chip selects
> means it might be cleaner would be to do all the GPIO stuff yourself
> in the driver.  Then you'd have to specify the GPIOs in the device
> tree.
>
> ======
>
> OK, I took a look at your CL and I'm now of the opinion that we should
> disable Runtime PM when the chip select is asserted.  Maybe just
> ignore the above and instead look at:
>
>
> PROPOSAL: Disable Runtime PM when chip select is asserted
>
> I think this proposal will be very easy and is pretty clean.
> Basically go into "rockchip_spi_set_cs()" and adjust the
> "pm_runtime_get_sync()" and "pm_runtime_put_sync()" calls.  Only call
> the "get_sync" at the top of the function if you're asserting the chip
> select (and it wasn't already asserted).  Only call the "put_sync" at
> the bottom of the function if you're deasserting the chip select (and
> it wasn't already deasserted).
hmm, looks like a better way to solve this, but i think we need to call 
pm_runtime_get_sync unconditionally to make sure the read ser register safe.
>
> This should avoid entering PM sleep any time a transaction is midway
> through happening.
>
> Secondly, make sure that the chip selects have a pullup on them (they
> already do).  When you Runtime PM then the SPI part will stop driving
> the pins and the pull will take effect.  Since we can only Runtime PM
> when the chip select is deasserted then this pull will always be
> correct.  Also: since we Runtime PM when the chip select is deasserted
> then the state of the other pins isn't terribly important (though to
> avoid leakage it's probably good to choose a sane pull).
>
>
> How does that sound?  It should only be a few lines of code and only one patch.
>
sounds good, new patch sent(https://patchwork.kernel.org/patch/9808601)
>
> -Doug
>
>
>
