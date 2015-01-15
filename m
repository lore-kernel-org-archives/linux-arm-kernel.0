From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 15 Jan 2015 22:46:24 +0100
Subject: [linux-sunxi] Re: [PATCH v3 05/13] ARM: dts: sun9i: Add
 clock-indices property for bus gate clocks
In-Reply-To: <CAGb2v67x=NP8SX9bLqvKg-=-TM4EwU3fNppaxo0HP7fO=gDGjw@mail.gmail.com>
References: <1421113055-17867-1-git-send-email-wens@csie.org>
 <1421113055-17867-6-git-send-email-wens@csie.org>
 <20150114163351.GY4891@lukather>
 <CAGb2v64brc_2c5Jz2=BzfCpwiwBQgGf=SLD2ib+taOYUgicekA@mail.gmail.com>
 <20150115152026.GA1135@lukather>
 <CAGb2v65g-HMH5ezGd29SxSNCA6J5H6Q1X1H3rLKh0=nqdHDgMA@mail.gmail.com>
 <20150115155156.GA1837@lukather>
 <CAGb2v67x=NP8SX9bLqvKg-=-TM4EwU3fNppaxo0HP7fO=gDGjw@mail.gmail.com>
Message-ID: <20150115214624.GA5567@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 12:09:01AM +0800, Chen-Yu Tsai wrote:
> On Thu, Jan 15, 2015 at 11:51 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Thu, Jan 15, 2015 at 11:35:42PM +0800, Chen-Yu Tsai wrote:
> >> On Thu, Jan 15, 2015 at 11:20 PM, Maxime Ripard
> >> <maxime.ripard@free-electrons.com> wrote:
> >> > On Thu, Jan 15, 2015 at 10:24:04AM +0800, Chen-Yu Tsai wrote:
> >> >> On Thu, Jan 15, 2015 at 12:33 AM, Maxime Ripard
> >> >> <maxime.ripard@free-electrons.com> wrote:
> >> >> > On Tue, Jan 13, 2015 at 09:37:27AM +0800, Chen-Yu Tsai wrote:
> >> >> >> of_clk_get_parent_name() uses the clock-indices property to resolve
> >> >> >> clock phandle arguments in case that the argument index does not
> >> >> >> match the clock-output-names sequence.
> >> >> >>
> >> >> >> This is the case on sunxi, where we use the actual bit index as the
> >> >> >> argument to the phandle. Add the clock-indices property so that
> >> >> >> of_clk_get_parent_name() resolves the names correctly.
> >> >> >>
> >> >> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >> >> >
> >> >> > Applied. Are the mask in the clock driver still of any use now? I
> >> >> > don't think they are, and if we're going that way, I'd rather have
> >> >> > them removed from the driver.
> >> >>
> >> >> Yes they are still passed through factors_data, for mux_clk_ops to
> >> >> know about the width of the mux, which is 3 bits on older SoCs vs
> >> >> 4 bits on sun9i.
> >> >
> >> > Erm.... These are gates. They are not muxable and are not handled
> >> > through clk-factors, so I'm not sure how it is relevant :)
> >>
> >> Sorry. I jumped to the mux mask stuff. Yes the gate masks are still
> >> used, and the gates are still referenced by the bit offset.
> >>
> >> As described in the commit message, clock-indices is used by
> >> of_clk_get_parent_name() to match the index used in the phandle
> >> to the correct name in clock-names.
> >>
> >> Take apb1 for example:
> >>
> >>                        clock-indices = <0>, <1>, <2>, <3>, <4>,
> >>                                        <16>, <17>, <18>, <19>, <20>, <21>;
> >>                        clock-output-names = "apb1_i2c0", "apb1_i2c1",
> >>                                        "apb1_i2c2", "apb1_i2c3", "apb1_i2c4",
> >>                                        "apb1_uart0", "apb1_uart1", ...
> >>
> >> If we have "clocks = <&apb1 16>;" in some device, and we call
> >> of_clk_get_parent_name() on said clock, it would try to get
> >> clock_output_names[16], which obviously is the wrong one.
> >>
> >> With clock-indices, of_clk_get_parent_name first looks at
> >> that array, finds an entry matching 16, then uses the
> >> index of the matching entry to get the name from
> >> clock-output-names.
> >
> > Yeah, I know what it does, and we do agree on the fact that it's
> > needed.
> >
> >> So, we are still using the gate bitmask to declare valid
> >> clock gates. The sunxi driver does not use clock-indices
> >> directly. Nor do I think it was intended to be used by
> >> clock drivers directly.
> >
> > However, the gate bitmask itself carries exactly the same information
> > than clock-indices. It's the exact same list of numbers, just with two
> > different ways of defining it.
> >
> > If we go with clock-indices, which is the right solution, then we can
> > just drop the other one.
> >
> > I actually started to do just this last evening. A31 boots without any
> > gates bit mask but the USB clocks one so far, I intend on converting
> > the others as well.
> 
> So as I understand, you want to replace the masks in the clock drivers
> with clock-indices in the dt. Is this correct? This potentially makes
> the gates clock driver very generic, which is nice.

Yeah, the only thing that is not are the clocks protected, which will
depend on the compatible.

> I only see drivers/clk/shmobile/clk-mstp.c using it this way though.
> Didn't we have this for sun6i-apb0-gates at one time?

I don't think we did. Or at least, it was never merged.

And since this property was introduced for shmobile iirc, I don't find
it very surprising :)

> I'm not against it. Just want to make sure everyone agrees, and we
> can work who and how we're going about this.

I did most of the work tonight, for all the sun7i, sun8i and sun9i
SoCs. sun6i work, I'll test sun9i, but I'll need some tests from you
for the A23 if it's ok :)

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150115/7cd3e7b6/attachment.sig>
