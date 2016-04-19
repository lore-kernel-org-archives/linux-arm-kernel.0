From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 19 Apr 2016 16:10:51 -0500
Subject: [PATCH v2 all 00/14] use of_platform_default_populate() to
 populate default bus
In-Reply-To: <1458113743-15131-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1458113743-15131-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <CAL_JsqK34MOSkdJb1Sqq3CzYSz5xGeEnuThS_GmfFXMHX-8d9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16, 2016 at 2:35 AM, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> Use helper of_platform_default_populate() in linux/of_platform
> when possible, instead of calling of_platform_populate() with
> the default match table.
>
> Then it is possible for driver code build as a module, and no
> need to export of_default_bus_match_table anymore.
>
> This patchset is based on Linux 4.5.
>
> Changes since v1:
> - Add ack, test and review
> - Remove v1 patch 14/15, the similar patch has posted and applied,
>   see https://patchwork.kernel.org/patch/8096991/
>
> v1:
> - https://lkml.org/lkml/2016/1/26/1123

I was going to apply this, but I've thought about this some more and
it is a lot of tree wide churn for little gain. Most of the call sites
here I want to get rid of by making of_platform_populate callable
multiple times. The infrastructure is almost there, but I think we
just need something like this:

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 8d103e4..b25e710 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -345,6 +345,9 @@ static int of_platform_bus_create(struct device_node *bus,
                return 0;
        }

+       if (of_node_check_flag(bus, OF_POPULATED_BUS))
+               return 0;
+
        auxdata = of_dev_lookup(lookup, bus);
        if (auxdata) {
                bus_id = auxdata->name;

Then we can call of_platform_populate from the DT core and remove all
the default calls.

Rob
