From: lkp@intel.com (kbuild test robot)
Date: Wed, 10 Oct 2018 05:32:45 +0800
Subject: [xlnx:master 1922/2013]
 drivers/staging/xroeframer/sysfs_xroe_framer_ipv4.c:532:23: note: in
 expansion of macro 'ETH_IPV4_SOURCE_ADD_MASK'
Message-ID: <201810100543.PArTnzci%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   7ea1af329aee531681b87b1fba5496337bff680f
commit: e57a0973a5a7d24654f6a423ac7212fe5abe0619 [1922/2013] staging: xroeframer: IPv4 sysfs source file commit
config: i386-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout e57a0973a5a7d24654f6a423ac7212fe5abe0619
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from drivers/staging/xroeframer/xroe_framer.h:7:0,
                    from drivers/staging/xroeframer/sysfs_xroe_framer_ipv4.c:14:
   drivers/staging/xroeframer/sysfs_xroe_framer_ipv4.c: In function 'ipv4_source_address_show':
   drivers/staging/xroeframer/roe_framer_ctrl.h:814:34: warning: large integer implicitly truncated to unsigned type [-Woverflow]
    #define ETH_IPV4_SOURCE_ADD_MASK 0x4294967295 /* 4294967295 */
                                     ^
>> drivers/staging/xroeframer/sysfs_xroe_framer_ipv4.c:532:23: note: in expansion of macro 'ETH_IPV4_SOURCE_ADD_MASK'
     unsigned long mask = ETH_IPV4_SOURCE_ADD_MASK;
                          ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/xroeframer/sysfs_xroe_framer_ipv4.c: In function 'ipv4_source_address_store':
   drivers/staging/xroeframer/roe_framer_ctrl.h:814:34: warning: large integer implicitly truncated to unsigned type [-Woverflow]
    #define ETH_IPV4_SOURCE_ADD_MASK 0x4294967295 /* 4294967295 */
                                     ^
   drivers/staging/xroeframer/sysfs_xroe_framer_ipv4.c:564:23: note: in expansion of macro 'ETH_IPV4_SOURCE_ADD_MASK'
     unsigned long mask = ETH_IPV4_SOURCE_ADD_MASK;
                          ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/xroeframer/sysfs_xroe_framer_ipv4.c: In function 'ipv4_destination_address_show':
   drivers/staging/xroeframer/roe_framer_ctrl.h:821:39: warning: large integer implicitly truncated to unsigned type [-Woverflow]
    #define ETH_IPV4_DESTINATION_ADD_MASK 0x4294967295 /* 4294967295 */
                                          ^
