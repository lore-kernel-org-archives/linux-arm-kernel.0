From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Dec 2014 20:08:59 +0100
Subject: [PATCH 1/2] tty: serial: 8250_mtk: Add earlycon
In-Reply-To: <1419827096.6184.128.camel@mtksdaap41>
References: <1418891601-53769-1-git-send-email-eddie.huang@mediatek.com>
 <CAL_JsqKp+1ZWPK4rB4_vxrx-dtNCy7Hc3S67uQ9VHdAby8erjg@mail.gmail.com>
 <1419827096.6184.128.camel@mtksdaap41>
Message-ID: <16342339.NQnBcp9YuE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 December 2014 12:24:56 Eddie Huang wrote:
> Hi Rob,
> 
> On Fri, 2014-12-26 at 15:24 -0600, Rob Herring wrote:
> > On Thu, Dec 18, 2014 at 2:33 AM, Eddie Huang <eddie.huang@mediatek.com> wrote:
> > > Mediatek UART has highspeed register, but 8250_early.c doesn't
> > > support this, so add earlycon in 8250_mtk.c
> > 
> > I don't see any highspeed register setup here. More generically,
> > aren't you just skipping any UART setup? That may be useful on other
> > platforms with 8250s, too. With the kernel command line version, you
> > could perhaps add a "noinit" flag. The DT case is harder, and I'm not
> > sure how we should handle that. We could perhaps add a
> > "stdout-path-initialized" flag to chosen.
> > 
> 
> Yes, I skipped UART setup same as msm_serial.c and amba-pl011.c
> (although they are standalone serial driver). Just like earlyprintk, I
> think earlycon should reuse UART setting in loader. Since some other
> platforms with 8250 already depend on this, it's ok to add flags to
> distinguish whether 8250 earlycon driver should init hw or not. As you
> said, add "noinit" flag is simple, but "stdout-path-initialized" need
> more discussion. 

It would definitely be nice to have consistent behavior, and I also
think it would be good to default to noinit for the console, because that
is the more likely case. Basically anything that can do debug_ll on ARM
already depends on this behavior because the debug_ll infrastructure
does not initialize the console before using it. I believe the same
is true for powerpc udbg.

	Arnd
