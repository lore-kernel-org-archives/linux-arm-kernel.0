From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 23 Feb 2018 16:51:04 +0100
Subject: [v2,1/1] ARM: orion5x: use mac_pton() helper
In-Reply-To: <1519399128.10722.111.camel@linux.intel.com>
References: <1443795153-40836-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <099870d3-e2bd-aad9-d526-5438596bb575@the2masters.de>
 <20180222214237.GH28112@lunn.ch>
 <bce65520-7f11-49f5-c806-59e508001321@the2masters.de>
 <20180222233457.GA6052@lunn.ch>
 <1519380573.10722.94.camel@linux.intel.com>
 <20180223150147.GA17857@lunn.ch>
 <1519399128.10722.111.camel@linux.intel.com>
Message-ID: <20180223155104.GB6052@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Hi Andy
> > 
> > Thanks for pointing this patch out.
> > 
> > What is the advantage of doing to the strnlen()? As Stefan says, the
> > code which follows will detect a short string, in that a NULL is not
> > in [0-9a-f], nor a : .
> 
> I'm not sure, but my understanding is that, the strchr() call in the
> original code or isxdigit() in the follow up change will trash a cache a
> bit. Besides that some of the users are (often?) supplying empty strings
> to convert from, and in this case makes sense to bail out fast.

Is this function being called on a hot path? In the case which is
crashing, it is during early boot, and it gets called ~ 40 times, in
quick succession. The first call to isxdigit() will need to fetch part
of the _ctype array into cache, but since the caller is only walking
memory, i hope it is still in cache for the next call to mac_pton().

	Andrew
