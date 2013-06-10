From: jonathan.austin@arm.com (Jonathan Austin)
Date: Mon, 10 Jun 2013 16:35:12 +0100
Subject: [PATCH] arm: versatile: don't mark pen as __INIT
In-Reply-To: <1370876844-6599-1-git-send-email-mark.rutland@arm.com>
References: <1370876844-6599-1-git-send-email-mark.rutland@arm.com>
Message-ID: <51B5F230.6020803@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/13 16:07, Mark Rutland wrote:
> When booting fewer cores than are physically present on a versatile
> platform (e.g. when passing maxcpus=N on the command line), some
> secondary cores may remain in the holding pen, which is marked __INIT.
> Late in the boot process, the memory comprising the holding pen will be
> released to the kernel for more general use, and may be overwritten with
> arbitrary data, which can cause the held secondaries to start behaving
> unpredictably. This can lead to all manner of odd behaviour from the
> kernel.
>
> Instead don't mark the section as __INIT. This means we can't reuse the
> pen memory, but we won't get secondaries corrupting the rest of the
> kernel.
>
Thanks for the patch, Mark,

I got bitten by this today booting Russell's devel-stable branch (with 4 
CPUs). The corruption you get can lead you up the garden path debugging 
something totally different!

Does this need to be applied to stable kernels, too?

Jonny
