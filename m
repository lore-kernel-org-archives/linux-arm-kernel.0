From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 21 Mar 2018 18:27:49 +0200
Subject: WL1837-st on imx6 request_firmware failed with 4.16-RC6
In-Reply-To: <CAHCN7xKQxF34LSy7TZUQ2yCo9KdrKppOvamgna-CHJD_kt=80w@mail.gmail.com>
References: <CAHCN7xKQxF34LSy7TZUQ2yCo9KdrKppOvamgna-CHJD_kt=80w@mail.gmail.com>
Message-ID: <20180321162749.ammvnmamwknwjonr@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Adam,

On Wed, Mar 21, 2018 at 10:31:55AM -0500, Adam Ford wrote:
> I have an i.MX6 board and I am trying to get Bluetooth operational on
> 4.16-RC6 using the default imx_v6_v7_defconfig
> 
> I have my device tree configured as follows:
> 
> &uart2 {
>   pinctrl-names = "default";
>   pinctrl-0 = <&pinctrl_uart2>;
>   uart-has-rtscts;
>   status = "okay";
> 
>   bluetooth {
>     compatible = "ti,wl1837-st";
>     enable-gpios = <&gpio7 8 GPIO_ACTIVE_HIGH>;
>   };
> };
> 
> I have the firmware TIInit_11.8.32  available in /lib/firmware/ti-connectivity
> 
> # ls -l /lib/firmware/ti-connectivity/
> total 2748
> -rwxrwxrwx    1 root     root         53488 Mar 21  2018 TIInit_10.6.15.bts
> -rwxrwxrwx    1 root     root         70313 Mar 21  2018 TIInit_11.8.32.bts
> -rwxrwxrwx    1 root     root         14610 Mar 21  2018 TIInit_12.10.28.bts
> -rwxrwxrwx    1 root     root         70313 Mar 21  2018 TIInit_12.8.32.bts
> -rwxrwxrwx    1 root     root         48909 Jan  4  2018 TIInit_7.2.31.bts
> -rwxrwxrwx    1 root     root         50695 Mar 21  2018 TIInit_7.6.15.bts
> 
> However, when the Bluetooth driver loads, it appears it cannot locate
> the proper firmware image.
> 
> [    0.176338] Bluetooth: Core ver 2.22
> [    0.176453] Bluetooth: HCI device and connection manager initialized
> [    0.176529] Bluetooth: HCI socket layer initialized
> [    0.176563] Bluetooth: L2CAP socket layer initialized
> [    0.176705] Bluetooth: SCO socket layer initialized
> [    2.043237] Bluetooth: HCI UART driver ver 2.3
> [    2.047710] Bluetooth: HCI UART protocol H4 registered
> [    2.055090] Bluetooth: HCI UART protocol LL registered
> [    2.130658] Bluetooth: hci0: request_firmware failed(errno -2) for
> ti-connectivity/TIInit_11.8.32.bts
> [    2.147064] Bluetooth: hci0: download firmware failed, retrying...
> [    2.218509] Bluetooth: hci0: request_firmware failed(errno -2) for
> ti-connectivity/TIInit_11.8.32.bts
> [    2.227752] Bluetooth: hci0: download firmware failed, retrying...
> [    2.288584] Bluetooth: hci0: request_firmware failed(errno -2) for
> ti-connectivity/TIInit_11.8.32.bts
> [    2.306472] Bluetooth: hci0: download firmware failed, retrying...
> [    2.380161] Bluetooth: hci0: request_firmware failed(errno -2) for
> ti-connectivity/TIInit_11.8.32.bts
> [    2.389459] Bluetooth: hci0: download firmware failed, retrying...

Is your filesystem mounted at this point? Do you use initramfs?

baruch

> I was hoping someone might have some insight on what might be the issue.
> 
> Thanks
> 
> adam
> 
> pinctrl_uart2: uart2grp {
> fsl,pins = <
> MX6QDL_PAD_SD4_DAT4__UART2_RX_DATA 0x1b0b1
> MX6QDL_PAD_SD4_DAT5__UART2_RTS_B 0x1b0b1
> MX6QDL_PAD_SD4_DAT6__UART2_CTS_B 0x1b0b1
> MX6QDL_PAD_SD4_DAT7__UART2_TX_DATA 0x1b0b1
> MX6QDL_PAD_SD3_RST__GPIO7_IO08 0x13059 /* BT_EN */
> >;
> };

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
