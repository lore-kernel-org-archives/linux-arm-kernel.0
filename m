From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 19 Dec 2017 08:09:18 +0200
Subject: [PATCH v4 01/12] dt-bindings: thermal: Describe Armada AP806 and
 CP110
In-Reply-To: <20171219014320.182d2522@xps13>
References: <20171218143643.7714-1-miquel.raynal@free-electrons.com>
 <20171218143643.7714-2-miquel.raynal@free-electrons.com>
 <20171218203324.ftyqrgjawkujvhmn@tarshish>
 <20171219014320.182d2522@xps13>
Message-ID: <20171219060918.nr4ojwpmqf6ju6od@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miqu?l,

On Tue, Dec 19, 2017 at 01:43:20AM +0100, Miquel RAYNAL wrote:
> On Mon, 18 Dec 2017 22:33:24 +0200
> Baruch Siach <baruch@tkos.co.il> wrote:
> > On Mon, Dec 18, 2017 at 03:36:32PM +0100, Miquel Raynal wrote:
> > > From: Baruch Siach <baruch@tkos.co.il>
> > > 
> > > Add compatible strings for AP806 and CP110 that are part of the
> > > Armada 8k/7k line of SoCs.
> > > 
> > > Add a note on the differences in the size of the control area in
> > > different bindings. This is an existing difference between the
> > > Armada 375 binding and the other boards already supported. The new
> > > AP806 and CP110 bindings are similar to the existing Armada 375 in
> > > this regard.
> > > 
> > > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> > > [<miquel.raynal@free-electrons.com>: reword, additional details]
> > > Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
> > > ---
> > >  .../devicetree/bindings/thermal/armada-thermal.txt | 24
> > > +++++++++++++++++----- 1 file changed, 19 insertions(+), 5
> > > deletions(-)
> > > 
> > > diff --git
> > > a/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> > > b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> > > index 24aacf8948c5..9b7b2c03cc6f 100644 ---
> > > a/Documentation/devicetree/bindings/thermal/armada-thermal.txt +++
> > > b/Documentation/devicetree/bindings/thermal/armada-thermal.txt @@
> > > -7,17 +7,31 @@ Required properties: marvell,armada375-thermal
> > > marvell,armada380-thermal marvell,armadaxp-thermal
> > > +		marvell,armada-ap806-thermal
> > > +		marvell,armada-cp110-thermal
> > >  
> > >  - reg:		Device's register space.
> > >  		Two entries are expected, see the examples below.
> > > -		The first one is required for the sensor register;
> > > -		the second one is required for the control register
> > > -		to be used for sensor initialization (a.k.a.
> > > calibration).
> > > +		The first one points to the status register (4B).
> > > +		The second one points to the control registers
> > > (8B).
> > > +		Note: with legacy bindings, the second entry
> > > pointed
> > > +		only to the so called "control MSB" ("control 1"),
> > > was
> > > +		4B wide and did not let the possibility to reach
> > > the
> > > +		"control LSB" ("control 0") register. This is only
> > > +		allowed for compatibility reasons in Armada
> > > +		370/375/38x/XP DT nodes.  
> > 
> > "allowed" is not the right term, IMO. Legacy compatibles MUST point
> > to the MSB control register to preserve compatibility with existing
> > DTs.
> > 
> > The original patch had a list of legacy and non-legacy compatibles. I
> > think we need to keep them.
> 
> Maybe I should reword this paragraph because we both agree on the
> meaning:
> 
> "
> Note: Legacy bindings are only supported with Armada 370/375/38x/XP
> compatibles. The second memory resource entry only points to
> "control MSB/control 1", is 4 bytes wide and is preventing any access
> to "control LSB/control 0".
> "
> 
> Does this sounds better to you?

I think we need to explicitly list the affected compatible strings. Something 
like:

  For backwards compatibility reasons, the compatibles 
  marvell,armada370-thermal, marvell,armada380-thermal, and 
  marvell,armadaxp-thermal must point to "control MSB/control 1", with size of 
  4. All other compatibles must point to "control LSB/control 0" with size of
  8.

But I think you are right that we can use the size of the control registers to  
tell whether e.g. marvell,armada380-thermal is of the old binding of the new 
one. So maybe the "allow" language is more correct. But let's make it explicit 
to avoid any doubt. How about:

  The compatibles marvell,armada370-thermal, marvell,armada380-thermal, and 
  marvell,armadaxp-thermal must point to "control MSB/control 1", with size of 
  4 (deprecated binding), or point to "control LSB/control 0" with size of 8 
  (current binding). All other compatibles must point to "control LSB/control 
  0" with size of 8.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
