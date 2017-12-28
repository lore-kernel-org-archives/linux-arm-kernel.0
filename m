From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Thu, 28 Dec 2017 21:20:31 +0100
Subject: [BUG] sun8i-a83t-bananapi-m3: Ethernet unstable since d7c5f6863550
 ("ARM: dts: sun8i: a83t: bananapi-m3: Add AXP813 regulator nodes")
Message-ID: <20171228202031.GA18393@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

Since d7c5f6863550 ("ARM: dts: sun8i: a83t: bananapi-m3: Add AXP813 regulator nodes"), my BPIM3 does not have stable ethernet.
from 50% to 100% packet loss.
According to the logs (below), vcc-ephy is disabled during boot

With the following hack, https://paste.pound-python.org/show/6BlmwcE60z0o4GrbAMUU/ (which is a badly d7c5f6863550 revert)
the situation is better (ping with 0% loss), but the bandwitch is unstable low.

So the problem is clearly that the PHY is badly powered.

Regards

[    4.840336] sunxi-rsb 1f03400.rsb: RSB running at 3000000 Hz
[    4.847252] axp20x-rsb sunxi-rsb-3a3: AXP20x variant AXP813 found
[    4.856307] axp20x-rsb sunxi-rsb-3a3: Looking up vin1-supply from device tree
[    4.856331] axp20x-rsb sunxi-rsb-3a3: Looking up vin1-supply property in node /soc/rsb at 1f03400/pmic at 3a3 failed
[    4.856351] dcdc1: supplied by regulator-dummy
[    4.860802] regulator-dummy: could not add device link regulator.1 err -2
[    4.861006] vcc-3v3: 3300 mV 
[    4.861264] axp20x-rsb sunxi-rsb-3a3: Looking up vin2-supply from device tree
[    4.861281] axp20x-rsb sunxi-rsb-3a3: Looking up vin2-supply property in node /soc/rsb at 1f03400/pmic at 3a3 failed
[    4.861291] dcdc2: supplied by regulator-dummy
[    4.865854] regulator-dummy: could not add device link regulator.2 err -2
[    4.866041] vdd-cpua: 700 <--> 1100 mV at 900 mV 
[    4.866251] axp20x-rsb sunxi-rsb-3a3: Looking up vin3-supply from device tree
[    4.866264] axp20x-rsb sunxi-rsb-3a3: Looking up vin3-supply property in node /soc/rsb at 1f03400/pmic at 3a3 failed
[    4.866274] dcdc3: supplied by regulator-dummy
[    4.870717] regulator-dummy: could not add device link regulator.3 err -2
[    4.870814] vdd-cpub: 700 <--> 1100 mV at 900 mV 
[    4.871017] axp20x-rsb sunxi-rsb-3a3: Looking up vin4-supply from device tree
[    4.871029] axp20x-rsb sunxi-rsb-3a3: Looking up vin4-supply property in node /soc/rsb at 1f03400/pmic at 3a3 failed
[    4.871040] dcdc4: supplied by regulator-dummy
[    4.875524] regulator-dummy: could not add device link regulator.4 err -2
[    4.875633] vdd-gpu: 700 <--> 1100 mV at 900 mV 
[    4.875832] axp20x-rsb sunxi-rsb-3a3: Looking up vin5-supply from device tree
[    4.875845] axp20x-rsb sunxi-rsb-3a3: Looking up vin5-supply property in node /soc/rsb at 1f03400/pmic at 3a3 failed
[    4.875857] dcdc5: supplied by regulator-dummy
[    4.880299] regulator-dummy: could not add device link regulator.5 err -2
[    4.880413] vcc-dram: Bringing 1180000uV into 1200000-1200000uV
[    4.886402] vcc-dram: ramp_delay not set
[    4.886418] vcc-dram: 1200 mV 
[    4.886643] axp20x-rsb sunxi-rsb-3a3: Looking up vin6-supply from device tree
[    4.886655] axp20x-rsb sunxi-rsb-3a3: Looking up vin6-supply property in node /soc/rsb at 1f03400/pmic at 3a3 failed
[    4.886669] dcdc6: supplied by regulator-dummy
[    4.891110] regulator-dummy: could not add device link regulator.6 err -2
[    4.891216] vdd-sys: 900 mV 
[    4.891495] axp20x-rsb sunxi-rsb-3a3: Looking up vin7-supply from device tree
[    4.891508] axp20x-rsb sunxi-rsb-3a3: Looking up vin7-supply property in node /soc/rsb at 1f03400/pmic at 3a3 failed
[    4.891521] dcdc7: supplied by regulator-dummy
[    4.895995] regulator-dummy: could not add device link regulator.7 err -2
[    4.896102] dcdc7: at 1000 mV 
[    4.896324] axp20x-rsb sunxi-rsb-3a3: Looking up aldoin-supply from device tree
[    4.896336] axp20x-rsb sunxi-rsb-3a3: Looking up aldoin-supply property in node /soc/rsb at 1f03400/pmic at 3a3 failed
[    4.896348] aldo1: supplied by regulator-dummy
[    4.900790] regulator-dummy: could not add device link regulator.8 err -2
[    4.900936] vcc-1v8: 1800 mV 
[    4.901142] axp20x-rsb sunxi-rsb-3a3: Looking up aldoin-supply from device tree
[    4.901155] axp20x-rsb sunxi-rsb-3a3: Looking up aldoin-supply property in node /soc/rsb at 1f03400/pmic at 3a3 failed
[    4.901169] aldo2: supplied by regulator-dummy
[    4.905638] regulator-dummy: could not add device link regulator.9 err -2
[    4.905734] dram-pll: 1800 mV 
[    4.905959] axp20x-rsb sunxi-rsb-3a3: Looking up aldoin-supply from device tree
[    4.905972] axp20x-rsb sunxi-rsb-3a3: Looking up aldoin-supply property in node /soc/rsb at 1f03400/pmic at 3a3 failed
[    4.905986] aldo3: supplied by regulator-dummy
[    4.910428] regulator-dummy: could not add device link regulator.10 err -2
[    4.910536] avcc: 3000 mV 
[    4.910813] axp20x-rsb sunxi-rsb-3a3: Looking up dldoin-supply from device tree
[    4.910827] axp20x-rsb sunxi-rsb-3a3: Looking up dldoin-supply property in node /soc/rsb at 1f03400/pmic at 3a3 failed
[    4.910842] dldo1: supplied by regulator-dummy
[    4.915313] regulator-dummy: could not add device link regulator.11 err -2
[    4.915448] vcc-wifi: Bringing 2900000uV into 3300000-3300000uV
[    4.921405] vcc-wifi: ramp_delay not set
[    4.921414] vcc-wifi: 3300 mV 
[    4.921627] axp20x-rsb sunxi-rsb-3a3: Looking up dldoin-supply from device tree
[    4.921640] axp20x-rsb sunxi-rsb-3a3: Looking up dldoin-supply property in node /soc/rsb at 1f03400/pmic at 3a3 failed
[    4.921654] dldo2: supplied by regulator-dummy
[    4.926118] regulator-dummy: could not add device link regulator.12 err -2
[    4.926208] dldo2: at 2900 mV 
[    4.926422] axp20x-rsb sunxi-rsb-3a3: Looking up dldoin-supply from device tree
[    4.926435] axp20x-rsb sunxi-rsb-3a3: Looking up dldoin-supply property in node /soc/rsb at 1f03400/pmic at 3a3 failed
[    4.926451] dldo3: supplied by regulator-dummy
[    4.930892] regulator-dummy: could not add device link regulator.13 err -2
[    4.930983] vcc-pd: Bringing 2900000uV into 2500000-2500000uV
[    4.936787] vcc-pd: ramp_delay not set
[    4.936801] vcc-pd: 2500 mV 
[    4.937018] axp20x-rsb sunxi-rsb-3a3: Looking up dldoin-supply from device tree
[    4.937030] axp20x-rsb sunxi-rsb-3a3: Looking up dldoin-supply property in node /soc/rsb at 1f03400/pmic at 3a3 failed
[    4.937045] dldo4: supplied by regulator-dummy
[    4.941486] regulator-dummy: could not add device link regulator.14 err -2
[    4.941579] dldo4: at 3300 mV 
[    4.941785] axp20x-rsb sunxi-rsb-3a3: Looking up eldoin-supply from device tree
[    4.941822] eldo1: supplied by vcc-3v3
[    4.945598] vcc-3v3: could not add device link regulator.15 err -2
[    4.945763] eldo1: at 700 mV 
[    4.945994] axp20x-rsb sunxi-rsb-3a3: Looking up eldoin-supply from device tree
[    4.946013] eldo2: supplied by vcc-3v3
[    4.949763] vcc-3v3: could not add device link regulator.16 err -2
[    4.949849] eldo2: at 700 mV 
[    4.950067] axp20x-rsb sunxi-rsb-3a3: Looking up eldoin-supply from device tree
[    4.950083] eldo3: supplied by vcc-3v3
[    4.953866] vcc-3v3: could not add device link regulator.17 err -2
[    4.953964] eldo3: at 1600 mV 
[    4.954190] axp20x-rsb sunxi-rsb-3a3: Looking up fldoin-supply from device tree
[    4.954208] fldo1: supplied by vcc-dram
[    4.958043] vcc-dram: could not add device link regulator.18 err -2
[    4.958143] vdd12-hsic: override min_uV, 1080000 -> 1100000
[    4.958149] vdd12-hsic: override max_uV, 1320000 -> 1300000
[    4.958159] vdd12-hsic: 1100 <--> 1300 mV at 1250 mV 
[    4.958419] axp20x-rsb sunxi-rsb-3a3: Looking up fldoin-supply from device tree
[    4.958440] fldo2: supplied by vcc-dram
[    4.962275] vcc-dram: could not add device link regulator.19 err -2
[    4.962447] vdd-cpus: 700 <--> 1100 mV at 900 mV 
[    4.962686] axp20x-rsb sunxi-rsb-3a3: Looking up ips-supply from device tree
[    4.962700] axp20x-rsb sunxi-rsb-3a3: Looking up ips-supply property in node /soc/rsb at 1f03400/pmic at 3a3 failed
[    4.962721] rtc-ldo: supplied by regulator-dummy
[    4.967375] regulator-dummy: could not add device link regulator.20 err -2
[    4.967425] vcc-rtc: 1800 mV 
[    4.967626] axp20x-rsb sunxi-rsb-3a3: Looking up ips-supply from device tree
[    4.967638] axp20x-rsb sunxi-rsb-3a3: Looking up ips-supply property in node /soc/rsb at 1f03400/pmic at 3a3 failed
[    4.967658] ldo-io0: supplied by regulator-dummy
[    4.972273] regulator-dummy: could not add device link regulator.21 err -2
[    4.972404] ldo-io0: at 3300 mV 
[    4.972622] axp20x-rsb sunxi-rsb-3a3: Looking up ips-supply from device tree
[    4.972635] axp20x-rsb sunxi-rsb-3a3: Looking up ips-supply property in node /soc/rsb at 1f03400/pmic at 3a3 failed
[    4.972656] ldo-io1: supplied by regulator-dummy
[    4.977297] regulator-dummy: could not add device link regulator.22 err -2
[    4.977435] ldo-io1: at 3300 mV 
[    4.977659] axp20x-rsb sunxi-rsb-3a3: Looking up swin-supply from device tree
[    4.977679] sw: supplied by vcc-3v3
[    4.981167] vcc-3v3: could not add device link regulator.23 err -2
[    4.981295] vcc-ephy: at 3300 mV 
[    4.981576] axp20x-rsb sunxi-rsb-3a3: Looking up drivevbus-supply from device tree
[    4.981590] axp20x-rsb sunxi-rsb-3a3: Looking up drivevbus-supply property in node /soc/rsb at 1f03400/pmic at 3a3 failed
[    4.981614] drivevbus: supplied by regulator-dummy
[    4.986436] regulator-dummy: could not add device link regulator.24 err -2
[    4.986539] usb0-vbus: no parameters
[    4.987174] axp20x-rsb sunxi-rsb-3a3: AXP20X driver loaded
[    4.996209] ac100-rtc ac100-rtc: registered as rtc0
[    5.001098] ac100-rtc ac100-rtc: RTC enabled
[    5.006016] sun4i-usb-phy 1c19400.phy: Looking up usb0_vbus-supply from device tree
[    5.006033] sun4i-usb-phy 1c19400.phy: Looking up usb0_vbus-supply property in node /soc/phy at 1c19400 failed
[    5.006142] phy phy-1c19400.phy.0: Looking up phy-supply from device tree
[    5.006153] phy phy-1c19400.phy.0: Looking up phy-supply property in node /soc/phy at 1c19400 failed
[    5.006270] sun4i-usb-phy 1c19400.phy: Looking up usb1_vbus-supply from device tree
[    5.006312] sun4i-usb-phy 1c19400.phy: Couldn't get regulator usb1_vbus... Deferring probe
[    5.020051] sun8i-a83t-pinctrl 1c20800.pinctrl: initialized sunXi PIO driver
[    5.028283] console [ttyS0] disabled
[    5.052157] 1c28000.serial: ttyS0 at MMIO 0x1c28000 (irq = 42, base_baud = 1500000) is a U6_16550A
[    5.061250] console [ttyS0] enabled
[    5.068271] bootconsole [earlycon0] disabled
[    5.078429] sunxi-mmc 1c0f000.mmc: Looking up vmmc-supply from device tree
[    5.078551] sunxi-mmc 1c0f000.mmc: Looking up vqmmc-supply from device tree
[    5.078565] sunxi-mmc 1c0f000.mmc: Looking up vqmmc-supply property in node /soc/mmc at 1c0f000 failed
[    5.079422] sunxi-mmc 1c0f000.mmc: Got CD GPIO
[    5.109476] sunxi-mmc 1c0f000.mmc: base:0x(ptrval) irq:24
[    5.115503] sunxi-mmc 1c10000.mmc: Looking up vmmc-supply from device tree
[    5.115609] sunxi-mmc 1c10000.mmc: Looking up vqmmc-supply from device tree
[    5.116352] sunxi-mmc 1c10000.mmc: allocated mmc-pwrseq
[    5.144835] sunxi-mmc 1c10000.mmc: base:0x(ptrval) irq:25
[    5.150842] sunxi-mmc 1c11000.mmc: Looking up vmmc-supply from device tree
[    5.150976] sunxi-mmc 1c11000.mmc: Looking up vqmmc-supply from device tree
[    5.157776] mmc0: host does not support reading read-only switch, assuming write-enable
[    5.168115] mmc0: new high speed SDHC card at address 59b4
[    5.175753] mmcblk0: mmc0:59b4 00000 14.9 GiB 
[    5.180362] sunxi-mmc 1c11000.mmc: base:0x(ptrval) irq:26
[    5.180849] usb1-vbus: 5000 mV 
[    5.181218] reg-fixed-voltage reg-usb1-vbus: usb1-vbus supplying 5000000uV
[    5.181674] sun4i-usb-phy 1c19400.phy: Looking up usb0_vbus-supply from device tree
[    5.181689] sun4i-usb-phy 1c19400.phy: Looking up usb0_vbus-supply property in node /soc/phy at 1c19400 failed
[    5.181825] phy phy-1c19400.phy.0: Looking up phy-supply from device tree
[    5.181834] phy phy-1c19400.phy.0: Looking up phy-supply property in node /soc/phy at 1c19400 failed
[    5.181941] sun4i-usb-phy 1c19400.phy: Looking up usb1_vbus-supply from device tree
[    5.182203] phy phy-1c19400.phy.1: Looking up phy-supply from device tree
[    5.182215] phy phy-1c19400.phy.1: Looking up phy-supply property in node /soc/phy at 1c19400 failed
[    5.182320] sun4i-usb-phy 1c19400.phy: Looking up usb2_vbus-supply from device tree
[    5.182330] sun4i-usb-phy 1c19400.phy: Looking up usb2_vbus-supply property in node /soc/phy at 1c19400 failed
[    5.182418] phy phy-1c19400.phy.2: Looking up phy-supply from device tree
[    5.182427] phy phy-1c19400.phy.2: Looking up phy-supply property in node /soc/phy at 1c19400 failed
[    5.183355] ehci-platform 1c1a000.usb: EHCI Host Controller
[    5.189212] ehci-platform 1c1a000.usb: new USB bus registered, assigned bus number 1
[    5.189548] ehci-platform 1c1a000.usb: irq 28, io mem 0x01c1a000
[    5.212983] ehci-platform 1c1a000.usb: USB 2.0 started, EHCI 1.00
[    5.219425] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    5.226470] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.233887]  mmcblk0: p1
[    5.238179] usb usb1: Product: EHCI Host Controller
[    5.243188] usb usb1: Manufacturer: Linux 4.15.0-rc4-next-20171222+ ehci_hcd
[    5.250260] usb usb1: SerialNumber: 1c1a000.usb
[    5.255686] hub 1-0:1.0: USB hub found
[    5.259513] hub 1-0:1.0: 1 port detected
[    5.263822] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
[    5.269572] console [netcon0] enabled
[    5.273325] netconsole: network logging started
[    5.278597] ac100-rtc ac100-rtc: setting system clock to 2017-12-28 20:39:02 UTC (1514493542)
[    5.287486] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    5.293314] vdd-gpu: disabling
[    5.296485] vcc-ephy: disabling
[    5.301896] EXT4-fs (mmcblk0p1): couldn't mount as ext3 due to feature incompatibilities
[    5.311055] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    5.321221] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
[    5.343195] EXT4-fs (mmcblk0p1): mounted filesystem with ordered data mode. Opts: (null)
[    5.351451] VFS: Mounted root (ext4 filesystem) readonly on device 179:1.
[    5.367566] devtmpfs: mounted
[    5.372472] Freeing unused kernel memory: 1024K
[    5.377759] mmc2: new DDR MMC card at address 0001
[    5.379726] mmcblk2: mmc2:0001 8WPD3R 7.28 GiB 
[    5.381258] mmcblk2boot0: mmc2:0001 8WPD3R partition 1 4.00 MiB
[    5.382822] mmcblk2boot1: mmc2:0001 8WPD3R partition 2 4.00 MiB
[    5.470371] mmc1: new high speed SDIO card at address 0001
[    5.633004] usb 1-1: new high-speed USB device number 2 using ehci-platform
[    5.834539] usb 1-1: New USB device found, idVendor=1a40, idProduct=0101
[    5.841615] usb 1-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    5.849030] usb 1-1: Product: USB 2.0 Hub
[    5.854281] hub 1-1:1.0: USB hub found
[    5.858757] hub 1-1:1.0: 4 ports detected
[    6.183024] usb 1-1.1: new high-speed USB device number 3 using ehci-platform
[    6.356172] usb 1-1.1: New USB device found, idVendor=05e3, idProduct=0718
[    6.363586] usb 1-1.1: New USB device strings: Mfr=0, Product=1, SerialNumber=2
[    6.371011] usb 1-1.1: Product: USB Storage
[    6.375406] usb 1-1.1: SerialNumber: 000000000033
[    6.381855] usb-storage 1-1.1:1.0: USB Mass Storage device detected
[    6.401248] scsi host0: usb-storage 1-1.1:1.0
[    7.466681] scsi 0:0:0:0: Direct-Access     USB TO I DE/SATA Device   0016 PQ: 0 ANSI: 4
[    7.484140] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    7.490789] sd 0:0:0:0: [sda] 0 512-byte logical blocks: (0 B/0 B)
[    7.503041] sd 0:0:0:0: [sda] 0-byte physical blocks
[    7.513103] sd 0:0:0:0: [sda] Test WP failed, assume Write Enabled
[    7.526422] sd 0:0:0:0: [sda] Asking for cache data failed
[    7.531936] sd 0:0:0:0: [sda] Assuming drive cache: write through
[    7.559074] sd 0:0:0:0: [sda] Attached SCSI disk
[   14.564013] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   14.695046] axp20x-gpio axp20x-gpio: AXP209 pinctrl and GPIO driver loaded
[   14.781019] dwmac-sun8i 1c30000.ethernet: PTP uses main clock
[   14.781082] dwmac-sun8i 1c30000.ethernet: Looking up phy-supply from device tree
[   14.913317] dwmac-sun8i 1c30000.ethernet: Current syscon value is not the default 1ce6 (expect 0)
[   14.913365] dwmac-sun8i 1c30000.ethernet: Chain mode enabled
[   14.913373] dwmac-sun8i 1c30000.ethernet: No HW DMA feature register supported
[   14.913381] dwmac-sun8i 1c30000.ethernet: Normal descriptors
[   14.913388] dwmac-sun8i 1c30000.ethernet: RX Checksum Offload Engine supported
[   14.913395] dwmac-sun8i 1c30000.ethernet: COE Type 2
[   14.913402] dwmac-sun8i 1c30000.ethernet: TX Checksum insertion supported
[   14.913726] libphy: stmmac: probed
[   15.838616] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   15.838978] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[   15.838993] cfg80211: failed to load regulatory.db
[   15.971608] brcmfmac: brcmf_fw_map_chip_to_name: using brcm/brcmfmac43430a0-sdio.bin for chip 0x00a9a6(43430) rev 0x000000
[   15.972039] usbcore: registered new interface driver brcmfmac
[   15.972147] brcmfmac mmc1:0001:1: Direct firmware load for brcm/brcmfmac43430a0-sdio.bin failed with error -2
[   16.983325] brcmfmac: brcmf_sdio_htclk: HT Avail timeout (1000000): clkctl 0x50
[   17.642892] EXT4-fs (mmcblk0p1): re-mounted. Opts: (null)
[   17.993291] brcmfmac: brcmf_sdio_htclk: HT Avail timeout (1000000): clkctl 0x50
[   25.292693] RTL8211E Gigabit Ethernet stmmac-0:01: attached PHY driver [RTL8211E Gigabit Ethernet] (mii_bus:phy_addr=stmmac-0:01, irq=POLL)
[   25.297646] dwmac-sun8i 1c30000.ethernet eth0: No MAC Management Counters available
[   25.297669] dwmac-sun8i 1c30000.ethernet eth0: PTP not supported by HW
[   30.503958] dwmac-sun8i 1c30000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
[   39.675382] random: crng init done
