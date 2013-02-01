From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 1 Feb 2013 15:14:10 +0000
Subject: [PATCH v4 00/13] ARM LPAE Fixes - Part 1
In-Reply-To: <510BDAED.8060805@ti.com>
References: <1359669512-31276-1-git-send-email-cyril@ti.com>
 <alpine.LFD.2.02.1301312252230.6300@xanadu.home> <510BDAED.8060805@ti.com>
Message-ID: <20130201151410.GR23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 01, 2013 at 10:10:37AM -0500, Cyril Chemparathy wrote:
> With this, I ran simple network and filesystem performance tests to  
> compare the code-patching vs. non-code-patching variants.  These tests  
> didn't yield any significant performance difference between the two on  
> an ARMv7 (Cortex-A8) platform.

It's not network and fs activity that this kind of stuff is likely to
show up in, but more to do with walking pages tables and the like -
remember that page tables are stored using physical addresses, and any
walks of them have to convert those physical addresses to virtual
addresses and back again.

So, things like page scanning for eviction (eg, page aging, page
faults even those which just re-use a page from the page cache) have
to use the v:p / p:v translation macros.
