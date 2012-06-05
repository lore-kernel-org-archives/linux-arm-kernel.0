From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 5 Jun 2012 15:59:18 +0900
Subject: [PATCH] printk: Fix alignment of buf causing crash on ARM EABI
In-Reply-To: <1338879154-6546-1-git-send-email-andrew@lunn.ch>
References: <1338879154-6546-1-git-send-email-andrew@lunn.ch>
Message-ID: <20120605065918.GA17674@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 05, 2012 at 08:52:34AM +0200, Andrew Lunn wrote:
> Commit 7ff9554bb578ba02166071d2d487b7fc7d860d62, printk: convert
> byte-buffer to variable-length record buffer, causes systems using
> EABI to crash very early in the boot cycle. The first entry in struct
> log is a u64, which for EABI must be 8 byte aligned.
> 
> Make use of __alignof__() so the compiler to decide the alignment, but
> allow it to be overridden using CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS,
> for systems which can perform unaligned access and want to save
> a few bytes of space.
> 
> Tested on Orion5x and Kirkwood.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  kernel/printk.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, I think I have a patch in my to-apply queue that fixes this in a
bit different way.  I'll dig that up and compare them in the next few
days as I work my way through my pending patch queue.

greg k-h
