From: dawei.chien@mediatek.com (dawei chien)
Date: Mon, 2 Nov 2015 18:46:21 +0800
Subject: [PATCH v3 0/2] thermal: mediatek: Add cpu power cooling model
In-Reply-To: <20151028154449.GH3716@ubuntu>
References: <1445515359-8587-1-git-send-email-dawei.chien@mediatek.com>
 <20151028154449.GH3716@ubuntu>
Message-ID: <1446461181.10039.28.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,
On Wed, 2015-10-28 at 21:14 +0530, Viresh Kumar wrote:
> On 22-10-15, 20:02, Dawei Chien wrote:
> > Use Intelligent Power Allocation (IPA) technical to add static/dynamic power model for binding CPU thermal zone.
> > The power allocator governor allocates power budget to control CPU temperature.
> > 
> > Power Allocator governor is able to keep SOC temperature within a defined temperature range to avoid SOC overheat and keep it's performance. mt8173-cpufreq.c need to register its' own power model with power allocator thermal governor, so that power allocator governor can allocates suitable power budget to control CPU temperature.
> > 
> > PATCH1 is base on
> > https://patchwork.kernel.org/patch/7034601/
> > 
> > PATCH2 is base on Sascha's thermal driver V9
> > https://patchwork.kernel.org/patch/7249821/
> > https://patchwork.kernel.org/patch/7249861/
> > https://patchwork.kernel.org/patch/7249891/
> > 
> > Change since V1:
> > include mt8171.h and sort header file for mt8173.dtsi
> > 
> > Change since V2:
> > Move dynamic/static power model in device tree
> > 
> > Dawei.Chien (2):
> >   thermal: mediatek: Add cpu power cooling model.
> >   arm64: dts: mt8173: Add thermal zone node for mt8173.
> 
> Sorry for being extremely late in reviewing this stuff. You are
> already on v3 and I haven't reviewed it once. Mostly due to bad timing
> of my holidays and other work pressure.

You're welcome, truly thank you for your kindly reviewing

> Now, there are few things that I feel are not properly addressed here,
> and I may be wrong:
> - Where are the bindings for static-power-points and
>   dynamic-power-coefficient. Sorry I failed to see them in this or
>   other series you mentioned.

Please refer to following document (2-1,2-2) for dynamic-power &
static-power in detail. Besides, do I need to add another document for
our own MT8173 IC.
http://lxr.free-electrons.com/source/Documentation/thermal/cpu-cooling-api.txt

> - Even then, why should we be adding another table into DT for
>   voltage/power ? And not reuse and extend the opp-v2 stuff which is
>   already mainlined now.

We could reuse opp-v2 for static power points after OPPV2 back port to
our currently branch.
However, as far as I know, there is no "power" in opp.c (suck like
opp-hz) as far, so I need to add something in opp.c for my purpose, suck
like add power in _opp_add_static_v2, and add something for return
"power", right? I may be wrong, please kindly give me your suggestion,
thank you.

Actually, I am considering to remove the part of static power point
since it is optional for Power Model. Could you agree with this?
> - There are few issues with the code as well, but I want to see where
>   the bindings should go first. And then only discuss the code
>   further.
> 
