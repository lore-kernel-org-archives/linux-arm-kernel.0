From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 11 Feb 2018 17:21:53 -0200
Subject: [PATCH] ARM: dts: imx6qdl-udoo: Disable usbh1 to avoid kernel hang
In-Reply-To: <CAOMZO5D=83p947b=0d6zrxv8mGONjMzXJP1Jyg8W+u1eH=Spww@mail.gmail.com>
References: <1516278858-15464-1-git-send-email-fabio.estevam@nxp.com>
 <CAOcK=CMFahBh9rmm5PGHe=UVrdxi_pwWH=cOs9Q_kCgzTTKOew@mail.gmail.com>
 <CAOcK=CMoVd=nWQd1pyCM4J0YXpMj1i4+nn4o60tPZfntwFm8AA@mail.gmail.com>
 <CAOMZO5D=83p947b=0d6zrxv8mGONjMzXJP1Jyg8W+u1eH=Spww@mail.gmail.com>
Message-ID: <CAOMZO5BSWvjHaXH=xq67pwUADa055_Et6xu08Yy3c3ow0yvn9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Markus,

On Sun, Feb 11, 2018 at 11:58 AM, Fabio Estevam <festevam@gmail.com> wrote:

>> With your changes the board will boot again, so a step forward (but
>> USB will not working).

If you re-enable USBH1 and apply this quick hack:

--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -920,5 +920,11 @@ static void __init imx6q_clocks_init(struct
device_node *ccm_node)
        }

        imx_register_uart_clocks(uart_clks);
+
+       if (of_machine_is_compatible("udoo,imx6dl-udoo") ||
+           of_machine_is_compatible("udoo,imx6q-udoo"))
+               clk_prepare_enable(clk[IMX6QDL_CLK_CKO]);
+
 }
 CLK_OF_DECLARE(imx6q, "fsl,imx6q-ccm", imx6q_clocks_init);

Does USB work again?

I don't have access to my udoo board at the moment.
