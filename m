From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 6 Sep 2016 10:51:40 +0800
Subject: [PATCH 5/7] ARM: sun8i: a33: Add display pipeline
In-Reply-To: <20160905202143.GC8596@lukather>
References: <20160901153204.11217-1-maxime.ripard@free-electrons.com>
 <20160901153204.11217-6-maxime.ripard@free-electrons.com>
 <CAGb2v66F+i=8SxrCN2+HNrjo5d=zXpCmbe9R=BT2sBxDXXXquw@mail.gmail.com>
 <20160905202143.GC8596@lukather>
Message-ID: <CAGb2v67E8tZeSgvoYAZDcb-4yvh_r_aYpchiybDuVTvjvQU2tQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 6, 2016 at 4:21 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Fri, Sep 02, 2016 at 02:28:54PM +0800, Chen-Yu Tsai wrote:
>> > +               be0: display-backend at 01e60000 {
>> > +                       compatible = "allwinner,sun8i-a33-display-backend";
>> > +                       reg = <0x01e60000 0x10000>;
>>
>> Please also list the interrupt, even though we don't use it yet.
>> The manual says it's 127 - 32 = 95.
>
> Yep, you're right.
>
>> > +               sat0: sat at 01e80000 {
>> > +                       compatible = "allwinner,sun8i-a33-sat";
>> > +                       reg = <0x01e80000 0x1000>;
>> > +                       clocks = <&ccu CLK_BUS_SAT>;
>> > +                       resets = <&ccu RST_BUS_SAT>;
>> > +
>> > +                       ports {
>> > +                               #address-cells = <1>;
>> > +                               #size-cells = <0>;
>> > +
>> > +                               sat0_in: port at 0 {
>> > +                                       #address-cells = <1>;
>> > +                                       #size-cells = <0>;
>> > +                                       reg = <0>;
>> > +
>> > +                                       sat0_in_fe0: endpoint at 0 {
>> > +                                               reg = <0>;
>> > +                                               remote-endpoint = <&fe0_out_sat0>;
>> > +                                       };
>> > +                               };
>> > +
>> > +                               sat0_out: port at 1 {
>> > +                                       #address-cells = <1>;
>> > +                                       #size-cells = <0>;
>> > +                                       reg = <1>;
>> > +
>> > +                                       sat0_out_be0: endpoint at 0 {
>> > +                                               reg = <0>;
>> > +                                               remote-endpoint = <&be0_in_sat0>;
>> > +                                       };
>> > +                               };
>>
>> I'm worried about the representation here.
>>
>> In the user manuals, the SAT is shown as part of the BE.  Look at it
>> this way: if it did come before the BE and is independent, we
>> shouldn't have to bring the SAT out of reset for simplefb to work.
>
> Indeed.
>
>> For comparison, a similar function unit called "CMU" found on the
>> other post-sun6i SoCs has the same function description as SAT on
>> the A33. It uses the reserved registers at the beginning of the BE
>> address space.
>
> Hmm, ok, so you would essentially, merge the backend and sat nodes?
>
> That wouldn't be very hard to do, i'll do it.

Yes. That is what I propose.

ChenYu
