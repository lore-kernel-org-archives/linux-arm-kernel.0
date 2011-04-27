From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 27 Apr 2011 10:55:33 -0400 (EDT)
Subject: [PATCH 3/3] ARM: zImage: fix issues with missing GOT entries
	for some global variables
In-Reply-To: <20110427085505.GM17290@n2100.arm.linux.org.uk>
References: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org>
	<1303272904-31392-4-git-send-email-nicolas.pitre@linaro.org>
	<20110427085505.GM17290@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1104271048250.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Apr 2011, Russell King - ARM Linux wrote:

> On Wed, Apr 20, 2011 at 12:15:04AM -0400, Nicolas Pitre wrote:
> > Many architecture specific versions of uncompress.h make use of global
> > variables marked static.  In such case the GOT is bypassed and the
> > code in head.S can't relocate them.
> 
> No, we're not doing this - it creates confusion with static variables
> declared inside functions.

Yes, but in such case those variables would be allocated to the .data 
section, and we're already discarding .data up front to prevent its 
usage.  So there might not be static variables within functions used 
now, unless they're also const.

However I've discovered that static variables within functions with an 
initial value of zero are instead allocated in the .bss section, and 
always using a GOTOFF relocation.  So those can't be used either and 
right now there is nothing preventing them.

Anyway I've discarded this patch as it also makes problems with 
architecture code including standard kernel header files containing 
static inline functions.

> It's far easier to audit for the presence of 'static' than it is for
> the possibility of an ignored 'static' inside a function body.
> 
> Ensure that the uncompress.h header files are right.

Exact.  And I now have a patch failing the build if the wrong usage is 
made ending up in GOTOFF relocs that we can't support which is even 
better than manual auditing.


Nicolas
