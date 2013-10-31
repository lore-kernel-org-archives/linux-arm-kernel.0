From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 31 Oct 2013 16:47:51 -0200
Subject: [PATCH] clk: fix boot panic with non-dev-associated clocks
In-Reply-To: <CAOesGMgU6qJMpXi5DGe7=XbObiWh8icNFRhZv_9ot+KZMNcTnw@mail.gmail.com>
References: <1383238174-14650-1-git-send-email-olof@lixom.net>
 <CAOMZO5C4+K+RfHOpex7EwLObPV4Uy8YmjdVx2HPv36ZGAKeSZA@mail.gmail.com>
 <CAOesGMgU6qJMpXi5DGe7=XbObiWh8icNFRhZv_9ot+KZMNcTnw@mail.gmail.com>
Message-ID: <CAOMZO5BsMuN3bZuK+06X6ukAEmRyZDpvoKXdhatNiG61x_GZsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 3:07 PM, Olof Johansson <olof@lixom.net> wrote:
> On Thu, Oct 31, 2013 at 10:05 AM, Fabio Estevam <festevam@gmail.com> wrote:
>> Hi Olof,
>>
>> On Thu, Oct 31, 2013 at 2:49 PM, Olof Johansson <olof@lixom.net> wrote:
>>> Fixes a panic at boot on many platforms. For example, on imx (wandboard),
>>> I get:
>>
>> With this patch applied console messages appears on 20131031, but it
>> seems we still have other issues:
>
>
> Yeah, there's lots of badness in last night's -next. :(

If I apply this change:

--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -44,7 +44,7 @@ struct clk *of_clk_get(struct device_node *np, int index)
        of_clk_lock();
        clk = __of_clk_get_from_provider(&clkspec);

-       if (!IS_ERR(clk) && !__clk_get(clk))
+       if (IS_ERR(clk) && !__clk_get(clk))
                clk = ERR_PTR(-ENOENT);

        of_clk_unlock();

Then I am able to boot until the prompt. (Still get the warning
_clk_get warning though).
