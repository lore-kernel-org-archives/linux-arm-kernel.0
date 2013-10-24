From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Oct 2013 14:03:46 +0100
Subject: [RFC 0/3] Allow CONFIG_DEBUG_SET_MODULE_RONX to be used on ARM
In-Reply-To: <1371057810-3189-1-git-send-email-lauraa@codeaurora.org>
References: <1371057810-3189-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <20131024130346.GA31369@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 10:23:27AM -0700, Laura Abbott wrote:
> Hi,
> 
> This is an RFC to allow CONFIG_DEBUG_SET_MODULE_RONX to be used on ARM. The
> current config description from x86 describes it best:
> 
> 	This option helps catch unintended modifications to loadable
> 	kernel module's text and read-only data. It also prevents execution
> 	of module data. Such protection may interfere with run-time code
> 	patching and dynamic kernel tracing - and they might also protect
> 	against certain classes of kernel exploits.
> 
> ARM was missing a few functions to modify the page tables so those have been
> added. I believe modules are always mapped with pages so changing them at map
> time should be acceptable. Comments/concerns are appreciated.

I've just tested this and it seems to work:

---[ Modules ]---
0xbf000000-0xbf002000           8K     ro x      MEM/CACHED/WBRA
0xbf002000-0xbf003000           4K     ro NX     MEM/CACHED/WBRA
0xbf003000-0xbf005000           8K     RW NX     MEM/CACHED/WBRA
0xbf009000-0xbf00b000           8K     ro x      MEM/CACHED/WBRA
0xbf00b000-0xbf00c000           4K     ro NX     MEM/CACHED/WBRA
0xbf00c000-0xbf00e000           8K     RW NX     MEM/CACHED/WBRA
0xbf012000-0xbf013000           4K     ro x      MEM/CACHED/WBRA
0xbf013000-0xbf014000           4K     ro NX     MEM/CACHED/WBRA
0xbf014000-0xbf016000           8K     RW NX     MEM/CACHED/WBRA
0xbf01a000-0xbf01c000           8K     ro x      MEM/CACHED/WBRA
0xbf01c000-0xbf01d000           4K     ro NX     MEM/CACHED/WBRA
0xbf01d000-0xbf01f000           8K     RW NX     MEM/CACHED/WBRA
0xbf024000-0xbf025000           4K     ro x      MEM/CACHED/WBRA
0xbf025000-0xbf026000           4K     ro NX     MEM/CACHED/WBRA
0xbf026000-0xbf028000           8K     RW NX     MEM/CACHED/WBRA
0xbf02c000-0xbf033000          28K     ro x      MEM/CACHED/WBRA
0xbf033000-0xbf035000           8K     ro NX     MEM/CACHED/WBRA
0xbf035000-0xbf03a000          20K     RW NX     MEM/CACHED/WBRA
0xbf041000-0xbf043000           8K     ro x      MEM/CACHED/WBRA
0xbf043000-0xbf045000           8K     ro NX     MEM/CACHED/WBRA
0xbf045000-0xbf048000          12K     RW NX     MEM/CACHED/WBRA
0xbf04e000-0xbf04f000           4K     ro x      MEM/CACHED/WBRA
0xbf04f000-0xbf050000           4K     ro NX     MEM/CACHED/WBRA
0xbf050000-0xbf052000           8K     RW NX     MEM/CACHED/WBRA
0xbf056000-0xbf05f000          36K     ro x      MEM/CACHED/WBRA
0xbf05f000-0xbf061000           8K     ro NX     MEM/CACHED/WBRA
0xbf061000-0xbf064000          12K     RW NX     MEM/CACHED/WBRA
