From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 24 Oct 2012 22:15:45 +0200
Subject: [PATCH] [RFC] pinctrl: mvebu: reset pins to an UNKNOWN state on
 startup
In-Reply-To: <1351106281-31288-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1351106281-31288-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20121024201545.GA21046@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 09:18:01PM +0200, Thomas Petazzoni wrote:
> Note: this patch is a *RFC*, it is not intended for merging, only to
> get a discussion started. The code is horrible, makes terrible
> assumptions and so on.
> 
> On many platforms, most of the pinmux initialization is done in the
> bootloader, and therefore persists when we boot the Linux kernel. This
> prevents us from making sure that the pinmux configuration in the
> board device trees is correct.

You can get a lot of information from /debug. eg,
# cat /debug/pinctrl/f1010000.pinctrl/pinconf-groups 
Pin config settings per pin group
Format: group (name): configs
0 (mpp0):current: spi(cs), available = [ gpio(io) nand(io2) ]
1 (mpp1):current: spi(mosi), available = [ gpo(o) nand(io3) ]
2 (mpp2):current: spi(sck), available = [ gpo(o) nand(io4) ]
3 (mpp3):current: spi(miso), available = [ gpo(o) nand(io5) ]
4 (mpp4):current: sata1(act), available = [ gpio(io) nand(io6) uart0(rxd) lcd(hsync) ]
5 (mpp5):current: sata0(act), available = [ gpo(o) nand(io7) uart0(txd) lcd(vsync) ]
6 (mpp6):current: spi(mosi), available = [ sysrst(out) ]
7 (mpp7):current: gpo(o), available = [ spi(cs) lcd(pwm) ]
8 (mpp8):current: twsi0(sda), available = [ gpio(io) uart0(rts) uart1(rts) mii-1(rxerr) sata1(prsnt) mii(col) ]
9 (mpp9):current: twsi0(sck), available = [ gpio(io) uart0(cts) uart1(cts) sata0(prsnt) mii(crs) ]
10 (mpp10):current: uart0(txd), available = [ gpo(o) spi(sck) sata1(act) ]
11 (mpp11):current: uart0(rxd), available = [ gpio(io) spi(miso) sata0(act) ]
12 (mpp12):current: gpo(o), available = [ sdio(clk) audio(spdifo) spi(mosi) twsi1(sda) ]
13 (mpp13):current: uart1(txd), available = [ gpio(io) sdio(cmd) audio(rmclk) lcd(pwm) ]
14 (mpp14):current: uart1(rxd), available = [ gpio(io) sdio(d0) sata1(prsnt) audio(spdifi) audio-1(sdi) mii(col) ]
15 (mpp15):current: sata0(act), available = [ gpio(io) sdio(d1) uart0(rts) uart1(txd) spi(cs) ]
16 (mpp16):current: gpio(io), available = [ sdio(d2) uart0(cts) uart1(rxd) sata1(act) lcd(extclk) mii(crs) ]
17 (mpp17):current: gpio(io), available = [ sdio(d3) sata0(prsnt) sata1(act) twsi1(sck) ]
18 (mpp18):current: gpo(o), available = [ nand(io0) pex(clkreq) ]
19 (mpp19):current: gpo(o), available = [ nand(io1) ]
20 (mpp20):current: sata1(act), available = [ gpio(io) ts(mp0) tdm(tx0ql) ge1(txd0) audio(spdifi) lcd(d0) ]
21 (mpp21):current: sata0(act), available = [ gpio(io) ts(mp1) tdm(rx0ql) ge1(txd1) audio(spdifo) lcd(d1) ]
22 (mpp22):current: sata1(prsnt), available = [ gpio(io) ts(mp2) tdm(tx2ql) ge1(txd2) audio(rmclk) lcd(d2) ]
23 (mpp23):current: sata0(prsnt), available = [ gpio(io) ts(mp3) tdm(rx2ql) ge1(txd3) audio(bclk) lcd(d3) ]
24 (mpp24):current: gpio(io), available = [ ts(mp4) tdm(spi-cs0) ge1(rxd0) audio(sdo) lcd(d4) ]
25 (mpp25):current: gpio(io), available = [ ts(mp5) tdm(spi-sck) ge1(rxd1) audio(lrclk) lcd(d5) ]
26 (mpp26):current: gpio(io), available = [ ts(mp6) tdm(spi-miso) ge1(rxd2) audio(mclk) lcd(d6) ]
27 (mpp27):current: gpio(io), available = [ ts(mp7) tdm(spi-mosi) ge1(rxd3) audio(sdi) lcd(d7) ]
28 (mpp28):current: gpio(io), available = [ ts(mp8) tdm(int) ge1(col) audio(extclk) lcd(d8) ]
29 (mpp29):current: gpio(io), available = [ ts(mp9) tdm(rst) ge1(txclk) lcd(d9) ]
30 (mpp30):current: gpio(io), available = [ ts(mp10) tdm(pclk) ge1(rxctl) lcd(d10) ]
31 (mpp31):current: gpio(io), available = [ ts(mp11) tdm(fs) ge1(rxclk) lcd(d11) ]
32 (mpp32):current: gpio(io), available = [ ts(mp12) tdm(drx) ge1(txclko) lcd(d12) ]
33 (mpp33):current: gpo(o), available = [ tdm(dtx) ge1(txctl) lcd(d13) ]
34 (mpp34):current: gpio(io), available = [ tdm(spi-cs1) ge1(txen) sata1(act) lcd(d14) ]
35 (mpp35):current: gpio(io), available = [ tdm(tx0ql) ge1(rxerr) sata0(act) lcd(d15) mii(rxerr) ]
36 (mpp36):current: gpio(io), available = [ ts(mp0) tdm(spi-cs1) audio(spdifi) twsi1(sda) ]
37 (mpp37):current: gpio(io), available = [ ts(mp1) tdm(tx2ql) audio(spdifo) twsi1(sck) ]
38 (mpp38):current: gpio(io), available = [ ts(mp2) tdm(rx2ql) audio(rmclk) lcd(d18) ]
39 (mpp39):current: gpio(io), available = [ ts(mp3) tdm(spi-cs0) audio(bclk) lcd(d19) ]
40 (mpp40):current: gpio(io), available = [ ts(mp4) tdm(spi-sck) audio(sdo) lcd(d20) ]
41 (mpp41):current: gpio(io), available = [ ts(mp5) tdm(spi-miso) audio(lrclk) lcd(d21) ]
42 (mpp42):current: gpio(io), available = [ ts(mp6) tdm(spi-mosi) audio(mclk) lcd(d22) ]
43 (mpp43):current: gpio(io), available = [ ts(mp7) tdm(int) audio(sdi) lcd(d23) ]
44 (mpp44):current: gpio(io), available = [ ts(mp8) tdm(rst) audio(extclk) lcd(clk) ]
45 (mpp45):current: gpio(io), available = [ ts(mp9) tdm(pclk) lcd(e) ]
46 (mpp46):current: gpio(io), available = [ ts(mp10) tdm(fs) lcd(hsync) ]
47 (mpp47):current: gpio(io), available = [ ts(mp11) tdm(drx) lcd(vsync) ]
48 (mpp48):current: gpio(io), available = [ ts(mp12) tdm(dtx) lcd(d16) ]
49 (mpp49):current: gpo(o), available = [ tdm(rx0ql) pex(clkreq) lcd(d17) ]

