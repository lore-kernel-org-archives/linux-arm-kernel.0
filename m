From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 10 Mar 2016 11:06:01 -0800
Subject: [PATCH v4 00/52] mtd: rework ECC layout definition
In-Reply-To: <1457344062-11633-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457344062-11633-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160310190601.GC2545@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 07, 2016 at 10:46:50AM +0100, Boris Brezillon wrote:
> Hello,
> 
> This patchset aims at getting rid of the nand_ecclayout limitations.
> struct nand_ecclayout is defining fixed eccpos and oobfree arrays which
> can only be increased by modifying the MTD_MAX_ECCPOS_ENTRIES_LARGE and
> MTD_MAX_OOBFREE_ENTRIES_LARGE macros.
> This approach forces us to modify the macro values each time we add a
> new NAND chip with a bigger OOB area, and increasing these arrays also
> penalize all platforms, even those who only support small NAND devices
> (with small OOB area).
> 
> The idea to overcome this limitation, is to define the ECC/OOB layout
> by the mean of two functions: ->ecc() and ->free(), which will
> basically return the same information has those stored in the
> nand_ecclayout struct.
> 
> Another advantage of this solution is that ECC layouts are usually
> following a repetitive pattern (i.e. leave X bytes free and put Y bytes
> of ECC per ECC chunk), which allows one to implement the ->ecc()
> and ->free() functions with a simple logic that can be applied
> to any size of OOB.
> 
> Patches 1 to 4 are just cleanups or trivial fixes that can be taken
> independently.
> 
> Also note that the last two commits are removing the nand_ecclayout
> definition, thus preventing any new driver to use this structure.
> Of course, this step can be delayed if some of the previous patches
> are not accepted.
> 
> All those changes are available here [1].
> 
> Best Regards,
> 
> Boris
> 
> [1]https://github.com/bbrezillon/linux-0day/tree/nand/ecclayout

FYI, I've pushed patches 1-4 to l2-mtd.git. I'll take another look at
them this week I hope (or your new fellow, Richard, can!), then you can
queue them up for the next cycle.

Brian
