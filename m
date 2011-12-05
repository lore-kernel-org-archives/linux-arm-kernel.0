From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 05 Dec 2011 17:24:40 +0000
Subject: [PATCH v3 5/5] ARM: vexpress: DT-based support for CoreTiles
 Express A5x2 and A9x4
In-Reply-To: <20111201122144.GD2026@localhost.localdomain>
References: <1322579473-8804-1-git-send-email-pawel.moll@arm.com>
 <1322579473-8804-6-git-send-email-pawel.moll@arm.com>
 <20111129164050.GC2829@localhost.localdomain>
 <1322678364.3180.34.camel@hornet.cambridge.arm.com>
 <20111201122144.GD2026@localhost.localdomain>
Message-ID: <1323105880.3147.55.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-12-01 at 12:21 +0000, Dave Martin wrote:
> That will work, but we should make it clear that this option does not
> provide board support all by itself, maybe:
> 
> "Provides common dependencies for VE platforms based on Cortex-A5 or
> Cortex-A9 processors.  In order to build a working kernel, you must also
> enable one or more core tile support options."

Actually, the longer I think about it the more it seems that this code
doesn't support a particular tile, but rather a particular processor...
After all _exactly_ the same code will work with any SMM based on FPGA
Logic Tile (V2F-2XV6), even if it was very different from the coretile,
eg. A9 with RS1 memory map. In such case making it compatible with
V2P-CA9 would be logically wrong...

I have an idea of spinning the compatible values again to get something
like that:

compatible = "arm,vexpress-v2p-ca5s", "arm,vexpress-cortex_a5";
compatible = "arm,vexpress-v2p-ca9", "arm,vexpress-cortex_a9";
compatible = "arm,vexpress-v2p-ca15", "arm,vexpress-cortex_a15";

and the board code would simply have:

static const char *dt_ca5_ca9_dt_match[] __initdata = {
	"arm,vexpress-cortex_a5",
	"arm,vexpress-cortex_a9",
	NULL,
};

I've already tried that (adding tree for A15 tile as well) and it
actually simplifies a lot of things. I'll clean the patches, test them
and post tomorrow. Of course if anyone thinks it's a bad idea I'm happy
to get back to where we were last week.

Cheers!

Pawe?
