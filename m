From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 24 Apr 2012 19:03:26 -0600 (MDT)
Subject: [PATCH-V3 3/3] ARM: OMAP3+: clock33xx: Add AM33XX clock tree data
In-Reply-To: <1333458578-23073-4-git-send-email-hvaibhav@ti.com>
References: <1333458578-23073-1-git-send-email-hvaibhav@ti.com>
 <1333458578-23073-4-git-send-email-hvaibhav@ti.com>
Message-ID: <alpine.DEB.2.00.1204241857260.24864@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Vaibhav, Afzal, Vaibhav,

On Tue, 3 Apr 2012, Vaibhav Hiremath wrote:

> AM33XX clock implementation is different than any existing OMAP
> family of devices. Although DPLL module is similar to OMAP4
> device, but the usage is very much different than OMAP4.
> AM33XX has different peripheral set and each module gets
> integrated to the clock framework differently than OMAP
> family of devices.
> 
> This patch adds full Clock tree data for AM33XX family
> of devices and also integrates it into existing OMAP framework.

What do you think about the possibility of removing all of the leaf clocks
that have AM33XX_MODULEMODE_SWCTRL as their .enable_bit, assuming there 
are no .fixed_div or .clksel* fields associated with the clocks?

In theory, I don't think they are needed.  The drivers should be using 
runtime PM, and that should enable and disable the module via the hwmod 
code, rather than the clock code.

Of course some clocks would still be needed for the main_clk fields for 
the hwmods, but the hwmods should be able to use the leaf clock's parent 
clocks for that.

That would save quite a few lines of data.  And I think Beno?t is planning 
to do that for OMAP4+.

What do you think?


- Paul
