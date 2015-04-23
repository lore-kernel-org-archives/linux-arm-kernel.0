From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 23 Apr 2015 07:41:39 -0600
Subject: [PATCH] coresight: Add support for Juno platform
In-Reply-To: <20150423092032.GA16238@leverpostej>
References: <1429742802-13089-1-git-send-email-mathieu.poirier@linaro.org>
 <20150423092032.GA16238@leverpostej>
Message-ID: <CANLsYkzbKiCyU5ZYknTF6hzkPAbz2oMYaW3m8Xa6=W67w_N_EA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 April 2015 at 03:20, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Matthieu,
>
>> +     main_funnel at 20040000 {
>> +             compatible = "arm,coresight-funnel", "arm,primecell";
>> +             reg = <0 0x20040000 0 0x1000>;
>> +
>> +             clocks = <&soc_smc50mhz>;
>> +             clock-names = "apb_pclk";
>> +             ports {
>> +                     #address-cells = <1>;
>> +                     #size-cells = <0>;
>> +
>> +                     port at 0 {
>> +                             reg = <0>;
>> +                             main_funnel_out_port: endpoint {
>> +                                     remote-endpoint =
>> +                                             <&etf_in_port>;
>> +                             };
>> +                     };
>> +
>> +                     port at 1 {
>> +                             reg = <0>;
>> +                             main_funnel_in_port0: endpoint {
>> +                                     slave-mode;
>> +                                     remote-endpoint =
>> +                                                     <&A57_funnel_out_port>;
>> +                             };
>> +                     };
>> +
>> +                     port at 2 {
>> +                             reg = <1>;
>> +                             main_funnel_in_port1: endpoint {
>> +                                     slave-mode;
>> +                                     remote-endpoint = <&A53_etm0_out_port>;
>> +                             };
>> +                     };
>
> What's going on with these reg properties? They aren't matched with
> their nodes' unit-addresses, and the same reg is reused by multiple
> nodes. That doesn't make sense to me.
>
> Is the mismatch deliberate (against DT conventions), or is this
> mistaken?

Thanks for the review.

Coresight blocks have input and output ports and I use (and used [1])
the reg property to label the physical ports as found on device
itself.  Above, "port at 0" doesn't have a "slave-mode" property and as
such is output port "0".

"port at 1" and "port at 2" have a "slave-mode" property and thus are input
port "0" and "1", as indicated by their reg properly.

[1]. http://lxr.free-electrons.com/source/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts#L426

Mathieu

>
> Likewise for the other funnels.


>
> Mark
