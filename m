From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 03 Sep 2013 13:25:09 -0600
Subject: [alsa-devel] [PATCH 2/3] ASoC: generic simple sound card DT
 bindings
In-Reply-To: <52220766.1040504@metafoo.de>
References: <1377945878-13322-1-git-send-email-mpa@pengutronix.de>
 <1377945878-13322-3-git-send-email-mpa@pengutronix.de>
 <52220766.1040504@metafoo.de>
Message-ID: <52263795.8010600@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/31/2013 09:10 AM, Lars-Peter Clausen wrote:
> On 08/31/2013 12:44 PM, Markus Pargmann wrote:
>> Simple sound card initialized using DT. When used with AC97, ac97-codec
>> is used to automatically discover the used codec.

>> diff --git a/Documentation/devicetree/bindings/sound/generic,simple-dt-card.txt b/Documentation/devicetree/bindings/sound/generic,simple-dt-card.txt

>> +ASoC Simple Sound Card

As Lars mentions below, we shouldn't have bindings for ASoC; we should
have bindings that describe the HW. Bindings are supposed to be
OS-agnostic, whereas "ASoC" is Linux-specific.

>> +
>> +A simple generic driver that connects a CPU DAI with a CODEC.
>> +
>> +Required properties:
>> + - compatible: "asoc-simple-card" used for standard ssi, codec
>> +   combinations, or "asoc-simple-ac97-card" to use ac97 to discover the
>> +   codec.
>> + - cpu-dai: CPU DAI connected to the codec.
>> +
>> +Required properties for "asoc-simple-card":
>> + - audio-codec: Codec phandle.
>> + - codec-dai-name: DAI name within the codec.
> 
> In my opinion this binding exposes way to much of the ASoC internal data
> structures. E.g. CODECs are referenced by phandle, but the DAI of the CODEC
> is reference by a string. This string is completely ASoC internal.

Mark has made the argument that (at least for CODEC analog pins) we can
simply put those strings into the binding document, and make them as
much a part of the binding as anything else. After all, (at least for
CODEC analog pins) the values are simply the names of the pins on the
package, as listed by the HW documentation itself.

We could presumably do the same thing for DAIs; in DT, use a
string-based DAI name derived directly from the HW documentation, rather
than the current intra-ASoC DAI name strings.

That said, I will admit that I personally don't really like the idea of
using strings in bindings. That opinion certainly isn't universal though.

> The
> binding also assumes that a CPU controller may have one DAI at most. In my
> opinion this binding ought to use the upcoming of_xlate stuff for ASoC
> components.

That restriction seems reasonable for a *simple* DT sound binding. For
more complex cards, one could presumably create more complex bindings,
be they generic bindings that cover arbitrary more complex cases, or
bindings for specific configurations that happen to include multiple DAIs.
