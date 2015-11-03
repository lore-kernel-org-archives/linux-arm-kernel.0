From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 03 Nov 2015 09:40:52 +0100
Subject: [PATCH v2 2/5] mfd: ts4800-syscon: add driver for TS-4800 syscon
In-Reply-To: <20151103083923.GD3503@x1>
References: <1446150450-22093-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <20151103083817.GC3503@x1> <20151103083923.GD3503@x1>
Message-ID: <4911273.Q2mbQ2gvpn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 November 2015 08:39:23 Lee Jones wrote:
> On Tue, 03 Nov 2015, Lee Jones wrote:
> 
> > On Mon, 02 Nov 2015, Damien Riegel wrote:
> > > On Mon, Nov 02, 2015 at 09:12:53AM +0000, Lee Jones wrote:
> > > > [Cc'ing Arnd]
> > > > 
> > > > On Fri, 30 Oct 2015, Damien Riegel wrote:
> > > > > On Fri, Oct 30, 2015 at 05:56:56PM +0000, Lee Jones wrote:
> > > > > > On Thu, 29 Oct 2015, Damien Riegel wrote:
> > > > > > 
> > > > > > > Driver for TS-4800 syscon. These registers belong to a FPGA that is
> > > > > > > memory mapped and are used for counters, enable various IPs in the FPGA,
> > > > > > > control LEDs, control IOs, etc.
> > > > > > > 
> > > > > > > Currently, only the watchdog is handled.
> > > > > > 
> > > > > > Why do you require your own syscon driver?
> > > > > > 
> > > > > > What's wrong with the generic one?
> > > > > > 
> > > > > 
> > > > > The generic one uses a regmap_config with reg_stride set to 4 and val_bits
> > > > > to 32.
> > > > > 
> > > > > TS-4800 syscon registers are 16-bit wide and must be accessed with 16
> > > > > bit read and writes:
> > > > > http://wiki.embeddedarm.com/wiki/TS-4800#Syscon
> > > > > 
> > > > > I will address the other issues in the next version (split commit,
> > > > > license issue, style, and superfluous remove).
> > > > 
> > > > The Syscon driver was written to be generic so that each
> > > > vendor/platform didn't require their own incarnation.  How unique is
> > > > the TS-4800?
> > > > 
> > > > Perhaps it might be better to supply a generic 16 bit Syscon for
> > > > devices akin to the TS-4800?
> > > 
> > > The TS-4800 syscon could use a generic 16-bit syscon. There is nothing
> > > specific that requires a driver besides that.
> > > 
> > > We could add some optional properties to the generic syscon node to
> > > configure reg_bits, val_bits, and reg_stride (and pad_bits ?). Would
> > > that be a good solution ?
> > 
> > Without looking at the ramifications of such an addition, the premise
> > sounds good to me.  So long as the current behaviour remains the
> > default.
> 
> Perhaps a "syscon-16bit" compatible might be in order?
> 
> 

I think a 'buswidth=<16>;' property in addition to 'compatible="syscon"'
is more in line with what other subsystems do.

	Arnd
