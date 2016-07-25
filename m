From: mirza.krak@gmail.com (Mirza Krak)
Date: Mon, 25 Jul 2016 15:16:28 +0200
Subject: [RFC 3/6] dt/bindings: Add bindings for Tegra20/30 NOR bus driver
In-Reply-To: <20160725113034.GD21170@ulmo.ba.sec>
References: <1468935397-11926-1-git-send-email-mirza.krak@gmail.com>
 <1468935397-11926-4-git-send-email-mirza.krak@gmail.com>
 <20160725113034.GD21170@ulmo.ba.sec>
Message-ID: <CALw8SCWEFVu__8Gyr5q995h+=oMQEz1VUNB=Ne7MRb0O-tZXqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-07-25 13:30 GMT+02:00 Thierry Reding <thierry.reding@gmail.com>:
> On Tue, Jul 19, 2016 at 03:36:34PM +0200, Mirza Krak wrote:
>> From: Mirza Krak <mirza.krak@gmail.com>
>>
>> Document the devicetree bindings for NOR bus driver found on Tegra20 and
>> Tegra30 SOCs
>>
>> +
>> +Required properties:
>> +
>> + - compatible: should be "nvidia,tegra20-nor", "nvidia,tegra30-nor"
>> + - reg: Should contain NOR controller registers location and length.
>> + - clocks: Must contain one entry, for the module clock.
>> +   See ../clocks/clock-bindings.txt for details.
>> + - resets : Must contain an entry for each entry in reset-names.
>> +   See ../reset/reset.txt for details.
>> + - reset-names : Must include the following entries:
>> +  - nor
>> + - #address-cells: Must be set to 2 to allow memory address translation
>> + - #size-cells:      Must be set to 1 to allow CS address passing
>> + - ranges: Must be set up to reflect the memory layout with four integer
>> +             values for each chip-select line in use.
>> + - nvidia,config: This property represents the SNOR_CONFIG_0 register.
>
> I'd prefer if this was split out into separate properties. It's somewhat
> friendlier in my opinion to let people know what each of the settings is
> along with any units and such, rather than point them at the TRM, which
> they may or may not have access to.
>
> Or which not be available anymore.

Will split it out.

>
>> +
>> +Note that the NOR controller does not have any internal chip-select address
>> +decoding and if you want to access multiple devices external chip-select
>> +decoding must be provided.
>> +
>> +Optional properties:
>> +
>> + - nvidia,cs-timing: The timing array represents the SNOR_TIMING0_0 and
>> +   SNOR_TIMING1_0 registers for the NOR controller. If unset reset-values will
>> +   be used. See reference documentation for detailed description of the timing
>> +   registers.
>
> Are the reset values sensible? Are they reasonable defaults for a class
> of use-cases? I'm thinking that if they aren't we might as well make it
> a required property.
>
> Also, I'd prefer if this was split out into individual fields for the
> same reasons as the SNOR_CONFIG_0 register property.

I have tested the default values with two different chip types, and
both have worked without me adjusting any timings. The tested chips
are SJA1000 (CAN) and 16C550 (UART). So I would say that they are
sensible.

Will split it out as well.

>
>> +
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
>
> No space between < and &, please.

ACK.

>
>> +             reset-names = "nor";
>> +             ranges = <
>> +                     0 0 0x48000000 0x00000100
>> +                     1 0 0x48040000 0x00000100
>> +             >;
>> +
>> +             can at 0,0 {
>> +                     compatible = "nxp,sja1000";
>> +                     reg = <0 0 0x100>;
>> +                     interrupt-parent = <&gpio>;
>> +                     interrupts = <TEGRA_GPIO(B, 5) IRQ_TYPE_EDGE_RISING>;
>> +                     nxp,external-clock-frequency = <24000000>;
>> +                     nxp,tx-output-config = <0x16>;
>> +                     nxp,clock-out-frequency = <24000000>;
>> +                     reg-io-width = <2>;
>> +             };
>> +
>> +
>
> There's an extra blank line here.

ACK.

>
>> +             can at 1,0 {
>> +                     compatible = "nxp,sja1000";
>> +                     reg = <1 0 0x100>;
>> +                     interrupt-parent = <&gpio>;
>> +                     interrupts = <TEGRA_GPIO(A, 6) IRQ_TYPE_EDGE_RISING>;
>> +                     nxp,external-clock-frequency = <24000000>;
>> +                     nxp,tx-output-config = <0x16>;
>> +                     reg-io-width = <2>;
>> +     };
>
> I'm somewhat confused about how this hardware works. My understanding
> was that each chip gets mapped to the whole range of the NOR address
> range (0x48000000 - 0x4fffffff on Tegra30).

I can understand the confusion.

>
> The above suggests that one of the CAN controllers gets mapped to an
> address 0x48000000 and the other gets mapped to 0x48040000. But why do
> we even need a chip-select at all in that case? If both chips don't use
> any overlapping memory region, what good does the chip-select do?

If we take a look on similar controllers found on others SOCs they
usually define an address range / chip-select.

Example (weim):
ranges = <
0 0 0x10000000 0x02000000
1 0 0x12000000 0x01000000
2 0 0x13000000 0x01000000
3 0 0x14000000 0x01000000
4 0 0x15000000 0x01000000
5 0 0x16000000 0x01000000
>;

Which means that you all ready have an address mapped to PIN function.

But Tegra GMI controller is a first for me, where you do not have this
kind of setup in hardware. Usually you also have a timing register /
chip-select so that you can connect different chip types.

The lack of hardware support do decode an address to a chip-select PIN
function, we have implemented this our self externally.

We actually have 6 different chips connected to the GMI bus and the
"ranges" would be:
  ranges = <
   0 0 0x48000000 0x00000100
   1 0 0x48040000 0x00000100
   2 0 0x48080000 0x00000100
   3 0 0x480A0000 0x00000100
   4 0 0x480C0000 0x00000100
   5 0 0x480E0000 0x00000100
  >;

And this not nothing complicated, small number of AND gates and that is it.

The chip-select signal is necessary for the access characteristics, so
we need to translate an address to an chip-select so that the chip
knows the host CPU wants to talk to it.

Do not know if I made anything more clear here :).

>
> Also, it seems to me that you'd have to program the SNOR_CONFIG_0
> register in order to select a specific chip, but I don't see anything in
> the driver access that register after the initial write of the register.

This is only setup at probe.

>
> I would've expected this to require some sort of infrastructure to allow
> devices connected to the GMI controller to acquire the bus via some API
> to select their chip.

Yes, ultimately you would need some sort of infrastructure to allow
devices to acquire the GMI bus if you want to solve this in software.
But at the moment I do not see such an infrastructure in place, and is
it feasible to add one specifically for the GMI controller? If one
such infrastructure was in place we would need to modify all the
drivers that want to use to include Tegra specific infrastructure to
access the GMI bus?

Since my knowledge is limited it hard for me to comment on this, maybe
there is a simple way of doing this?


Best Regards,
Mirza
