From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 19 Jan 2017 10:38:29 +1100
Subject: [PATCH v1 2/2] arm: dts: mt2701: add nor flash node
In-Reply-To: <20170118222010.ivc6jxpnrumemvdf@rob-hp-laptop>
References: <d7b866ad-5b2f-62d3-3aa3-6fa42803d625@gmail.com>
 <b850b751-1d8d-0053-cf1f-d5314542e5c3@gmail.com>
 <20170113172825.75d545a3@bbrezillon>
 <86c997be-f500-eaa1-3ba5-d21cff6223b7@gmail.com>
 <20170113175628.1793f433@bbrezillon>
 <0fafcd8d-cf99-de6b-728f-5e3637810b68@gmail.com>
 <20170114092958.022f2fc8@bbrezillon>
 <e7fa1542-f0e2-0e45-23b3-25d6491ae40d@gmail.com>
 <20170116094032.6f471f11@bbrezillon>
 <20170117143650.5db87148@free-electrons.com>
 <20170118222010.ivc6jxpnrumemvdf@rob-hp-laptop>
Message-ID: <20170119103829.524ce715@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 18 Jan 2017 16:20:10 -0600, Rob Herring wrote:

> > > Rob, Mark, any opinion?  
> >  
> 
> Sigh, is how to do compatibles really not yet understood?

Well, it seems like not everyone necessarily understands what is the
best strategy to adopt (me included).

> > I agree that a clarification would be good. There are really two
> > options:
> > 
> >  1. Have two compatible strings in the DT, the one that matches the
> >     exact SoC where the IP is found (first compatible string) and the
> >     one that matches some other SoC where the same IP is found (second
> >     compatible string). Originally, Linux only supports the second
> >     compatible string in its device driver, but if it happens that a
> >     difference is found between two IPs that we thought were the same,
> >     we can add support for the first compatible string in the driver,
> >     with a slightly different behavior.  
> 
> This. And no wildcards in the compatible string. 

OK. So it means that today we do something like:

	compatible = "baz,foo-12", "baz,foo-00";

and support only baz,foo-00 in the driver. If tomorrow we discover
that there is in fact a difference between the two IP blocks, we can
add support for baz,foo-12 in the driver, and handle the differences.

But then, the DT still contains:

	compatible = "baz,foo-12", "baz,foo-00";

and therefore pretends that the IP block is compatible with
"baz,foo-00" which is in fact *not* the case. It was a mistake to
consider it as compatible. So we keep living with a DT that has
incorrect information.

> 
> >  2. Have a single compatible string in the DT, matching the exact SoC
> >     where the IP is found. This involves adding immediately this
> >     compatible string in the corresponding driver.  
> 
> I wouldn't object to this from a DT perspective as I have no clue 
> generally if IP blocks are "the same" or not. Subsystem maintainers will 
> object though.

Knowing if IP blocks are "the same" is in fact not necessarily trivial.
What appears to be identical IP blocks today might be discovered later
as actually having subtle differences (sometimes not even visible in
the datasheet).

> > I've not really been able to figure out which of the two options is the
> > most future-proof/appropriate.  
> 
> They are both future-proof. #2 has the disadvantage of requiring a 
> kernel update for a new SoC. 

Which is generally anyway needed because a new SoC will almost always
require some new drivers, adjusting pin-muxing or clock drivers, etc.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
