From: olof@lixom.net (Olof Johansson)
Date: Tue, 25 Nov 2014 12:06:41 -0800
Subject: [PATCH 2/2 v2] SPI: spi-pxa2xx: SPI support for Intel Quark X1000
In-Reply-To: <1412000548-9908-3-git-send-email-alvin.chen@intel.com>
References: <1412000548-9908-1-git-send-email-alvin.chen@intel.com>
 <1412000548-9908-3-git-send-email-alvin.chen@intel.com>
Message-ID: <CAOesGMi5f_Kc1xA_JqiZYsbVYxaJgBXMZCe5TAxDkPQj7=o8sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 29, 2014 at 7:22 AM, Weike Chen <alvin.chen@intel.com> wrote:
> There are two SPI controllers exported by PCI subsystem for Intel Quark X1000.
> The SPI memory mapped I/O registers supported by Quark are different from
> the current implementation, and Quark only supports the registers of 'SSCR0',
> 'SSCR1', 'SSSR', 'SSDR', and 'DDS_RATE'. This patch is to enable the SPI for
> Intel Quark X1000.
>
> This piece of work is derived from Dan O'Donovan's initial work for Intel Quark
> X1000 SPI enabling.
>
> Signed-off-by: Weike Chen <alvin.chen@intel.com>

How about build testing for other platforms that share this driver
when you make changes to it? This is obviously completely broken.

Doing these constants under ifdef seems fragile at best, braindead at
worst. Please don't proliferate that coding style.

Mark, can you revert until Intel learns how to play well with others?



This is from a pxa3xx-defconfig build:

/home/build/work/batch/drivers/spi/spi-pxa2xx.c: In function
'pxa2xx_spi_get_ssrc1_change_mask':
/home/build/work/batch/drivers/spi/spi-pxa2xx.c:66:40: error:
'QUARK_X1000_SSCR1_STRF' undeclared (first use in this function)
 #define QUARK_X1000_SSCR1_CHANGE_MASK (QUARK_X1000_SSCR1_STRF \
                                        ^
/home/build/work/batch/drivers/spi/spi-pxa2xx.c:146:10: note: in
expansion of macro 'QUARK_X1000_SSCR1_CHANGE_MASK'
   return QUARK_X1000_SSCR1_CHANGE_MASK;
          ^
/home/build/work/batch/drivers/spi/spi-pxa2xx.c:66:40: note: each
undeclared identifier is reported only once for each function it
appears in
 #define QUARK_X1000_SSCR1_CHANGE_MASK (QUARK_X1000_SSCR1_STRF \
                                        ^
/home/build/work/batch/drivers/spi/spi-pxa2xx.c:146:10: note: in
expansion of macro 'QUARK_X1000_SSCR1_CHANGE_MASK'
   return QUARK_X1000_SSCR1_CHANGE_MASK;
          ^
/home/build/work/batch/drivers/spi/spi-pxa2xx.c:67:7: error:
'QUARK_X1000_SSCR1_EFWR' undeclared (first use in this function)
     | QUARK_X1000_SSCR1_EFWR \
       ^
/home/build/work/batch/drivers/spi/spi-pxa2xx.c:146:10: note: in
expansion of macro 'QUARK_X1000_SSCR1_CHANGE_MASK'
   return QUARK_X1000_SSCR1_CHANGE_MASK;
          ^
/home/build/work/batch/drivers/spi/spi-pxa2xx.c:68:7: error:
'QUARK_X1000_SSCR1_RFT' undeclared (first use in this function)
     | QUARK_X1000_SSCR1_RFT  \
       ^
/home/build/work/batch/drivers/spi/spi-pxa2xx.c:146:10: note: in
expansion of macro 'QUARK_X1000_SSCR1_CHANGE_MASK'
   return QUARK_X1000_SSCR1_CHANGE_MASK;
          ^
/home/build/work/batch/drivers/spi/spi-pxa2xx.c:69:7: error:
'QUARK_X1000_SSCR1_TFT' undeclared (first use in this function)
     | QUARK_X1000_SSCR1_TFT  \
       ^
/home/build/work/batch/drivers/spi/spi-pxa2xx.c:146:10: note: in
expansion of macro 'QUARK_X1000_SSCR1_CHANGE_MASK'
   return QUARK_X1000_SSCR1_CHANGE_MASK;
          ^
