From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 28 Oct 2017 09:47:30 +0100
Subject: [RFC PATCH 0/2] arm64: optional paranoid __{get,put}_user checks
In-Reply-To: <20171027154113.GA13737@arm.com>
References: <20171026090942.7041-1-mark.rutland@arm.com>
 <20171027154113.GA13737@arm.com>
Message-ID: <20171028084729.GL20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 27, 2017 at 04:41:13PM +0100, Will Deacon wrote:
> Probably a stupid question, but why not just move the access_ok check
> into __{get,put}_user and remove it from {get,put}_user? We can also
> then move the uaccess_{enable,disable}_not_uao calls out from the __
> variants so that we can implement user_access_{begin,end}.

The intent of __{get,put}_user() is to have a fast accessor compared
to {get,put}_user() which does all the full checks.

However, with the uaccess stuff we have now by default, I don't think
it makes much sense - maybe we're better off using copy_{to,from}_user()
in those code paths and fixing up the struct in kernel space rather than
__{get,put}_user()?

I suspect that if we do have the full checks in __{get,put}_user() that
makes the case stronger for doing that - and maybe killing the __
accessors entirely.

Take a look at kernel/signal.c to see a typical usage of the __
accessors.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
