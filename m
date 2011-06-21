From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 21 Jun 2011 16:29:10 -0400 (EDT)
Subject: [PATCH v6 02/11] omap_hsmmc: add support for pre_req and post_req
In-Reply-To: <BANLkTi=AgOmwkJkVAON5AFTr+ytqkAGP4w@mail.gmail.com>
References: <1308518257-9783-1-git-send-email-per.forlin@linaro.org>
	<1308518257-9783-3-git-send-email-per.forlin@linaro.org>
	<BANLkTi=+o496k8Uz_k33AH=Zr8+MaFOEig@mail.gmail.com>
	<BANLkTinNG2h747MggWfoJfMp4wOSTaTKSg@mail.gmail.com>
	<alpine.LFD.2.00.1106211515270.2142@xanadu.home>
	<BANLkTi=AgOmwkJkVAON5AFTr+ytqkAGP4w@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1106211624400.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 21 Jun 2011, Per Forlin wrote:

> On 21 June 2011 21:18, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > On Tue, 21 Jun 2011, Per Forlin wrote:
> >
> >> On 21 June 2011 07:41, Kishore Kadiyala <kishorek.kadiyala@gmail.com> wrote:
> >> > <snip>
> >> >
> >> >> +
> >> >> +static void omap_hsmmc_pre_req(struct mmc_host *mmc, struct mmc_request *mrq,
> >> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?bool is_first_req)
> >> >
> >> > I don't see the usage of "is_first_req" below.
> >> > Is it required?
> >> >
> >> It is not required. It is only an indication that this request is the
> >> first in a series of request. The host driver may do various
> >> optimisations based on this information. The first request in a series
> >> of jobs can't be prepared in parallel to the previous job. The host
> >> driver can do the following to minimise latency for the first job.
> >> ?* Preparing the cache while the MMC read/write cmd is being
> >> processed. In this case the pre_req could do nothing and the job is
> >> instead run in parallel to the read/write cmd being sent. If the
> >> is_first_req is false pre_req will run in parallel to an active
> >> transfer, in this case it is more efficient to prepare the request in
> >> pre_req.
> >> ?* Run PIO mode instead of DMA
> >
> > That is never going to be a good tradeoff. ?If the CPU is busy doing
> > PIO, it won't have a chance to prepare a subsequent request in parallel
> > to the first transfer.
> >
> If you have two CPUs and the MMC interrupts are scheduled on the CPU
> 1, CPU 0 can prepare the next one.

Well, it is true that in theory the PIO operation shouldn't take all the 
CPU anyway, so maybe there are some cycles left in between FIFO 
interrupts.

The danger here is of course to be presented with a trickle of single 
requests.  Doing them all with PIO is going to waste more power or 
prevent other tasks from running with 100% CPU which might impact the 
system latency more than the latency we're trying to avoid here.

In other words this is something that should be evaluated and not 
applied freely.


Nicolas
