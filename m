From: evgreen@chromium.org (Evan Green)
Date: Mon, 2 Jul 2018 10:08:32 -0700
Subject: [PATCH v5 6/8] interconnect: qcom: Add msm8916 interconnect
 provider driver
In-Reply-To: <8e2218b4-a193-3bb4-b732-3608a4019977@linaro.org>
References: <20180620121141.15403-1-georgi.djakov@linaro.org>
 <20180620121141.15403-7-georgi.djakov@linaro.org>
 <CAE=gft6pbLzeLLtpWd-jHbvYuURi=SpODOVqgY7mdHhmz=ZP9A@mail.gmail.com>
 <8e2218b4-a193-3bb4-b732-3608a4019977@linaro.org>
Message-ID: <CAE=gft489LjMLp6YW1C_TywGDx0BPLAc8nSac1qCGiRDpAV9Ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 1, 2018 at 5:12 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Hi Evan,
>
> On 06/26/2018 11:48 PM, Evan Green wrote:
> > On Wed, Jun 20, 2018 at 5:11 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> >> +static int qcom_icc_init(struct icc_node *node)
> >> +{
> >> +       struct qcom_icc_provider *qp = to_qcom_provider(node->provider);
> >> +       int ret;
> >> +
> >> +       /* TODO: init qos and priority */
> >> +
> >> +       clk_set_rate(qp->bus_clk, INT_MAX);
> >
> > Vroom! What's the rationale here? I wonder if it might be better to
> > avoid touching the clocks initially, and expect that the boot loader
> > sets up a decent initial set of bus frequencies for consumers that
> > never enable bus scaling? Otherwise, I worry that this driver becomes
> > basically an essential driver for the platform solely because of this
> > line and the one below, when really it might not be.
>
> The idea is to run the interconnects at max rate until consumers start
> sending requests, but i understand your worry and we can live without
> this for now. The better solution would be to set maximum bandwidth and
> remove it at late_init (after consumers are registered) or use this
> patchset: https://lkml.org/lkml/2018/3/21/897
> Actually I have some patches which add support for interconnects to keep
> the bandwidth constraints active until consumers are registered. The
> whole boot constraint thing adds complexity and introduces some
> overhead, but hopefully can be optimized.

Ah, that makes sense. This is a trickier issue than I was thinking
before. On one hand, you don't want to shut off bandwidth to a device
that was set up correctly by the boot environment and should keep
working until the driver comes up, like LCD. But on the other hand, if
a driver fails to come up, or fails to ask for bus bandwidth, you're
now burning at max. And then there's the issue of whether or not this
should be a required or optional driver for platforms that support it
(it would be nice if the system booted even without this driver, but
maybe for others that's a non-goal). I agree this is shouldn't hold up
this initial set of framework patches, we can solve this in a future
set.

-Evan
