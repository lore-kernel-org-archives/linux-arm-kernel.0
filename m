From: lamiaposta71@gmail.com (Raffaele Recalcati)
Date: Wed, 30 Jun 2010 10:17:40 +0200
Subject: [PATCH] ASoC: DaVinci: Added support for cpu clocking I2S
In-Reply-To: <20100628103030.GB14247@rakim.wolfsonmicro.main>
References: <1277707487-3371-1-git-send-email-lamiaposta71@gmail.com>
	<20100628103030.GB14247@rakim.wolfsonmicro.main>
Message-ID: <AANLkTimedG3X-rQbZvS6QfxUGkPIAtCgliI0xWknmNA9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/6/28 Mark Brown <broonie@opensource.wolfsonmicro.com>

> On Mon, Jun 28, 2010 at 08:44:46AM +0200, Raffaele Recalcati wrote:
> > From: Raffaele Recalcati <raffaele.recalcati@bticino.it>
>
> It's still very hard to understand what this patch is supposed to do.
> As previously mentioned this would probably be a lot clearer if you
> split this into multiple patches, for example one adding support for the
> fast clock mode, one adding support for selecting the pin used for any
> external clock and then further patches with any other changes.
>

Looking at other paches, they are simpler than mine.
I'll try to split it, hoping to obtain the final result.


>
> I strongly suggest looking at the commit messages for other patches in
> the kernel and trying to follow a similar style.
>
> >     Added audio playback support with [frame sync master - clock master]
> mode
> >     and with [frame sync master - clock slave].
>
> What are these modes - which clock are you talking about?
>

McBSP i2s interface to external codec.


>
> >        i2s_fast_clock switch can be used to have better approximate or
> >        symmetric waveforms.
>
> Why would someone choose not to use this?
>

I was not sure if symmetric waveform can be a must.
In general I think it is better a non symmetric, but better approximate,
waveform.
Anyway, it is better to have the possibility to choose in my opinion,
because I have not so much experience in i2s communication.


>
> >        clk_input_pin board info can be used to select it depending on hw
> >        connections
>
> >     3. We haven't changed the evmdm365 support (due also to CPLD that
> doesn't
> >                                                 help to understand)
> >         We don't know in this mode if audio stereo works on evmdm365.
> >         Probably it does.
>
> This is what makes me unsure if you're trying to add new modes or not -
> if you're adding new modes then I'd expect that existing boards would be
> unaffected with any changes to use the new feature being easily
> seperable.
>

Some tests are needed, but it requires time.
I'll try try to make some tests on evmdm365, but I'm not sure to have time
to do it.


> > +     /*
> > +      * This define works when both clock and FS are output for the cpu
> > +      * and makes clock very fast (FS is not simmetrical, but sampling
>
> symmetrical.
>

thx


>
> > +      * frequency is better approximated
> > +      */
> > +     int i2s_fast_clock;
>
> Is this a bool?
>

yes, I'll change it.


>
> > +     /* To be used when cpu gets clock from extenal pin */
> > +     int clk_input_pin;
> > +
>
> How would one use this?
>

looking at 2.5 Clock, Frames, and Data in
you can select MCBSP_CLKS or other input clock pins.

>From bogus@does.not.exist.com  Sun Jun  6 12:36:48 2010
From: bogus@does.not.exist.com ()
Date: Sun, 06 Jun 2010 16:36:48 -0000
Subject: No subject
Message-ID: <mailman.59.1277886068.27306.linux-arm-kernel@lists.infradead.org>

static struct snd_platform_data dm365_bmx_snd_data[] =3D {
        {
        },
        {
                .i2s_fast_clock =3D 0,
                .clk_input_pin =3D MCBSP_CLKS,
        },
};

If not set, it works as evm works, that is the default mode.


