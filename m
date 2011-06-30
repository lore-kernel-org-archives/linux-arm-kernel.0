From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Jun 2011 15:33:38 +0100
Subject: [PATCH 4/4] mmci: fixup sg buffer handling in pio_write
In-Reply-To: <1309247869-17220-1-git-send-email-linus.walleij@stericsson.com>
References: <1309247869-17220-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110630143338.GA21898@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2011 at 09:57:49AM +0200, Linus Walleij wrote:
> From: Ulf Hansson <ulf.hansson@stericsson.com>
> 
> Earlier code in pio_write was expecting that each
> scatter-gather buffer was 4-bytes aligned which is
> not always the case, especially when dealing with long
> chains of SDIO packages. This patch fix the problem by
> using a 4 bytes buffer to cache unaligned data between
> each unaligned pio_write operation.
> 
> In the last transaction we pad the last write access
> with zeroes.
> 
> Remove older fix for ST Micro since it was not a
> variant-specific problem.

This is horrid, and will probably cause MMCI to underrun on ARM platforms
where it hasn't done so previously due to all the extra overhead at the
start of the interrupt.

Therefore, I don't think this is acceptable.

Plus, what exactly is it trying to solve - writesl() handles unaligned
buffers already.

> +		if (len > sg_miter->consumed)
> +			len = sg_miter->consumed;
> +		else
> +			sg_miter->consumed = len;

sg_miter is supposed to _always_ be written with the number of bytes
consumed.  To start playing these games with it is inviting trouble,
and to start return a length greater than 'remain' from mmci_pio_write
is just silly.

What is probably a better approach is to detect this condition when
we receive the request, and copy the data into a bounce buffer.
