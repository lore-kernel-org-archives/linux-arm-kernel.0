From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 26 Apr 2016 11:11:36 +0100
Subject: [PATCH 09/18] ASoC: sti: Update DT example to match the driver
 code
In-Reply-To: <4337545.DyleYAUzIV@wuerfel>
References: <1461236675-10176-1-git-send-email-peter.griffin@linaro.org>
 <1461236675-10176-10-git-send-email-peter.griffin@linaro.org>
 <4337545.DyleYAUzIV@wuerfel>
Message-ID: <20160426101136.GA2984@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, 21 Apr 2016, Arnd Bergmann wrote:

> On Thursday 21 April 2016 12:04:26 Peter Griffin wrote:
> > uniperiph-id, version and mode are ST specific bindings and
> > need the 'st,' prefix. Update the examples, as otherwise copying
> > them yields a runtime error parsing the DT node.
> > 
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > Cc: arnaud.pouliquen at st.com
> > ---
> >  .../devicetree/bindings/sound/st,sti-asoc-card.txt         | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt b/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
> > index 028fa1c..ef2e0c6 100644
> > --- a/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
> > +++ b/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
> > @@ -67,9 +67,9 @@ Example:
> >                 dmas = <&fdma0 4 0 1>;
> >                 dai-name = "Uni Player #1 (DAC)";
> >                 dma-names = "tx";
> > -               uniperiph-id = <2>;
> > -               version = <5>;
> > -               mode = "PCM";
> > +               st,uniperiph-id = <2>;
> > +               st,version = <5>;
> > +               st,mode = "PCM";
> >         };
> 
> You don't change the binding desciption here, only the example,
> so they no longer match.

Whoops. Will fix that in v4.

> 
> What is st,uniperiph-id needed for anyway? It's often an indication
> that you are doing something wrong if you need this.

>From looking at the code in sound/soc/sti/uniperif_player.c, there is
one sysconf register called "Audio glue config" which is shared by all
of the uniperif IP instances. This binding is being used to generate a
bitoffset into this shared register based on the instance of the IP.

I guess the alternative is to have an explosion of compatibles?

st,sti-uni-player-1
st,sti-uni-player-2
st,sti-uni-player-3

If not what would you recommend instead? :-)

I don't currently have access to the functional spec for this
IP block, but I have asked ST to send it to me to see if there is any
other way to derive this information (although I suspect there won't
be).

FYI I didn't actually write or upstream that driver. However fdma is
a depedency of the ASoC driver and it is required to get working audio
upstream. It's also worth pointing out that this ASoC driver has been
merged for a while, so I'm not sure what your opinion is of now changing
the DT bindings? Obviously it is currently not used by anyone upstream
due to the missing fdma depedency.

regards,

Peter.
