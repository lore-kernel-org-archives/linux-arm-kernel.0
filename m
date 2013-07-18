From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Jul 2013 16:42:06 +0100
Subject: Audio issue on Kirkwood t5325: no sound
In-Reply-To: <20130718173727.2cfa38d3@skate>
References: <20130718134330.5aea00c5@skate>
 <20130718142009.GX24642@n2100.arm.linux.org.uk>
 <20130718173727.2cfa38d3@skate>
Message-ID: <20130718154206.GY24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 05:37:27PM +0200, Thomas Petazzoni wrote:
> # for i in /sys/kernel/debug/asoc/t5325/dapm/* ; do echo $i ; cat "$i" ; done
> /sys/kernel/debug/asoc/t5325/dapm/Headphone Jack
> Headphone Jack: Off  in 2 out 1
>  in  "static" "HPR"
>  in  "static" "HPL"
> /sys/kernel/debug/asoc/t5325/dapm/Mic Jack
> Mic Jack: Off  in 1 out 0
>  out "static" "MIC2"
>  out "static" "MIC1"
> /sys/kernel/debug/asoc/t5325/dapm/Speaker
> Speaker: Off  in 2 out 1
>  in  "static" "SPKOUTN"
>  in  "static" "SPKOUT"
> /sys/kernel/debug/asoc/t5325/dapm/bias_level
> Off
> 
> I don't see anything that looks unreasonable in there, but I've never
> played with DAPM and related things, so it is very possible that my
> reasonable-guesser might be wrong on this.

The last one.  I've seen that with the UDA134x driver too, where the bias
level stays in a low power state, resulting in no audio output.  I fixed
it by adding DAPM to the UDA134x and my SA11x0 driver.  Mark mentioned
something about virtual DAPM support must not be working correctly.

This needs an understanding of the DAPM code, which I'm told is just a
graph walk.  However, trying to work out where stuff starts and how to
follow the code through the stages of state changes in soc-dapm.c has
proved to be quite an onerous task.  I think there's only one or maybe
two people on this planet who understands that chunk of code.

At this point, you need Mark or Liam to sort this out.
