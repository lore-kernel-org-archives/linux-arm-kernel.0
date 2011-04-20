From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 20 Apr 2011 09:17:04 -0400 (EDT)
Subject: [PATCH 3/3] ARM: zImage: fix issues with missing GOT entries
	for some global variables
In-Reply-To: <alpine.LFD.2.00.1104200901300.24613@xanadu.home>
References: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org>
	<1303272904-31392-4-git-send-email-nicolas.pitre@linaro.org>
	<20110420084234.GV31131@pengutronix.de>
	<alpine.LFD.2.00.1104200826550.24613@xanadu.home>
	<20110420125222.GE1965@S2100-06.ap.freescale.net>
	<alpine.LFD.2.00.1104200901300.24613@xanadu.home>
Message-ID: <alpine.LFD.2.00.1104200911070.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Apr 2011, Nicolas Pitre wrote:

> On Wed, 20 Apr 2011, Shawn Guo wrote:
> 
> > Though I'm unsure if it realistically exists, what if it's a static
> > variable inside a function?  It's actually changing something, right?
> 
> Right.  In that case the variable is allocated to the .data section, but 
> we explicitly discard .data at link time to prevent a successful build.

Sorry, more clarification is needed here.

The patch changing all occurrences of "static" into nothing would break 
code using static variables within functions.  I just hope that no one 
is using local static variables in their uncompress.h file.

And local static variables are always using GOTOFF relocations which is 
what we want to avoid in the first place.

The conclusion is that no one should be using local static variables in 
code linked by the kernel decompressor, unless those variables are also 
marked const.


Nicolas
