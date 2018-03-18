From: jbrunet@baylibre.com (Jerome Brunet)
Date: Sun, 18 Mar 2018 16:09:57 +0100
Subject: [PATCH 1/4] dt-bindings: clock: meson: update documentation
 with hhi syscon
In-Reply-To: <20180318125222.kqtybu4hiwvsx3om@rob-hp-laptop>
References: <20180315115545.1884-1-jbrunet@baylibre.com>
 <20180315115545.1884-2-jbrunet@baylibre.com>
 <20180318125222.kqtybu4hiwvsx3om@rob-hp-laptop>
Message-ID: <1521385797.6569.90.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2018-03-18 at 07:52 -0500, Rob Herring wrote:
> On Thu, Mar 15, 2018 at 12:55:42PM +0100, Jerome Brunet wrote:
> > The HHI register region hosts more than just clocks and needs to
> > accessed drivers other than the clock controller, such as the display
> > driver.
> > 
> > This register region should be managed by syscon. It is already the case
> > on gxbb/gxl and it soon will be on axg. The clock controllers must use
> > this system controller instead of directly mapping the registers.
> 
> Sounds like a kernel problem, not a DT one.

It's a platform problem, so it has much a kernel problem (solution already
merged) as a DT problem

DT wise, we've got two devices mapping the same region

in arch/arm64/boot/dts/amlogic/meson-gx.dtsi:
> system-controller at 0 

which is used by the display device.

and in arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi (same for gxl)
> clock-controller at 0

It has worked so far because the clock controller claims the region w/o
reserving it but it remains unsafe since both device may access the same region.
The fix is to have the clock controller go through the existing syscon.

> 
> > 
> 
> With a single child, there is really no point to this change. A single 
> node can provide multiple functions. Look at nodes that are both reset 
> and clock providers.

There is more than a single user, as explained above and in the cover letter of
this series.

> 
> What other functions are there?
> 
> Rob
