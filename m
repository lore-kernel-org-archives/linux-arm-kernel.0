From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 15 Jan 2015 23:35:42 +0800
Subject: [linux-sunxi] Re: [PATCH v3 05/13] ARM: dts: sun9i: Add
 clock-indices property for bus gate clocks
In-Reply-To: <20150115152026.GA1135@lukather>
References: <1421113055-17867-1-git-send-email-wens@csie.org>
 <1421113055-17867-6-git-send-email-wens@csie.org>
 <20150114163351.GY4891@lukather>
 <CAGb2v64brc_2c5Jz2=BzfCpwiwBQgGf=SLD2ib+taOYUgicekA@mail.gmail.com>
 <20150115152026.GA1135@lukather>
Message-ID: <CAGb2v65g-HMH5ezGd29SxSNCA6J5H6Q1X1H3rLKh0=nqdHDgMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 15, 2015 at 11:20 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Thu, Jan 15, 2015 at 10:24:04AM +0800, Chen-Yu Tsai wrote:
>> On Thu, Jan 15, 2015 at 12:33 AM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > On Tue, Jan 13, 2015 at 09:37:27AM +0800, Chen-Yu Tsai wrote:
>> >> of_clk_get_parent_name() uses the clock-indices property to resolve
>> >> clock phandle arguments in case that the argument index does not
>> >> match the clock-output-names sequence.
>> >>
>> >> This is the case on sunxi, where we use the actual bit index as the
>> >> argument to the phandle. Add the clock-indices property so that
>> >> of_clk_get_parent_name() resolves the names correctly.
>> >>
>> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> >
>> > Applied. Are the mask in the clock driver still of any use now? I
>> > don't think they are, and if we're going that way, I'd rather have
>> > them removed from the driver.
>>
>> Yes they are still passed through factors_data, for mux_clk_ops to
>> know about the width of the mux, which is 3 bits on older SoCs vs
>> 4 bits on sun9i.
>
> Erm.... These are gates. They are not muxable and are not handled
> through clk-factors, so I'm not sure how it is relevant :)

Sorry. I jumped to the mux mask stuff. Yes the gate masks are still
used, and the gates are still referenced by the bit offset.

As described in the commit message, clock-indices is used by
of_clk_get_parent_name() to match the index used in the phandle
to the correct name in clock-names.

Take apb1 for example:

                       clock-indices = <0>, <1>, <2>, <3>, <4>,
                                       <16>, <17>, <18>, <19>, <20>, <21>;
                       clock-output-names = "apb1_i2c0", "apb1_i2c1",
                                       "apb1_i2c2", "apb1_i2c3", "apb1_i2c4",
                                       "apb1_uart0", "apb1_uart1", ...

If we have "clocks = <&apb1 16>;" in some device, and we call
of_clk_get_parent_name() on said clock, it would try to get
clock_output_names[16], which obviously is the wrong one.

With clock-indices, of_clk_get_parent_name first looks at
that array, finds an entry matching 16, then uses the
index of the matching entry to get the name from
clock-output-names.

So, we are still using the gate bitmask to declare valid
clock gates. The sunxi driver does not use clock-indices
directly. Nor do I think it was intended to be used by
clock drivers directly.

Hope this clears things up.


ChenYu
