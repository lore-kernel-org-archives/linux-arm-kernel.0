From: lkp@intel.com (kbuild test robot)
Date: Wed, 8 Aug 2018 19:48:47 +0800
Subject: [PATCH v10 2/3] Bluetooth: mediatek: Add protocol support for
 MediaTek serial devices
In-Reply-To: <67c95dcdc4d68691955e043c99a7d313cb126f48.1533663928.git.sean.wang@mediatek.com>
References: <67c95dcdc4d68691955e043c99a7d313cb126f48.1533663928.git.sean.wang@mediatek.com>
Message-ID: <201808081956.l2WM5eKO%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,

I love your patch! Perhaps something to improve:

[auto build test WARNING on bluetooth/master]
[also build test WARNING on v4.18-rc8]
[cannot apply to next-20180808]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/linux-kernel-owner-vger-kernel-org/dt-bindings-net-bluetooth-Add-mediatek-bluetooth/20180808-132732
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   drivers/bluetooth/btmtkuart.c: In function 'mtk_hci_wmt_sync':
   drivers/bluetooth/btmtkuart.c:99:8: error: implicit declaration of function '__hci_cmd_send'; did you mean '__hci_cmd_sync'? [-Werror=implicit-function-declaration]
     err = __hci_cmd_send(hdev, 0xfc6f, hlen, &wc);
           ^~~~~~~~~~~~~~
           __hci_cmd_sync
   In file included from include/linux/bitops.h:38:0,
                    from include/linux/kernel.h:11,
                    from include/linux/unaligned/packed_struct.h:4,
                    from include/linux/unaligned/be_struct.h:5,
                    from arch/arm/include/asm/unaligned.h:18,
                    from drivers/bluetooth/btmtkuart.c:11:
   drivers/bluetooth/btmtkuart.c: In function 'btmtkuart_probe':
   drivers/bluetooth/btmtkuart.c:586:10: error: 'HCI_QUIRK_NON_PERSISTENT_SETUP' undeclared (first use in this function); did you mean 'HCI_QUIRK_NON_PERSISTENT_DIAG'?
     set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
             ^
   arch/arm/include/asm/bitops.h:183:42: note: in definition of macro 'ATOMIC_BITOP'
    #define ATOMIC_BITOP(name,nr,p)  _##name(nr,p)
                                             ^~
>> drivers/bluetooth/btmtkuart.c:586:2: note: in expansion of macro 'set_bit'
     set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
     ^~~~~~~
   drivers/bluetooth/btmtkuart.c:586:10: note: each undeclared identifier is reported only once for each function it appears in
     set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
             ^
   arch/arm/include/asm/bitops.h:183:42: note: in definition of macro 'ATOMIC_BITOP'
    #define ATOMIC_BITOP(name,nr,p)  _##name(nr,p)
                                             ^~
>> drivers/bluetooth/btmtkuart.c:586:2: note: in expansion of macro 'set_bit'
     set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
     ^~~~~~~
   cc1: some warnings being treated as errors

vim +/set_bit +586 drivers/bluetooth/btmtkuart.c

   543	
   544	static int btmtkuart_probe(struct serdev_device *serdev)
   545	{
   546		struct btmtkuart_dev *bdev;
   547		struct hci_dev *hdev;
   548	
   549		bdev = devm_kzalloc(&serdev->dev, sizeof(*bdev), GFP_KERNEL);
   550		if (!bdev)
   551			return -ENOMEM;
   552	
   553		bdev->clk = devm_clk_get(&serdev->dev, "ref");
   554		if (IS_ERR(bdev->clk))
   555			return PTR_ERR(bdev->clk);
   556	
   557		bdev->serdev = serdev;
   558		serdev_device_set_drvdata(serdev, bdev);
   559	
   560		serdev_device_set_client_ops(serdev, &btmtkuart_client_ops);
   561	
   562		INIT_WORK(&bdev->tx_work, btmtkuart_tx_work);
   563		skb_queue_head_init(&bdev->txq);
   564	
   565		/* Initialize and register HCI device */
   566		hdev = hci_alloc_dev();
   567		if (!hdev) {
   568			dev_err(&serdev->dev, "Can't allocate HCI device\n");
   569			return -ENOMEM;
   570		}
   571	
   572		bdev->hdev = hdev;
   573	
   574		hdev->bus = HCI_UART;
   575		hci_set_drvdata(hdev, bdev);
   576	
   577		hdev->open     = btmtkuart_open;
   578		hdev->close    = btmtkuart_close;
   579		hdev->flush    = btmtkuart_flush;
   580		hdev->setup    = btmtkuart_setup;
   581		hdev->shutdown = btmtkuart_shutdown;
   582		hdev->send     = btmtkuart_send_frame;
   583		SET_HCIDEV_DEV(hdev, &serdev->dev);
   584	
   585		hdev->manufacturer = 70;
 > 586		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
   587	
   588		if (hci_register_dev(hdev) < 0) {
   589			dev_err(&serdev->dev, "Can't register HCI device\n");
   590			hci_free_dev(hdev);
   591			return -ENODEV;
   592		}
   593	
   594		return 0;
   595	}
   596	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 65165 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180808/4f994ef1/attachment-0001.gz>
