From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Jun 2016 10:08:39 +0200
Subject: [PATCH] pinctrl: Add missing of_node_put
In-Reply-To: <20160624130630.GA11858@amitoj-Inspiron-3542>
References: <20160624130630.GA11858@amitoj-Inspiron-3542>
Message-ID: <CACRpkdbOBG8g0ifrzF0_Ub2iDS9JpVH_qtEcN+-83dkk4Hz7pQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 24, 2016 at 3:06 PM, Amitoj Kaur Chawla
<amitoj1606@gmail.com> wrote:

> of_find_node_by_name does an of_node_get on its return value,
> so an of_node_put is needed on this value before the corresponding
> variable goes out of scope.
>
> The Coccinelle semantic patch used to make this change is as follows:
> @@
> struct device_node *n;
> struct device_node *n1;
> statement S;
> identifier f;
> expression E;
> constant C;
> @@
>
> n = of_find_node_by_name(...)
> ...
> if (!n) S
> ... when != of_node_put(n)
>     when != n1 = f(n,...)
>     when != E = n
>     when any
>     when strict
> (
> + of_node_put(n);
>   return -C;
> |
>   of_node_put(n);
> |
>   n1 = f(n,...)
> |
>   E = n
> |
>   return ...;
> )
>
> Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>

Patch applied.

Yours,
Linus Walleij
