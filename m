From: per.forlin@linaro.org (Per Forlin)
Date: Fri, 24 Jun 2011 10:58:31 +0200
Subject: [PATCH v6 00/11] mmc: use nonblock mmc requests to minimize
	latency
In-Reply-To: <20110623133702.GZ23234@n2100.arm.linux.org.uk>
References: <1308518257-9783-1-git-send-email-per.forlin@linaro.org>
	<20110621075319.GN26089@n2100.arm.linux.org.uk>
	<BANLkTikOA3G0Gt4Cxua3EDnAzbFKLAk6Yw@mail.gmail.com>
	<BANLkTimfxrcKWLZJmVC+1zL27th7j4uzEA@mail.gmail.com>
	<20110623133702.GZ23234@n2100.arm.linux.org.uk>
Message-ID: <BANLkTi=8Awu4Z3ESizE9WDEyWNw0r9N0ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 June 2011 15:37, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Tue, Jun 21, 2011 at 11:26:27AM +0200, Per Forlin wrote:
>> Here are the results.
>
> It looks like this patch is either a no-op or slightly worse. ?As
> people have been telling me that dsb is rather expensive, and this
> patch results in less dsbs, I'm finding these results hard to believe.
> It seems to be saying that dsb is an effective no-op on your platform.
>
The result of your patch depends on the number of sg-elements. With
your patch there is only on DSB per list instead of element I can
write a test to measure performance per number of sg-element in the
sg-list. Fixed transfer size but vary the number of sg-elements in the
list. This test may give a better understanding of the affect.

I have seen performance gain if using __raw_write instead of writel.
Writel test includes both the cost of DSB and the outer_sync, where
outer_sync is more expensive one I presume.

> So either people are wrong about dsb being expensive, the patch is
> wrong, or there's something wrong with these results/test method.
>
> You do have an error in the ported patch, as that hasn't updated the
> v7 cache cleaning code to remove the dsb() there, but that would only
> affect the write tests.
>
I will fix that mistake and also improve the test cases to measure the
cost per number of sg-elements.

I'll come back with new numbers on Monday.

Regards,
Per
