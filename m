From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 23 Aug 2013 09:00:23 -0700
Subject: [RFC 17/17] clk: zynq: remove call to of_clk_init
In-Reply-To: <20130823073250.GB30135@pengutronix.de>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376964271-22715-18-git-send-email-sebastian.hesselbarth@gmail.com>
 <d17acba9-85f9-40cd-a176-2005e3e924f8@CO1EHSMHS002.ehs.local>
 <c4d10bdf-6506-4edc-92cc-2acc67b86602@VA3EHSMHS032.ehs.local>
 <20130823073250.GB30135@pengutronix.de>
Message-ID: <bf33d6fc-a28b-410a-aa75-be7b584aadd8@CO9EHSMHS025.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steffen,

On Fri, Aug 23, 2013 at 09:32:50AM +0200, Steffen Trumtrar wrote:
> Hi!
> 
> On Thu, Aug 22, 2013 at 05:59:36PM -0700, S?ren Brinkmann wrote:
> > On Thu, Aug 22, 2013 at 05:26:47PM -0700, S?ren Brinkmann wrote:
[ ... ]
> I propose getting rid of the whole global pointer and let the clkc map the
> address itself instead.
> 
> Then there is no need to shuffle stuff around in the initcalls.
> I have some WIP patches (not rebased on next and not even tested with it,
> but with v3.11-rc4)
> 
> The dtsi would be something like:
> 
>        control-register at f8000000 {
> 	       compatible = "simple-bus";
>                #address-cells = <1>;
>                #size-cells = <1>;
>                reg = <0xf8000000 0x1000>;
>                ranges;
> 
>                slcr: slcr at f8000000 {
>                        compatible = "xlnx,zynq-slcr", "syscon";
>                        reg = <0xf8000000 0x10>;
>                };
> 
>                clkc: clkc at f8000100 {
>                        #clock-cells = <1>;
>                        compatible = "xlnx,ps7-clkc";
>                        reg = <0xf8000100 0x100>;

This is splitting the SLCR into multiple regions. I just heard about the
syscon the first time, but wouldn't it be more correct to leave the SLCR
region in one piece in the slcr node and then pass the slcr phandle to
the clkc and later also pinmux etc. nodes? This way the SLCR is in
charge of the lock and all registers protected by the lock.
That wouldn't get rid of the dependency that SLCR has to be initialized
before any of its users, but seems to reflect actual HW better since the
whole region is protected by the same SLCR lock which makes them kinda
inseparable.

Anyway, after all we more or less agree, that syscon/slcr has to be
initialized before any SLCR user. So, no matter whether we do this
through current code and a global pointer or DT phandles, the effect
stays the same, IIUC.
So, in order to not mix stuff around too much, I'd rather make sure that
zynq_slcr_init() is called early enough (put it in init_irq() or some
init_call() whatever works best), and keep the global pointer for now.
That way most code can stay as is and we don't have to change the DT
bindings.
And then you can finish your work on this and we can revisit the topic
of migrating to use the slcr through a phandle later?

	S?ren