> >       case SND_SOC_DAIFMT_CBM_CFS:
> > -             /* McBSP CLKR pin is the input for the Sample Rate
> Generator.
> > -              * McBSP FSR and FSX are driven by the Sample Rate
> Generator. */
> > -             pcr =3D DAVINCI_MCBSP_PCR_SCLKME |
> > -                     DAVINCI_MCBSP_PCR_FSXM |
> > -                     DAVINCI_MCBSP_PCR_FSRM;
> > +             pcr =3D DAVINCI_MCBSP_PCR_FSRM | DAVINCI_MCBSP_PCR_FSXM;
> > +             if (dev->clk_input_pin =3D=3D MCBSP_CLKS)
> > +                     pcr |=3D DAVINCI_MCBSP_PCR_CLKXM |
> > +                             DAVINCI_MCBSP_PCR_CLKRM;
> > +             else
> > +                     /*
> > +                      * McBSP CLKR pin is the input for the Sample Rat=
e
> > +                      * Generator.
> > +                      * McBSP FSR and FSX are driven by the Sample Rat=
e
> > +                      * Generator.
> > +                      */
> > +                     pcr |=3D DAVINCI_MCBSP_PCR_SCLKME;
>
> This looks like you need a switch statement for the clock selection.
>


ok.



> > +static int davinci_i2s_dai_set_clkdiv(struct snd_soc_dai *cpu_dai,
> > +                             int div_id, int div)
> > +{
> > +     struct davinci_mcbsp_dev *dev =3D cpu_dai->private_data;
> > +     int srgr;
> > +
> > +     dev->clk_div =3D div;
> > +     return 0;
> > +}
> > +
>
> I would add a clock ID here in case someone wants to configure another
> clock in the patch.
>

Can you explain better,
please?