/home/build/work/batch/drivers/spi/spi-pxa2xx.c: In function
'pxa2xx_spi_get_rx_default_thre':
/home/build/work/batch/drivers/spi/spi-pxa2xx.c:157:10: error:
'RX_THRESH_QUARK_X1000_DFLT' undeclared (first use in this function)
   return RX_THRESH_QUARK_X1000_DFLT;
          ^
/home/build/work/batch/drivers/spi/spi-pxa2xx.c: In function
'pxa2xx_spi_txfifo_full':
/home/build/work/batch/drivers/spi/spi-pxa2xx.c:170:10: error:
'QUARK_X1000_SSSR_TFL_MASK' undeclared (first use in this function)
   mask = QUARK_X1000_SSSR_TFL_MASK;
          ^
/home/build/work/batch/drivers/spi/spi-pxa2xx.c: In function
'pxa2xx_spi_clear_rx_thre':
/home/build/work/batch/drivers/spi/spi-pxa2xx.c:187:10: error:
'QUARK_X1000_SSCR1_RFT' undeclared (first use in this function)
   mask = QUARK_X1000_SSCR1_RFT;
          ^
/home/build/work/batch/drivers/spi/spi-pxa2xx.c: In function
'pxa2xx_spi_set_rx_thre':
/home/build/work/batch/drivers/spi/spi-pxa2xx.c:201:3: error: implicit
declaration of function 'QUARK_X1000_SSCR1_RxTresh'
[-Werror=implicit-function-declaration]
   *sccr1_reg |= QUARK_X1000_SSCR1_RxTresh(threshold);
   ^
/home/build/work/batch/drivers/spi/spi-pxa2xx.c: In function
'pxa2xx_configure_sscr0':
/home/build/work/batch/drivers/spi/spi-pxa2xx.c:215:6: error:
'QUARK_X1000_SSCR0_Motorola' undeclared (first use in this function)
    | QUARK_X1000_SSCR0_Motorola
      ^
/home/build/work/batch/drivers/spi/spi-pxa2xx.c:216:4: error: implicit
declaration of function 'QUARK_X1000_SSCR0_DataSize'
[-Werror=implicit-function-declaration]
    | QUARK_X1000_SSCR0_DataSize(bits > 32 ? 8 : bits)
    ^
/home/build/work/batch/drivers/spi/spi-pxa2xx.c: In function 'setup':
/home/build/work/batch/drivers/spi/spi-pxa2xx.c:1062:14: error:
'TX_THRESH_QUARK_X1000_DFLT' undeclared (first use in this function)
   tx_thres = TX_THRESH_QUARK_X1000_DFLT;
              ^
/home/build/work/batch/drivers/spi/spi-pxa2xx.c:1064:14: error:
'RX_THRESH_QUARK_X1000_DFLT' undeclared (first use in this function)
   rx_thres = RX_THRESH_QUARK_X1000_DFLT;
              ^
/home/build/work/batch/drivers/spi/spi-pxa2xx.c:1154:10: error:
'QUARK_X1000_SSCR1_RFT' undeclared (first use in this function)
        & QUARK_X1000_SSCR1_RFT)
          ^
/home/build/work/batch/drivers/spi/spi-pxa2xx.c:1155:8: error:
implicit declaration of function 'QUARK_X1000_SSCR1_TxTresh'
[-Werror=implicit-function-declaration]
        | (QUARK_X1000_SSCR1_TxTresh(tx_thres)
        ^
/home/build/work/batch/drivers/spi/spi-pxa2xx.c:1156:10: error:
'QUARK_X1000_SSCR1_TFT' undeclared (first use in this function)
        & QUARK_X1000_SSCR1_TFT);
          ^
/home/build/work/batch/drivers/spi/spi-pxa2xx.c: In function 'pxa2xx_spi_probe':
/home/build/work/batch/drivers/spi/spi-pxa2xx.c:1393:6: error:
'RX_THRESH_QUARK_X1000_DFLT' undeclared (first use in this function)
      RX_THRESH_QUARK_X1000_DFLT) |
      ^
/home/build/work/batch/drivers/spi/spi-pxa2xx.c:1395:6: error:
'TX_THRESH_QUARK_X1000_DFLT' undeclared (first use in this function)
      TX_THRESH_QUARK_X1000_DFLT),
      ^
/home/build/work/batch/drivers/spi/spi-pxa2xx.c:1399:15: error:
'QUARK_X1000_SSCR0_Motorola' undeclared (first use in this function)
   write_SSCR0(QUARK_X1000_SSCR0_Motorola



-Olof
