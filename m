From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Mon, 19 Mar 2018 16:42:07 +0100
Subject: [PATCH] clk: don't call __of_clk_get_by_name() unnecessarily from
 clk_get()
In-Reply-To: <20180212210053.GO9418@n2100.armlinux.org.uk>
References: <20180212142439.15885-1-brgl@bgdev.pl>
 <36b4b8a0-0254-c6fa-c84f-ceab20c326ad@lechnology.com>
 <20180212210053.GO9418@n2100.armlinux.org.uk>
Message-ID: <CAMRc=MfD0m6rs7hVyf9B5ScCa1Wu9zUGYMNs-tmQJUqeSpNPdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-02-12 22:00 GMT+01:00 Russell King - ARM Linux <linux@armlinux.org.uk>:
> On Mon, Feb 12, 2018 at 02:51:57PM -0600, David Lechner wrote:
>> On 02/12/2018 08:24 AM, Bartosz Golaszewski wrote:
>> >From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> >
>> >The way this function is implemented caused some confusion when
>> >converting the TI DaVinci platform to using the common clock framework.
>> >
>> >Current kernel supports booting DaVinci boards both in device tree as
>> >well as legacy, board-file mode. In the latter, we always end up
>> >calling clk_get_sys() as of_node is NULL and __of_clk_get_by_name()
>> >returns -ENOENT.
>> >
>> >It was not obvious at first glance how clk_get(dev, NULL) will work in
>> >board-file mode since we always call __of_clk_get_by_name(). Let's make
>> >it clearer by checking if of_node is NULL and skipping right to
>> >clk_get_sys().
>> >
>> >Cc: Sekhar Nori <nsekhar@ti.com>
>> >Cc: Kevin Hilman <khilman@baylibre.com>
>> >Cc: David Lechner <david@lechnology.com>
>> >Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> >---
>> >  drivers/clk/clkdev.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> >diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
>> >index 7513411140b6..f394e8964909 100644
>> >--- a/drivers/clk/clkdev.c
>> >+++ b/drivers/clk/clkdev.c
>> >@@ -199,7 +199,7 @@ struct clk *clk_get(struct device *dev, const char *con_id)
>> >     const char *dev_id = dev ? dev_name(dev) : NULL;
>> >     struct clk *clk;
>> >-    if (dev) {
>> >+    if (dev && dev->of_node) {
>> >             clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id);
>> >             if (!IS_ERR(clk) || PTR_ERR(clk) == -EPROBE_DEFER)
>> >                     return clk;
>> >
>>
>> Shouldn't you be sending this to the linux-clk mailing list and cc'ing
>> the clock maintainers?
>
> No, I'm the maintainer for clkdev, as per MAINTAINERS.
>
>> FWIW, it seems pretty clear to me that if we are using a board file
>> then we should expect clk_get_sys() to be called because there is
>> no device tree.
>
> clk_get() pre-dates DT, and using it has no bearing on whether DT is
> in use or not.  The above change looks correct to me - if the
> struct device is not a DT device, then we shouldn't be trying to look
> up the clock in DT.
>
> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
> According to speedtest.net: 8.21Mbps down 510kbps up

Hi Russell,

can you pick this patch up for 4.17?

Thanks in advance,
Bartosz
