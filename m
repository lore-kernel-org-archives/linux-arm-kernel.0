From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 7 Dec 2017 12:46:40 -0600
Subject: [PATCH 2/2] acpi, x86: Use SPCR table for earlycon on x86
In-Reply-To: <20171207172912.17868-3-prarit@redhat.com>
References: <20171207172912.17868-1-prarit@redhat.com>
 <20171207172912.17868-3-prarit@redhat.com>
Message-ID: <CAOZdJXXdeY0+SRfSQC_X-L1UNemigO7DDgRk7jRdMKVe34NWvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 7, 2017 at 11:29 AM, Prarit Bhargava <prarit@redhat.com> wrote:
> -int __init acpi_parse_spcr(bool earlycon)
> +int __init acpi_parse_spcr(bool earlycon, bool enable_console)
>  {
>         static char opts[ACPI_SPCR_OPTS_SIZE];
>         static char uart[ACPI_SPCR_BUF_SIZE];
> @@ -113,7 +113,8 @@ int __init acpi_parse_spcr(bool earlycon)
>         if (earlycon)
>                 setup_earlycon(opts);
>
> -       err = add_preferred_console(uart, 0, opts + strlen(uart) + 1);
> +       if (enable_console)
> +               err = add_preferred_console(uart, 0, opts + strlen(uart) + 1);

So if earlycon==true but enable_console==false, then you parse SPCR
and use it for the early console, but not the primary console?  I'm
not sure what that gives you.
