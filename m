From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 15 Feb 2012 18:59:54 -0800
Subject: [PATCH] mtd: fix the wrong check condition
In-Reply-To: <1329302008-10228-1-git-send-email-b32955@freescale.com>
References: <1329302008-10228-1-git-send-email-b32955@freescale.com>
Message-ID: <4F3C712A.5060406@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Add Florian and Matthieu)

On 2/15/2012 2:33 AM, Huang Shijie wrote:
> If we use `||` check condition, many NAND chips which are not
> ONFI nands have to do the ONFI detection.

Running the ONFI detection on non-ONFI NAND should not, ideally, be a 
problem. They should fail one or both tests included in the routine: the 
'O N F I' string check or the CRC calculation.

> Use `&&` here to detect the ONFI NAND when we can not find any type
> in the nand_flash_ids.

There are many chips whose ID might be in the NAND table but for which 
it is preferable (or even required) to check by ONFI for one reason or 
another. For instance, some ONFI chips might use odd-sized OOB that 
isn't in the ID decoding algorithm.

The current `||` check is, I think, designed to weed out old small-page 
NAND only, which define both 'name' and 'pagesize' in the table.

So in short: the current code works as intended.

Brian
