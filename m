From: lkp@intel.com (kbuild test robot)
Date: Fri, 2 Oct 2015 02:17:05 +0800
Subject: [PATCH v2] mtd: nand: pass page number to ecc->write_xxx() methods
In-Reply-To: <1443722657-13051-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <201510020244.DQEH8IPg%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

[auto build test results on next-20151001 -- if it's inappropriate base, please ignore]

config: i386-randconfig-s1-201539 (attached as .config)
reproduce:
        git checkout 425b29816a0dba028eef09be5cb531a187e256a1
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   drivers/mtd/nand/docg4.c: In function 'docg4_block_markbad':
>> drivers/mtd/nand/docg4.c:1116:2: error: too few arguments to function 'docg4_write_page'
     docg4_write_page(mtd, nand, buf, 1);
     ^
   drivers/mtd/nand/docg4.c:985:12: note: declared here
    static int docg4_write_page(struct mtd_info *mtd, struct nand_chip *nand,
               ^

vim +/docg4_write_page +1116 drivers/mtd/nand/docg4.c

570469f3 Mike Dunn    2012-01-03  1110  	memset(nand->oob_poi, 0xff, mtd->oobsize);
570469f3 Mike Dunn    2012-01-03  1111  	for (i = 0; i < bbtd->len; i++)
570469f3 Mike Dunn    2012-01-03  1112  		nand->oob_poi[bbtd->offs + i] = ~bbtd->pattern[i];
570469f3 Mike Dunn    2012-01-03  1113  
570469f3 Mike Dunn    2012-01-03  1114  	/* write first page of block */
570469f3 Mike Dunn    2012-01-03  1115  	write_page_prologue(mtd, g4_addr);
1fbb938d Brian Norris 2012-05-02 @1116  	docg4_write_page(mtd, nand, buf, 1);
570469f3 Mike Dunn    2012-01-03  1117  	ret = pageprog(mtd);
570469f3 Mike Dunn    2012-01-03  1118  
570469f3 Mike Dunn    2012-01-03  1119  	kfree(buf);

:::::: The code at line 1116 was first introduced by commit
:::::: 1fbb938dff5b6bb4514a4e7600276b03c7f08e25 mtd: nand: add 'oob_required' argument to NAND {read,write}_page interfaces

:::::: TO: Brian Norris <computersforpeace@gmail.com>
:::::: CC: David Woodhouse <David.Woodhouse@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 21000 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151002/8e7c1958/attachment-0001.obj>
