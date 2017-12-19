From: robdclark@gmail.com (Rob Clark)
Date: Tue, 19 Dec 2017 10:21:01 -0500
Subject: [PATCH v3 1/3] interconnect: Add generic on-chip interconnect API
In-Reply-To: <20170908171830.13813-2-georgi.djakov@linaro.org>
References: <20170908171830.13813-1-georgi.djakov@linaro.org>
 <20170908171830.13813-2-georgi.djakov@linaro.org>
Message-ID: <CAF6AEGsMKMfDz=C6n5Fw0Fo92nu6qHXMV1w4rvE+6EhfTW6huA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 8, 2017 at 1:18 PM, Georgi Djakov <georgi.djakov@linaro.org> wrote:
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
>

[snip]

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
> +                    struct interconnect_creq *creq)

drive-by comment... afaict creq could be 'const'

BR,
-R
