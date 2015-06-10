From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 11 Jun 2015 00:30:41 +0800
Subject: [PATCH 1/2 V3] clk: sirf: add CSR atlas7 clk and reset support
In-Reply-To: <20150521213324.GA1885@codeaurora.org>
References: <1431675587-8637-1-git-send-email-21cnbao@gmail.com>
 <20150515183029.GL31753@codeaurora.org>
 <CAGsJ_4zwNQvvSwb49nwKzfke1V1nUCW-tDqbP4FxEr0SfmX9zA@mail.gmail.com>
 <20150521213324.GA1885@codeaurora.org>
Message-ID: <CAGsJ_4xUk1kDnLDrRnipN+Kpm6oOe8C-4DfhdshVUmv+PKjgig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-22 5:33 GMT+08:00 Stephen Boyd <sboyd@codeaurora.org>:
> On 05/16, Barry Song wrote:
>> 2015-05-16 2:30 GMT+08:00 Stephen Boyd <sboyd@codeaurora.org>:
>> > On 05/15, Barry Song wrote:
>> >> From: Zhiwu Song <Zhiwu.Song@csr.com>
>> >>
>> >> the hardware node includes both clock and reset support, so it
>> >> is named as "car".
>> >> this patch implements Flexible clocks(mux, divider, gate), Selectable
>> >> clock(mux, divider, gate), root clock(gate),leaf clock(gate), others.
>> >> it also implements the reset controller functionality.
>> >>
>> >> Signed-off-by: Zhiwu Song <Zhiwu.Song@csr.com>
>> >> Signed-off-by: Guo Zeng <Guo.Zeng@csr.com>
>> >> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> >> ---
>> >
>
> Yes this has already been applied, but replying to the last
> comment.
>
>> >> +
>> >> +
>> >> +CLK_OF_DECLARE(atlas7_clk, "sirf,atlas7-car", atlas7_clk_init);
>> >>
>> >
>> > I'm also curious if we actually need to use CLK_OF_DECLARE here
>> > or if could we use a platform device.
>> >
>> > Even if we need to use CLK_OF_DECLARE because some timer or other
>> > early device needs a clock, I wonder if we shouldn't also make
>> > these things into real platform drivers that register the other
>> > clocks that aren't necessary for the early boot process.
>> >
>> it seems it is a general question not only for this driver?
>
> Yes it is.
>
>>
>> the main difficulty is maintaining the boot sequence of the platform
>> devices and other machine codes which require clocks. it seems it is
>> the easiest way to make clk ready earlier than other drivers.
>> and i don't think registering these clocks takes much boot time and
>> make boot slower at least for atlas7 platform since there is no sleep
>> and long delay in the procedure.
>
> It isn't really about making boot time faster, it's about using
> the proper linux device model for clock providers. That way when
> we want to support things like suspend/resume, deferred probe,
> devm_*(), sysfs, etc. we can use the device model instead of
> resorting to things like syscore_ops for suspend/resume or
> forgoing features entirely.
>

my feeling is if the clock controller is an internal controller which
serve all controllers in the SoC, "deferred probe" might be yes for
almost all HW since all HW need clock. so it seems it makes "deferred
probe" has no meaning. clock controller seems to be 1st HW which needs
to be ready.

but if the clock controller is an external controller, it might be
exactly a platform driver, or other bus-based drivers.


> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project

-barry
