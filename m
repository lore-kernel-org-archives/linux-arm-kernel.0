From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 15 May 2018 19:48:05 +0300
Subject: [PATCH v4 6/8] PCI: Rework of_pci_get_host_bridge_resources() to
 devm_of_pci_get_host_bridge_resources()
In-Reply-To: <3aeb2ed038cbce8fe744b614dc19d414555a7e8f.1526375226.git.jan.kiszka@siemens.com>
References: <cover.1526375226.git.jan.kiszka@siemens.com>
 <3aeb2ed038cbce8fe744b614dc19d414555a7e8f.1526375226.git.jan.kiszka@siemens.com>
Message-ID: <CAHp75VeUbjobse6uLeM4h_xXRUw+YUQUN+EOye67AJy77a5euQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2018 at 12:07 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> of_pci_get_host_bridge_resources() allocates the resource structures it
> fills dynamically, but none of its callers care to release them so far.
> Rather than requiring everyone to do this explicitly, convert the
> existing function to a managed version.

> -               res = kzalloc(sizeof(struct resource), GFP_KERNEL);
> +               res = devm_kzalloc(dev, sizeof(struct resource), GFP_KERNEL);
>                 if (!res) {
>                         err = -ENOMEM;
> -                       goto parse_failed;
> +                       goto failed;
>                 }
>
>                 err = of_pci_range_to_resource(&range, dev_node, res);
>                 if (err) {
> -                       kfree(res);
> +                       devm_kfree(dev, res);
>                         continue;
>                 }

Can't you rather make it better, i.e.

struct resource tmp;
...

err = of_pci_range_to_resource(&range, dev_node, &tmp);
if (err)
   continue;

res = devm_kmemdump();
if (!res) {
 ret = -ENOMEM;
 goto failed;
}

?

-- 
With Best Regards,
Andy Shevchenko