shows the current configuration of each pin.

# cat /debug/pinctrl/f1010000.pinctrl/pinmux-pins 
Pinmux settings per pin
Format: pin (name): mux_owner gpio_owner hog?
pin 0 (PIN0): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function spi group mpp0
pin 1 (PIN1): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function spi group mpp1
pin 2 (PIN2): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function spi group mpp2
pin 3 (PIN3): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function spi group mpp3
pin 4 (PIN4): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function sata1 group mpp4
pin 5 (PIN5): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function sata0 group mpp5
pin 6 (PIN6): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 7 (PIN7): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 8 (PIN8): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function twsi0 group mpp8
pin 9 (PIN9): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function twsi0 group mpp9
pin 10 (PIN10): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function uart0 group mpp10
pin 11 (PIN11): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function uart0 group mpp11
pin 12 (PIN12): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 13 (PIN13): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function uart1 group mpp13
pin 14 (PIN14): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function uart1 group mpp14
pin 15 (PIN15): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 16 (PIN16): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 17 (PIN17): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 18 (PIN18): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 19 (PIN19): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 20 (PIN20): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function sata1 group mpp20
pin 21 (PIN21): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function sata0 group mpp21
pin 22 (PIN22): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function sata1 group mpp22
pin 23 (PIN23): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function sata0 group mpp23
pin 24 (PIN24): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 25 (PIN25): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 26 (PIN26): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 27 (PIN27): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 28 (PIN28): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 29 (PIN29): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 30 (PIN30): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 31 (PIN31): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 32 (PIN32): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 33 (PIN33): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 34 (PIN34): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 35 (PIN35): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 36 (PIN36): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function gpio group mpp36
pin 37 (PIN37): f1010000.pinctrl mvebu-gpio:37 (HOG) function gpio group mpp37
pin 38 (PIN38): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 39 (PIN39): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 40 (PIN40): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 41 (PIN41): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 42 (PIN42): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 43 (PIN43): f1010000.pinctrl mvebu-gpio:43 (HOG) function gpio group mpp43
pin 44 (PIN44): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function gpio group mpp44
pin 45 (PIN45): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 46 (PIN46): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 47 (PIN47): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 48 (PIN48): (MUX UNCLAIMED) (GPIO UNCLAIMED)
pin 49 (PIN49): (MUX UNCLAIMED) (GPIO UNCLAIMED)

This shows how pins have been configured via DT.

If you compare the two, you can see that pin 6 has probably been set by
uboot, but not by DT.

       Andrew
