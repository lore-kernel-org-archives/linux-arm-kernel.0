From: b32955@freescale.com (Huang Shijie)
Date: Thu, 16 Feb 2012 11:15:40 +0800
Subject: [PATCH] mtd: fix the wrong check condition
In-Reply-To: <4F3C712A.5060406@gmail.com>
References: <1329302008-10228-1-git-send-email-b32955@freescale.com>
 <4F3C712A.5060406@gmail.com>
Message-ID: <4F3C74DC.1000706@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
> (Add Florian and Matthieu)
>
> On 2/15/2012 2:33 AM, Huang Shijie wrote:
>> If we use `||` check condition, many NAND chips which are not
>> ONFI nands have to do the ONFI detection.
>
> Running the ONFI detection on non-ONFI NAND should not, ideally, be a
> problem. They should fail one or both tests included in the routine:
> the 'O N F I' string check or the CRC calculation.
NO.

I have Hynix nand in my hand: H27UBG8T2A (page size :8192, oob:448).
It is not an ONFI nand.


But it accidentally can pass the ONFI detection, and get the result : 
page size 4192, oob:96. This is a wrong result.




>
>> Use `&&` here to detect the ONFI NAND when we can not find any type
>> in the nand_flash_ids.
>
> There are many chips whose ID might be in the NAND table but for which
> it is preferable (or even required) to check by ONFI for one reason or
> another. For instance, some ONFI chips might use odd-sized OOB that
> isn't in the ID decoding algorithm.
>
This nand is 32Gb, but we can not parse it out from the id.
I ever want to add a new database which use the all the 8/6 bytes id as key.
It seems it's time to change it now.

Huang Shijie

> The current `||` check is, I think, designed to weed out old
> small-page NAND only, which define both 'name' and 'pagesize' in the
> table.
>
> So in short: the current code works as intended.
>
> Brian
>
