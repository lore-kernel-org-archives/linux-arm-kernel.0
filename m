From: linux.amoon@gmail.com (Anand Moon)
Date: Sun, 8 Oct 2017 18:11:12 +0530
Subject: [RFC 2/2] phy: exynos5-usbdrd: remove disable and enable of phy
 clk
In-Reply-To: <CAJKOXPe9FCKqrvsgdohTAN9tXXwbMOuyaDiHPxZ1Ym1LLPD41w@mail.gmail.com>
References: <1507264595-3565-1-git-send-email-linux.amoon@gmail.com>
 <1507264595-3565-2-git-send-email-linux.amoon@gmail.com>
 <CAJKOXPe9FCKqrvsgdohTAN9tXXwbMOuyaDiHPxZ1Ym1LLPD41w@mail.gmail.com>
Message-ID: <CANAwSgSbHR+e_2wX3i3VoVxPe10mUOoS94uRpvebfUfybaNQ+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 6 October 2017 at 12:12, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Fri, Oct 6, 2017 at 6:36 AM, Anand Moon <linux.amoon@gmail.com> wrote:
>> remove the disable and enable of phy clk.
>> phy clk is needed to tune the phy controller.
>
> Drivers should in general enable and disable the clocks they use. Just
> like in patch #1 please describe why you are doing this, what kind of
> problem are you trying to solve and what exactly are you trying to do
> here.
>
> BR,
> Krzysztof
>

[snip]

Usually we would disable the clk on error patch and return with failed.
but in the current code we disable the clk in init routine and
enable the clk in disable routine which seem incorrect.

[0] https://github.com/torvalds/linux/blob/master/drivers/phy/samsung/phy-exynos5-usbdrd.c#L362-L412
[1] https://github.com/torvalds/linux/blob/master/drivers/phy/samsung/phy-exynos5-usbdrd.c#L424-L446

On 3.10.x kernel clk_summary all the clk are enables.

    mout_usbdrd300              3           3            24000000
       dout_usbdrd300           2           2            24000000
          sclk_usbdrd300        1           1            24000000
       dout_usbphy300           2           2            24000000
          sclk_usbphy300        1           1            24000000
    mout_usbdrd301              3           3            24000000
       dout_usbdrd301           2           2            24000000
          sclk_usbdrd301        1           1            24000000
       dout_usbphy301           2           2            24000000
          sclk_usbphy301        1           1            24000000

Some more changes in clk driver might be required to stabilize the usb module.

Best Regards
-Anand
