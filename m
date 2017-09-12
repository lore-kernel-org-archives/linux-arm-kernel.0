From: will.deacon@arm.com (Will Deacon)
Date: Wed, 13 Sep 2017 00:13:46 +0100
Subject: [PATCH 0/2] arm64: Cleanups if modules are disabled
In-Reply-To: <1504634813-29554-1-git-send-email-geert+renesas@glider.be>
References: <1504634813-29554-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170912231345.GF10675@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 05, 2017 at 08:06:51PM +0200, Geert Uytterhoeven wrote:
> 	Hi Catalin, Will,
> 
> This patch series disables printing and reservation of virtual memory for
> modules if module support is disabled.

If we're going to do this, then we should probably also update the pt
dumping code (mm/dump.c) to avoid dumping the modules area too.

There are also some weird consequences of defining MODULES_VSIZE to be 0,
since we'll end up registering a zero-length region with KASAN and
calculating a bogus module_alloc_base in the kaslr code. This might all be
harmless, but it feels like we're laying down some tripwires for ourselves
that I'd rather avoid doing.

Will
