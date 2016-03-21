From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 21 Mar 2016 18:54:36 +0100
Subject: [linux-sunxi] Re: [PATCH v8 2/2] ASoc: sun4i-codec: Add FM, Line
 and Mic inputs
In-Reply-To: <20160319171336.6e16eb5a@scratchpost.org>
References: <20151221123148.1ab6480b@dayas> <20151221123416.51aa938e@dayas>
 <20151227182157.GI30359@lukather> <20151228040649.475a742f@dayas>
 <20160106220908.GE9631@lukather> <20160109164832.515d69b0@dayas>
 <20160312085222.226d89bf@scratchpost.org>
 <20160314104939.GL8418@lukather>
 <20160315105802.GN2566@sirena.org.uk>
 <20160319171336.6e16eb5a@scratchpost.org>
Message-ID: <20160321175436.GD30977@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 19, 2016 at 05:13:36PM +0100, Danny Milosavljevic wrote:
> Hi Mark,
> 
> my question is whether it's possible to group together the left and
> right channel into one selem, and also if it's possible to reuse
> volumes then. For example:
> 
> For sun4i-codec Mic there's right now:
> - Left Mixer Mic1 Playback Switch
> - Left Mixer Mic2 Playback Switch
> - Right Mixer Mic1 Playback Switch
> - Right Mixer Mic2 Playback Switch
> - Mic Playback Volume
> 
> If possible, it could also then be collected together as:
> - Mic1 Playback:
>     Left Mixer Mic1 Playback Switch, 
>     Right Mixer Mic1 Playback Switch, 
>     Mic Playback Volume
> - Mic2 Playback:
>     Left Mixer Mic2 Playback Switch, 
>     Right Mixer Mic2 Playback Switch, 
>     Mic Playback Volume [note: there it is again]
> 
> ... where each outer group (f.e. "- Mic1 Playback:") is a selem
> (slider with two mutes in alsamixer).
> 
> alsamixer has support for seperate left and right channel muting so
> it would cut down a lot on the number of visible controls.
> 
> But as you can see, Mic Playback Volume is also shared.
> 
> Is it possible to group them together like this? How?
> 
> Right now, while everything technically works, it's overwhelming to
> use alsamixer with sun4i-codec as a user - you have to *scroll* for
> quite a while.
> 
> Additionally, while I'm at it: 
> 
> There's one capture volume right in front of the ADC. Whatever it is
> you capture, this tells you the gain for the ADC. But for some
> inputs, there are additional preamps. Right now in the v8 patch we
> don't distinguish between preamps and ADC gains (because I don't
> think it's possible), although the user has to kinda distinguish
> them in his head because for inputs which have preamps only the
> preamp and the adc gain *together* specify the total gain in the
> end.
> 
> E.g. in the hardware it's
> 
>   Mic In -> | Mic Preamp | -> | ADC Gain | -> | ADC |
> 
> while in alsamixer it's:
> 
>   [Capture Controls:]
> 
>   | Mic Preamp |  | Capture Volume | | xyz Preamp | | abc Preamp | | qrs Preamp |
>                     ^--- ADC Gain
> 
> Is it possible to somehow distinguish those in alsamixer? Do we want
> to?


As I recall it, we were mostly discussing the how to deal with the ADC
muxer that muxes both left and right at the same time (so shared
controls), but with different source on each channel.

For example, some valid values are:
4: left channel Mic 1, right channel mic 2
5: left and right channel are Mic1 and Mic2 mixed

As I understand it, you can have shared controls by sharing the
kcontrols structure, but then, you can't different labels.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160321/d1f5b53e/attachment.sig>
