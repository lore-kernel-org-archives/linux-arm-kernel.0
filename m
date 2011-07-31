From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 31 Jul 2011 02:04:47 +0200
Subject: [PATCH 07/18] dmaengine/amba-pl08x: Enable/Disable amba_pclk with
	channel requests
In-Reply-To: <CAKnu2MqTYF43wW3axM--jXdtvsCyRBTLEHDc3hPoJYAmTAL5UA@mail.gmail.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<96781d46e41fa6ffc04b88527a25d73f5a59eda8.1311936524.git.viresh.kumar@st.com>
	<20110730120740.GA15791@n2100.arm.linux.org.uk>
	<20110730130537.GB15791@n2100.arm.linux.org.uk>
	<CAKnu2MqTYF43wW3axM--jXdtvsCyRBTLEHDc3hPoJYAmTAL5UA@mail.gmail.com>
Message-ID: <CAKnu2MppEKxZD2Z77tfShMfG80d-Xx26yBGhZtJkJ2C6SjE=1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/31 Linus Walleij <linus.walleij@linaro.org>:
> 2011/7/30 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>> On Sat, Jul 30, 2011 at 01:07:40PM +0100, Russell King - ARM Linux wrote:
>>> It may make better sense to convert this to runtime PM. ?I suspect
>>> that there's core support which the amba/bus.c can do to help in that
>>> respect (eg, managing the apb pclk itself) so that we don't have to
>>> add the same code to every primecell driver.
>>
>> Something like this for the bus driver (untested):
>>
>> ?drivers/amba/bus.c | ? 38 ++++++++++++++++++++++++++++++++++++--
>> ?1 files changed, 36 insertions(+), 2 deletions(-)
>
> I think the pm_runtime_* code Rabin put in place inside
> drivers/spi/spi-pl022.c would play really well with this approach, and
> just work, so:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

..and while it will just cause some double refcounts on the clock,
it makes sense to delete the pclk manipulation from the PL022
driver code as part of the patch, like this:

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index eba88c7..4c4c02a 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -516,7 +516,6 @@ static void giveback(struct pl022 *pl022)
                msg->complete(msg->context);
        /* This message is completed, so let's turn off the clocks & power */
        clk_disable(pl022->clk);
-       amba_pclk_disable(pl022->adev);
        amba_vcore_disable(pl022->adev);
        pm_runtime_put(&pl022->adev->dev);
 }
@@ -1546,7 +1545,6 @@ static void pump_messages(struct work_struct *work)
         */
        pm_runtime_get_sync(&pl022->adev->dev);
        amba_vcore_enable(pl022->adev);
-       amba_pclk_enable(pl022->adev);
        clk_enable(pl022->clk);
        restore_state(pl022);
        flush(pl022);
@@ -2236,10 +2234,10 @@ pl022_probe(struct amba_device *adev, const
struct amba_id *id)
        }
        dev_dbg(dev, "probe succeeded\n");
        /*
-        * Disable the silicon block pclk and any voltage domain and just
-        * power it up and clock it when it's needed
+        * Disable the silicon block voltage domain and just
+        * power it up when it's needed. The AMBA core code will
+        * enable the pclk.
         */
-       amba_pclk_disable(adev);
        amba_vcore_disable(adev);
        return 0;

Yours,
Linus Walleij
