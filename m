From: dianders@chromium.org (Doug Anderson)
Date: Mon, 9 Nov 2015 13:32:28 -0800
Subject: [PATCH v2 0/8] phy: rockchip-usb: correct pll handling and
 usb-uart
In-Reply-To: <3369052.6pxaYT98AY@phil>
References: <1446998681-26436-1-git-send-email-heiko@sntech.de>
 <CAD=FV=UCQ7ESi8NiZubAwa9Zzo4uiZHqm96bVMEue=M+Th4pTA@mail.gmail.com>
 <3369052.6pxaYT98AY@phil>
Message-ID: <CAD=FV=UytwJ9jthOZZEzw6ZwTFwyuTz5-B7xkuN_OgMbHKbWRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Mon, Nov 9, 2015 at 1:27 PM, Heiko Stuebner <heiko@sntech.de> wrote:
>> If you happened to be in the mood for cleaning up this PHY and wanted
>> to fix up one more thing that I noticed...
>>
>> ...you could actually increase the range of registers managed by the
>> PHYs.  For instance, in rk3288, the "host1" port isn't just managed by
>> 1 register, but by 4 (GRF_UOC2_CON0 - GRF_UOC2_CON3).  I think there
>> are 5 for the OTG port.
>>
>> Obviously not required for this series and there's no (current) reason
>> to do anything with the rest of those registers, but it might be
>> interesting for the future...
>
> I'm not sure what change you're proposing :-) .

I was proposing changing the PHY to look like:

usbphy: phy {
  compatible = "rockchip,rk3288-usb-phy";
  rockchip,grf = <&grf>;
  #address-cells = <1>;
  #size-cells = <1>;
  status = "disabled";

  usbphy0: usb-phy0 {
    #phy-cells = <0>;
    reg = <0x320 0x14>;
    clocks = <&cru SCLK_OTGPHY0>;
    clock-names = "phyclk";
  };
  ...
};

...in other words change the "size-cells" for the main PHY to 1 and
add a length to the registers.


> I currently see the reg-property both in the dts and in the code as
> "offset" - the start-register, because it points to uoc_con0 for each phy.
> So if needed I was just planning on doing reg+x , as they're coming from
> the GRF anyway.

Yeah, that would work.  I was just trying to make it more obvious in
the DTS that there was actually a range of registers managed here...


> One interesting point would be to move that under the GRF node, similar
> to what we're doing with the power-domains under the PMU.
>
> In retrospect I think exposing the phys individually was not the best
> decision - especially as when you dive deeper, they are not that similar
> anymore and individual functions change. But we'll have to live with that.

Now it's my turn: I'm not sure I understand...  ;)
