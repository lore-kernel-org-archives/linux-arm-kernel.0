From: kieran.bingham+renesas@ideasonboard.com (Kieran Bingham)
Date: Tue, 29 May 2018 10:08:33 +0100
Subject: [PATCH v2 10/11] arm64: dts: r8a77965-salvator-x: Enable DU
 external clocks and HDMI
In-Reply-To: <CAMuHMdW6HeWMwRDcn6PLnwzgxvYz-h=jx=1qvYEK9okwqY0itg@mail.gmail.com>
References: <20180427165722.19445-1-kieran.bingham+renesas@ideasonboard.com>
 <20180427165722.19445-11-kieran.bingham+renesas@ideasonboard.com>
 <CAMuHMdW6HeWMwRDcn6PLnwzgxvYz-h=jx=1qvYEK9okwqY0itg@mail.gmail.com>
Message-ID: <3a36b5e7-56ab-c680-e575-7a8394e5799a@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On 28/05/18 10:06, Geert Uytterhoeven wrote:
> Hi Kieran, Morimoto-san,
> 
> On Fri, Apr 27, 2018 at 6:57 PM, Kieran Bingham
> <kieran.bingham+renesas@ideasonboard.com> wrote:
>> The DU1 external dot clock is provided by the fixed frequency clock
>> generator X21, while the DU0 and DU3 clocks are provided by the
>> programmable Versaclock5 clock generator.
>>
>> Enable the clocks, and the HDMI encoder for the M3-N Salvator-X board
>> and hook it up to the HDMI connector.
>>
>> Based on patches from Takeshi Kihara <takeshi.kihara.df@renesas.com>
>>
>> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>>
>> ---
>> v2:
>>  - Remove LVDS clocks from DU node
>>  - Merge DU Clocks and HDMI enablement
>> ---
>>  .../boot/dts/renesas/r8a77965-salvator-x.dts  | 28 +++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
>> index 75d890d91df9..340a3c72b65a 100644
>> --- a/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
>> +++ b/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
>> @@ -19,3 +19,31 @@
>>                 reg = <0x0 0x48000000 0x0 0x78000000>;
>>         };
>>  };
>> +
>> +&du {
>> +       clocks = <&cpg CPG_MOD 724>,
>> +                <&cpg CPG_MOD 723>,
>> +                <&cpg CPG_MOD 721>,
>> +                <&versaclock5 1>,
>> +                <&x21_clk>,
>> +                <&versaclock5 2>;
>> +       clock-names = "du.0", "du.1", "du.3",
>> +                     "dclkin.0", "dclkin.1", "dclkin.3";
>> +};
>> +
>> +&hdmi0 {
>> +       status = "okay";
>> +
>> +       ports {
>> +               port at 1 {
>> +                       reg = <1>;
>> +                       rcar_dw_hdmi0_out: endpoint {
>> +                               remote-endpoint = <&hdmi0_con>;
>> +                       };
>> +               };
>> +       };
>> +};
>> +
>> +&hdmi0_con {
>> +       remote-endpoint = <&rcar_dw_hdmi0_out>;
>> +};
> 
> I think the hdmi0 and hdmi0_con parts can be moved to salvator-common.dtsi.
> Can we do that now (with stubs?), or does this have to wait until r8a77965 has
> received HDMI sound support?

I don't know about the sound integration I'm afraid, but common HDMI connections
would certainly be a benefit I believe.

Is this something you're looking to tackle? Or would you like
me/Morimoto-san/media team to look at it?


--
Regards

Kieran

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
