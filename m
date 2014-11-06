From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 06 Nov 2014 22:06:45 +0100
Subject: [PATCH 0/5] clk: rockchip: add full support for HDMI clock on
 rk3288
In-Reply-To: <1415087559-19444-1-git-send-email-kever.yang@rock-chips.com>
References: <1415087559-19444-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <48806799.thBSifdUp8@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kever,

Am Dienstag, 4. November 2014, 15:52:34 schrieb Kever Yang:
> we are going to make a clock usage solution for rk3288:
> 1. CPLL and GPLL always not change after assign init;
> 2. NPLL default as 500MHz, may used for most scene;
> 3. NPLL may be changed by VOP(HDMI) clock for some special
>    frequency requirement.
> 
>     I test it with rk3288 evb on top of Heiko's clk-for-next

In general I'm not really sure if allowing one component to arbitarily change 
a shared clock wouldn't result in trouble.

At the moment only dclk_vop0 is included in your series, while the hdmi 
controller can connect to both vop0 and vop1.
And as Doug mentioned the gpu also has the npll as one possible source.

Looking through the clock-tree there are a lot more components possibly using 
(or wanting to use) the npll: of course the VOPs, the edp, hdmi, isp, hevc, 
gpu, tsp uart0 and gmac. So I'm slightly uncomfortable with somehow reserving 
the npll for VOP0 alone.

But I also don't see a different way to get these frequencies right now.


Heiko
