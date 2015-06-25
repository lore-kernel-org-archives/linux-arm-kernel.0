From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 25 Jun 2015 19:49:13 +0200
Subject: [RFC PATCH v6 2/2] nvmem: Add Vybrid OCOTP and OCROM support
In-Reply-To: <558A79B3.1010205@linaro.org>
References: <cover.1435066190.git.maitysanchayan@gmail.com>
 <b4a52f6c229bdabbfe9d21c03cb04593dde33ec4.1435066190.git.maitysanchayan@gmail.com>
 <20150624083529.GY2266@lukather> <558A79B3.1010205@linaro.org>
Message-ID: <20150625174913.GG2266@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 24, 2015 at 10:34:43AM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 24/06/15 09:35, Maxime Ripard wrote:
> >Hi,
> >
> >On Tue, Jun 23, 2015 at 07:14:57PM +0530, Sanchayan Maity wrote:
> >>+static struct nvmem_config ocotp_config = {
> >>+	.name = "soc_id",
> >>+};
> >>+
> >>+static struct nvmem_config rom_config = {
> >>+	.name = "rom_rev",
> >>+};
> >
> >Srinivas, shouldn't we use the DT to setup these names, just like
> >clock-output-names does for example?
>
> These are the provider names, which would not change per board, I
> think. :-)

Except that my understanding is that it will fallback to the list of
these names if there's nothing in the DT.

> On the other hand if we are going to use generic drivers like
> "simple-mmio-nvmem" then having name DT bindings makes sense.
> 
> IMO, clock-output-names are analogous to nvmem consumers, which are
> obviously getting there names from cell node name ATM.

clock-output-names is the name of the clock itself within the
system. clock-names is the name of the clock to the consumer.

So, it looks like nvmem-names is strictly equivalent to clock-names
(local to the device, doesn't affect the name of the provider within
in the system) which makes perfect sense, but we don't really have an
equivalent to clock-output-names but this one (global range, defines
the name of the provider globally), which is fine for specific
devices, whose format and functions are very standardized, like those
EEPROMs, but is not so much for other more generic devices, like the
mmio-nvmem driver you were talking about, or ...

> >This is very likely to change from one board to another, and defining
> >a new compatible and/or driver for each board seems a bit fishy.
> >
> Do you have any particular example in mind, where the provider names would
> change per board?

... AT24, AT25, and all those generic, off-the-SoC EEPROMs, where each
board vendor is pretty much free to do whatever he wants with it.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150625/eff621b6/attachment-0001.sig>
