From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 24 Jul 2012 16:55:02 -0700
Subject: [RFC] kernel, logbuf: add support for external log buffer
In-Reply-To: <1339395188-10166-1-git-send-email-hs@denx.de>
References: <1339395188-10166-1-git-send-email-hs@denx.de>
Message-ID: <20120724165502.17de8e13.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Jun 2012 08:13:08 +0200
Heiko Schocher <hs@denx.de> wrote:

> This merges support for the previously DENX-only kernel
> feature of specifying an alternative, "external" buffer
> for kernel printk messages and their associated metadata.
> This patch is based on DENX-only kernel commit:
> 
> commit 212f61c7fd3b952a81d1459dd32a86a32ddfd4ce
> Author: Igor Lisitsin <igor@emcraft.com>
> Date:   Wed Apr 18 14:55:19 2007 +0400
> 
> Add support for external log buffer.
> 
> Add support for external log buffer, for example passed by U-Boot,
> which may already contain messages (from the boot loader and/or POST).
> 
> Signed-off-by: Igor Lisitsin <igor@emcraft.com>
> 
> see:
> http://git.denx.de/?p=linux-denx.git;a=commit;h=212f61c7fd3b952a81d1459dd32a86a32ddfd4ce
> 
> When this option is enabled, an architecture- or machine-specific log
> buffer is used for all printk messages. This allows entities such as
> boot loaders (e.g. U-Boot) to place printk-compatible messages into
> this buffer and for the kernel to coalesce them with its normal
> messages. This patch support this feature for arch/arm based
> boards.

Why was it done this way, rather than adding a hook to permit
architectures to insert data into the head of the existing kernel
buffer?

The latter approach would be quite simple, wouldn't it?  A single line
added to printk.c which calls an arch function which locates the boot
loader buffer and prints it, with printk.  And this is more flexible -
for example, there might be more than one external message stream
which we wish to capture.
