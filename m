From: lkp@intel.com (kbuild test robot)
Date: Thu, 8 Oct 2015 18:45:37 +0800
Subject: [PATCH v8 3/6] pci:host: Add Altera PCIe host controller driver
In-Reply-To: <1444297394-3122-4-git-send-email-lftan@altera.com>
Message-ID: <201510081812.sJm6ZLVH%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ley,

[auto build test WARNING on v4.3-rc4 -- if it's inappropriate base, please ignore]

config: x86_64-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   drivers/pci/host/pcie-altera.c: In function 'tlp_cfg_dword_read':
>> drivers/pci/host/pcie-altera.c:243:12: warning: large integer implicitly truncated to unsigned type [-Woverflow]
      *value = ~0UL; /* return 0xFFFFFFFF if error */
               ^
   drivers/pci/host/pcie-altera.c: In function 'altera_pcie_cfg_read':
   drivers/pci/host/pcie-altera.c:291:12: warning: large integer implicitly truncated to unsigned type [-Woverflow]
      *value = ~0UL;
               ^

vim +243 drivers/pci/host/pcie-altera.c

   227		int ret;
   228		u32 headers[TLP_HDR_SIZE];
   229	
   230		if (bus == pcie->root_bus_nr)
   231			headers[0] = TLP_CFG_DW0(TLP_FMTTYPE_CFGRD0);
   232		else
   233			headers[0] = TLP_CFG_DW0(TLP_FMTTYPE_CFGRD1);
   234	
   235		headers[1] = TLP_CFG_DW1(TLP_REQ_ID(pcie->root_bus_nr, devfn),
   236						TLP_READ_TAG);
   237		headers[2] = TLP_CFG_DW2(bus, devfn, where);
   238	
   239		tlp_write_packet(pcie, headers, 0, false);
   240	
   241		ret = tlp_read_packet(pcie, value);
   242		if (ret != PCIBIOS_SUCCESSFUL)
 > 243			*value = ~0UL;	/* return 0xFFFFFFFF if error */
   244	
   245		return ret;
   246	}
   247	
   248	static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus, u32 devfn,
   249				       int where, u32 value)
   250	{
   251		u32 headers[TLP_HDR_SIZE];

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 50062 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151008/a30a135e/attachment-0001.obj>
