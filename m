From: lkp@intel.com (kbuild test robot)
Date: Thu, 14 Jan 2016 09:24:27 +0800
Subject: [PATCH v7 2/2] drm/bridge: Add I2C based driver for ps8640 bridge
In-Reply-To: <1452651494-16806-2-git-send-email-jitao.shi@mediatek.com>
Message-ID: <201601140940.uXzmZfZZ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jitao,

[auto build test WARNING on v4.4-rc8]
[also build test WARNING on next-20160113]
[cannot apply to drm/drm-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Jitao-Shi/Documentation-bridge-Add-documentation-for-ps8640-DT-properties/20160113-102004
config: i386-randconfig-sb0-01140840 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/bridge/parade-ps8640.c: In function 'ps8640_update_fw_store':
>> drivers/gpu/drm/bridge/parade-ps8640.c:788:20: warning: 'progress_cnt' may be used uninitialized in this function [-Wmaybe-uninitialized]
      if (progress_cnt != (pos * 100) / fw->size) {
                       ^
   drivers/gpu/drm/bridge/parade-ps8640.c:770:5: note: 'progress_cnt' was declared here
     u8 progress_cnt, rom_page_id[2];
        ^

vim +/progress_cnt +788 drivers/gpu/drm/bridge/parade-ps8640.c

   772	
   773		ps8640_regw_byte(client2, PAGE2_SPI_CFG3, I2C_TO_SPI_RESET);
   774		msleep(100);
   775		ps8640_regw_byte(client2, PAGE2_SPI_CFG3, 0x00);
   776	
   777		while (pos < fw->size) {
   778			rom_page_id[0] = (pos >> 8) & 0xFF;
   779			rom_page_id[1] = (pos >> 16) & 0xFF;
   780			ret = ps8640_regw(client2, PAGE2_ROMADD_BYTE1, rom_page_id, 2);
   781			if (ret)
   782				goto error;
   783			ret = ps8640_regw(client7, 0, fw->data + pos, 256);
   784			if (ret)
   785				goto error;
   786	
   787			pos += 256;
 > 788			if (progress_cnt != (pos * 100) / fw->size) {
   789				progress_cnt = (pos * 100) / fw->size;
   790				dev_info(dev, "fw update progress percent %d\n",
   791					 progress_cnt);
   792			}
   793		}
   794		return 0;
   795	
   796	error:

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 22464 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160114/c378da16/attachment-0001.obj>
