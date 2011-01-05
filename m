From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Jan 2011 20:26:45 +0000
Subject: [PATCH] arm: mm: Poison freed init memory
In-Reply-To: <1294256845-29517-1-git-send-email-sboyd@codeaurora.org>
References: <1294256845-29517-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20110105202645.GL8638@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 05, 2011 at 11:47:25AM -0800, Stephen Boyd wrote:
> Poisoning __init marked memory can be useful when tracking down
> obscure memory corruption bugs. When a pointer is 0xCCCCCCCC in an

That's a bad idea for a value.  With a 3GB page offset and 256MB or
more memory, accesses to such an address will always succeed.

There's two things to be considered when selecting a possible poison
value:

1. what value is guaranteed to provoke an undefined instruction exception?
2. what value when used as an address and dereferenced is mostly always
   going to abort?

1 for ARM mode implies an 0xe7fXXXfX value.  For Thumb mode 0xdeXX.  We
use this space for breakpoints.

2 unfortunately depends on the platform. 
