From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 Oct 2013 11:08:40 +0100
Subject: [PATCH] pinctrl: phandle entries will be applied sequentially
In-Reply-To: <20131010072624.GA29191@S2101-09.ap.freescale.net>
References: <1381297324-19006-1-git-send-email-shawn.guo@linaro.org>
 <CACRpkdazPK6SNg9PdWCrjB8nwho1rCueumJWAN=STXdN1zNnMA@mail.gmail.com>
 <20131010072624.GA29191@S2101-09.ap.freescale.net>
Message-ID: <20131010100840.GP25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 10, 2013 at 03:26:26PM +0800, Shawn Guo wrote:
> However, my patch is talking about a different thing.  For example, we
> have a device whose pinctrl-0 consists of two phandle entries that point
> to pin configuration nodes foo and bar.
> 
> 	pinctrl-0 = <&foo &bar>;
> 
> 	foo {
> 		...
> 	};
> 
> 	bar {
> 		...
> 	};
> 
> My patch only wants to make it clear that the configuration specified by
> node foo will be applied to pin controller first, and the configuration
> defined in node bar will be applied after that.  When both nodes have
> configuration for a pin, these two configs for the same pin go to two
> different pinctrl_setting structures.  And these two pinctrl_settings
> can not be applied accumulatedly but only sequentially.  That's what my
> patch talks about.

I still say this is a potentially dangerous thing, and in my case of
overriding the DAT3 pull-sense, it will cause the pin to glitch if
nothing is connected to it.

So even if you do get this clarified, I am *not* happy to change my
patch.
