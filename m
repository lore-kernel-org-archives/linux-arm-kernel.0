From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 14 Sep 2015 17:06:05 +0200
Subject: [PATCH] clk: rockchip: add critical clock for rk3368
In-Reply-To: <20150914141920.GF7002@leverpostej>
References: <5267432.TORlj1Iv40@diego> <20150914141920.GF7002@leverpostej>
Message-ID: <6675833.8DAAvDYooL@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 14. September 2015, 15:19:21 schrieb Mark Rutland:
> On Sun, Sep 13, 2015 at 12:20:36PM +0100, Heiko St?bner wrote:
> > Again a result of the gpio-clock-liberation the rk3368 needs the
> > pclk_pd_pmu marked as critical, to boot successfully.
> > 
> > Reported-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> 
> FWIW: Tested-by: Mark Rutland <mark.rutland@arm.com>
> 
> I'm surprised that we don't describe these as critical in the DT, given
> that this isn't really an internal property of the clock controller, but
> rather what happens to be attached to it. That ship appears to have
> sailed, however.

I wouldn't necessarily think so ... what is called critical only means "don't 
turn off when walking the clock-tree upwards".

The pclk_pd_pmu for example simply supplies some more clocks we don't handle 
at all currently (pclk_pmu_noc, ...). That we currently choose to ignore those 
[because we don't have any code nor dt-bindings to handle the components 
supplied] sounds very much like an implementation-specific detail, not 
something about the hardware.

I really like the concept of critical clock handling Mike is working on, which 
implements some sort of hand-off and keeps so marked clocks on until a real 
components picks them up.
