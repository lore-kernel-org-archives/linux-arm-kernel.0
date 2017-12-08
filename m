From: amit.kucheria@verdurent.com (Amit Kucheria)
Date: Sat, 9 Dec 2017 00:08:22 +0530
Subject: [PATCH v3 1/3] interconnect: Add generic on-chip interconnect API
In-Reply-To: <20170908171830.13813-2-georgi.djakov@linaro.org>
References: <20170908171830.13813-1-georgi.djakov@linaro.org>
 <20170908171830.13813-2-georgi.djakov@linaro.org>
Message-ID: <CAHLCerOgm+T6S1pxjo5hFajyU+vqUgBFcwfuBCsphgECRMf3Yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 8, 2017 at 10:48 PM, Georgi Djakov <georgi.djakov@linaro.org> wrote:
> This patch introduce a new API to get requirements and configure the
> interconnect buses across the entire chipset to fit with the current demand.
>
> The API is using a consumer/provider-based model, where the providers are
> the interconnect buses and the consumers could be various drivers.
> The consumers request interconnect resources (path) between endpoints and
> set the desired constraints on this data flow path. The providers receive
> requests from consumers and aggregate these requests for all master-slave
> pairs on that path. Then the providers configure each participating in the
> topology node according to the requested data flow path, physical links and
> constraints. The topology could be complicated and multi-tiered and is SoC
> specific.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  Documentation/interconnect/interconnect.rst |  93 +++++++
>  drivers/Kconfig                             |   2 +
>  drivers/Makefile                            |   1 +
>  drivers/interconnect/Kconfig                |  10 +
>  drivers/interconnect/Makefile               |   1 +
>  drivers/interconnect/interconnect.c         | 382 ++++++++++++++++++++++++++++
>  include/linux/interconnect-consumer.h       |  73 ++++++
>  include/linux/interconnect-provider.h       | 119 +++++++++
>  8 files changed, 681 insertions(+)
>  create mode 100644 Documentation/interconnect/interconnect.rst
>  create mode 100644 drivers/interconnect/Kconfig
>  create mode 100644 drivers/interconnect/Makefile
>  create mode 100644 drivers/interconnect/interconnect.c
>  create mode 100644 include/linux/interconnect-consumer.h
>  create mode 100644 include/linux/interconnect-provider.h
>

<snip>

> diff --git a/include/linux/interconnect-consumer.h b/include/linux/interconnect-consumer.h
> new file mode 100644
> index 000000000000..6e71bf7a63c0
> --- /dev/null
> +++ b/include/linux/interconnect-consumer.h
> @@ -0,0 +1,73 @@
> +/*
> + * Copyright (c) 2017, Linaro Ltd.
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef _LINUX_INTERCONNECT_CONSUMER_H
> +#define _LINUX_INTERCONNECT_CONSUMER_H
> +
> +struct interconnect_node;
> +struct interconnect_path;
> +
> +#if IS_ENABLED(CONFIG_INTERCONNECT)
> +
> +struct interconnect_path *interconnect_get(const char *sdev, const int sid,
> +                                          const char *ddev, const int did);
> +
> +void interconnect_put(struct interconnect_path *path);
> +
> +/**
> + * struct creq - interconnect consumer request
> + * @avg_bw: the average requested bandwidth (over longer period of time) in kbps
> + * @peak_bw: the peak (maximum) bandwidth in kpbs
> + */
> +struct interconnect_creq {
> +       u32 avg_bw;
> +       u32 peak_bw;
> +};
> +
> +/**
> + * interconnect_set() - set constraints on a path between two endpoints
> + * @path: reference to the path returned by interconnect_get()
> + * @creq: request from the consumer, containing its requirements
> + *
> + * This function is used by an interconnect consumer to express its own needs
> + * in term of bandwidth and QoS for a previously requested path between two
> + * endpoints. The requests are aggregated and each node is updated accordingly.
> + *
> + * Returns 0 on success, or an approproate error code otherwise.
> + */
> +int interconnect_set(struct interconnect_path *path,
> +                    struct interconnect_creq *creq);
> +
> +#else
> +
> +inline struct interconnect_path *interconnect_get(const char *sdev,
> +                                                        const int sid,
> +                                                        const char *ddev,
> +                                                        const int did)
> +{
> +       return ERR_PTR(-ENOTSUPP);
> +}
> +
> +inline void interconnect_put(struct interconnect_path *path)
> +{
> +}
> +
> +inline int interconnect_set(struct interconnect_path *path,
> +                           struct interconnect_creq *creq);

Remove the semi colon

> +{
> +       return -ENOTSUPP

return ERR_PTR(-ENOTSUPP);

> +}
> +

This breaks the build with INTERCONNECT disabled in Kconfig.
