From: balbi@kernel.org (Felipe Balbi)
Date: Mon, 29 Aug 2016 10:28:32 +0300
Subject: PROBLEM: DWC3 USB 3.0 not working on Odroid-XU4 with Exynos 5422
In-Reply-To: <1472414695.3845.3.camel@mniewoehner.de>
References: <1472414695.3845.3.camel@mniewoehner.de>
Message-ID: <87lgzgdof3.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Michael Niew?hner <linux@mniewoehner.de> writes:
> [1.] One line summary of the problem:
> DWC3 USB 3.0 not working on Odroid-XU4 with Exynos 5422
>
> [2.] Full description of the problem/report:
> No usb 3.0 devices are being detected when attached while USB 2.0
> devices work on the same port.
> USB 3.0 works after applying patches [9.1] and [9.2], but seems to be
> buggy. The usb hub is redetected every time an usb device is attached.

dwc3 is host, which means it's actually XHCI :-)

Adding Mathias

> dmesg:
> [??192.287080] usb 3-1.2: USB disconnect, device number 7
> [??210.370699] hub 3-1:1.0: hub_ext_port_status failed (err = -71)
> [??210.375159] usb 3-1-port2: connect-debounce failed
> [??210.380126] usb 3-1: USB disconnect, device number 5
> [??210.488917] usb 4-1: USB disconnect, device number 3
> [??210.708861] usb 3-1: new high-speed USB device number 9 using xhci-hcd
> [??210.851308] usb 3-1: New USB device found, idVendor=05e3, idProduct=0610
> [??210.856530] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [??210.863696] usb 3-1: Product: USB2.0 Hub
> [??210.867721] usb 3-1: Manufacturer: GenesysLogic
> [??210.877800] hub 3-1:1.0: USB hub found
> [??210.880600] hub 3-1:1.0: 2 ports detected
> [??210.913438] [drm:hdmi_probe] *ERROR* Failed to get ddc i2c adapter by node
> [??211.468970] usb 3-1.2: new high-speed USB device number 10 using xhci-hcd
> [??211.579279] usb 3-1.2: New USB device found, idVendor=0951, idProduct=1666
> [??211.584667] usb 3-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [??211.592002] usb 3-1.2: Product: DataTraveler 3.0
> [??211.596720] usb 3-1.2: Manufacturer: Kingston
> [??211.601075] usb 3-1.2: SerialNumber: 00190F0C0295BE711962B008
> [??211.607557] usb-storage 3-1.2:1.0: USB Mass Storage device detected
> [??211.613640] scsi host0: usb-storage 3-1.2:1.0
> [??211.620179] [drm:hdmi_probe] *ERROR* Failed to get ddc i2c adapter by node
> [??212.677008] scsi 0:0:0:0: Direct-Access?????Kingston DataTraveler 3.0 PMAP PQ: 0 ANSI: 6
> [??212.685208] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [??212.687323] [drm:hdmi_probe] *ERROR* Failed to get ddc i2c adapter by node
> [??214.209074] usb 4-1: new SuperSpeed USB device number 4 using xhci-hcd
> [??214.231660] usb 4-1: New USB device found, idVendor=05e3, idProduct=0616
> [??214.236882] usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [??214.244057] usb 4-1: Product: USB3.0 Hub
> [??214.248060] usb 4-1: Manufacturer: GenesysLogic
> [??214.254181] hub 4-1:1.0: USB hub found
> [??214.256754] hub 4-1:1.0: 2 ports detected
> [??214.264279] [drm:hdmi_probe] *ERROR* Failed to get ddc i2c adapter by node
> [??214.634773] sd 0:0:0:0: [sda] 61457664 512-byte logical blocks: (31.5 GB/29.3 GiB)
> [??214.641164] sd 0:0:0:0: [sda] Write Protect is off
> [??214.645631] sd 0:0:0:0: [sda] Mode Sense: 23 00 00 00
> [??214.645900] sd 0:0:0:0: [sda] No Caching mode page found
> [??214.650978] sd 0:0:0:0: [sda] Assuming drive cache: write through [??214.682552]??sda: sda1
> [??214.685165] sd 0:0:0:0: [sda] Attached SCSI removable disk
> [??234.526936] usb 3-1.2: USB disconnect, device number 10
>
> [3.] Keywords (i.e., modules, networking, kernel):
> usb 3.0, dwc3, exynos, odroid
> ?
> [4.] Kernel information
> 4.6.x, 4.7.x
>
> [4.1.] Kernel version (from /proc/version):
> Linux version 4.7.2+ (c0d3 at z3r0) (gcc version 5.3.1 20160113 (Linaro
> GCC 5.3-2016.02) ) #1 SMP Sun Aug 28 18:52:25 CEST 2016
>
> [4.2.] Kernel .config file:
> #cat .config | grep -E "(USB|DWC|DRD).*=(m|y)"
> CONFIG_CAN_EMS_USB=m
> CONFIG_CAN_ESD_USB2=m
> CONFIG_CAN_GS_USB=m
> CONFIG_CAN_KVASER_USB=m
> CONFIG_CAN_PEAK_USB=m
> CONFIG_CAN_8DEV_USB=m
> CONFIG_BT_HCIBTUSB=m
> CONFIG_BT_HCIBTUSB_BCM=y
> CONFIG_BT_HCIBTUSB_RTL=y
> CONFIG_USB_NET_DRIVERS=y
> CONFIG_USB_CATC=m
> CONFIG_USB_KAWETH=m
> CONFIG_USB_PEGASUS=m
> CONFIG_USB_RTL8150=m
> CONFIG_USB_RTL8152=m
> CONFIG_USB_USBNET=m
> CONFIG_USB_NET_AX8817X=m
> CONFIG_USB_NET_AX88179_178A=m
> CONFIG_USB_NET_CDCETHER=m
> CONFIG_USB_NET_CDC_EEM=m
> CONFIG_USB_NET_CDC_NCM=m
> CONFIG_USB_NET_HUAWEI_CDC_NCM=m
> CONFIG_USB_NET_CDC_MBIM=m
> CONFIG_USB_NET_DM9601=m
> CONFIG_USB_NET_SR9700=m
> CONFIG_USB_NET_SR9800=m
> CONFIG_USB_NET_SMSC75XX=m
> CONFIG_USB_NET_SMSC95XX=m
> CONFIG_USB_NET_GL620A=m
> CONFIG_USB_NET_NET1080=m
> CONFIG_USB_NET_PLUSB=m
> CONFIG_USB_NET_MCS7830=m
> CONFIG_USB_NET_RNDIS_HOST=m
> CONFIG_USB_NET_CDC_SUBSET_ENABLE=m
> CONFIG_USB_NET_CDC_SUBSET=m
> CONFIG_USB_ALI_M5632=y
> CONFIG_USB_AN2720=y
> CONFIG_USB_BELKIN=y
> CONFIG_USB_ARMLINUX=y
> CONFIG_USB_EPSON2888=y
> CONFIG_USB_KC2190=y
> CONFIG_USB_NET_ZAURUS=m
> CONFIG_USB_NET_CX82310_ETH=m
> CONFIG_USB_NET_KALMIA=m
> CONFIG_USB_NET_QMI_WWAN=m
> CONFIG_USB_HSO=m
> CONFIG_USB_NET_INT51X1=m
> CONFIG_USB_CDC_PHONET=m
> CONFIG_USB_IPHETH=m
> CONFIG_USB_SIERRA_NET=m
> CONFIG_USB_VL600=m
> CONFIG_ATH6KL_USB=m
> CONFIG_AT76C50X_USB=m
> CONFIG_BRCMFMAC_USB=y
> CONFIG_P54_USB=m
> CONFIG_LIBERTAS_USB=m
> CONFIG_LIBERTAS_THINFIRM_USB=m
> CONFIG_RT2500USB=m
> CONFIG_RT73USB=m
> CONFIG_RT2800USB=m
> CONFIG_RT2800USB_RT33XX=y
> CONFIG_RT2800USB_RT35XX=y
> CONFIG_RT2800USB_RT3573=y
> CONFIG_RT2800USB_RT53XX=y
> CONFIG_RT2800USB_RT55XX=y
> CONFIG_RT2X00_LIB_USB=m
> CONFIG_RTLWIFI_USB=m
> CONFIG_RSI_USB=m
> CONFIG_USB_NET_RNDIS_WLAN=m
> CONFIG_WIMAX_I2400M_USB=m
> CONFIG_MOUSE_SYNAPTICS_USB=m
> CONFIG_TABLET_USB_ACECAD=m
> CONFIG_TABLET_USB_AIPTEK=m
> CONFIG_TABLET_USB_GTCO=m
> CONFIG_TABLET_USB_HANWANG=m
> CONFIG_TABLET_USB_KBTAB=m
> CONFIG_TOUCHSCREEN_USB_COMPOSITE=m
> CONFIG_TOUCHSCREEN_USB_EGALAX=y
> CONFIG_TOUCHSCREEN_USB_PANJIT=y
> CONFIG_TOUCHSCREEN_USB_3M=y
> CONFIG_TOUCHSCREEN_USB_ITM=y
> CONFIG_TOUCHSCREEN_USB_ETURBO=y
> CONFIG_TOUCHSCREEN_USB_GUNZE=y
> CONFIG_TOUCHSCREEN_USB_DMC_TSC10=y
> CONFIG_TOUCHSCREEN_USB_IRTOUCH=y
> CONFIG_TOUCHSCREEN_USB_IDEALTEK=y
> CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=y
> CONFIG_TOUCHSCREEN_USB_GOTOP=y
> CONFIG_TOUCHSCREEN_USB_JASTEC=y
> CONFIG_TOUCHSCREEN_USB_ELO=y
> CONFIG_TOUCHSCREEN_USB_E2I=y
> CONFIG_TOUCHSCREEN_USB_ZYTRONIC=y
> CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=y
> CONFIG_TOUCHSCREEN_USB_NEXIO=y
> CONFIG_TOUCHSCREEN_USB_EASYTOUCH=y
> CONFIG_I2C_TINY_USB=m
> CONFIG_MFD_RTSX_USB=m
> CONFIG_IR_MCEUSB=m
> CONFIG_IR_IGORPLUGUSB=m
> CONFIG_IR_TTUSBIR=m
> CONFIG_MEDIA_USB_SUPPORT=y
> CONFIG_USB_VIDEO_CLASS=m
> CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
> CONFIG_USB_GSPCA=m
> CONFIG_USB_M5602=m
> CONFIG_USB_STV06XX=m
> CONFIG_USB_GL860=m
> CONFIG_USB_GSPCA_BENQ=m
> CONFIG_USB_GSPCA_CONEX=m
> CONFIG_USB_GSPCA_CPIA1=m
> CONFIG_USB_GSPCA_DTCS033=m
> CONFIG_USB_GSPCA_ETOMS=m
> CONFIG_USB_GSPCA_FINEPIX=m
> CONFIG_USB_GSPCA_JEILINJ=m
> CONFIG_USB_GSPCA_JL2005BCD=m
> CONFIG_USB_GSPCA_KINECT=m
> CONFIG_USB_GSPCA_KONICA=m
> CONFIG_USB_GSPCA_MARS=m
> CONFIG_USB_GSPCA_MR97310A=m
> CONFIG_USB_GSPCA_NW80X=m
> CONFIG_USB_GSPCA_OV519=m
> CONFIG_USB_GSPCA_OV534=m
> CONFIG_USB_GSPCA_OV534_9=m
> CONFIG_USB_GSPCA_PAC207=m
> CONFIG_USB_GSPCA_PAC7302=m
> CONFIG_USB_GSPCA_PAC7311=m
> CONFIG_USB_GSPCA_SE401=m
> CONFIG_USB_GSPCA_SN9C2028=m
> CONFIG_USB_GSPCA_SN9C20X=m
> CONFIG_USB_GSPCA_SONIXB=m
> CONFIG_USB_GSPCA_SONIXJ=m
> CONFIG_USB_GSPCA_SPCA500=m
> CONFIG_USB_GSPCA_SPCA501=m
> CONFIG_USB_GSPCA_SPCA505=m
> CONFIG_USB_GSPCA_SPCA506=m
> CONFIG_USB_GSPCA_SPCA508=m
> CONFIG_USB_GSPCA_SPCA561=m
> CONFIG_USB_GSPCA_SPCA1528=m
> CONFIG_USB_GSPCA_SQ905=m
> CONFIG_USB_GSPCA_SQ905C=m
> CONFIG_USB_GSPCA_SQ930X=m
> CONFIG_USB_GSPCA_STK014=m
> CONFIG_USB_GSPCA_STK1135=m
> CONFIG_USB_GSPCA_STV0680=m
> CONFIG_USB_GSPCA_SUNPLUS=m
> CONFIG_USB_GSPCA_T613=m
> CONFIG_USB_GSPCA_TOPRO=m
> CONFIG_USB_GSPCA_TV8532=m
> CONFIG_USB_GSPCA_VC032X=m
> CONFIG_USB_GSPCA_VICAM=m
> CONFIG_USB_GSPCA_XIRLINK_CIT=m
> CONFIG_USB_GSPCA_ZC3XX=m
> CONFIG_USB_PWC=m
> CONFIG_USB_PWC_INPUT_EVDEV=y
> CONFIG_USB_ZR364XX=m
> CONFIG_USB_STKWEBCAM=m
> CONFIG_USB_S2255=m
> CONFIG_VIDEO_USBTV=m
> CONFIG_VIDEO_PVRUSB2=m
> CONFIG_VIDEO_PVRUSB2_SYSFS=y
> CONFIG_VIDEO_PVRUSB2_DVB=y
> CONFIG_VIDEO_USBVISION=m
> CONFIG_DVB_USB=m
> CONFIG_DVB_USB_A800=m
> CONFIG_DVB_USB_DIBUSB_MB=m
> CONFIG_DVB_USB_DIBUSB_MB_FAULTY=y
> CONFIG_DVB_USB_DIBUSB_MC=m
> CONFIG_DVB_USB_DIB0700=m
> CONFIG_DVB_USB_UMT_010=m
> CONFIG_DVB_USB_CXUSB=m
> CONFIG_DVB_USB_M920X=m
> CONFIG_DVB_USB_DIGITV=m
> CONFIG_DVB_USB_VP7045=m
> CONFIG_DVB_USB_VP702X=m
> CONFIG_DVB_USB_GP8PSK=m
> CONFIG_DVB_USB_NOVA_T_USB2=m
> CONFIG_DVB_USB_TTUSB2=m
> CONFIG_DVB_USB_DTT200U=m
> CONFIG_DVB_USB_OPERA1=m
> CONFIG_DVB_USB_AF9005=m
> CONFIG_DVB_USB_AF9005_REMOTE=m
> CONFIG_DVB_USB_PCTV452E=m
> CONFIG_DVB_USB_DW2102=m
> CONFIG_DVB_USB_CINERGY_T2=m
> CONFIG_DVB_USB_DTV5100=m
> CONFIG_DVB_USB_FRIIO=m
> CONFIG_DVB_USB_AZ6027=m
> CONFIG_DVB_USB_TECHNISAT_USB2=m
> CONFIG_DVB_USB_V2=m
> CONFIG_DVB_USB_AF9015=m
> CONFIG_DVB_USB_AF9035=m
> CONFIG_DVB_USB_ANYSEE=m
> CONFIG_DVB_USB_AU6610=m
> CONFIG_DVB_USB_AZ6007=m
> CONFIG_DVB_USB_CE6230=m
> CONFIG_DVB_USB_EC168=m
> CONFIG_DVB_USB_GL861=m
> CONFIG_DVB_USB_LME2510=m
> CONFIG_DVB_USB_MXL111SF=m
> CONFIG_DVB_USB_RTL28XXU=m
> CONFIG_DVB_USB_DVBSKY=m
> CONFIG_SMS_USB_DRV=m
> CONFIG_DVB_B2C2_FLEXCOP_USB=m
> CONFIG_USB_AIRSPY=m
> CONFIG_USB_HACKRF=m
> CONFIG_USB_MSI2500=m
> CONFIG_USB_SI470X=m
> CONFIG_USB_MR800=m
> CONFIG_USB_KEENE=m
> CONFIG_USB_RAREMONO=m
> CONFIG_USB_MA901=m
> CONFIG_SND_USB=y
> CONFIG_SND_USB_AUDIO=m
> CONFIG_SND_USB_UA101=m
> CONFIG_SND_USB_CAIAQ=m
> CONFIG_SND_USB_CAIAQ_INPUT=y
> CONFIG_SND_USB_6FIRE=m
> CONFIG_SND_USB_HIFACE=m
> CONFIG_SND_USB_LINE6=m
> CONFIG_SND_USB_POD=m
> CONFIG_SND_USB_PODHD=m
> CONFIG_SND_USB_TONEPORT=m
> CONFIG_SND_USB_VARIAX=m
> CONFIG_USB_HID=y
> CONFIG_USB_HIDDEV=y
> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> CONFIG_USB_SUPPORT=y
> CONFIG_USB_COMMON=y
> CONFIG_USB_ARCH_HAS_HCD=y
> CONFIG_USB=y
> CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
> CONFIG_USB_DEFAULT_PERSIST=y
> CONFIG_USB_DYNAMIC_MINORS=y
> CONFIG_USB_MON=y
> CONFIG_USB_WUSB_CBAF=m
> CONFIG_USB_XHCI_HCD=m
> CONFIG_USB_XHCI_PLATFORM=m
> CONFIG_USB_EHCI_HCD=m
> CONFIG_USB_EHCI_ROOT_HUB_TT=y
> CONFIG_USB_EHCI_TT_NEWSCHED=y
> CONFIG_USB_EHCI_EXYNOS=m
> CONFIG_USB_EHCI_HCD_PLATFORM=m
> CONFIG_USB_OHCI_HCD=m
> CONFIG_USB_OHCI_EXYNOS=m
> CONFIG_USB_OHCI_HCD_PLATFORM=m
> CONFIG_USB_ACM=m
> CONFIG_USB_PRINTER=m
> CONFIG_USB_WDM=m
> CONFIG_USB_TMC=m
> CONFIG_USB_STORAGE=y
> CONFIG_USB_STORAGE_REALTEK=m
> CONFIG_USB_STORAGE_DATAFAB=m
> CONFIG_USB_STORAGE_FREECOM=m
> CONFIG_USB_STORAGE_ISD200=m
> CONFIG_USB_STORAGE_USBAT=m
> CONFIG_USB_STORAGE_SDDR09=m
> CONFIG_USB_STORAGE_SDDR55=m
> CONFIG_USB_STORAGE_JUMPSHOT=m
> CONFIG_USB_STORAGE_ALAUDA=m
> CONFIG_USB_STORAGE_ONETOUCH=m
> CONFIG_USB_STORAGE_KARMA=m
> CONFIG_USB_STORAGE_CYPRESS_ATACB=m
> CONFIG_USB_STORAGE_ENE_UB6250=m
> CONFIG_USB_UAS=m
> CONFIG_USB_MDC800=m
> CONFIG_USB_MICROTEK=m
> CONFIG_USB_DWC3=m
> CONFIG_USB_DWC3_HOST=y
> CONFIG_USB_DWC3_EXYNOS=m
> CONFIG_USB_DWC3_OF_SIMPLE=m
> CONFIG_USB_DWC2=m
> CONFIG_USB_DWC2_HOST=y
> CONFIG_USB_CHIPIDEA=m
> CONFIG_USB_CHIPIDEA_OF=m
> CONFIG_USB_CHIPIDEA_UDC=y
> CONFIG_USB_SERIAL=m
> CONFIG_USB_SERIAL_GENERIC=y
> CONFIG_USB_SERIAL_SIMPLE=m
> CONFIG_USB_SERIAL_AIRCABLE=m
> CONFIG_USB_SERIAL_ARK3116=m
> CONFIG_USB_SERIAL_BELKIN=m
> CONFIG_USB_SERIAL_CH341=m
> CONFIG_USB_SERIAL_WHITEHEAT=m
> CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
> CONFIG_USB_SERIAL_CP210X=m
> CONFIG_USB_SERIAL_CYPRESS_M8=m
> CONFIG_USB_SERIAL_EMPEG=m
> CONFIG_USB_SERIAL_FTDI_SIO=m
> CONFIG_USB_SERIAL_VISOR=m
> CONFIG_USB_SERIAL_IPAQ=m
> CONFIG_USB_SERIAL_IR=m
> CONFIG_USB_SERIAL_EDGEPORT=m
> CONFIG_USB_SERIAL_EDGEPORT_TI=m
> CONFIG_USB_SERIAL_F81232=m
> CONFIG_USB_SERIAL_GARMIN=m
> CONFIG_USB_SERIAL_IPW=m
> CONFIG_USB_SERIAL_IUU=m
> CONFIG_USB_SERIAL_KEYSPAN_PDA=m
> CONFIG_USB_SERIAL_KEYSPAN=m
> CONFIG_USB_SERIAL_KLSI=m
> CONFIG_USB_SERIAL_KOBIL_SCT=m
> CONFIG_USB_SERIAL_MCT_U232=m
> CONFIG_USB_SERIAL_METRO=m
> CONFIG_USB_SERIAL_MOS7720=m
> CONFIG_USB_SERIAL_MOS7840=m
> CONFIG_USB_SERIAL_MXUPORT=m
> CONFIG_USB_SERIAL_NAVMAN=m
> CONFIG_USB_SERIAL_PL2303=m
> CONFIG_USB_SERIAL_OTI6858=m
> CONFIG_USB_SERIAL_QCAUX=m
> CONFIG_USB_SERIAL_QUALCOMM=m
> CONFIG_USB_SERIAL_SPCP8X5=m
> CONFIG_USB_SERIAL_SAFE=m
> CONFIG_USB_SERIAL_SIERRAWIRELESS=m
> CONFIG_USB_SERIAL_SYMBOL=m
> CONFIG_USB_SERIAL_TI=m
> CONFIG_USB_SERIAL_CYBERJACK=m
> CONFIG_USB_SERIAL_XIRCOM=m
> CONFIG_USB_SERIAL_WWAN=m
> CONFIG_USB_SERIAL_OPTION=m
> CONFIG_USB_SERIAL_OMNINET=m
> CONFIG_USB_SERIAL_OPTICON=m
> CONFIG_USB_SERIAL_XSENS_MT=m
> CONFIG_USB_SERIAL_WISHBONE=m
> CONFIG_USB_SERIAL_SSU100=m
> CONFIG_USB_SERIAL_QT2=m
> CONFIG_USB_SERIAL_DEBUG=m
> CONFIG_USB_EMI62=m
> CONFIG_USB_EMI26=m
> CONFIG_USB_ADUTUX=m
> CONFIG_USB_SEVSEG=m
> CONFIG_USB_RIO500=m
> CONFIG_USB_LEGOTOWER=m
> CONFIG_USB_LCD=m
> CONFIG_USB_LED=m
> CONFIG_USB_CYPRESS_CY7C63=m
> CONFIG_USB_CYTHERM=m
> CONFIG_USB_IDMOUSE=m
> CONFIG_USB_FTDI_ELAN=m
> CONFIG_USB_APPLEDISPLAY=m
> CONFIG_USB_LD=m
> CONFIG_USB_TRANCEVIBRATOR=m
> CONFIG_USB_IOWARRIOR=m
> CONFIG_USB_TEST=m
> CONFIG_USB_EHSET_TEST_FIXTURE=m
> CONFIG_USB_ISIGHTFW=m
> CONFIG_USB_YUREX=m
> CONFIG_USB_EZUSB_FX2=m
> CONFIG_USB_HSIC_USB3503=m
> CONFIG_USB_PHY=y
> CONFIG_NOP_USB_XCEIV=y
> CONFIG_AM335X_CONTROL_USB=m
> CONFIG_AM335X_PHY_USB=m
> CONFIG_USB_GPIO_VBUS=m
> CONFIG_USB_ULPI=y
> CONFIG_USB_ULPI_VIEWPORT=y
> CONFIG_USB_GADGET=y
> CONFIG_USB_LIBCOMPOSITE=m
> CONFIG_USB_F_ACM=m
> CONFIG_USB_U_SERIAL=m
> CONFIG_USB_U_ETHER=m
> CONFIG_USB_F_OBEX=m
> CONFIG_USB_F_ECM=m
> CONFIG_USB_F_PHONET=m
> CONFIG_USB_F_SUBSET=m
> CONFIG_USB_F_RNDIS=m
> CONFIG_USB_F_MASS_STORAGE=m
> CONFIG_USB_ETH=m
> CONFIG_USB_ETH_RNDIS=y
> CONFIG_USB_GADGETFS=m
> CONFIG_USB_G_NOKIA=m
> CONFIG_USB_LED_TRIG=y
> CONFIG_MMC_REALTEK_USB=m
> CONFIG_MEMSTICK_REALTEK_USB=m
> CONFIG_PHY_SAMSUNG_USB2=m
> CONFIG_PHY_EXYNOS5250_USB2=y
> CONFIG_PHY_EXYNOS5_USBDRD=m
>
> [5.] Most recent kernel version which did not have the bug:
> I did not test any other versions.
>
> [6.] Output of Oops:
> -
>
> [7.] A small shell script or example program which triggers the
> ?????problem (if possible)
> -
>
> [8.] Environment
> [8.1.] Software (add the output of the ver_linux script here)
> Linux c0xu4 4.7.2+ #1 SMP Sun Aug 28 18:52:25 CEST 2016 armv7l
> GNU/Linux
> ?
> GNU C			4.9.2
> GNU Make		4.0
> Binutils		2.25
> Util-linux		2.25.2
> Mount			2.25.2
> Module-init-tools	18
> E2fsprogs		1.42.12
> Linux C Library		2.19
> Dynamic linker (ldd)	2.19
> Linux C++ Library	6.0.20
> Procps			3.3.9
> Net-tools		1.60
> Kbd			1.15.5
> Console-tools		1.15.5
> Sh-utils		8.23
> Udev			215
> Modules Loaded		autofs4 cdc_ether dwc3 dwc3_exynos
> ehci_exynos ehci_hcd evdev hid_generic ip6table_filter ip6_tables
> iptable_filter iptable_mangle iptable_nat ip_tables ipt_REJECT mii
> nf_conntrack nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat nf_nat_ipv4
> nf_reject_ipv4 ohci_exynos ohci_hcd phy_exynos5_usbdrd phy_exynos_usb2
> r8152 s5p_sss snd snd_hwdep snd_pcm snd_rawmidi snd_seq_device
> snd_timer snd_usb_audio snd_usbmidi_lib soundcore tun usbnet xhci_hcd
> xhci_plat_hcd x_tables xt_conntrack xt_multiport xt_tcpudp
>
> [8.2.] Processor information (from /proc/cpuinfo):
> processor	: 0
> vendor_id	: GenuineIntel
> cpu family	: 6
> model		: 78
> model name	: Intel(R) Core(TM) i5-6200U CPU @ 2.30GHz
> stepping	: 3
> microcode	: 0x8a
> cpu MHz		: 2739.111
> cache size	: 3072 KB
> physical id	: 0
> siblings	: 4
> core id		: 0
> cpu cores	: 2
> apicid		: 0
> initial apicid	: 0
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 22
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
> pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
> syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts
> rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
> dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid
> sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c
> rdrand lahf_lm abm 3dnowprefetch epb intel_pt tpr_shadow vnmi
> flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms
> invpcid mpx rdseed adx smap clflushopt xsaveopt xsavec xgetbv1 dtherm
> ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp
> bugs		:
> bogomips	: 4801.87
> clflush size	: 64
> cache_alignment	: 64
> address sizes	: 39 bits physical, 48 bits virtual
> power management:
>
> processor	: 1
> vendor_id	: GenuineIntel
> cpu family	: 6
> model		: 78
> model name	: Intel(R) Core(TM) i5-6200U CPU @ 2.30GHz
> stepping	: 3
> microcode	: 0x8a
> cpu MHz		: 2618.701
> cache size	: 3072 KB
> physical id	: 0
> siblings	: 4
> core id		: 1
> cpu cores	: 2
> apicid		: 2
> initial apicid	: 2
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 22
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
> pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
> syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts
> rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
> dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid
> sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c
> rdrand lahf_lm abm 3dnowprefetch epb intel_pt tpr_shadow vnmi
> flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms
> invpcid mpx rdseed adx smap clflushopt xsaveopt xsavec xgetbv1 dtherm
> ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp
> bugs		:
> bogomips	: 4802.09
> clflush size	: 64
> cache_alignment	: 64
> address sizes	: 39 bits physical, 48 bits virtual
> power management:
>
> processor	: 2
> vendor_id	: GenuineIntel
> cpu family	: 6
> model		: 78
> model name	: Intel(R) Core(TM) i5-6200U CPU @ 2.30GHz
> stepping	: 3
> microcode	: 0x8a
> cpu MHz		: 2765.917
> cache size	: 3072 KB
> physical id	: 0
> siblings	: 4
> core id		: 0
> cpu cores	: 2
> apicid		: 1
> initial apicid	: 1
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 22
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
> pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
> syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts
> rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
> dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid
> sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c
> rdrand lahf_lm abm 3dnowprefetch epb intel_pt tpr_shadow vnmi
> flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms
> invpcid mpx rdseed adx smap clflushopt xsaveopt xsavec xgetbv1 dtherm
> ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp
> bugs		:
> bogomips	: 4803.65
> clflush size	: 64
> cache_alignment	: 64
> address sizes	: 39 bits physical, 48 bits virtual
> power management:
>
> processor	: 3
> vendor_id	: GenuineIntel
> cpu family	: 6
> model		: 78
> model name	: Intel(R) Core(TM) i5-6200U CPU @ 2.30GHz
> stepping	: 3
> microcode	: 0x8a
> cpu MHz		: 2757.421
> cache size	: 3072 KB
> physical id	: 0
> siblings	: 4
> core id		: 1
> cpu cores	: 2
> apicid		: 3
> initial apicid	: 3
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 22
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
> pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
> syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts
> rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
> dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid
> sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c
> rdrand lahf_lm abm 3dnowprefetch epb intel_pt tpr_shadow vnmi
> flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms
> invpcid mpx rdseed adx smap clflushopt xsaveopt xsavec xgetbv1 dtherm
> ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp
> bugs		:
> bogomips	: 4803.17
> clflush size	: 64
> cache_alignment	: 64
> address sizes	: 39 bits physical, 48 bits virtual
> power management:
>
>
> [8.3.] Module information (from /proc/modules):
> mmc_block 40960 0 - Live 0xffffffffc0cb3000
> xfrm_user 32768 1 - Live 0xffffffffc0caa000
> xfrm_algo 16384 1 xfrm_user, Live 0xffffffffc0c5c000
> xt_addrtype 16384 2 - Live 0xffffffffc0c46000
> br_netfilter 24576 0 - Live 0xffffffffc0c7a000
> fuse 98304 2 - Live 0xffffffffc0c91000
> dm_thin_pool 61440 1 - Live 0xffffffffc0c81000
> dm_persistent_data 57344 1 dm_thin_pool, Live 0xffffffffc0c6b000
> dm_bio_prison 16384 1 dm_thin_pool, Live 0xffffffffc0c62000
> dm_bufio 24576 1 dm_persistent_data, Live 0xffffffffc0c55000
> libcrc32c 16384 1 dm_persistent_data, Live 0xffffffffc0c50000
> crc32c_generic 16384 0 - Live 0xffffffffc0c4b000
> loop 28672 4 - Live 0xffffffffc0c3e000
> xt_CHECKSUM 16384 1 - Live 0xffffffffc0bf3000
> iptable_mangle 16384 1 - Live 0xffffffffc0c39000
> ipt_MASQUERADE 16384 4 - Live 0xffffffffc0c34000
> nf_nat_masquerade_ipv4 16384 1 ipt_MASQUERADE, Live 0xffffffffc0c2f000
> iptable_nat 16384 1 - Live 0xffffffffc0c2a000
> nf_nat_ipv4 16384 1 iptable_nat, Live 0xffffffffc07ef000
> nf_nat 24576 2 nf_nat_masquerade_ipv4,nf_nat_ipv4, Live
> 0xffffffffc0bec000
> ipt_REJECT 16384 2 - Live 0xffffffffc07e1000
> nf_reject_ipv4 16384 1 ipt_REJECT, Live 0xffffffffc07dc000
> xt_tcpudp 16384 6 - Live 0xffffffffc0be7000
> tun 28672 1 - Live 0xffffffffc07e7000
> bridge 122880 1 br_netfilter, Live 0xffffffffc0c0b000
> stp 16384 1 bridge, Live 0xffffffffc07d7000
> llc 16384 2 bridge,stp, Live 0xffffffffc07ce000
> ebtable_filter 16384 0 - Live 0xffffffffc07c9000
> ebtables 32768 1 ebtable_filter, Live 0xffffffffc07bc000
> ip6_tables 28672 0 - Live 0xffffffffc09cf000
> snd_hda_codec_hdmi 45056 1 - Live 0xffffffffc0aee000
> snd_hda_codec_realtek 69632 1 - Live 0xffffffffc0bf9000
> snd_hda_codec_generic 69632 1 snd_hda_codec_realtek, Live
> 0xffffffffc0ba7000
> nf_conntrack_ipv4 16384 4 - Live 0xffffffffc09a1000
> nf_defrag_ipv4 16384 1 nf_conntrack_ipv4, Live 0xffffffffc091f000
> xt_conntrack 16384 3 - Live 0xffffffffc062f000
> nf_conntrack 90112 5
> nf_nat_masquerade_ipv4,nf_nat_ipv4,nf_nat,nf_conntrack_ipv4,xt_conntrac
> k, Live 0xffffffffc0bd0000
> iptable_filter 16384 1 - Live 0xffffffffc04cb000
> rc_su3000 16384 0 - Live 0xffffffffc0bcb000
> snd_soc_skl 57344 0 - Live 0xffffffffc0bbc000
> snd_soc_skl_ipc 32768 1 snd_soc_skl, Live 0xffffffffc097c000
> snd_soc_sst_ipc 16384 1 snd_soc_skl_ipc, Live 0xffffffffc0977000
> snd_soc_sst_dsp 36864 1 snd_soc_skl_ipc, Live 0xffffffffc09a6000
> snd_hda_ext_core 20480 1 snd_soc_skl, Live 0xffffffffc093b000
> snd_soc_sst_match 16384 1 snd_soc_skl, Live 0xffffffffc0936000
> snd_soc_core 180224 1 snd_soc_skl, Live 0xffffffffc0b7a000
> snd_compress 20480 1 snd_soc_core, Live 0xffffffffc0919000
> snd_pcm_dmaengine 16384 1 snd_soc_core, Live 0xffffffffc0665000
> ac97_bus 16384 1 snd_soc_core, Live 0xffffffffc0660000
> dw_dmac_core 24576 1 snd_soc_sst_dsp, Live 0xffffffffc0540000
> ts2020 20480 1 - Live 0xffffffffc04f3000
> ds3000 20480 1 - Live 0xffffffffc0514000
> nls_iso8859_1 16384 1 - Live 0xffffffffc04e9000
> nls_cp437 20480 1 - Live 0xffffffffc0508000
> vfat 20480 1 - Live 0xffffffffc0502000
> fat 65536 1 vfat, Live 0xffffffffc08c9000
> arc4 16384 2 - Live 0xffffffffc055b000
> iTCO_wdt 16384 0 - Live 0xffffffffc0529000
> intel_rapl 20480 0 - Live 0xffffffffc04d2000
> iTCO_vendor_support 16384 1 iTCO_wdt, Live 0xffffffffc067a000
> x86_pkg_temp_thermal 16384 0 - Live 0xffffffffc04ee000
> intel_powerclamp 16384 0 - Live 0xffffffffc050f000
> coretemp 16384 0 - Live 0xffffffffc02f4000
> mousedev 20480 0 - Live 0xffffffffc04bb000
> kvm_intel 184320 0 - Live 0xffffffffc0a7c000
> kvm 507904 1 kvm_intel, Live 0xffffffffc0afd000
> irqbypass 16384 1 kvm, Live 0xffffffffc063e000
> iwlmvm 266240 0 - Live 0xffffffffc0aac000
> mac80211 659456 1 iwlmvm, Live 0xffffffffc09da000
> pcspkr 16384 0 - Live 0xffffffffc062a000
> snd_hda_intel 32768 2 - Live 0xffffffffc05c1000
> psmouse 118784 0 - Live 0xffffffffc09b1000
> serio_raw 16384 0 - Live 0xffffffffc059c000
> snd_hda_codec 106496 4
> snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_
> intel, Live 0xffffffffc0986000
> e1000e 217088 0 - Live 0xffffffffc0941000
> snd_hda_core 65536 7
> snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_soc_
> skl,snd_hda_ext_core,snd_hda_intel,snd_hda_codec, Live
> 0xffffffffc0925000
> snd_hwdep 16384 1 snd_hda_codec, Live 0xffffffffc053b000
> snd_pcm 86016 8
> snd_hda_codec_hdmi,snd_soc_skl,snd_hda_ext_core,snd_soc_core,snd_pcm_dm
> aengine,snd_hda_intel,snd_hda_codec,snd_hda_core, Live
> 0xffffffffc0903000
> ptp 20480 1 e1000e, Live 0xffffffffc0531000
> snd_timer 28672 1 snd_pcm, Live 0xffffffffc04c3000
> pps_core 20480 1 ptp, Live 0xffffffffc08fd000
> i2c_i801 20480 0 - Live 0xffffffffc08f7000
> hid_generic 16384 0 - Live 0xffffffffc08f2000
> joydev 20480 0 - Live 0xffffffffc08e8000
> evdev 24576 16 - Live 0xffffffffc08dd000
> input_leds 16384 0 - Live 0xffffffffc0684000
> mac_hid 16384 0 - Live 0xffffffffc067f000
> dvb_usb_dw2102 65536 0 - Live 0xffffffffc0888000
> dvb_usb 24576 1 dvb_usb_dw2102, Live 0xffffffffc066a000
> dvb_core 106496 2 dvb_usb_dw2102,dvb_usb, Live 0xffffffffc086d000
> rc_core 24576 4 rc_su3000,dvb_usb_dw2102,dvb_usb, Live
> 0xffffffffc0623000
> iwlwifi 184320 1 iwlmvm, Live 0xffffffffc089b000
> cfg80211 491520 3 iwlmvm,mac80211,iwlwifi, Live 0xffffffffc07f4000
> rtsx_pci_ms 20480 0 - Live 0xffffffffc061d000
> i915 1236992 15 - Live 0xffffffffc068d000
> memstick 16384 1 rtsx_pci_ms, Live 0xffffffffc0614000
> shpchp 32768 0 - Live 0xffffffffc0671000
> drm_kms_helper 114688 1 i915, Live 0xffffffffc0643000
> mei_me 32768 0 - Live 0xffffffffc0635000
> drm 294912 9 i915,drm_kms_helper, Live 0xffffffffc05cb000
> mei 81920 1 mei_me, Live 0xffffffffc05ac000
> intel_pch_thermal 16384 0 - Live 0xffffffffc05a7000
> intel_gtt 20480 1 i915, Live 0xffffffffc05a1000
> syscopyarea 16384 1 drm_kms_helper, Live 0xffffffffc04e4000
> sysfillrect 16384 1 drm_kms_helper, Live 0xffffffffc0560000
> sysimgblt 16384 1 drm_kms_helper, Live 0xffffffffc0520000
> fb_sys_fops 16384 1 drm_kms_helper, Live 0xffffffffc04df000
> i2c_algo_bit 16384 1 i915, Live 0xffffffffc051b000
> thermal 20480 0 - Live 0xffffffffc0596000
> thinkpad_acpi 77824 1 - Live 0xffffffffc057e000
> wmi 16384 0 - Live 0xffffffffc04fd000
> nvram 16384 1 thinkpad_acpi, Live 0xffffffffc048b000
> snd 65536 15
> snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_soc_
> core,snd_compress,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_tim
> er,thinkpad_acpi, Live 0xffffffffc056d000
> soundcore 16384 1 snd, Live 0xffffffffc04b6000
> led_class 16384 3 iwlmvm,input_leds,thinkpad_acpi, Live
> 0xffffffffc04ad000
> rfkill 20480 3 cfg80211,thinkpad_acpi, Live 0xffffffffc04d9000
> ac 16384 0 - Live 0xffffffffc0565000
> video 36864 2 i915,thinkpad_acpi, Live 0xffffffffc0551000
> battery 20480 0 - Live 0xffffffffc054b000
> tpm_tis 20480 0 - Live 0xffffffffc0499000
> fjes 28672 0 - Live 0xffffffffc0491000
> button 16384 1 i915, Live 0xffffffffc02cf000
> tpm 36864 1 tpm_tis, Live 0xffffffffc0481000
> sch_fq_codel 20480 3 - Live 0xffffffffc04a7000
> vboxnetflt 28672 0 - Live 0xffffffffc049f000 (O)
> vboxnetadp 28672 0 - Live 0xffffffffc0398000 (O)
> pci_stub 16384 1 - Live 0xffffffffc026e000
> vboxpci 24576 0 - Live 0xffffffffc02de000 (O)
> vboxdrv 385024 3 vboxnetflt,vboxnetadp,vboxpci, Live 0xffffffffc0422000
> (O)
> ip_tables 24576 3 iptable_mangle,iptable_nat,iptable_filter, Live
> 0xffffffffc0323000
> x_tables 28672 11
> xt_addrtype,xt_CHECKSUM,iptable_mangle,ipt_MASQUERADE,ipt_REJECT,xt_tcp
> udp,ebtables,ip6_tables,xt_conntrack,iptable_filter,ip_tables, Live
> 0xffffffffc0313000
> ext4 516096 1 - Live 0xffffffffc03a3000
> crc16 16384 1 ext4, Live 0xffffffffc023a000
> jbd2 90112 1 ext4, Live 0xffffffffc02b0000
> mbcache 16384 2 ext4, Live 0xffffffffc0269000
> algif_skcipher 20480 0 - Live 0xffffffffc021f000
> af_alg 16384 1 algif_skcipher, Live 0xffffffffc0198000
> usbhid 45056 0 - Live 0xffffffffc038c000
> dm_crypt 28672 1 - Live 0xffffffffc01a4000
> dm_mod 102400 12 dm_thin_pool,dm_persistent_data,dm_bufio,dm_crypt,
> Live 0xffffffffc0372000
> sd_mod 36864 3 - Live 0xffffffffc01e5000
> rtsx_pci_sdmmc 24576 0 - Live 0xffffffffc01de000
> mmc_core 118784 2 mmc_block,rtsx_pci_sdmmc, Live 0xffffffffc0354000
> atkbd 24576 0 - Live 0xffffffffc019d000
> libps2 16384 2 psmouse,atkbd, Live 0xffffffffc02ef000
> crct10dif_pclmul 16384 0 - Live 0xffffffffc0303000
> crc32_pclmul 16384 0 - Live 0xffffffffc0226000
> crc32c_intel 24576 1 - Live 0xffffffffc031c000
> ghash_clmulni_intel 16384 0 - Live 0xffffffffc021a000
> aesni_intel 167936 3 - Live 0xffffffffc032a000
> aes_x86_64 20480 1 aesni_intel, Live 0xffffffffc030d000
> lrw 16384 1 aesni_intel, Live 0xffffffffc02fe000
> gf128mul 16384 1 lrw, Live 0xffffffffc0308000
> glue_helper 16384 1 aesni_intel, Live 0xffffffffc02f9000
> ablk_helper 16384 1 aesni_intel, Live 0xffffffffc0193000
> cryptd 20480 4 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
> 0xffffffffc02e5000
> ahci 36864 2 - Live 0xffffffffc02d4000
> libahci 28672 1 ahci, Live 0xffffffffc02c7000
> libata 204800 2 ahci,libahci, Live 0xffffffffc027d000
> xhci_pci 16384 0 - Live 0xffffffffc0274000
> xhci_hcd 159744 1 xhci_pci, Live 0xffffffffc0241000
> rtsx_pci 45056 2 rtsx_pci_ms,rtsx_pci_sdmmc, Live 0xffffffffc022e000
> scsi_mod 155648 2 sd_mod,libata, Live 0xffffffffc01f3000
> usbcore 200704 5 dvb_usb_dw2102,dvb_usb,usbhid,xhci_pci,xhci_hcd, Live
> 0xffffffffc01ac000
> usb_common 16384 1 usbcore, Live 0xffffffffc018e000
> i8042 24576 1 libps2, Live 0xffffffffc017c000
> serio 20480 7 psmouse,serio_raw,atkbd,i8042, Live 0xffffffffc0188000
> hid_cherry 16384 0 - Live 0xffffffffc0183000
> hid 114688 3 hid_generic,usbhid,hid_cherry, Live 0xffffffffc015f000
> jitterentropy_rng 16384 0 - Live 0xffffffffc015a000
> sha256_ssse3 32768 1 - Live 0xffffffffc0151000
> sha256_generic 20480 1 sha256_ssse3, Live 0xffffffffc0148000
> hmac 16384 1 - Live 0xffffffffc0140000
> drbg 32768 1 - Live 0xffffffffc0133000
> ansi_cprng 16384 0 - Live 0xffffffffc012b000
>
> [8.4.] Loaded driver and hardware information (/proc/ioports,
> /proc/iomem)
> #ioports
> empty
>
> #iomem
> 02020000-02073fff : 2020000.sysram:
> 03810000-0381000b : /audss-clock-controller at 3810000
> 03860000-03860fff : /pinctrl at 03860000
> 03880000-03880fff : /amba/adma at 03880000
> ? 03880000-03880fff : /amba/adma at 03880000
> 10040000-10044fff : /system-controller at 10040000
> 101e0000-101e00ff : /rtc at 101E0000
> 10800000-10800fff : /amba/mdma at 10800000
> ? 10800000-10800fff : /amba/mdma at 10800000
> 10830000-108302ff : /sss at 10830000
> 10a60000-10a60fff : /sysmmu at 0x10A60000
> 10a70000-10a70fff : /sysmmu at 0x10A70000
> 10ca1000-10ca11ff : /nocp at 10CA1000
> 10ca1400-10ca15ff : /nocp at 10CA1400
> 10ca1800-10ca19ff : /nocp at 10CA1800
> 10ca1c00-10ca1dff : /nocp at 10CA1C00
> 11200000-11200fff : /sysmmu at 0x11200000
> 11210000-11210fff : /sysmmu at 0x11210000
> 11c00000-11c00063 : /rotator at 11C00000
> 11d40000-11d40fff : /sysmmu at 0x11D40000
> 11f10000-11f10fff : /sysmmu at 0x11F10000
> 11f20000-11f20fff : /sysmmu at 0x11F20000
> 12000000-12007fff : /usb3-0/dwc3 at 12000000
> ? 12000000-12007fff : /usb3-0/dwc3 at 12000000
> 1200c100-1200ffff : /usb3-0/dwc3 at 12000000
> 12100000-121000ff : /phy at 12100000
> 12110000-121100ff : /usb at 12110000
> 12120000-121200ff : /usb at 12120000
> 12130000-121300ff : /phy at 12130000
> 121a0000-121a0fff : /amba/pdma at 121A0000
> ? 121a0000-121a0fff : /amba/pdma at 121A0000
> 121b0000-121b0fff : /amba/pdma at 121B0000
> ? 121b0000-121b0fff : /amba/pdma at 121B0000
> 12200000-12201fff : /mmc at 12200000
> 12220000-12220fff : /mmc at 12220000
> 12400000-12407fff : /usb3-1/dwc3 at 12400000
> ? 12400000-12407fff : /usb3-1/dwc3 at 12400000
> 1240c100-1240ffff : /usb3-1/dwc3 at 12400000
> 12500000-125000ff : /phy at 12500000
> 12880000-12880fff : /sysmmu at 0x12880000
> 12890000-12890fff : /sysmmu at 0x12890000
> 128a0000-128a0fff : /sysmmu at 0x128A0000
> 128c0000-128c0fff : /sysmmu at 0x128C0000
> 128d0000-128d0fff : /sysmmu at 0x128D0000
> 128e0000-128e0fff : /sysmmu at 0x128E0000
> 12c00000-12c000ff : 12c00000.serial:
> 12c10000-12c100ff : 12c10000.serial:
> 12c20000-12c200ff : 12c20000.serial:
> 12c30000-12c300ff : 12c30000.serial:
> 12ca0000-12ca0fff : /i2c at 12CA0000
> 12dd0000-12dd00ff : /pwm at 12dd0000
> 13400000-13400fff : /pinctrl at 13400000
> 13410000-13410fff : /pinctrl at 13410000
> 13e00000-13e00fff : /video-scaler at 13e00000
> 13e10000-13e10fff : /video-scaler at 13e10000
> 13e80000-13e80fff : /sysmmu at 0x13E80000
> 13e90000-13e90fff : /sysmmu at 0x13E90000
> 14000000-14000fff : /pinctrl at 14000000
> 14010000-14010fff : /pinctrl at 14010000
> 14640000-14640fff : /sysmmu at 0x14640000
> 14650000-14650fff : /sysmmu at 0x14650000
> 14680000-14680fff : /sysmmu at 0x14680000
> 40000000-42ffffff : System RAM
> ? 40008000-40ae61bb : Kernel code
> ? 40c00000-40cf10c3 : Kernel data
> 43800000-50ffffff : System RAM
> 51800000-be9fffff : System RAM
>
> [8.5.] PCI information ('lspci -vvv' as root)
> [8.6.] SCSI information (from /proc/scsi/scsi)
> [8.7.] Other information that might be relevant to the problem
> ???????(please look in /proc and include all information that you
> ???????think to be relevant):
>
> [9.] Other notes, patches, fixes, workarounds:
> [9.1] https://lkml.org/lkml/2014/4/28/234
> [9.2] https://lkml.org/lkml/2015/2/2/259
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160829/22550a43/attachment-0001.sig>
