From: kever.yang@rock-chips.com (Kever Yang)
Date: Wed, 05 Nov 2014 09:02:12 +0800
Subject: [PATCH] clk: rockchip: change hierarchy for some clocks
In-Reply-To: <CAD=FV=VByf=YKw7q4L2493C-z9uJ3dTSk9WZyCFdOkSjD2XoDw@mail.gmail.com>
References: <1414747777-12625-1-git-send-email-kever.yang@rock-chips.com>
 <CAD=FV=VByf=YKw7q4L2493C-z9uJ3dTSk9WZyCFdOkSjD2XoDw@mail.gmail.com>
Message-ID: <54597714.3050406@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

On 11/05/2014 05:32 AM, Doug Anderson wrote:
> Kever
>
> On Fri, Oct 31, 2014 at 2:29 AM, Kever Yang <kever.yang@rock-chips.com> wrote:
>> This patch change the hierarchy for some clocks, to met the following
>> bus hierarchy:
>> hclk_usb_peri is bus clock for
>> |- hclk_otg0,
>> |- hclk_host0,
>> |- hclk_host1,
>> |- hclk_hsic
>>
>> hclk_emem is bus clock for
>> |- hclk_nandc0
>> |- hclk_nandc1
>>
>> hclk_mem is bus clock for
>> |- hclk_sdmmc
>> |- hclk_sdio0
>> |- hclk_sdio1
>> |- hclk_emmc
> So as I understand it the "parent" clocks aren't really parents but
> are actually peer clocks.  That is if "hclk_usb_peri" is gated
> "hclk_otg0" continues to run.  ...but the OTG periperhal is useless
> without "hclk_usb_peri" also being enabled.
Correct.
>
> There doesn't seem to be any real downside to modeling thing as you
> have done it, though it's not quite a true representation of the
> world.  A slightly more true representation would be to make it so
> that whenever "hclk_otg0" is enabled/disabled that it makes an
> enable/disable call to "hclk_usb_peri".  I think you'd have to
> subclass the gate clock and patch your stuff in the "enable" function.
>
> I'm personally OK with things landing as you've described it (I can
> see no downside), but it seems like this at least deserves a comment
> (either in the code or the commit message).
I will update the commit message in new version, I describe it
in a private mail ask for how to handle this kind of clock, but not
in this patch, I will add it.
>
> If Mike T. thinks that we should use a more truthful model or if
> there's some better way to express this, you should of course listen
> to him and not to me.
Sure, I'm always looks for a better way for these kind of clocks,
there are many other clocks like *_arbi and *_niu still on rk3288
are not handled by any module which we have to use
CLK_IGNORE_UNUSED tag when disable unused init.

- Kever
