From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 28 Jan 2013 07:40:09 -0300
Subject: [RFC V2 PATCH 0/8] ARM: kirkwood: cleanup DT conversion
In-Reply-To: <20130125183407.GC7393@obsidianresearch.com>
References: <cover.1358983578.git.jason@lakedaemon.net>
 <cover.1359091286.git.jason@lakedaemon.net>
 <201301251115.47480.arnd@arndb.de>
 <20130125125214.GI1758@titan.lakedaemon.net>
 <CABJ1b_QaTBLgGASTs2yi435jR=LepN-iY97xTLXAu1hZw69Wuw@mail.gmail.com>
 <20130125183407.GC7393@obsidianresearch.com>
Message-ID: <20130128104008.GA5170@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Fri, Jan 25, 2013 at 11:34:07AM -0700, Jason Gunthorpe wrote:
> On Fri, Jan 25, 2013 at 04:03:29PM +0100, Sebastian Hesselbarth wrote:
> > On Fri, Jan 25, 2013 at 1:52 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> > > Once I have the mv643xx_eth binding working reliably, preferably with
> > > mvmdio, I'll take a look at removing the last board-*.c files.  If the
> > > stars align, we'll get it all done for v3.9.
> > >
> > > The only big thing left will be pcie.
> 
> > there is also addr_map that we haven't thought about yet. Is it supposed
> > to be configurable through DT or do we leave it as "linux wants it that way"?
> 
> FWIW, this was a pain + surprise for us when we started out. The
> address map Linux wants is not the same as the device power on
> default, and the Linux mapping is hardwired into the kernel :(
> 
> I would be happy to see the address map setup be more flexible and
> done via DT. It would be a bit of a pain to change, but via DT each
> decoded window could be described as a bus with a ranges and an OF
> address map driver could directly setup the windows to match those DT
> nodes. Something like this, repeated for each window:
> 
>         // MBUS Decoder window for NAND
>         nand at f4000000 {
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>                 compatible = "simple-bus", "marvell,orion-mbus";
> 		mbus-target = 0xXXXXX;
>                 ranges = <0 0xf4000000 0x10000>;
> 
>                 nand at 0 {
>                         cle = <0>;
>                         ale = <1>;
>                         bank-width = <1>;
>                         chip-delay = <50>;
>                         compatible = "marvell,orion-nand";
>                         reg = <0x0 0x400>;
>                 };
>         };
> 

This is a nice idea.

I have a few questions, though.

1. Are you sure we should use "ranges" property?
In this case it's not an address translation but rather
and address window configuration.
If I got this right, in this case child device address
space is the same as its parent. So, it's not an actual translation.

I would think we could add a new "windows" property to reflect
address window configuration.

2. Also, If we use "ranges" property. How would that work?
By reading the property in the addr-map driver or
by somehow improving on of_bus to include this new kind of busses?

Thanks,

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
