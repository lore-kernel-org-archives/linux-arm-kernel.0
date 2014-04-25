From: tony@atomide.com (Tony Lindgren)
Date: Fri, 25 Apr 2014 09:46:14 -0700
Subject: [PATCH] ARM: dts: am437x-gp-evm: Do not reset gpio5
In-Reply-To: <20140417163407.GB23385@atomide.com>
References: <1395379213-15451-1-git-send-email-lokeshvutla@ti.com>
 <53319A7D.1060904@ti.com> <20140417163407.GB23385@atomide.com>
Message-ID: <20140425164614.GE20807@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [140417 09:34]:
> * Nishanth Menon <nm@ti.com> [140325 08:05]:
> > On 03/21/2014 12:20 AM, Lokesh Vutla wrote:
> > > From: Dave Gerlach <d-gerlach@ti.com>
> > > 
> > > Do not reset GPIO5 at boot-up because GPIO5_7 is used
> > > on AM437x GP-EVM to control VTT regulators on DDR3.
> > > Without this some GP-EVM boards will fail to boot because
> > > of DDR3 corruption.
> 
> How funny :)
> 
> Ideally we would be able to specify which GPIO pins should
> maintain their state during the boot.
> 
> AFAIK, this patch currently means that the kernel has no idea
> what state the whole GPIO bank is in. At minimum we should
> parse the GPIO bank state so the kernel knows it and then it
> should be safe to set the no reset flag.
> 
> So for the workaround, can you guys please try to see test
> if the old mux trick in the bootloader works to mux the pin
> into something PIN_INPUT_PULLUP | MUX_MODE7? Or a PULLDOWN
> depending on the direction naturally. That would allow
> leaving out the GPIO completely from this.

OK so no safe mode as MUX_MODE7 on am335x. So based on the
tests done by Dave on various GPIO banks without the reset,
this seems OK to do. So applying into omap-for-v3.15/fixes-v2
to get the board booting properly.

Naturally this is not a reason to stop further work on making
sure the GPIO driver actually knows what state the bank is
as suggested by Felipe.

Tony
