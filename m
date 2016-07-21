From: mirza.krak@gmail.com (Mirza Krak)
Date: Thu, 21 Jul 2016 22:10:49 +0200
Subject: [RFC 3/6] dt/bindings: Add bindings for Tegra20/30 NOR bus driver
In-Reply-To: <434561ec-510e-a3bf-c7b6-c961db299bd6@nvidia.com>
References: <1468935397-11926-1-git-send-email-mirza.krak@gmail.com>
 <1468935397-11926-4-git-send-email-mirza.krak@gmail.com>
 <434561ec-510e-a3bf-c7b6-c961db299bd6@nvidia.com>
Message-ID: <CALw8SCU0cz6mbO=oudCZ4-=2PHVORNt3gwmg2bzNjyhJFnWS3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-07-21 11:56 GMT+02:00 Jon Hunter <jonathanh@nvidia.com>:
>> +
>> +The NOR controller supports a number of memory types, including synchronous NOR,
>> +asynchronous NOR, and other flash memories with similar interfaces, such as
>> +MuxOneNAND. One could also connect high speed devices like FPGAs, DSPs,
>> +CAN chips, Wi-Fi chips etc.
>
> Nit-pick ... the Tegra documentation refers to this controller as the
> GMI (general memory interface) or SNOR (sync-NOR) controller because it
> is not just limited to NOR as you mentioned. I see references to GMI in
> the Tegra pinctrl driver and so may be we should use this name.

ACK.


>> +Required properties:
>> +
>> + - compatible: should be "nvidia,tegra20-nor", "nvidia,tegra30-nor"
>
> I see at least one difference at the register level between Tegra20 and
> Tegra30 and so I think this should be something like ...
>
>  - compatible : Should contain one of the following:
>         For Tegra20 must contain "nvidia,tegra20-gmi".
>         For Tegra30 must contain "nvidia,tegra30-gmi".

ACK. Just curious, which register was it? I only checked that they
have the same count of registers.

>> + - nvidia,config: This property represents the SNOR_CONFIG_0 register.
>
> There is also a SNOR_MIO_CONFIG for the MIO address space and so I think
> that this should be nvidia,snor-config to be explicit. It might be nice
> to also add a "nvidia,mio-config" while you are at it as well, however,
> that could always be done later. If you do, then the
> "nvidia,snor-config" becomes optional depending on whether you are using
> the SNOR or MIO address space.

ACK the nvidia,snor-config part, will though wait for further comments
regarding what to do with the config registers, break-out or keep it
is a one property / register.

Regarding mio-config, not sure about if I would like to include that
part in this stage. If you feel strongly about this we can do it. If
it only comes to down to replicate the same configurations that we do
for SNOR to MIO then I do not see much of a problem, but would like
SNOR to be accepted and would not like the MIO part to halt this. But
then again this up to you guys.

>
>> +
>> +Note that the NOR controller does not have any internal chip-select address
>> +decoding and if you want to access multiple devices external chip-select
>> +decoding must be provided.
>
> Although it is true, you do have the MIO address space and so you could
> support two devices via the SNOR address space and MIO address space
> (assuming that the MIO can be used for the 2nd device).

This is true. If we include MIO support above could be added to the bindings.

>
> Furthermore, if you do have external logic to support multiple devices
> this would assume that the devices use the same timing and so are
> probably the same type. It also assumes both can fit in the 256MB
> address range. May be worth mentioning.

ACK.

>
> The GMI does have 8 chip selects and I believe the purpose of these is
> to allow you to address more than the 256MB range. However, I believe to
> do this it require software intervention to change the current CS that
> is in use.

Yes that is true. One has to modify the SNOR_CONFIG register to choose
a different CS pin.

>
> I wonder if it is worth mentioning that the chip-select specified in the
> "nvidia,config" prop should match that in the "ranges" prop unless you
> have some external decoding logic to provide an external chip-select.
> Which raises a question, what does the chip-select in the ranges
> actually represent? I am not sure if there is a common practice here for
> device tree when boards have external logic to provide additional
> chip-selects. I am sure this is quite common.

I do not understand why CS pin setting in nvidia,config need to match
the "ranges" prop? Other then maybe cosmetics.

If we do not have any external decoding logic to create more
chip-selects we only have ONE chip-select, and that one should always
be indexed as 0? Regardless of which CS pin is used. Because
ultimately what we configure in SNOR_CONFIG is which PIN(function) to
use as chip-select. The address space remains the same.

>> +Example with two SJA1000 CAN controllers connected to the NOR bus:
>> +
>> +     nor at 70009000 {
>> +             status = "okay";
>> +             compatible = "nvidia,tegra20-nor", "nvidia,tegra30-nor";
>> +             reg = <0x70009000 0x1000>;
>> +             #address-cells = <2>;
>> +             #size-cells = <1>;
>> +             clocks = <&tegra_car TEGRA30_CLK_NOR>;
>> +             resets = < &tegra_car 42>;
>> +             reset-names = "nor";
>> +             ranges = <
>> +                     0 0 0x48000000 0x00000100
>> +                     1 0 0x48040000 0x00000100
>> +             >;
>
> The "nvidia,config" appears to be missing here.

Indeed it is. ACK.

Thank you Jonanthan for your feedback.

Best Regards,
Mirza
