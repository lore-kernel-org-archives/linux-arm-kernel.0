From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Wed, 16 Dec 2015 23:30:51 +0100
Subject: [linux-sunxi] Re: [PATCH v6] sun4i-codec: Add FM, Line and Mic
 inputs
In-Reply-To: <20151216104736.GT19456@lukather>
References: <20151209235530.7240df0a@dayas> <20151213205839.GA19456@lukather>
 <20151215025208.7c468673@dayas> <20151216104736.GT19456@lukather>
Message-ID: <20151216233051.09d34738@dayas>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Wed, 16 Dec 2015 11:47:36 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> > Because SUN4I_CODEC_AC_MIC_PHONE_CAL is sun7i-specific.
> 
> Yet, you're using it in both cases (A10 vs A20).

Yes. I'm trying to keep complexity and duplication down.
I figured it wouldn't be bad to have unused registers in the regmap.

(Technially .max_register = MAX(max_register_a10, max_register_a20) would be 
 better. Should we do that?)

If it's bad in this case, we have to split it up, but frankly the *codec_probe() 
function is much too long now and this would make it even longer.

Also, it was that way before, so I'm mostly using it in both cases because 
previously it was also used in both cases (with the too-large max-register), 
apparently without problems. 

Should I duplicate and adapt the structure?

> You can also have the defines on top, and everything just works :)

The idea is to make the compiler complain when I try to use a sun7i define in a 
generic sun4i function (or struct, in this case) - because that would probably 
be causing problems at runtime, too. Better to catch problems earlier.
So I kept the sun7i-specific things closely together and as much to the bottom 
of the file as possible - as a poor-mans modularity. 
If I kept the sun7i defines at the top I could use them anywhere with impunity - 
also in the A10 case - and it would not complain.

But it's mostly to make the life of the developer easier, so feel free to choose 
otherwise. (not sarcasm)

> > Or is it better to rename it to "SUN7I_CODEC_AC_DAC_CAL" rather than delete?
> 
> You can rename it if you want, but it's not like it's of the highest
> importance :)

The only somewhat important part of the name is the "7". 
If you use a "7"-register on an A10, it's not going to work at runtime, or worse: 
do something else that wasn't intended. Right now it has a "4" although it isn't
an A10 register. This separation should be visible somewhere in the source code, 
or problems are going to slip through later.

I agree it's not at all important right now because the register is unused 
by us :P
(But it's actually an interesting register, it contains DAC bias calibration 
data. Cool that that can be modified)

> > Note: the newest original ASoC sun4i-codec has a variable
> >   "struct sun4i_codec *scodec;"
> > as well in the same function (which is a different thing).
> 
> I don't know what you're refering to with "newest" and "original".

Oops, sorry, by "newest" I meant "I checked the tree online right before I wrote 
the mail".
By "original" I meant "not of my patch".

> But two different variables with two different names doesn't seem so
> bad, does it?

For the computer? No.

Two different variables with almost the same name for humans? Welll. 

But it's fine, just wanted to point it out because you can't see it in the patch.

Thanks,
   Danny