>
> > +     if (master =3D=3D SND_SOC_DAIFMT_CBS_CFS) {
>
> Use a switch staetment for this too.
>
> > +             clk =3D clk_get(NULL, "pll1_sysclk6");
>
> You're doing a clk_get() every time you go through here but never
> freeing it - it would seem better to just do the clk_get() at startup.
>

Thx for this.
I think it could create problems, right?
I can do it in the probe, I think, similarly to other drivers.


> I'd also expect this to be doing a clk_get() using the struct device for
> the DAI so that the driver can function even if the clock tree for a new.=
.
> SoC is different.
>

Sorry, I don't understand, can you explain me better?



>
> > +             if (clk)
> > +                     freq =3D clk_get_rate(clk);
>
> clk_get() returns an error pointer on error, not NULL, and...
>


gueSsing that I have to use this example code:
        aemif_clk =3D clk_get(NULL, "aemif");
        if (IS_ERR(aemif_clk))
                return;

I'll do it.


>
> > +             freq =3D 122000000; /* FIXME ask to Texas */
>
> ...this presumably ought to be in an else clause (or perhaps just not
> using this clocking at all if you can't find the clock?).
>

freq is used to obtain clk_div.
The real problem is that, as explained in the manual, it is not clear its
value.
I hope someone can help!!


>
> > +     } else if (master =3D=3D SND_SOC_DAIFMT_CBM_CFS) {
> > +             /* Clock given on CLKS */
>
> What if the user selected a different clock source?
>

I need another check,
right!


>
> > +             if (master =3D=3D SND_SOC_DAIFMT_CBS_CFS ||
> > +                             master =3D=3D SND_SOC_DAIFMT_CBS_CFM) {
>
> Again, switch statement.
>

ok


>
> > +     if (master =3D=3D SND_SOC_DAIFMT_CBS_CFS ||
> > +                     master =3D=3D SND_SOC_DAIFMT_CBS_CFM) {
>
> Here too.
>

again.


Conclusion
I split patches and I do fixes above.
Than I'll submit again and wait for new info.

The freq problem is describe here below, but it is not clear to me:


>From bogus@does.not.exist.com  Sun Jun  6 12:36:48 2010
From: bogus@does.not.exist.com ()
Date: Sun, 06 Jun 2010 16:36:48 -0000
Subject: No subject
Message-ID: <mailman.60.1277886068.27306.linux-arm-kernel@lists.infradead.org>

.
A) <http://www.ti.com/litv/pdf/sprufi3a>*
2.5.3 Data Clock Generation
When the receive/transmit clock mode is set to 1 (CLK(R/X)M =3D 1 in the pi=
n
control register (PCR)), the
data clocks (CLK(R/X)) are driven by the internal sample rate generator
output clock, CLKG. You can
select for the receiver and transmitter from a variety of data bit clocks
including:
=95 The input clock to the sample rate generator, which can be either the
internal clock source or a
dedicated external clock source via the MCBSP_CLKX, MCBSP_CLKR, or
MCBSP_CLKS pins. The
McBSP internal clock is the CPU/6 clock. See Section 2.5.3.1 for details on
the source of the McBSP
internal clock.
=95 The input clock source (internal clock source or external clock
MCBSP_CLKX/MCBSP_CLKR/MCBSP_CLKS) to the sample rate generator can be
divided-down by a
programmable value (CLKGDV bit in the sample rate generator register (SRGR)=
)
to drive CLKG.
Regardless of the source to the sample rate generator, the rising edge of
CLKSRG (see Figure 5)
generates CLKG and FSG.

CPU/6 is not clear.


regards,
Raffaele

--00163692034dc5a041048a3afc4c
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2010/6/28 Mark Brown <span dir=3D"ltr">&=
lt;<a href=3D"mailto:broonie@opensource.wolfsonmicro.com" target=3D"_blank"=
>broonie at opensource.wolfsonmicro.com</a>&gt;</span><br><blockquote class=3D=
"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rg=
b(204, 204, 204); padding-left: 1ex;">


<div>On Mon, Jun 28, 2010 at 08:44:46AM +0200, Raffaele Recalcati wrote:<br=
>
&gt; From: Raffaele Recalcati &lt;<a href=3D"mailto:raffaele.recalcati@btic=
ino.it" target=3D"_blank">raffaele.recalcati at bticino.it</a>&gt;<br>
<br>
</div>It&#39;s still very hard to understand what this patch is supposed to=
 do.<br>
As previously mentioned this would probably be a lot clearer if you<br>
split this into multiple patches, for example one adding support for the<br=
>
fast clock mode, one adding support for selecting the pin used for any<br>
external clock and then further patches with any other changes.<br></blockq=
uote><div><br>Looking at other paches, they are simpler than mine.<br>I&#39=
;ll try to split it, hoping to obtain the final result.<br>=A0</div>

<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<br>
I strongly suggest looking at the commit messages for other patches in<br>
the kernel and trying to follow a similar style.<br>
<div><br>
&gt; =A0 =A0 Added audio playback support with [frame sync master - clock m=
aster] mode<br>
&gt; =A0 =A0 and with [frame sync master - clock slave].<br>
<br>
</div>What are these modes - which clock are you talking about?<br></blockq=
uote><div><br>McBSP i2s interface to external codec.<br>=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1p=
x solid rgb(204, 204, 204); padding-left: 1ex;">



<div><br>
&gt; =A0 =A0 =A0 =A0i2s_fast_clock switch can be used to have better approx=
imate or<br>
&gt; =A0 =A0 =A0 =A0symmetric waveforms.<br>
<br>
</div>Why would someone choose not to use this?<br></blockquote><div><br>I =
was not sure if symmetric waveform can be a must.<br>In general I think it =
is better a non symmetric, but better approximate, waveform.<br>Anyway, it =
is better to have the possibility to choose in my opinion, because I have n=
ot so much experience in i2s communication.<br>


=A0</div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8=
ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div><br>
&gt; =A0 =A0 =A0 =A0clk_input_pin board info can be used to select it depen=
ding on hw<br>
&gt; =A0 =A0 =A0 =A0connections<br>
<br>
</div><div>&gt; =A0 =A0 3. We haven&#39;t changed the evmdm365 support (due=
 also to CPLD that doesn&#39;t<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 help to understand)<br>
&gt; =A0 =A0 =A0 =A0 We don&#39;t know in this mode if audio stereo works o=
n evmdm365.<br>
&gt; =A0 =A0 =A0 =A0 Probably it does.<br>
<br>
</div>This is what makes me unsure if you&#39;re trying to add new modes or=
 not -<br>
if you&#39;re adding new modes then I&#39;d expect that existing boards wou=
ld be<br>
unaffected with any changes to use the new feature being easily<br>
seperable.<br></blockquote><div><br>Some tests are needed, but it requires =
time.<br>I&#39;ll try try to make some tests on evmdm365, but I&#39;m not s=
ure to have time to do it.<br><br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204=
); padding-left: 1ex;">



<div><br>
&gt; + =A0 =A0 /*<br>
&gt; + =A0 =A0 =A0* This define works when both clock and FS are output for=
 the cpu<br>
&gt; + =A0 =A0 =A0* and makes clock very fast (FS is not simmetrical, but s=
ampling<br>
<br>
</div>symmetrical.<br></blockquote><div><br>thx<br>=A0<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px=
 solid rgb(204, 204, 204); padding-left: 1ex;">
<div><br>
&gt; + =A0 =A0 =A0* frequency is better approximated<br>
&gt; + =A0 =A0 =A0*/<br>
&gt; + =A0 =A0 int i2s_fast_clock;<br>
<br>
</div>Is this a bool?<br></blockquote><div><br>yes, I&#39;ll change it.<br>=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8=
ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div><br>
&gt; + =A0 =A0 /* To be used when cpu gets clock from extenal pin */<br>
&gt; + =A0 =A0 int clk_input_pin;<br>
&gt; +<br>
<br>
</div>How would one use this?<br></blockquote><div><br>looking at 2.5 Clock=
, Frames, and Data in <br>you can select MCBSP_CLKS or other input clock pi=
ns.<br><br>From board file you can select the possibilites:<br>static struc=
t snd_platform_data dm365_bmx_snd_data[] =3D {<br>


=A0=A0=A0=A0=A0=A0=A0 {<br>=A0=A0=A0=A0=A0=A0=A0 },<br>=A0=A0=A0=A0=A0=A0=
=A0 {<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .i2s_fast_clock =3D =
0,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .clk_input_pin =3D MCBS=
P_CLKS,<br>=A0=A0=A0=A0=A0=A0=A0 },<br>};<br><br>If not set, it works as ev=
m works, that is the default mode.<br><br>
</div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex;=
 border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">


<div><br>
&gt; =A0 =A0 =A0 case SND_SOC_DAIFMT_CBM_CFS:<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 /* McBSP CLKR pin is the input for the Sampl=
e Rate Generator.<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0* McBSP FSR and FSX are driven by the Sam=
ple Rate Generator. */<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 pcr =3D DAVINCI_MCBSP_PCR_SCLKME |<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DAVINCI_MCBSP_PCR_FSXM |<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DAVINCI_MCBSP_PCR_FSRM;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 pcr =3D DAVINCI_MCBSP_PCR_FSRM | DAVINCI_MCB=
SP_PCR_FSXM;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 if (dev-&gt;clk_input_pin =3D=3D MCBSP_CLKS)=
<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pcr |=3D DAVINCI_MCBSP_PCR_C=
LKXM |<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DAVINCI_MCBS=
P_PCR_CLKRM;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 else<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* McBSP CLKR pin is the i=
nput for the Sample Rate<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Generator.<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* McBSP FSR and FSX are d=
riven by the Sample Rate<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Generator.<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pcr |=3D DAVINCI_MCBSP_PCR_S=
CLKME;<br>
<br>
</div>This looks like you need a switch statement for the clock selection.<=
br></blockquote><div><br><br>ok.<br><br><br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204=
, 204, 204); padding-left: 1ex;">



<div><br>
&gt; +static int davinci_i2s_dai_set_clkdiv(struct snd_soc_dai *cpu_dai,<br=
>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int div_id, =
int div)<br>
&gt; +{<br>
&gt; + =A0 =A0 struct davinci_mcbsp_dev *dev =3D cpu_dai-&gt;private_data;<=
br>
&gt; + =A0 =A0 int srgr;<br>
&gt; +<br>
&gt; + =A0 =A0 dev-&gt;clk_div =3D div;<br>
&gt; + =A0 =A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
<br>
</div>I would add a clock ID here in case someone wants to configure anothe=
r<br>
clock in the patch.<br></blockquote><div><br>Can you explain better,<br>ple=
ase?<br>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt=
 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div><br>
&gt; + =A0 =A0 if (master =3D=3D SND_SOC_DAIFMT_CBS_CFS) {<br>
<br>
</div>Use a switch staetment for this too.<br>
<div><br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 clk =3D clk_get(NULL, &quot;pll1_sysclk6&quo=
t;);<br>
<br>
</div>You&#39;re doing a clk_get() every time you go through here but never=
<br>
freeing it - it would seem better to just do the clk_get() at startup.<br><=
/blockquote><div><br>Thx for this.<br>
I think it could create problems, right?<br>I can do it in the probe, I thi=
nk, similarly to other drivers.<br>=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204,=
 204); padding-left: 1ex;">

I&#39;d also expect this to be doing a clk_get() using the struct device fo=
r<br>
the DAI so that the driver can function even if the clock tree for a new..<=
br>
SoC is different.<br></blockquote><div><br>Sorry, I don&#39;t understand, c=
an you explain me better?<br><br>=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 2=
04); padding-left: 1ex;">

<div><br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 if (clk)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 freq =3D clk_get_rate(clk);<=
br>
<br>
</div>clk_get() returns an error pointer on error, not NULL, and...<br></bl=
ockquote><div><br><br>gueSsing that I have to use this example code:<br>=A0=
=A0=A0=A0=A0=A0=A0 aemif_clk =3D clk_get(NULL, &quot;aemif&quot;);<br>=A0=
=A0=A0=A0=A0=A0=A0 if (IS_ERR(aemif_clk))<br>


=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;<br><br>I&#39;ll do it=
.<br>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0p=
t 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div><br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 freq =3D 122000000; /* FIXME ask to Texas */=
<br>
<br>
</div>...this presumably ought to be in an else clause (or perhaps just not=
<br>
using this clocking at all if you can&#39;t find the clock?).<br></blockquo=
te><div><br>freq is used to obtain clk_div.<br>The real problem is that, as=
 explained in the manual, it is not clear its value.<br>I hope someone can =
help!!<br>


=A0</div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8=
ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div><br>
&gt; + =A0 =A0 } else if (master =3D=3D SND_SOC_DAIFMT_CBM_CFS) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 /* Clock given on CLKS */<br>
<br>
</div>What if the user selected a different clock source?<br></blockquote><=
div><br>I need another check, <br>right!<br>=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(=
204, 204, 204); padding-left: 1ex;">



<div><br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 if (master =3D=3D SND_SOC_DAIFMT_CBS_CFS ||<=
br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 master =3D=
=3D SND_SOC_DAIFMT_CBS_CFM) {<br>
<br>
</div>Again, switch statement.<br></blockquote><div><br>ok<br>=A0<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div><br>
&gt; + =A0 =A0 if (master =3D=3D SND_SOC_DAIFMT_CBS_CFS ||<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 master =3D=3D SND_SOC_DAIFMT=
_CBS_CFM) {<br>
<br>
</div>Here too.<br>
</blockquote></div><br>again.<br><br><br>Conclusion<br>I split patches and =
I do fixes above.<br>
Than I&#39;ll submit again and wait for new info.<br><br>The freq problem i=
s describe here below, but it is not clear to me:<br><br>From <b><a href=3D=
"http://www.ti.com/litv/pdf/sprufi3a" target=3D"_blank" name=3D"&amp;lid=3D=
en_US_folder_p_tech_docs_user_guides_action_link">TMS320DM36x
 DMSoC Multichannel Buffered Serial Port User&#39;s Guide (Rev. A)</a></b>
                                                           =20
                                                           =20
                                                           =20
                                                       =20
                                                       =20
                                                       =20
                                                            <br>2.5.3 Data =
Clock Generation<br>When the receive/transmit clock mode is set to 1 (CLK(R=
/X)M =3D 1 in the pin control register (PCR)), the<br>data clocks (CLK(R/X)=
) are driven by the internal sample rate generator output clock, CLKG. You =
can<br>
select for the receiver and transmitter from a variety of data bit clocks i=
ncluding:<br>=95 The input clock to the sample rate generator, which can be=
 either the internal clock source or a<br>dedicated external clock source v=
ia the MCBSP_CLKX, MCBSP_CLKR, or MCBSP_CLKS pins. The<br>
McBSP internal clock is the CPU/6 clock. See Section 2.5.3.1 for details on=
 the source of the McBSP<br>internal clock.<br>=95 The input clock source (=
internal clock source or external clock<br>MCBSP_CLKX/MCBSP_CLKR/MCBSP_CLKS=
) to the sample rate generator can be divided-down by a<br>
programmable value (CLKGDV bit in the sample rate generator register (SRGR)=
) to drive CLKG.<br>Regardless of the source to the sample rate generator, =
the rising edge of CLKSRG (see Figure 5)<br>generates CLKG and FSG.<br>
<br>CPU/6 is not clear.<br><br><br>regards,<br>Raffaele<br>
<br>



--00163692034dc5a041048a3afc4c--
