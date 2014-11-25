From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Nov 2014 11:33:57 +0100
Subject: [PATCH v4 1/2] ARM: keystone: pm: switch to use generic pm domains
In-Reply-To: <20141125064406.12298.57929@quantum>
References: <1415631557-22897-1-git-send-email-grygorii.strashko@ti.com>
 <2997659.fTX2lvxXfH@wuerfel> <20141125064406.12298.57929@quantum>
Message-ID: <15074721.IbfeeI3ajE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 November 2014 22:44:06 Mike Turquette wrote:
> Quoting Arnd Bergmann (2014-11-24 02:50:28)
> > 
> > Could the driver maybe identify the clocks that it wants to manage itself
> > to the pm-domain code? If it's safe for a device to have the clock turned
> > on at the default rate before loading the driver, any device that is connected
> > to the simple clk-pm-domain code could have all its clocks start out as
> > owned by the pm-domain, but then claim the clocks it needs to reprogram for
> > itself and take them out of the pmdomain.
> 
> I was thinking along similar lines. The functional versus optional stuff
> is really a property of the consuming device, not the clock signal
> itself.
> 
> Instead of adding a new property to the clock binding (e.g. fck-clocks
> or optional-clocks), could we simply wrap those lists of clocks in
> another node? E.g:
> 
> mandatory-clocks {
>        clocks = <&papllclk>, <&clkcpgmac>;
>        clock-names = "clk_pa", "clk_cpgmac";
> }
> 
> clocks = <&papllclk>, <&clkcpgmac>, <&chipclk12>;
>        clocks = <&clkcpgmac>;
>        clock-names = "cpsw_cpts_rft_clk";
> }
> 
> I'm showing my DT ignorance on this one. I haven't really thought
> through how these sub-nodes would work with of_clk_* handlers in
> drivers/clk/clkdev.c.

I'm not sure I even understand what you intended the example to look
like, it does't parse ;-)

My point above was completely different, the suggestion I made was
to not classify the clocks in DT at all, but to leave it all in
the client driver.

	Arnd
