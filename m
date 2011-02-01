From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Tue, 1 Feb 2011 12:56:10 +0100
Subject: [PATCH] mmci: restrict DMA usage to large,
	even multiblock	transfers
In-Reply-To: <20110201114522.GD31216@n2100.arm.linux.org.uk>
References: <1296556873-2730-1-git-send-email-linus.walleij@linaro.org>
	<20110201105408.GA31216@n2100.arm.linux.org.uk>
	<4D47EFB6.5090509@stericsson.com>
	<20110201114522.GD31216@n2100.arm.linux.org.uk>
Message-ID: <4D47F4DA.8090802@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Tue, Feb 01, 2011 at 12:34:14PM +0100, Ulf Hansson wrote:
>> Getting FIFO overrun/underruns is then as of today already the case when  
>> running PIO for ARM primecell. To prevent this; you probably now that  
>> already, hardware flow control is implemented in ST version of the ARM  
>> primecell.
> 
> That really doesn't matter.  This driver is not specific to the ST
> version.  It has to work on other versions as well.
> 
> I would like to see some further discussion on the unresolved issue of
> the burst size setting - the discussion between myself and Linus died
> without any apparant conclusion.  Linus tried to get some knowledgable
> people from ST involved but no one ever followed up.
> 
> What I gathered from the discussion was that the additional DMA enable
> bit found in ST variants should not be set as this changes the behaviour
> of the DMA requests to be incompatible with the DMA controller
> requirements.  With that bit clear, I see no problem with leaving the
> burst threshold set at the half FIFO size.
> 
> That then makes avoiding DMA for requests below a specific size an
> optimization issue and nothing more.
> 

OK, I see your point - I agree. This should then be done as a two step 
approach. One for making sure DMA transfers is setup on data transfers 
that is not too small to handle by any reasons. Second as an performance 
optimization, which most likely means an increased threshold value that 
could "override" the earlier one.

/Ulf Hansson
