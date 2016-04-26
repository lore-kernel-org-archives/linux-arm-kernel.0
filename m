From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Apr 2016 12:58:35 +0200
Subject: [PATCH 09/18] ASoC: sti: Update DT example to match the driver
 code
In-Reply-To: <20160426101136.GA2984@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1461236675-10176-1-git-send-email-peter.griffin@linaro.org>
 <4337545.DyleYAUzIV@wuerfel>
 <20160426101136.GA2984@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <6161197.8XCk69TI60@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 April 2016 11:11:36 Peter Griffin wrote:
> Hi Arnd,
> 
> On Thu, 21 Apr 2016, Arnd Bergmann wrote:
> 
> > On Thursday 21 April 2016 12:04:26 Peter Griffin wrote:
> > > uniperiph-id, version and mode are ST specific bindings and
> > > need the 'st,' prefix. Update the examples, as otherwise copying
> > > them yields a runtime error parsing the DT node.
> > > 
> > > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > > Cc: arnaud.pouliquen at st.com
> > > ---
> > >  .../devicetree/bindings/sound/st,sti-asoc-card.txt         | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt b/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
> > > index 028fa1c..ef2e0c6 100644
> > > --- a/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
> > > +++ b/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
> > > @@ -67,9 +67,9 @@ Example:
> > >                 dmas = <&fdma0 4 0 1>;
> > >                 dai-name = "Uni Player #1 (DAC)";
> > >                 dma-names = "tx";
> > > -               uniperiph-id = <2>;
> > > -               version = <5>;
> > > -               mode = "PCM";
> > > +               st,uniperiph-id = <2>;
> > > +               st,version = <5>;
> > > +               st,mode = "PCM";
> > >         };
> > 
> > You don't change the binding desciption here, only the example,
> > so they no longer match.
> 
> Whoops. Will fix that in v4.
> 
> > 
> > What is st,uniperiph-id needed for anyway? It's often an indication
> > that you are doing something wrong if you need this.
> 
> From looking at the code in sound/soc/sti/uniperif_player.c, there is
> one sysconf register called "Audio glue config" which is shared by all
> of the uniperif IP instances. This binding is being used to generate a
> bitoffset into this shared register based on the instance of the IP.
> 
> I guess the alternative is to have an explosion of compatibles?
> 
> st,sti-uni-player-1
> st,sti-uni-player-2
> st,sti-uni-player-3
> 

That would certainly be worse: if the devices are actually identical,
they should have the same compatible string.

> If not what would you recommend instead? :-)

It's still not clear to me what that bit in the syscfg register
is for. Given the error message about "sti-audio-clk-glue",
I suspect that this is actually a clock controller and that
it should be using the clock binding with a separate driver
instead of manipulating the regmap directly from the audio driver.

	Arnd
