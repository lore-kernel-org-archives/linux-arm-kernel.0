From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Tue, 17 Apr 2012 17:57:23 +0800
Subject: [PATCH 1/3] pinctrl: pinctrl-imx: add imx pinctrl core driver
In-Reply-To: <20120416034646.GI24997@S2101-09.ap.freescale.net>
References: <1334333915-1174-1-git-send-email-b29396@freescale.com>
 <20120414134814.GA3852@pengutronix.de>
 <CAA+hA=T0FAfuGKcW0vAKO+OWyFdM-6vQqVo53xKf8y28m7gPOQ@mail.gmail.com>
 <20120415141736.GG24997@S2101-09.ap.freescale.net>
 <20120416034713.GB17173@shlinux2.ap.freescale.net>
 <20120416034646.GI24997@S2101-09.ap.freescale.net>
Message-ID: <20120417095722.GF17173@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2012 at 11:46:49AM +0800, Shawn Guo wrote:
> On Mon, Apr 16, 2012 at 11:47:14AM +0800, Dong Aisheng wrote:
> ...
> > Good suggestion.
> > I can do it and it's easy to change.
> > But as i said above, before the dtc macro support is available, the pinctrl
> > setting in dts file will be hard to read since it's all raw data.
> > It becomes
> > fsl,pins = <1 2 3 4 5 6 ....>;
> > People have to search the binding doc to see what the data means.
> > 
> It does not make the thing any worse.  You were asking people to search
> pinctrl-imx6q.c for the meaning of the following.
> 
>   fsl,mux = <0 0 1 1 1 1 1 1 1 1>;
> 
> IMO, it makes a bit more sense to look at binding doc than code to
> understand the dts file.
> 
Yes if this is binding rather than data.

> > The question is how long the dtc macro support will be available?
> > I'm very willing to do like as you said if it's just a short time.
> > But if it's long time, do we still want to lose the readability right now?
> > 
> The point is with my suggestion taken, we do not need to change code
> when the dtc macro support is available.
> 

Yes, that's the benefit.
I'm fine with both method, but i was personally a little intend to the
original one before dtc macro support is available(Stehpen said it's
possible not a short-term) since it's better readable.

But considering minimize the changes after convert many other platforms
to pinctrl subsystem, the new one may be a good choice.

Sascha & Shawn,

Just let you know:
After changes the pinctrl table may look like:
(i also removed fsl,* config properties since it was introduced for better
readability before, but after dtc macro support is available, it could also
be removed. So i removed now. Then the using is much similar as iomux-v3).

iomuxc at 020e0000 {
        compatible = "fsl,imx6q-iomuxc";
        reg = <0x020e0000 0x4000>;

        /* shared pinctrl settings */
        uart4 {
                pinctrl_uart4_1: uart4grp-1 {
                        fsl,pins = <58 61>;
                        fsl,configs = <0x12407>
                };
        };

        usdhc4 {
                pinctrl_usdhc4_1: usdhc4grp-1 {
                        fsl,pins = <101 102 103 104 105 ...>;
                        fsl,configs = <0x12407>
                };
        };
};

When dt macro is available, it may be like:
/define/ MX6Q_UART_PAD_CTRL 0x12407 /* pull: 100KOhm Pull Up, speed: 50Mhz... */
/define/ MX6Q_USDHC_PAD_CTRL 0x12407 /* pull: 100KOhm Pull Up, speed: 50Mhz... */
iomuxc at 020e0000 {
        compatible = "fsl,imx6q-iomuxc";
rt4 {
                pinctrl_uart4_1: uart4grp-1 {
                        fsl,pins = <MX6Q_PAD_KEY_COL0__UART4_RX
                                    MX6Q_PAD_KEY_ROW0__UART4_TX>;
                        fsl,configs = <MX6Q_UART_PAD_CTRL>
                };
        };

        usdhc4 {
                pinctrl_usdhc4_1: usdhc4grp-1 {
                        fsl,pins = <MX6Q_PAD_SD4_CMD__SD4_CMD
                                    MX6Q_PAD_SD4_CLK__SD4_CLK
                                    ......>;
                        fsl,configs = <MX6Q_USDHC_PAD_CTRL>
                };
        };
};

If you're also fine with it, i will do like this.

Regards
Dong Aisheng
