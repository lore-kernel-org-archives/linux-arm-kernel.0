From: robherring2@gmail.com (Rob Herring)
Date: Tue, 28 Jul 2015 08:39:46 -0500
Subject: [PATCH v2 04/22] of/platform: add of_platform_device_find()
In-Reply-To: <1438089593-7696-5-git-send-email-tomeu.vizoso@collabora.com>
References: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
 <1438089593-7696-5-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <CAL_JsqJGhFXDKuayuKc2E58X5A7ZGN=uYCVDLnXw_t3_auBg+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 28, 2015 at 8:19 AM, Tomeu Vizoso
<tomeu.vizoso@collabora.com> wrote:
> From an arbitrary node in the tree, find the enclosing node that
> corresponds to a platform device, as registered by
> of_platform_populate().
>
> This can be used to find out what device needs to be probed so the
> dependency described by a given node is made available.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>
> Changes in v2:
> - Move the logic for finding a platform device from its firmware node to
>   of/platform.c as it's not needed for ACPI nodes.
>
>  drivers/of/platform.c       | 60 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of_platform.h |  1 +
>  2 files changed, 61 insertions(+)
>
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index ff27494cda8c..89c5cd513027 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -501,6 +501,66 @@ void of_platform_depopulate(struct device *parent)
>  }
>  EXPORT_SYMBOL_GPL(of_platform_depopulate);
>
> +static bool of_is_platform(struct device_node *np)
> +{
> +       int count;
> +
> +       count = of_property_count_strings(np, "compatible");
> +
> +       /* The node has to have a compatible string */
> +       if (!count)
> +               return false;
> +
> +       /* But it cannot be just a simple memory-mapped bus */
> +       if (count == 1 && of_match_node(of_default_bus_match_table, np))
> +               return false;
> +
> +       /* But AMBA devices aren't platform devices */
> +       if (of_device_is_compatible(np, "arm,primecell"))
> +               return false;
> +
> +       /* Node is immediately below root */
> +       if (!np->parent || !np->parent->parent)
> +               return true;
> +
> +       /* If it's a node in a simple memory-mapped bus */
> +       if (of_match_node(of_default_bus_match_table, np->parent))
> +               return true;

This seems really fragile. What about platform devices which are
children of MFDs but are not "simple-mfd"?

Does of_find_device_by_node not work for you? That is probably not the
most efficient search, but we could fix that. We could add struct
device ptr to struct device_node and check without searching for
example.

Rob