>> drivers/staging/xroeframer/sysfs_xroe_framer_ipv4.c:591:23: note: in expansion of macro 'ETH_IPV4_DESTINATION_ADD_MASK'
     unsigned long mask = ETH_IPV4_DESTINATION_ADD_MASK;
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/xroeframer/sysfs_xroe_framer_ipv4.c: In function 'ipv4_destination_address_store':
   drivers/staging/xroeframer/roe_framer_ctrl.h:821:39: warning: large integer implicitly truncated to unsigned type [-Woverflow]
    #define ETH_IPV4_DESTINATION_ADD_MASK 0x4294967295 /* 4294967295 */
                                          ^
   drivers/staging/xroeframer/sysfs_xroe_framer_ipv4.c:623:23: note: in expansion of macro 'ETH_IPV4_DESTINATION_ADD_MASK'
     unsigned long mask = ETH_IPV4_DESTINATION_ADD_MASK;
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +/ETH_IPV4_SOURCE_ADD_MASK +532 drivers/staging/xroeframer/sysfs_xroe_framer_ipv4.c

   517	
   518	/**
   519	 * ipv4_source_address_show - Returns the IPv4 source address
   520	 * @kobj:	The kernel object of the entry
   521	 * @attr:	The attributes of the kernel object
   522	 * @buff:	The buffer containing the IPv4 source address
   523	 *
   524	 * Returns the IPv4 source address in x.x.x.x format
   525	 *
   526	 * Return: XROE_SIZE_MAX on success
   527	 */
   528	static ssize_t ipv4_source_address_show
   529	(struct kobject *kobj, struct kobj_attribute *attr, char *buff)
   530	{
   531		u32 offset = ETH_IPV4_SOURCE_ADD_OFFSET;
 > 532		unsigned long mask = ETH_IPV4_SOURCE_ADD_MASK;
   533		u32 buffer = 0;
   534		u32 source_add = 0;
   535		unsigned char *ip_addr_char = NULL;
   536		void __iomem *working_address = ((u8 *)lp->base_addr +
   537		ETH_IPV4_SOURCE_ADD_ADDR);
   538	
   539		buffer = ioread32(working_address);
   540		source_add = (buffer & mask) >> offset;
   541		utils_ipv4addr_hextochar(source_add, ip_addr_char);
   542		sprintf(buff, "%d.%d.%d.%d\n", ip_addr_char[3], ip_addr_char[2],
   543			ip_addr_char[1], ip_addr_char[0]);
   544	
   545		return XROE_SIZE_MAX;
   546	}
   547	
   548	/**
   549	 * ipv4_source_address_store - Writes to the IPv4 source address sysfs entry
   550	 * @kobj:	The kernel object of the entry
   551	 * @attr:	The attributes of the kernel object
   552	 * @buff:	The buffer containing the IPv4 source address
   553	 * @count:	The number of characters typed by the user
   554	 *
   555	 * Writes to the IPv4 source address sysfs entry
   556	 *
   557	 * Return: XROE_SIZE_MAX or the value of "count", if that's lesser, on success
   558	 */
   559	static ssize_t ipv4_source_address_store
   560	(struct kobject *kobj, struct kobj_attribute *attr, const char *buff,
   561	size_t count)
   562	{
   563		u32 offset = ETH_IPV4_SOURCE_ADD_OFFSET;
 > 564		unsigned long mask = ETH_IPV4_SOURCE_ADD_MASK;
   565		u32 source_add = 0;
   566		void __iomem *working_address = ((u8 *)lp->base_addr +
   567		ETH_IPV4_SOURCE_ADD_ADDR);
   568	
   569		xroe_size = min_t(size_t, count, (size_t)XROE_SIZE_MAX);
   570		strncpy(xroe_tmp, buff, xroe_size);
   571		if (utils_ipv4addr_chartohex(xroe_tmp, &source_add) == 4)
   572			utils_write32withmask(working_address,
   573					      source_add, mask, offset);
   574		return xroe_size;
   575	}
   576	
   577	/**
   578	 * ipv4_destination_address_show - Returns the IPv4 destination address
   579	 * @kobj:	The kernel object of the entry
   580	 * @attr:	The attributes of the kernel object
   581	 * @buff:	The buffer containing the IPv4 destination address
   582	 *
   583	 * Returns the IPv4 destination address in x.x.x.x format
   584	 *
   585	 * Return: XROE_SIZE_MAX on success
   586	 */
   587	static ssize_t ipv4_destination_address_show
   588	(struct kobject *kobj, struct kobj_attribute *attr, char *buff)
   589	{
   590		u32 offset = ETH_IPV4_DESTINATION_ADD_OFFSET;
 > 591		unsigned long mask = ETH_IPV4_DESTINATION_ADD_MASK;
   592		u32 buffer = 0;
   593		u32 destination_add = 0;
   594		unsigned char *ip_addr_char = NULL;
   595		void __iomem *working_address = ((u8 *)lp->base_addr +
   596		ETH_IPV4_DESTINATION_ADD_ADDR);
   597	
   598		buffer = ioread32(working_address);
   599		destination_add = (buffer & mask) >> offset;
   600		utils_ipv4addr_hextochar(destination_add, ip_addr_char);
   601		sprintf(buff, "%d.%d.%d.%d\n", ip_addr_char[3], ip_addr_char[2],
   602			ip_addr_char[1], ip_addr_char[0]);
   603		return XROE_SIZE_MAX;
   604	}
   605	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 62160 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181010/81352c88/attachment-0001.gz>
