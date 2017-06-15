From: kim.phillips@arm.com (Kim Phillips)
Date: Thu, 15 Jun 2017 10:57:35 -0500
Subject: [PATCH v4 0/5] Add support for the ARMv8.2 Statistical
 Profiling Extension
In-Reply-To: <20170612112048.69561e8d067488e8689de755@arm.com>
References: <1496676177-29356-1-git-send-email-will.deacon@arm.com>
 <20170612110823.GA27319@leverpostej>
 <20170612112048.69561e8d067488e8689de755@arm.com>
Message-ID: <20170615105735.b89183a9190a261d3b8d132a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Jun 2017 11:20:48 -0500
Kim Phillips <kim.phillips@arm.com> wrote:

> On Mon, 12 Jun 2017 12:08:23 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > On Mon, Jun 05, 2017 at 04:22:52PM +0100, Will Deacon wrote:
> > > This is the sixth posting of the patches previously posted here:
...
> > Kim, do you have any version of the userspace side that we could look
> > at?
> > 
> > For review, it would be really helpful to have something that can poke
> > the PMU, even if it's incomplete or lacking polish.
> 
> Here's the latest push, based on a a couple of prior versions of this
> driver:
> 
> http://linux-arm.org/git?p=linux-kp.git;a=shortlog;h=refs/heads/armspev0.1
> 
> I don't seem to be able to get any SPE data output after rebasing on
> this version of the driver.  Still don't know why at the moment...

Bisected to commit e38ba76deef "perf tools: force uncore events to
system wide monitoring".  So, using record with specifying a -C
<cpu> explicitly now produces SPE data, but only a couple of valid
records at the beginning of each buffer; the rest is filled with
PADding (0's).

I see Mark's latest comments have found a possible issue in the perf
aux buffer handling code in the driver, and that the driver does some
memset of padding (0's) itself; could that be responsible for the above
behaviour?

Thanks,

Kim
