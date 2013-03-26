From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Tue, 26 Mar 2013 12:12:22 +0100
Subject: [RFC PATCH] CLK: Allow parent clock and rate to be configured
 in DT.
In-Reply-To: <20130325132935.GE1906@pengutronix.de>
References: <20130319170933.28337.50448.stgit@localhost>
 <20130325101707.GZ1906@pengutronix.de> <51503007.5020403@parkeon.com>
 <20130325132935.GE1906@pengutronix.de>
Message-ID: <51518296.7000500@parkeon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/03/13 14:29, Sascha Hauer wrote:
> Put it differently. OpenBSD might have much better clock support. 
> Imagine it can dynamically figure out the correct esdhc frequencies 
> for different usecases on the fly. In this situation it would be 
> counterproductive if Linux requires static values for these in the 
> devicetree. 
It shouldn't *require* them.
If they are in a separate subtree of the DT OpenBSD would be free to 
ignore them and use its better method.
>> The cko case is even worse - due to a board design decision that
>> clock needs to have
>> a frequency suitable for supplying some external chip. We don't want
>> board specific code in
>> the platform clock code and we're trying to get away from board files...
> The codec could be provided a phandle to the cko clk. This is hardware
> description and is fine for putting into the devicetree.
Sure but just the phandle isn't enough.
We also need the frequency and the parent.

For the frequency the driver could, and maybe should, set it (and indeed 
I've submitted a patch for this for the sgtl5000 driver).

But IMHO it's not the driver's business to be setting the parent clock 
(the driver just gets a phandle and
shouldn't know if it can be reparented).

Maybe if and when the clock framework learns how to reparent clocks 
during set_rate() this problem may go away but
I'm not entirely comfortable with that - I'm sure there are cases where 
it will be better to manually specify the parent clock.

> I know that we currently have no place to put such information. There
> recently was a similar discussion with CMA descriptions in the
> devicetree and I remember several other discussions of the same type,
> all of which ended at the dont-know-but-not-in-the-devicetree point.
Yes, I looked up the CMA discussion which, AFAICT ended with a proposition
to use chosen to which there was no reply :(

I quite understand (and agree with) not wanting to scatter linux 
specific configuration
data all over the DT but, given that there are clearly usecases for this 
type of
configuration,  I fail to see the conceptual difference between:

1) Pure hardware DT plus a completely seperate "config-tree"
2) DT with a configuration node ("chosen" or probably better something 
like "linux-config")

Except that 1) requires more work to implement.
Even if the DT parser and tooling were reused it would still require:
* A means of passing another blob to the kernel
* A means of providing the parsed data to drivers

Both of these are obtained "for free" with solution 2), whilst still 
retaining the
separation of the tree into "hardware" and "configuration"

It would be possible for hardware vendors to ship the pure hardware part 
and then
add the configuration node either at runtime in the bootloader or by a 
preprocessing
tool "dtcat"?

Other OSs would simply ignore the "linux-config" node (and could add 
"bsd-config" node too)

Just my 2 centimes,

Martin
