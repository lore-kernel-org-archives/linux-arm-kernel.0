From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Fri, 19 Oct 2018 16:43:22 +0300
Subject: [PATCH 11/15] x86, olpc: Use a correct version when making up a
 battery node
In-Reply-To: <20181010172300.317643-12-lkundrak@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-12-lkundrak@v3.sk>
Message-ID: <CAHp75VdnrWUSONXwPfVD1HuON5DyGq3qF4JOJbhC-LKudhRdng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2018 at 8:23 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> The XO-1 and XO-1.5 batteries apparently differ in an ability to report
> ambient temperature. Add a different compatible string to the 1.5
> battery.

> +int olpc_dt_compatible_match(phandle node, const char *compat)
>  {
>         char buf[64];
> +       int plen;
> +       char *p;
> +       int len;
> +
> +       plen = olpc_dt_getproperty(node, "compatible", buf, sizeof(buf));
> +       if (plen <= 0)
> +               return 0;
> +
> +       len = strlen(compat);
> +       for (p = buf; p < buf + plen; p += strlen(p) + 1) {
> +               if (strcmp(p, compat) == 0)
> +                       return 1;
> +       }
> +
> +       return 0;
> +}

DT doesn't still have a helper for that?!
I hardly believe in that.

> +               olpc_dt_interpret("\" /battery at 0\" find-device"
> +                       " \" olpc,xo1.5-battery\" +compatible"
> +                       " device-end");

Please, don't split string literals.

>                 olpc_dt_interpret("\" /pci/display at 1\" find-device"
>                         " new-device"
>                         " \" dcon\" device-name \" olpc,xo1-dcon\" +compatible"
>                         " finish-device device-end");

Yeah, this and similar also needs to be fixed.

-- 
With Best Regards,
Andy Shevchenko
