From: snjw23@gmail.com (Sylwester Nawrocki)
Date: Tue, 06 Sep 2011 23:08:15 +0200
Subject: [PATCH v2] [media] at91: add code to initialize and manage the
	ISI_MCK for Atmel ISI driver.
In-Reply-To: <20110906200512.GA15083@game.jcrosoft.org>
References: <1315288601-22384-1-git-send-email-josh.wu@atmel.com>	<Pine.LNX.4.64.1109060803590.14818@axis700.grange>
	<20110906200512.GA15083@game.jcrosoft.org>
Message-ID: <4E668BBF.4020600@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/2011 10:05 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> I'm not entirely sure on this one, but as we had a similar situation with
>> clocks, we decided to extablish the clock hierarchy in the board code, and
>> only deal with the actual device clocks in the driver itself. I.e., we
>> moved all clk_set_parent() and setting up the parent clock into the board.
>> And I do think, this makes more sense, than doing this in the driver, not
>> all users of this driver will need to manage the parent clock, right?
>
> I don't like to manage the clock in the board except if it's manadatory otherwise
> we manage this at soc level
> 
> the driver does not have to manage the clock hierachy or detail implementation
> but manage the clock enable/disable and speed depending on it's need

We had a similar problem in the past and we ended up having the boot loader
setting up the parent clock for the device clock. The driver only controls clock
gating and sets its clock frequency based on an internal IP version information,
derived from the SoC revision.

AFAIK there is also a generic API at the runtime PM core so the driver can
register the clock(s) with it and only use pm_runtime_clk_* calls afterwards.

--
Regards,
Sylwester
