From: joel@jms.id.au (Joel Stanley)
Date: Thu, 11 Jan 2018 15:54:36 -0800
Subject: [patch v15 3/4] Documentation: jtag: Add bindings for Aspeed SoC
 24xx and 25xx families JTAG master driver
In-Reply-To: <CACPK8XfH-4r0mBQYA+BwvUo2+RF8igai2jy+RqTDQcxx2-acsQ@mail.gmail.com>
References: <1514202808-29747-1-git-send-email-oleksandrs@mellanox.com>
 <1514202808-29747-4-git-send-email-oleksandrs@mellanox.com>
 <CACPK8XfH-4r0mBQYA+BwvUo2+RF8igai2jy+RqTDQcxx2-acsQ@mail.gmail.com>
Message-ID: <CACPK8Xeb3K9PqynV2xymJwvhkZ9fLKsbodEFYiZtQ+SXXgGA5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 11, 2018 at 9:50 AM, Joel Stanley <joel@jms.id.au> wrote:
> On Mon, Dec 25, 2017 at 3:53 AM, Oleksandr Shamray <oleksandrs@mellanox.com> wrote:
>> +jtag: jtag at 1e6e4000 {
>> +       compatible = "aspeed,ast2500-jtag";
>> +       reg = <0x1e6e4000 0x1c>;
>> +       clocks = <&clk_apb>;
>
> We've now got a proper clock driver upstream. Can you update the
> example to match the newly added bindings?
>
>  clocks = <&syscon ASPEED_CLK_APB>;
>

I think we need to ensure the reset is deasserted as well. You will need:

 resets = <&syscon ASPEED_RESET_JTAG_MASTER>;

In addition, we need to make sure the reset line is deasserted in the
driver. Take a look at how I did this in the i2c driver:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=edd20e95bca4a5434f264d8ab40d729761479825

+       bus->rst = devm_reset_control_get_shared(&pdev->dev, NULL);
+       if (IS_ERR(bus->rst)) {
+               dev_err(&pdev->dev,
+                       "missing or invalid reset controller device
tree entry");
+               return PTR_ERR(bus->rst);
+       }
+       reset_control_deassert(bus->rst);

Please give this a test with an upstream kernel from a fresh power on.

Cheers,

Joel
