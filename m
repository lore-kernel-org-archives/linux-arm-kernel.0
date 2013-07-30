From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Tue, 30 Jul 2013 09:14:42 -0400
Subject: Defining schemas for Device Tree
In-Reply-To: <20130730102511.GM9858@sirena.org.uk>
References: <2469263.vMN09Q7Tzi@flatron> <51F6E30B.7060106@wwwdotorg.org>
 <CAKON4Oy6+7ZpAG5emAm_c62t=o_LXM7PcbK-z5YL_qx=r0AKqQ@mail.gmail.com>
 <1706112.Xn49tiCSKF@thinkpad>
 <CAKON4OwNrhmvnznyeD-igtZ5nsm7atUZoa0RJttN5kmwKubaDg@mail.gmail.com>
 <20130730102511.GM9858@sirena.org.uk>
Message-ID: <CAKON4OxSr13VPJkwkvuF91BwFXfQ6fkAuVeEsiA=JK3cuzmavQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 6:25 AM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jul 29, 2013 at 08:30:29PM -0400, jonsmirl at gmail.com wrote:
>
>> This...
>> tx-dma-channel = <&pdma0 7>; /* preliminary */
>> rx-dma-channel = <&pdma0 6>; /* preliminary */
>
>> Probably should be
>> dmas = <&pdma0 7>,<&pdma0 6>;
>> dma-names = "tx", "rx";
>
> It should be - the latter is the generic DMA binding.  There's a lot of
> bindings in the kernel that predate that but people are currently
> working to transfer over, this is one of the examples of instability
> that everyone is talking about.

Is something similar to this possible in device tree syntax?
dmas =  <"tx" &pdma0 7>,  <"rx"  &pdma0 6>;

That's an example of something the quirks system could do. We can make
a quirk for these older definitions and then map them to the new and
improved kernel schema.   And you only need to make quirks for devices
that have been deployed with dtb in boot loaders. There is no need to
accept older dtbs that were appended to the kernel.

The schema system provides the class description for the generic SPI
controller. This generic SPI controller is only generic in the sense
that all of the device syntax is as regular as possible. Each of the
actual SPI controller device drivers is completely different. But now
someone implementing a new SPI controller would have a single DT
example to follow - the schema for the generic SPI controller.

I don't think the quirks system will be that bad to work with. We will
quickly develop a list of device trees that have been deployed in
flash and need to be handled by the quirk system They are already
handled right now by code spread throughout the kernel. Quirks would
just collect everything into an init time segment where it can easily
be discarded.

Also consider that someone like Microsoft might ship SurfaceRT tablets
with a MS specific device tree format. That could be handled by a
quirk. But it would be even better if Microsoft used the generic
schema and followed its format. Right now that schema isn't written
down.

-- 
Jon Smirl
jonsmirl at gmail.com
