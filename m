From: lkp@intel.com (kbuild test robot)
Date: Wed, 27 Jun 2018 04:55:36 +0800
Subject: [PATCH v5 12/20] ACPI / APEI: Don't store CPER records physical
 address in struct ghes
In-Reply-To: <20180626170116.25825-13-james.morse@arm.com>
References: <20180626170116.25825-13-james.morse@arm.com>
Message-ID: <201806270332.vrWmASbO%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

I love your patch! Yet something to improve:

[auto build test ERROR on pm/linux-next]
[also build test ERROR on v4.18-rc2 next-20180626]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/James-Morse/APEI-in_nmi-rework-and-arm64-SDEI-wire-up/20180627-024229
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: i386-randconfig-i1-201825 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/acpi/apei/ghes.c: In function 'ghes_read_estatus':
>> drivers/acpi/apei/ghes.c:300:17: error: passing argument 1 of 'apei_read' from incompatible pointer type [-Werror=incompatible-pointer-types]
     rc = apei_read(buf_paddr, &g->error_status_address);
                    ^~~~~~~~~
   In file included from drivers/acpi/apei/ghes.c:57:0:
   drivers/acpi/apei/apei-internal.h:80:5: note: expected 'u64 * {aka long long unsigned int *}' but argument is of type 'phys_addr_t * {aka unsigned int *}'
    int apei_read(u64 *val, struct acpi_generic_address *reg);
        ^~~~~~~~~
   cc1: some warnings being treated as errors

vim +/apei_read +300 drivers/acpi/apei/ghes.c

   291	
   292	static int ghes_read_estatus(struct ghes *ghes,
   293				     struct acpi_hest_generic_status *estatus,
   294				     phys_addr_t *buf_paddr, int fixmap_idx)
   295	{
   296		struct acpi_hest_generic *g = ghes->generic;
   297		u32 len;
   298		int rc;
   299	
 > 300		rc = apei_read(buf_paddr, &g->error_status_address);
   301		if (rc) {
   302			if (printk_ratelimit())
   303				pr_warning(FW_WARN GHES_PFX
   304	"Failed to read error status block address for hardware error source: %d.\n",
   305					   g->header.source_id);
   306			return -EIO;
   307		}
   308		if (!*buf_paddr)
   309			return -ENOENT;
   310	
   311		ghes_copy_tofrom_phys(estatus, *buf_paddr,
   312				      sizeof(*estatus), 1, fixmap_idx);
   313		if (!estatus->block_status)
   314			return -ENOENT;
   315	
   316		ghes->flags |= GHES_TO_CLEAR;
   317	
   318		rc = -EIO;
   319		len = cper_estatus_len(estatus);
   320		if (len < sizeof(*estatus))
   321			goto err_read_block;
   322		if (len > ghes->generic->error_block_length)
   323			goto err_read_block;
   324		if (cper_estatus_check_header(estatus))
   325			goto err_read_block;
   326		ghes_copy_tofrom_phys(estatus + 1,
   327				      *buf_paddr + sizeof(*estatus),
   328				      len - sizeof(*estatus), 1, fixmap_idx);
   329		if (cper_estatus_check(estatus))
   330			goto err_read_block;
   331		rc = 0;
   332	
   333	err_read_block:
   334		if (rc && printk_ratelimit())
   335			pr_warning(FW_WARN GHES_PFX
   336				   "Failed to read error status block!\n");
   337		return rc;
   338	}
   339	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 26080 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180627/9fc15286/attachment-0001.gz>
