From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Jan 2016 15:45:38 +0100
Subject: [PATCH v5 5/6] mfd: dt-bindings: add device tree bindings for
 Hi3519 sysctrl
In-Reply-To: <20160125142609.GR3368@x1>
References: <1452219400-32478-1-git-send-email-xuejiancheng@huawei.com>
 <5675031.hi9rRCqFXs@wuerfel> <20160125142609.GR3368@x1>
Message-ID: <2693576.UgmARKQTGm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 January 2016 14:26:09 Lee Jones wrote:
> On Tue, 12 Jan 2016, Arnd Bergmann wrote:
> 
> > On Tuesday 12 January 2016 17:28:05 xuejiancheng wrote:
> > > >>>>>
> > > >>>> Not yet.
> > > >>>> Arnd Bergmann and Rob Herring all suggested adding a specific compatible string
> > > >>>> with the SOC name. This binding is just used for describing the compatible string now.
> > > >>>> When more functions on hi3519 SOC are added later, the specific driver will be also
> > > >>>> needed.
> > > >>>
> > > >>> Save this binding until it has more functionality.  We here "I'll add
> > > >>> to this later" all too often.
> > > >>>
> > > >>
> > > >> In the hi3519.dtsi file, there is a system-controller device node described like below:
> > > >> sysctrl: system-controller at 12010000 {
> > > >>      compatible = "hisilicon,hi3519-sysctrl", "syscon";
> > > >>      reg = <0x12010000 0x1000>;
> > > >> };
> > > >> Do you mean that I should remove "hisilicon,hi3519-sysctrl" and just use "syscon" as the
> > > >> compatible string??
> > > > 
> > > > Where is this compatible string _used_?
> > > > 
> > > >> If I want to add "hisilicon,hi3519-sysctrl" for hi3519. where should I put this binding?
> > > >> Could you give some suggestions?  Thank you very much!
> > > > 
> > > > If you're not using the compatible i.e. the device doesn't have its
> > > > own driver yet, then there is no need to supply the binding at all, is
> > > > there?
> > > > 
> > > 
> > > OK. Thank you.
> > > 
> > 
> > Sorry for stepping in late here. I still think that every syscon device should
> > come with a specific compatible string, so we have the option of creating a
> > driver later on, and I'd like to see a binding document that lists those strings
> > (which I believe exists here).
> > 
> > It's really hard to add compatible strings later on, anything else we can
> > work around by keying off that string and adding a workaround in the kernel.
> 
> Why is it more difficult (or any different) to add a compatible string
> later (when it is used) over now (when it is not used)?

There are many reasons why it can be hard to change a DT binary or source
file later on. Sometimes the dtb is shipped with the firmware, sometimes
someone has a slightly different platform that is not yet upstreamed,
and they need to know about the change when forward-porting to a newer
kernel.

Either way, you always want to be able to run a newer kernel on an older
dtb file without loss of functionality, so all "compatible" strings should
generally be as specific as possible (with fallbacks to more generic
strings). We do this even for devices that we think are identical, e.g.
when multiple SoC vendors integrate the same IP block, but in this case,
we already *know* that they are incompatible, so we should never have
the same string as the most specific ID.

	Arnd
