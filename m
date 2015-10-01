From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 1 Oct 2015 17:07:43 +0200
Subject: [PATCH] mtd: nand: pass page number to ecc->write_xxx() methods
In-Reply-To: <1440436219-31625-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1440436219-31625-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20151001170743.3aa0d6fa@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

On Mon, 24 Aug 2015 19:10:19 +0200
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> The ->read_xxx() methods are all passed the page number the NAND controller
> is supposed to read, but ->write_xxx() do not have such a parameter.
> 
> This is a problem if we want to properly implement data
> scrambling/randomization in order to mitigate MLC sensibility to repeated
> pattern: to prevent bitflips in adjacent pages in the same block we need
> to avoid repeating the same pattern at the same offset in those pages,
> hence the randomizer/scrambler engine need to be passed the page value
> in order to adapt its seed accordingly.
> 
> Moreover, adding the page parameter the ->write_xxx() methods add some
> consistency to the current model.

Apparently nobody complained (or nobody cares :-)) about that patch,
and I'll really need the page information if I want to support
randomization/scrambling in the sunxi driver.

Do you have any objections to this patch (I can rebase it on mainline
and check if new drivers have been added since the submission)?
I remember you pointed a trick you've used in the brcmnand driver to
get this page information (storing it during the ->cmdfunc() or
->ctrl_cmd() call), but it would be way easier to have it directly in
the ecc->write_xxx() parameters...

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
