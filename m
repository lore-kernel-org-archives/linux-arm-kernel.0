From: dongas86@gmail.com (Dong Aisheng)
Date: Wed, 11 Dec 2013 12:59:55 +0800
Subject: [PATCH 1/6] mmc: sdhci: add platfrom get_max_timeout hook
In-Reply-To: <20131211035654.GI18380@S2101-09.ap.freescale.net>
References: <1386680168-5227-1-git-send-email-b29396@freescale.com>
 <1386680168-5227-2-git-send-email-b29396@freescale.com>
 <20131211015640.GA18380@S2101-09.ap.freescale.net>
 <CAA+hA=ST0fAa2__PaeJqxj2yDWUAr6iaNO4Dj7ABiEWqnYp6Vw@mail.gmail.com>
 <20131211031254.GF18380@S2101-09.ap.freescale.net>
 <CAA+hA=QrEiwg8+hmEONgP5u6C0_YwQhEeBfDoFQTv=aCaLhqkQ@mail.gmail.com>
 <20131211035654.GI18380@S2101-09.ap.freescale.net>
Message-ID: <CAA+hA=TjhLKmLucm9R3fkiDQGCxTf_5WCMKbgyBXuuqC6Q0-RQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 11:56 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Wed, Dec 11, 2013 at 11:20:59AM +0800, Dong Aisheng wrote:
>> No, the max_to is the max timeout counter value, you need to divide it
>> by the timeout clock
>> to get the timeout time.
>> The defined of this API is return the max timeout value in
>> miliseconds, so you need to
>> divide the clock by 1000.
>> None of these handles the detail bout discard_to.
>
> Let me start it over again.  Here is basically what your patch does.
>
> -     mmc->max_discard_to = (1 << 27) / host->timeout_clk;
> +     if (host->ops->get_max_timeout)
> +             mmc->max_discard_to = host->ops->get_max_timeout(host);
>
> The only thing that does not work for you in the existing code is the
> (1 << 27) part, right?
>
> If so, why not just create a platform hook to return the correct thing
> for you platform, i.e. (1 << 28)?
>
>         if (host->ops->get_max_timeout)
>                 mmc->max_discard_to = host->ops->hook_foo(host);
>
> unsigned int esdhc_hook_foo(struct sdhci_host *host)
> {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct pltfm_imx_data *imx_data = pltfm_host->priv;
>
>         return esdhc_is_usdhc(imx_data) ? 1 << 28 : 1 << 27;
> }
>
> Such patch will be ease to be understood and less offensive to the
> existing code, no?
>

The example you give is not correct here.
The max timeout counter returned by esdhc_hook_foo can not be simpled assigned
to max_discard_to which is timeout in miliseconds.

Actually what i did is like the way you said:
-       mmc->max_discard_to = (1 << 27) / host->timeout_clk;
+       if (host->ops->get_max_timeout)
+               mmc->max_discard_to = host->ops->get_max_timeout(host);
+       else
+               mmc->max_discard_to = (1 << 27) / host->timeout_clk;

+unsigned int esdhc_get_max_timeout(struct sdhci_host *host)
+{
+       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+       struct pltfm_imx_data *imx_data = pltfm_host->priv;
+       u32 max_to = esdhc_is_usdhc(imx_data) ? 1 << 28 : 1 << 27;
+
+       return max_to / (esdhc_pltfm_get_max_clock(host) / 1000);
+}

Regards
Dong Aisheng

> Shawn
>
