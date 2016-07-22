From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 22 Jul 2016 14:33:17 +0900
Subject: [PATCH v1 3/4] arm64: Add arm64 kexec support
In-Reply-To: <20160722040842.GA14911@localhost.localdomain>
References: <cover.1468970114.git.geoff@infradead.org>
 <9ed513fd44a19b2f49b4da99477cedfff7341bf0.1468970114.git.geoff@infradead.org>
 <20160720153859.GG24691@leverpostej>
 <1469042361.2977.90.camel@infradead.org>
 <20160721103120.GB20559@leverpostej> <5790A902.6070601@arm.com>
 <1469137776.2977.128.camel@infradead.org>
 <20160722040842.GA14911@localhost.localdomain>
Message-ID: <20160722053316.GO20774@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 22, 2016 at 09:38:42AM +0530, Pratyush Anand wrote:
> On 21/07/2016:02:49:36 PM, Geoff Levand wrote:
> > On Thu, 2016-07-21 at 11:50 +0100, Robin Murphy wrote:
> > > The Exynos UART (drivers/tty/serial/samsung.c) is one which comes to
> > > mind as definitely existing, and on arm64 systems to boot. The TX
> > > register is at offset 0x20 there.
> > 
> > Here's what I came up with.
> > 
> > 
> > +	struct data {const char *name; int tx_offset;};
> > +	static const struct data ok_list[] = {
> > +	/*	{"armada-3700-uart", ?},	*/
> > +		{"exynos4210-uart", 0x20},
> > +	/*	{"ls1021a-lpuart", ?},		*/
> > +	/*	{"meson-uart", ?},		*/
> > +	/*	{"mt6577-uart", ?},		*/
> > +		{"ns16550", 0},
> > +		{"ns16550a", 0},
> > +		{"pl011", 0},
> > +		{NULL, 0}
> > +	};
> 
> sinc functionality is just to debug the scenario when something goes wrong in
> purgatory. IMHO, it should be disabled by default.

+1

-Takahiro AKASHI

> So, why not to keep it as
> simple as possible. Its a low level debugging mainly for developer, so user
> should know the absolute address. Therefore, I think no need to parse earlycon
> or earlyprintk from command line.  Whatever user passes in --port can be treated
> as address of TX register. If TX offset is 0x20, then user can pass --port as
> base+0x20. Additionally, we can pass TX register width as well. So what about
> something like "--port=0x1c020000,1" where 0x1c020000 is TX register address and
> 1 says about it's width in bytes.
> 
> ~Pratyush
