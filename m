From: dianders@chromium.org (Doug Anderson)
Date: Mon, 9 Nov 2015 13:12:44 -0800
Subject: [PATCH v2 4/8] phy: rockchip-usb: expose the phy-internal PLLs
In-Reply-To: <40224324.AZ7Q21CbSk@phil>
References: <1446998681-26436-1-git-send-email-heiko@sntech.de>
 <1446998681-26436-5-git-send-email-heiko@sntech.de>
 <CAD=FV=VburD9eRtNKL8DZXgspp4-nFVVOz5PnOaT8HvNG5uzFg@mail.gmail.com>
 <40224324.AZ7Q21CbSk@phil>
Message-ID: <CAD=FV=VVJ01cdQ245Ex_e_JJmJGjaD0+QUh0kGD5ReEbfFqe=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Mon, Nov 9, 2015 at 1:08 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> Hi Doug,
>
> Am Montag, 9. November 2015, 12:59:58 schrieb Doug Anderson:
>> On Sun, Nov 8, 2015 at 8:04 AM, Heiko Stuebner <heiko@sntech.de> wrote:
>> > +static const struct rockchip_usb_phy_pdata rk3066a_pdata = {
>> > +       .phys = (struct rockchip_usb_phys[]){
>> > +               { .reg = 0x17c, .pll_name = "sclk_otgphy0_480m" },
>> > +               { .reg = 0x188, .pll_name = "sclk_otgphy1_480m" },
>> > +               { /* sentinel */ }
>> > +       },
>> > +};
>> > +
>> > +static const struct rockchip_usb_phy_pdata rk3188_pdata = {
>> > +       .phys = (struct rockchip_usb_phys[]){
>> > +               { .reg = 0x10c, .pll_name = "sclk_otgphy0_480m" },
>> > +               { .reg = 0x11c, .pll_name = "sclk_otgphy1_480m" },
>> > +               { /* sentinel */ }
>> > +       },
>> > +};
>> > +
>> > +static const struct rockchip_usb_phy_pdata rk3288_pdata = {
>> > +       .phys = (struct rockchip_usb_phys[]){
>> > +               { .reg = 0x320, .pll_name = "sclk_otgphy0_480m" },
>> > +               { .reg = 0x334, .pll_name = "sclk_otgphy1_480m" },
>> > +               { .reg = 0x348, .pll_name = "sclk_otgphy2_480m" },
>> > +               { /* sentinel */ }
>> > +       },
>>
>> Slighly annoying to have to add a table for each SoC.  I'd imagine
>> this growing quite large.
>>
>> Would it be possible to query our parent clock name and then append a
>> "_480m" suffix?  Then you can magically get the name you want, right?
>> That doesn't preclude you from later overriding this or adding a "dts"
>> property for it, but it means no tables for now and (hopefully) for
>> the forseeable future.  ...and you get to kill a bunch of code in this
>> patch...
>>
>> You could fall back to some generic name based on the PHY device tree
>> node name if you wanted, or use the ID allocator...
>>
>>
>> Otherwise, this all looks good to me.  If you have a good reason why
>> using the parent name isn't a good idea, let me know and I can add my
>> Reviewed-by on this patch.
>
> Adding a _480m suffix was my initial solution. But the phy-supply clock
> is actually optional in the binding, so it may not be specified at all.
> Still the code needs this pll to work at all after the change, and
> inventing some completely random clock name seemed very strange
> (like pll_usbphy_REG or something) - especially as this would never
> have worked with the downstream clocks. As it is now, the downstream
> clock-tree will work indepent of the supply clock being specified.
>
> Also Rockchip seems to have moved to a different phy-ip, with one
> supplying clock, one pll and everything more tightly coupled,
> so we're probably getting a new driver for it, instead of additional
> entries for the picophy.

OK, seems quite reasonable to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
