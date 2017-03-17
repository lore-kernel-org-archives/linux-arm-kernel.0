From: lkp@intel.com (kbuild test robot)
Date: Fri, 17 Mar 2017 15:46:23 +0800
Subject: [PATCH] of: Mark property::value as const
In-Reply-To: <148951941955.30407.4217812594792852642@sboyd-linaro>
Message-ID: <201703171544.kHvqwsdT%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.11-rc2 next-20170310]
[cannot apply to glikely/devicetree/next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Stephen-Boyd/of-Mark-property-value-as-const/20170317-143414
config: sparc64-allmodconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

All warnings (new ones prefixed by >>):

   fs/openpromfs/inode.c: In function 'property_show':
>> fs/openpromfs/inode.c:74:16: warning: passing argument 1 of 'is_string' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     if (is_string(pval, len)) {
                   ^~~~
   fs/openpromfs/inode.c:48:12: note: expected 'unsigned char *' but argument is of type 'const void *'
    static int is_string(unsigned char *p, int len)
               ^~~~~~~~~

vim +74 fs/openpromfs/inode.c

^1da177e Linus Torvalds  2005-04-16  58  
3d824a46 David S. Miller 2006-06-25  59  		return 0;
^1da177e Linus Torvalds  2005-04-16  60  	}
^1da177e Linus Torvalds  2005-04-16  61  
3d824a46 David S. Miller 2006-06-25  62  	return 1;
3d824a46 David S. Miller 2006-06-25  63  }
^1da177e Linus Torvalds  2005-04-16  64  
3d824a46 David S. Miller 2006-06-25  65  static int property_show(struct seq_file *f, void *v)
3d824a46 David S. Miller 2006-06-25  66  {
3d824a46 David S. Miller 2006-06-25  67  	struct property *prop = f->private;
755d4871 Stephen Boyd    2017-03-14  68  	const void *pval;
3d824a46 David S. Miller 2006-06-25  69  	int len;
^1da177e Linus Torvalds  2005-04-16  70  
3d824a46 David S. Miller 2006-06-25  71  	len = prop->length;
3d824a46 David S. Miller 2006-06-25  72  	pval = prop->value;
^1da177e Linus Torvalds  2005-04-16  73  
3d824a46 David S. Miller 2006-06-25 @74  	if (is_string(pval, len)) {
3d824a46 David S. Miller 2006-06-25  75  		while (len > 0) {
3d824a46 David S. Miller 2006-06-25  76  			int n = strlen(pval);
^1da177e Linus Torvalds  2005-04-16  77  
3d824a46 David S. Miller 2006-06-25  78  			seq_printf(f, "%s", (char *) pval);
^1da177e Linus Torvalds  2005-04-16  79  
3d824a46 David S. Miller 2006-06-25  80  			/* Skip over the NULL byte too.  */
3d824a46 David S. Miller 2006-06-25  81  			pval += n + 1;
3d824a46 David S. Miller 2006-06-25  82  			len -= n + 1;

:::::: The code at line 74 was first introduced by commit
:::::: 3d824a46b7210ea3b0a13ab0d0fbd7f6e2e91ddf [OPENPROMFS]: Rewrite using in-kernel device tree and seq_file.

:::::: TO: David S. Miller <davem@davemloft.net>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 49518 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170317/0ec05757/attachment-0001.gz>
